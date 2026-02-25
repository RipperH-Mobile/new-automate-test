import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uchat/controllers/permission_controller.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/performance_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/call/call_kit_incoming.dart';
import 'package:uchat/features/call/data/models/models/room_call_model.dart';
import 'package:uchat/features/call/data/models/requests/accept_call_request.dart';
import 'package:uchat/features/call/data/models/requests/start_call_request.dart';
import 'package:uchat/features/call/domain/params/decline_call_param.dart';
import 'package:uchat/features/call/domain/params/start_call_param.dart';
import 'package:uchat/features/call/domain/repositories/calling_server_repository.dart';
import 'package:uchat/features/call/domain/user_cases/decline_call_use_case.dart';
import 'package:uchat/features/call/livekit/parent/uchat_livekit_controller.dart';
import 'package:uchat/features/call/livekit/start_group_call_controller.dart';
import 'package:uchat/features/call/presentation/views/widgets/dialogs/call_in_progress_dialog.dart';
import 'package:uchat/features/call/presentation/views/widgets/dialogs/call_in_progress_different_dialog.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/use_cases/use_case.dart';

import '../../livekit/start_direct_call_controller.dart';

final _log = useLogger();

class StartCallUseCase extends SimpleUseCase<void, StartCallParam> {
  StartCallUseCase({
    required this.callingServerRepository,
    required this.callController,
    required this.permissionController,
    required this.userController,
    required this.callKitController,
    required this.config,
  });

  final CallingServerRepository callingServerRepository;
  final UChatCallController callController;
  final PermissionController permissionController;
  final UserController userController;
  final UChatCallkitIncoming callKitController;
  final ConfigInstance config; //  config.authenticated

  @override
  Future<void> call(StartCallParam params) async {
    final startCallTrace = usePerformance().create('performance_calling_startcall_usecase', useFpsMonitoring: true)
      ..start();
    startCallTrace.putAttribute('call_connection_type', params.callData.callConnectionType?.name ?? 'unknown');
    eventBus.fire(CallIncomingEvent());

    if (params.callData.roomType == RoomType.group) {
      final startCallUseCaseGroup = usePerformance().create('calling-startCallUseCase-group', useFpsMonitoring: true);
      startCallUseCaseGroup.start();
      try {
        final liveKitCallCtl = StartGroupCallCtl(callData: params.callData);
        await addCall<StartGroupCallCtl>(
          params.callData,
          ctl: liveKitCallCtl,
        );
      } catch (e, st) {
        EventProperty.getNetworkTypeForEventParams().then((String networkType) {
          String callType = params.callData.callType == CallType.video ? 'video' : 'voice';
          GetIt.I<TaxonomyService>().sendEvent(EventName.callFailed,
              eventProperties: EventProperty.callFailed(callType, networkType, e.toString()));
        });
        _log.e('handleStartGroupCall error.', e, st);
      }
      startCallUseCaseGroup.stop();
    } else {
      final startCallUseCaseDirect = usePerformance().newTrace('calling-startCallUseCase-direct');
      startCallUseCaseDirect.start();
      try {
        final liveKitCallCtl = StartDirectCallCtl(callData: params.callData);
        await addCall<StartDirectCallCtl>(
          params.callData,
          ctl: liveKitCallCtl,
        );
      } catch (e, st) {
        EventProperty.getNetworkTypeForEventParams().then((String networkType) {
          String callType = params.callData.callType == CallType.video ? 'video' : 'voice';
          GetIt.I<TaxonomyService>().sendEvent(EventName.callFailed,
              eventProperties: EventProperty.callFailed(callType, networkType, e.toString()));
        });
        _log.e('handleStartCall error.', e, st);
      }
      startCallUseCaseDirect.stop();
    }
    startCallTrace.stop();
  }

  Future<void> addCall<C extends UChatLiveKitController>(RoomCallModel callData, {required C ctl}) async {
    // if (Get.context == null) {
    //   return;
    // }
    // Microphone permission
    bool micGranted = await permissionController.requestMicrophonePermissionDirect(Get.context!);
    if (!micGranted) {
      EventProperty.getNetworkTypeForEventParams().then((String networkType) {
        String callType = callData.callType == CallType.video ? 'video' : 'voice';
        GetIt.I<TaxonomyService>().sendEvent(EventName.callFailed,
            eventProperties: EventProperty.callFailed(callType, networkType, 'permission denied'));
      });
      return;
    }

    // Camera permission (for video calls)
    if (callData.callType == CallType.video) {
      // ignore: use_build_context_synchronously
      bool cameraGranted = await permissionController.requestCameraPermissionDirect(Get.context!);
      if (!cameraGranted) {
        EventProperty.getNetworkTypeForEventParams().then((String networkType) {
          String callType = callData.callType == CallType.video ? 'video' : 'voice';
          GetIt.I<TaxonomyService>().sendEvent(EventName.callFailed,
              eventProperties: EventProperty.callFailed(callType, networkType, 'permission denied'));
        });
        return;
      }
    }

    final isExist = await callController.checkExistingCall<C>(callData);
    if (isExist) {
      EventProperty.getNetworkTypeForEventParams().then((String networkType) {
        String callType = callData.callType == CallType.video ? 'video' : 'voice';
        GetIt.I<TaxonomyService>()
            .sendEvent(EventName.callFailed, eventProperties: EventProperty.callFailed(callType, networkType, 'busy'));
      });
      return;
    }

    final currentUser = userController.currentUser.value;
    final callOnSessionKeyId = currentUser?.callOnSessionKeyId;
    final currentSessionKeyId = currentUser?.currentSessionKeyId;
    final isSameCallDevice = callOnSessionKeyId != null && callOnSessionKeyId == currentSessionKeyId;
    if (currentUser!.isCalling && !callController.roomIsCalling(callData.roomId)) {
      EventProperty.getNetworkTypeForEventParams().then((String networkType) {
        String callType = callData.callType == CallType.video ? 'video' : 'voice';
        GetIt.I<TaxonomyService>()
            .sendEvent(EventName.callFailed, eventProperties: EventProperty.callFailed(callType, networkType, 'busy'));
      });
      if (!isSameCallDevice) {
        CallInProgressDifferentDialog.show();
        return;
      }
      if (isSameCallDevice && callController.callCtlList.isNotEmpty) {
        CallInProgressDialog.show();
        return;
      }
    }

    if (callController.callCtlList.isNotEmpty) {
      CallInProgressDialog.show();
      return;
    }
    final activeCalls = await FlutterCallkitIncoming.activeCalls();
    if (activeCalls != null &&
        activeCalls is List &&
        activeCalls.isNotEmpty &&
        callData.callConnectionType != CallConnectionType.accept) {
      CallInProgressDialog.show();
      return;
    }

    final callCtl = Get.put<C>(
      ctl,
      tag: callData.roomId,
      permanent: true,
    );
    callController.callCtlList.add(callCtl);
    callController.openCallScreen<C>(callData);

    try {
      final requestCallTrace = usePerformance().create('performance_calling_request_token', useFpsMonitoring: true)
        ..start();
      requestCallTrace.putAttribute('call_connection_type', callData.callConnectionType?.name ?? 'unknown');
      callData = await _requestToken(callData);
      callCtl.callData = callData;
      requestCallTrace.stop();
    } catch (e, st) {
      _log.e('call ctl :: >> request token error, ${callData.toString()}', e, st);
      // TODO: Implement remove call as a use case in call controller.
      await callController.removeCall<C>(
        callData,
        beforeRemoveTask: () async {
          callController.closeAnyCallScreen();

          // if user disconnect before error unnecessary to show dialog.
          if (callCtl.isDisconnected.value != true) {
            callController.showErrorDialog(
              e,
              st,
              description: '',
              isGroup: callData.roomType == RoomType.group,
            );
            try {
              final param = DeclineCallParam(
                roomCallModel: callData,
                isCancel: callData.callState != CallState.connected,
              );
              await GetIt.I<DeclineCallUseCase>().call(param);
            } catch (e, st) {
              _log.e('Error disposing call: ', e, st);
            }
          }
        },
        afterRemoveTask: null,
      );
      return;
    }
    if (callCtl.isDisconnected.value) {
      await callCtl.disconnect('user cancel call after request token');
      return;
    } else {
      if (callData.callConnectionType != CallConnectionType.accept &&
          currentUser.accountSettings?.call?.allowCallKit == true) {
        await callKitController.createIosCallKit(callData);
      }
      try {
        await callCtl.initialStartingUp();
      } catch (e, st) {
        EventProperty.getNetworkTypeForEventParams().then((String networkType) {
          String callType = callData.callType == CallType.video ? 'video' : 'voice';
          GetIt.I<TaxonomyService>().sendEvent(EventName.callFailed,
              eventProperties: EventProperty.callFailed(callType, networkType, 'network_error'));
        });
        _log.e('call ctl :: >> initial starting up error', e, st);
      }
      try {
        await callCtl.connect();
      } catch (e, st) {
        EventProperty.getNetworkTypeForEventParams().then((String networkType) {
          String callType = callData.callType == CallType.video ? 'video' : 'voice';
          GetIt.I<TaxonomyService>().sendEvent(EventName.callFailed,
              eventProperties: EventProperty.callFailed(callType, networkType, 'network_error'));
        });
        _log.e('call ctl :: >> connect error', e, st);
      }
    }
  }

  Future<RoomCallModel> _requestToken(RoomCallModel callData) async {
    if (callData.liveKitToken?.isNotEmpty == true) return callData;
    if (callData.roomId?.isNotEmpty != true) {
      throw Exception('Room ID is empty');
    }
    if (callData.callType == null) {
      throw Exception('callType is null');
    }

    try {
      await callController.clearCallConfig();
    } catch (e, st) {
      _log.w('call ctl :: >> clear call config error', e, st);
    }

    try {
      switch (callData.callConnectionType!) {
        case CallConnectionType.accept:
          final acceptedToken = await callingServerRepository.acceptCall(
            AcceptCallRequest(
              roomCallId: callData.roomCallId!,
            ),
          );
          if (acceptedToken?.isNotEmpty != true) {
            throw Exception('LiveKit token is empty');
          }
          callData.liveKitToken = acceptedToken!;
          await _saveCallData(callData);
          return callData;
        case CallConnectionType.joinGroup:
        case CallConnectionType.startGroup:
        case CallConnectionType.start:
          final resp = await callingServerRepository.startCall(
            StartCallRequest(
              callType: callData.callType!,
              roomId: callData.roomId!,
            ),
          );

          if (resp?.liveKitToken?.isNotEmpty != true) {
            throw Exception('LiveKit token is empty');
          }
          callData.startCallAt = resp?.startCallAt;
          callData.liveKitRoomSID = resp?.liveKitRoomSID ?? '';
          callData.roomCallId = resp?.roomCallId ?? '';
          callData.liveKitToken = resp!.liveKitToken!;
          callData.callType = CallType.fromString(resp.callType);
          _log.i(
            'start_group_call_duration: ${resp.startCallAt}, now: ${DateTime.now()}, roomID: ${callData.roomId}, roomCallId: ${resp.roomCallId}, liveKitRoomSID: ${resp.liveKitRoomSID}, callType: ${callData.callType}',
          );
          await _saveCallData(callData);
          return callData;
      }
    } catch (e) {
      _log.e('Error setting up token: (${callData.callConnectionType.toString()})', e);
      rethrow;
    }
  }

  Future<void> _saveCallData(RoomCallModel callData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(currentCallSessionId, callData.callOnSessionKeyId ?? '');

    if (callData.liveKitToken?.isNotEmpty == true) {
      await config.saveConfig(
        key: callLiveKitTokenKey,
        value: callData.liveKitToken,
      );
    }
    if (callData.startCallAt != null) {
      await config.saveConfig(
        key: callStartCallAtKey,
        value: callData.startCallAt,
      );
    }
    if (callData.roomCallId?.isNotEmpty == true) {
      await config.saveConfig(
        key: callRoomCallIdKey,
        value: callData.roomCallId,
      );
    }
    if (callData.liveKitRoomSID?.isNotEmpty == true) {
      await config.saveConfig(
        key: callLiveKitRoomSIDKey,
        value: callData.liveKitRoomSID,
      );
    }
    if (callData.roomId?.isNotEmpty == true) {
      await config.saveConfig(
        key: callRoomIDKey,
        value: callData.roomId,
      );
    }
    if (callData.callType != null) {
      await config.saveConfig(
        key: callRoomCallTypeKey,
        value: callData.callType?.value,
      );
    }

    if (callData.title?.isNotEmpty == true) {
      await config.saveConfig(
        key: callRoomNameKey,
        value: callData.title,
      );
    }
  }
}
