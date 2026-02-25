import 'dart:async';
import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/entities.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uchat/constants/uchat_duration.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/domain/services/native_method_channel_service.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/api_validation_exception.dart';
import 'package:uchat/core/infrastructure/analytics/enum/receive_method.dart';
import 'package:uchat/core/infrastructure/analytics/param/call_attribute_param.dart';
import 'package:uchat/core/infrastructure/analytics/performance_service.dart';
import 'package:uchat/core/infrastructure/analytics/call_performance_service.dart';
import 'package:uchat/entities/enum/call_status_type.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/features/call/call_native_method_channel.dart';
import 'package:uchat/features/call/call_system_audio.dart';
import 'package:uchat/features/call/data/models/requests/accept_call_request.dart';
import 'package:uchat/features/call/domain/params/decline_call_param.dart';
import 'package:uchat/features/call/domain/params/start_call_param.dart';
import 'package:uchat/features/call/domain/repositories/calling_server_repository.dart';
import 'package:uchat/features/call/domain/user_cases/decline_call_use_case.dart';
import 'package:uchat/features/call/domain/user_cases/start_call_use_case.dart';

// import 'package:uchat/features/call/livekit/accept_incoming_call_controller.dart';
import 'package:uchat/features/call/livekit/start_direct_call_controller.dart';
import 'package:uchat/features/call/livekit/start_group_call_controller.dart';
import 'package:uchat/features/call/presentation/views/widgets/dialogs/call_busy_dialog.dart';
import 'package:uchat/features/call/presentation/views/widgets/dialogs/call_unreachable_dialog.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/call/socket_call_process.dart';
import 'package:uchat/features/call/socket_call_process_event.dart';
import 'package:uchat/features/call/livekit/parent/uchat_livekit_controller.dart';
import 'package:uchat/entities/models/call_queue_model.dart';
import 'package:uchat/features/call/data/models/models/room_call_model.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/call/presentation/views/screens/mobile/call.dart';
import 'package:uchat/features/call/presentation/views/widgets/dialogs/call_in_progress_different_dialog.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/controllers/connectivity_controller.dart';

import 'call_kit_incoming.dart';

final _log = useLogger();

const callLiveKitTokenKey = 'callLiveKitToken';
const currentCallSessionId = 'currentCallSessionId';
const callStartCallAtKey = 'callStartCallAt';
const callRoomCallIdKey = 'callRoomCallId';
const callLiveKitRoomSIDKey = 'callLiveKitRoomSID';
const callRoomIDKey = 'callRoomID';
const callRoomCallTypeKey = 'callRoomCallType';
const callRoomNameKey = 'callRoomName';

class UChatCallController extends GetxController {
  static UChatCallController get instance => Get.find();
  static const durationScreen = Duration(milliseconds: 400);

  final callCtlList = <UChatLiveKitController>[].obs;
  StreamSubscription<CallEvent?>? callkitStream;
  StreamSubscription? callSocketStream;
  final disconnecting = Rx<bool?>(null);

  final callQueue = <CallQueueModel>[].obs;
  final callDuration = ''.obs;

  // true when user pressed back button
  final isCallScreenMinimize = false.obs;
  bool isSkipIntentCheck = false;

  bool get isSomeoneCameraOn {
    final isMyCameraOn = callCtlList.firstOrNull?.cameraOn.value == true;
    final isOtherCameraOn = callCtlList.firstOrNull?.isParticipantOpenCamera() == true;

    return isMyCameraOn || isOtherCameraOn;
  }

  // This actual bool value is used to check if the call screen is minimized
  bool get isCallFloatingScreenShouldShow {
    final callCtl = callCtlList.firstOrNull;
    if (callCtl is StartDirectCallCtl) {
      return callCtl.directFloatingScreenShow;
    } else if (callCtl is StartGroupCallCtl) {
      return callCtl.groupFloatingScreenShow;
    }
    return false;
  }

  final isInComingCall = false.obs;
  final config = ConfigDb();
  final roomDb = GetIt.I<RoomDb>();

  bool get inCallState => callCtlList.isNotEmpty;

  ConnectivityController get connectivityCtl => ConnectivityController.instance;

  bool get isShowCallStatusOverAppbar {
    final callConditionList = {
      CallStatusType.calling,
    };
    final outgoingCallConditionList = {
      CallStatusType.inProgress,
      CallStatusType.startCall,
    };

    final controller = UserController.instance;
    final currentUser = controller.currentUser.value;
    final callOnSessionKeyId = currentUser?.callOnSessionKeyId;
    final currentSessionKeyId = currentUser?.currentSessionKeyId;
    final isSameCallDevice = callOnSessionKeyId != null && callOnSessionKeyId == currentSessionKeyId;
    final generalCase = callConditionList.contains(controller.currentUser()?.callStatus);
    final outgoingCase = outgoingCallConditionList.contains(controller.currentUser()?.callStatus);

    return (generalCase || outgoingCase) &&
        isSameCallDevice &&
        UChatCallController.instance.isCallFloatingScreenShouldShow != true;
  }

  final initCallFromBackground = usePerformance().newTrace('calling-initCallFromBackground');

  Future<bool> get isDuringCall async {
    if (Platform.isIOS) {
      final activeCalls = await FlutterCallkitIncoming.activeCalls() as List?;
      return activeCalls?.isNotEmpty == true;
    }

    return inCallState;
  }

  @override
  void onClose() async {
    await callkitStream?.cancel();
    await callSocketStream?.cancel();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    initCallFromBackground.start();
  }

  Future<void> initCall() async {
    initCallFromBackground.stop();
    removeExistingCallWhenAppLaunch();
    clearProximitySensor();
    UChatCallNativeMethodChanel.instance.initialize();
    await initIncomingCallListenerEvent();
    await initCallSocketListenerEvent();
    try {
      await callIntentCheck();
    } catch (e, st) {
      _log.e('call ctl :: >> initCall error', e, st);
    }
  }

  void clearProximitySensor() {
    // prevent sensor from being triggered when the app is in background
    if (GetPlatform.isAndroid) {
      GetIt.I<NativeMethodChannelService>().invokeMethod('stopProximitySensor');
    }
  }

  bool roomIsCalling(String? roomId) {
    final callController = callCtlList.firstOrNull;
    final callConditionList = [
      CallState.idle,
      CallState.connecting,
      CallState.connected,
    ];
    return callController != null &&
        callController.callData.roomId == roomId &&
        callConditionList.contains(callController.callData.callState);
  }

  Future<void> callIntentCheck() async {
    if (isSkipIntentCheck) return;
    isSkipIntentCheck = true;
    if (GetPlatform.isAndroid) {
      try {
        // Check if app is opened from close state
        // and has intent data (accept call when app is closed)
        final intent = await GetIt.I<NativeMethodChannelService>().invokeMethod('getIntentData');
        final callIntent = Map<String, dynamic>.from(intent);
        if (intent['action'] != null) {
          final callData = RoomCallModel.fromMap(callIntent);

          if (callData.roomCallId != null) {
            await GetIt.I<CallingServerRepository>().acceptCall(
              AcceptCallRequest(
                roomCallId: callData.roomCallId!,
              ),
            );
          }

          callData.callConnectionType = CallConnectionType.accept;
          callData.callState = CallState.connecting;
          final param = StartCallParam(
            callData: callData,
          );
          await GetIt.I<StartCallUseCase>().call(param);
        }
      } catch (e, st) {
        debugPrint('UChat callIntentCheck error $e');
        _log.e('call ctl :: >> callIntentCheck error', e, st);
        // If error occurs, we can assume that the app is not opened from intent
        // and we can proceed with normal flow
        await clearCallConfig();
      }
    } else if (GetPlatform.isIOS) {
      // Removed this intent check call twice.
      // Before that this function fixed call from history doesn't work
      // if app is closed
    }
  }

  Future clearCallConfig() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(currentCallSessionId);
    return Future.wait([
      config.authenticated.clearConfig(key: callLiveKitTokenKey),
      config.authenticated.clearConfig(key: callStartCallAtKey),
      config.authenticated.clearConfig(key: callRoomCallIdKey),
      config.authenticated.clearConfig(key: callLiveKitRoomSIDKey),
      config.authenticated.clearConfig(key: callRoomIDKey),
      config.authenticated.clearConfig(key: callRoomCallTypeKey),
      config.authenticated.clearConfig(key: callRoomNameKey),
    ]);
  }

  Future<RoomCallModel?> _fetchCallData() async {
    final callLiveKitToken = await config.authenticated.getStringWithDefault(
      key: callLiveKitTokenKey,
      defaultValue: '',
    );
    final callStartCallAt = await config.authenticated.getDateTime(
      key: callStartCallAtKey,
    );
    final callRoomCallId = await config.authenticated.getStringWithDefault(
      key: callRoomCallIdKey,
      defaultValue: '',
    );
    final callLiveKitRoomSID = await config.authenticated.getStringWithDefault(
      key: callLiveKitRoomSIDKey,
      defaultValue: '',
    );
    final callRoomID = await config.authenticated.getStringWithDefault(
      key: callRoomIDKey,
      defaultValue: '',
    );
    final callRoomCallType = await config.authenticated.getStringWithDefault(
      key: callRoomCallTypeKey,
      defaultValue: '',
    );

    final room = await roomDb.getRoom(callRoomID);
    if (room == null || room.id?.isNotEmpty != true) {
      return null;
    }

    return RoomCallModel(
      imageBlurHash: room.photoBlurhash ?? '',
      roomCallId: callRoomCallId,
      liveKitRoomSID: callLiveKitRoomSID,
      callState: CallState.idle,
      roomId: room.id,
      callType: CallType.fromString(callRoomCallType),
      roomType: room.roomType,
      title: room.title,
      imageUrl: room.roomAvatarUrl,
      liveKitToken: callLiveKitToken,
      startCallAt: callStartCallAt,
      callConnectionType: room.roomType == RoomType.group ? CallConnectionType.joinGroup : CallConnectionType.accept,
    );
  }

  Future<bool> openExistingCall() async {
    final callData = await _fetchCallData();
    if (callData == null) {
      return false;
    }

    final param = StartCallParam(
      callData: callData,
    );
    await GetIt.I<StartCallUseCase>().call(param);
    return false;
  }

  Future<void> removeExistingCall() async {
    for (var call in callCtlList) {
      call.disconnect('removeExistingCall');
    }
  }

  Future<void> removeExistingCallWhenAppLaunch() async {
    final callData = await _fetchCallData();
    if (callData == null) {
      return;
    }

    final param = DeclineCallParam(
      roomCallModel: callData,
      isCancel: false,
    );
    await GetIt.I<DeclineCallUseCase>().call(param);
  }

  Future<bool> checkExistingCall<C extends UChatLiveKitController>(RoomCallModel callData) async {
    if (Get.isRegistered<C>(tag: callData.roomId)) {
      final callCtl = Get.find<C>(tag: callData.roomId);
      if (callCtl.isDisconnected.value == false) {
        unawaited(openCallScreen<C>(callData));
        return true;
      }
      await removeCall<C>(callData);
    }
    return false;
  }

  void onJoinCall({required RoomCollection room}) async {
    final isGroup = room.roomType == RoomType.group;
    try {
      final callCtl = isGroup ? Get.find<StartGroupCallCtl>(tag: room.id) : Get.find<StartDirectCallCtl>(tag: room.id);

      if (callCtl.isDisconnected.value == false) {
        unawaited(openCallScreen(callCtl.callData));
        return;
      }
    } catch (e) {
      _log.d('call ctl :: >> onJoinCall error', e);
    }

    if (callCtlList.isEmpty) {
      try {
        final isOpen = await UChatCallController.instance.openExistingCall();
        if (!isOpen) {
          final param = StartCallParam(
            callData: RoomCallModel.generateJoinGroupCall(room, CallType.voice),
          );
          await GetIt.I<StartCallUseCase>().call(param);
        } else {
          callCtlList.firstOrNull?.openCallScreen();
        }
      } on ApiException catch (e, stackTrace) {
        // Ignore ApiException
        _log.w('call ctl :: >> onJoinCall ApiException', e, stackTrace);
      } catch (e, st) {
        await clearCallConfig();
        _log.w('call ctl :: >> openExistingCall error', e);
        showErrorDialog(
          e,
          st,
          description: '',
          isGroup: isGroup,
        );
      } finally {
        await UChatLoading.hide();
      }
    }
  }

  void onStartCall({
    required RoomCollection room,
    required RoomCallModel callData,
  }) async {
    final param = StartCallParam(
      callData: callData,
    );
    await GetIt.I<StartCallUseCase>().call(param);
  }

  void closeAnyCallScreen() {
    if (disconnecting() == true) {
      return;
    }
    callDuration.value = '';
    Get.until(
      (r) =>
          r.settings.name?.contains('/IncomingCallScreen') == false &&
          r.settings.name?.contains('/CallScreen') == false,
    );
  }

  Future<void> openIncomingCallScreen(RoomCallModel callData, {bool isGroupIncoming = false}) async {
    isInComingCall(true);
    closeAnyCallScreen();
    Get.until((route) {
      final isProfileBottomSheet = route.settings.name == 'ProfileEditBottomSheet';
      if (isProfileBottomSheet) {
        return true;
      }

      final isDialogOpen = Get.isDialogOpen == true;
      final screenUseCamera = [Routes.addContactByQr, Routes.takePhotoAndVideoPath].contains(route.settings.name);

      return !isDialogOpen && !screenUseCamera;
    });

    // delay for context menu to close
    await Future.delayed(UChatDuration.contextMenuPopupDuration + const Duration(milliseconds: 100));

    if (isGroupIncoming == false) {
      UChatCallSystemAudio.instance.playDialingSound();
    }

    await Get.to(
      () => PopScope(
        canPop: false,
        child: CallScreen(
          callData: callData,
          onAnswerCall: () => _onAnswerCall(callData, isGroupIncoming),
          onDeclineCall: () => _onDeclineCall(callData, isGroupIncoming),
        ),
      ),
      routeName: 'CallScreen',
      transition: Transition.downToUp,
      fullscreenDialog: true,
      duration: durationScreen,
    );

    UChatCallSystemAudio.instance.stopAllSounds();
    isInComingCall(false);
  }

  Future<void> _onAnswerCall(RoomCallModel callData, bool isGroupIncoming) async {
    try {
      if (isGroupIncoming) {
        callData.callConnectionType = CallConnectionType.joinGroup;
        callData.callState = CallState.connected;
        final param = StartCallParam(
          callData: callData,
        );
        await GetIt.I<StartCallUseCase>().call(param);
      } else {
        await useCallPerformance().startPerformanceCallingAccept(
          CallAttributesParams(
            roomCallId: callData.roomCallId,
            roomType: callData.roomType?.value,
            callType: callData.callType?.value,
            receivingFrom: ReceiveMethod.socket,
          ),
        );
        if (callData.roomCallId != null) {
          await GetIt.I<CallingServerRepository>().acceptCall(
            AcceptCallRequest(
              roomCallId: callData.roomCallId!,
            ),
          );
        }

        callData.callConnectionType = CallConnectionType.accept;
        callData.callState = CallState.connecting;
        final param = StartCallParam(
          callData: callData,
        );
        await GetIt.I<StartCallUseCase>().call(param);
      }
    } on ApiException catch (e, stackTrace) {
      // Ignore ApiException
      _log.w('call ctl :: >> onAnswerCall ApiException', e, stackTrace);
      showErrorDialog(
        e,
        stackTrace,
        description: '',
        isGroup: isGroupIncoming,
      );
    } catch (e, stackTrace) {
      _log.e('call ctl :: >> onAnswerCall error', e, stackTrace);
    }
  }

  Future<void> _onDeclineCall(RoomCallModel callData, bool isGroupIncoming) async {
    if (!isGroupIncoming) {
      await _onDeclineUseCase(callData, true);
    }
    Get.back();
  }

  Future<void> _onDeclineUseCase(RoomCallModel callData, bool isCancel) async {
    final param = DeclineCallParam(
      roomCallModel: callData,
      isCancel: isCancel,
    );
    await GetIt.I<DeclineCallUseCase>().call(param);
  }

  Future<void> openCallScreen<C extends UChatLiveKitController>(RoomCallModel callData) async {
    isCallScreenMinimize(false);
    try {
      if (isInComingCall.value) {
        await Get.off(
          () => CallScreen<C>(
            callData: callData,
          ),
          transition: Transition.downToUp,
          fullscreenDialog: true,
          routeName: '/CallScreenV2/${callData.roomId}',
          duration: durationScreen,
        );
      } else {
        Get.until((route) => route.settings.name?.contains('/CallScreenV2') != true && Get.isDialogOpen != true);
        await Get.to(
          () => CallScreen<C>(
            callData: callData,
          ),
          transition: Transition.downToUp,
          fullscreenDialog: true,
          routeName: '/CallScreenV2/${callData.roomId}',
          duration: durationScreen,
        );
      }
    } finally {
      isCallScreenMinimize(true);
    }
  }

  // TODO: Implement remove call as a use case in call controller.
  Future<void> removeCall<C extends GetxController>(
    RoomCallModel roomCall, {
    Future<void> Function()? beforeRemoveTask,
    AfterCallTask? afterRemoveTask,
  }) async {
    disconnecting(true);

    if (Get.isRegistered<C>(tag: roomCall.roomId) != true) {
      // if the call controller is not registered, we can assume the call is already ended
      // and hold the screen for 2.5 seconds to show the user the call screen before it disappears
      await Future.delayed(const Duration(milliseconds: 2500));
      disconnecting(false);
      return;
    }

    try {
      await beforeRemoveTask?.call();
    } catch (e) {
      _log.e('call ctl :: >> before remove task error', e);
    }

    try {
      final callCtl = Get.find<C>(tag: roomCall.roomId);

      callCtlList.remove(callCtl);
      await Get.delete<C>(tag: roomCall.roomId, force: true);
    } catch (e) {
      _log.e('call ctl :: >> remove call error', e);
    }

    if (roomCall.roomCallId?.isNotEmpty == true) {
      try {
        debugPrint('call FlutterCallkitIncoming to end call: call controller');
        await FlutterCallkitIncoming.endCall(roomCall.roomCallId!);
      } catch (e) {
        _log.e('call ctl :: >> end call error', e);
      }
    } else {
      _log.w('call ctl :: >> roomCallId is null or empty !');
    }

    // Hold the screen for 4 seconds to allow the user to see the call screen before it disappears
    await Future.delayed(const Duration(milliseconds: 2000));
    disconnecting(false);

    try {
      afterRemoveTask?.call();
    } catch (e) {
      _log.e('call ctl :: >> after remove task error', e);
    }

    try {
      await clearCallConfig();
    } catch (e) {
      _log.e('call ctl :: >> clear call config error', e);
    }
  }

  Future<void> initIncomingCallListenerEvent() async {
    try {
      final handler = UChatCallkitIncoming.instance.callkitIncomingHandler;
      callkitStream ??= FlutterCallkitIncoming.onEvent.listen(handler);
    } catch (e, st) {
      _log.e('call ctl :: >> Boot call error', e, st);
    }
  }

  Future<void> initCallSocketListenerEvent() async {
    try {
      callSocketStream = eventBus.on<SocketCallProcessEvent>().listen((event) {
        SocketCallProcess.instance.processCallSocket(event.roomCall);
      });
    } catch (e, st) {
      _log.e('call ctl :: >> Boot call error', e, st);
    }
  }

  Future<void> showErrorDialog(
    dynamic exception,
    StackTrace? stackTrace, {
    String? additionalText,
    String? description,
    bool isGroup = false,
  }) async {
    String? debugCode;
    String? type;
    String? dataType;

    if (exception is ApiException) {
      debugCode = exception.code?.toString();
      type = exception.type;
      dataType = exception.data?.type;
      description = '${exception.data?.description ?? ''} ${exception.data?.message ?? ''}';
    }

    if (exception is SocketException) {
      debugCode = 'SKE ${exception.osError?.errorCode}';

      // TODO : handle socket exception
      // exception.osError?.message;
      // exception.osError?.errorCode;
      // exception.address?.address;
      // flutter:   ERROR │ ClientException with SocketException: Failed \n
      // host lookup: 'uchat-dev-8t31hdb9.livekit.cloud' \n
      // (OS Error: nodename nor servname provided, or not known, errno = 8), \n
      // uri=https://uchat-dev-8t31hdb9.livekit.cloud/rtc/validate\n
      // ?access_token=tokenboydy1.tokenboydy2.tokenboydy3&auto_subscribe=1&adaptive_stream=1&protocol=12&sdk=flutter&version=2.3.2&network=wifi&os=iOS&os_version=18.1.1&device_model=iPhone12%2C1

      // UChatDialog.showExceptionDialog(
      //   title: 'Unknown error code (${exception.osError?.errorCode})',
      //   description: exception.osError?.message,
      //   showReportBugWidget: true,
      // );
      // return;
    }

    if (exception is ApiValidationException) {
      debugCode = exception.code?.toString();
      type = exception.type;
      dataType = exception.data?.type;
      description = exception.data?.description ?? '';
    }

    if (Get.isDialogOpen == true) {
      Get.until((r) {
        return Get.isDialogOpen == false;
      });
    }

    // if (true) {
    //   // TODO: if debug mode show description
    //   description = '';
    // }

    switch (type) {
      case 'ERR_ROOM_CALL_CANNOT_START':
        if (isGroup && dataType == 'CANNOT_START_HAS_ANOTHER_CALL') {
          CallInProgressDifferentDialog.show();
        } else if (dataType == 'CANNOT_START_ACCOUNT_IS_ON_ANOTHER_CALL') {
          await CallBusyDialog.show();
        } else {
          await CallUnableDialog.show();
        }
        return;
      case 'ERR_ROOM_PERMISSION_CANNOT_SEND_MESSAGE_IN_ROOM':
        additionalText ??= '(00)';
        debugCode ??= '00';
        break;
      case 'CANNOT_START_ACCOUNT_IS_NOT_FOUND_IN_ROOM':
        additionalText ??= '(01)';
        debugCode ??= '1';

        break;
      case 'CANNOT_START_ACCOUNT_IS_ON_ANOTHER_CALL':
        additionalText ??= '(02)';
        debugCode ??= '2';
        break;
      case 'CANNOT_START_ROOM_IS_NOT_GROUP':
        additionalText ??= '(03)';
        debugCode ??= '3';
        break;
      case 'CANNOT_START_ROOM_IS_NOT_IN_PROGRESS':
        additionalText ??= '(04)';
        debugCode ??= '4';
        break;
      case 'ERR_ROOM_ACCOUNT_IS_NOT_FRIEND':
        additionalText ??= '(05)';
        debugCode ??= '5';
        break;
      case 'ERR_ROOM_ACCOUNT_IS_BLOCK_FRIEND':
        additionalText ??= '(06)';
        debugCode ??= '6';
        break;
      case 'ERR_ROOM_NOT_FOUND':
        additionalText ??= '(07)';
        debugCode ??= '7';
        break;
      case 'ERR_ROOM_CALL_NOT_FOUND':
        additionalText ??= '(08)';
        debugCode ??= '8';
        break;
      default:
        additionalText ??= '(99)';
        break;
    }
    await FirebaseCrashlytics.instance.recordError(
      exception,
      stackTrace,
      reason: 'unhandled error with calling',
      printDetails: true,
      fatal: true,
    );
    await CallUnableDialog.show(debugCode: debugCode, exception: exception);
  }
}
