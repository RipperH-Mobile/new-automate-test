import 'dart:convert';

import 'package:flutter_callkit_incoming/entities/entities.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/call_performance_service.dart';
import 'package:uchat/core/infrastructure/analytics/enum/receive_method.dart';
import 'package:uchat/core/infrastructure/analytics/param/call_attribute_param.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/entities/models/call_kit_params_model.dart';
import 'package:uchat/features/call/data/models/models/room_call_model.dart';
import 'package:uchat/features/call/domain/params/decline_call_param.dart';
import 'package:uchat/features/call/domain/params/start_call_param.dart';
import 'package:uchat/features/call/domain/user_cases/decline_call_use_case.dart';
import 'package:uchat/features/call/domain/user_cases/start_call_use_case.dart';
import 'package:uchat/features/call/livekit/parent/uchat_livekit_controller.dart';
import 'package:uchat/features/call/utils/enum.dart';

import 'call_controller.dart';

final _log = useLogger();

class UChatCallkitIncoming {
  factory UChatCallkitIncoming() => instance;

  UChatCallkitIncoming.internal();

  static final UChatCallkitIncoming instance = UChatCallkitIncoming.internal();

  UChatCallController get callCtl => Get.find<UChatCallController>();

  Future<void> showCallkitIncoming(CallKitParamsModel data) async {
    await FlutterCallkitIncoming.showCallkitIncoming(
      callKitParamsModelGenerator(data),
    );
  }

  Future<void> setCallConnected(RoomCallModel callData) async {
    if (callData.roomCallId != null) {
      try {
        await FlutterCallkitIncoming.setCallConnected(callData.roomCallId!);
      } catch (e) {
        _log.e('Error setCallConnected: $e');
      }
    }
  }

  Future<void> createIosCallKit(RoomCallModel callData) async {
    try {
      final params = callKitParamsModelGenerator(
        CallKitParamsModel(
          name: callData.title,
          avatar: callData.imageUrl,
          liveKitToken: callData.liveKitToken,
          liveKitRoomSid: callData.liveKitRoomSID,
          background: callData.imageUrl,
          roomCallId: callData.roomCallId,
          roomId: callData.roomId,
          roomType: callData.roomType,
          callType: callData.callType,
          type: callData.callType == CallType.video ? 1 : 0,
        ),
      );

      if (GetPlatform.isAndroid) {
        FlutterCallkitIncoming.hideCallkitIncoming(params); // This task await permanently.
      }

      if (!GetPlatform.isIOS) return;

      final activeCalls = await FlutterCallkitIncoming.activeCalls() as List?;
      final isActiveCall = activeCalls?.isNotEmpty == true;

      if (!isActiveCall) {
        await FlutterCallkitIncoming.startCall(params);
      }
    } catch (e, st) {
      _log.e('Error createIosCallKit: ', e, st);
    }
  }

  CallKitParams callKitParamsModelGenerator(CallKitParamsModel data) {
    // uuid(const Uuid().v4().toString());
    final params = CallKitParams(
      id: data.roomCallId,
      nameCaller: data.name,
      appName: 'UChat',
      avatar: data.avatar,
      handle: '${data.roomId},${data.roomCallId}',
      type: data.callType == CallType.video ? 1 : 0,
      duration: 30000,
      textAccept: 'Accept',
      textDecline: 'Decline'.tr,
      missedCallNotification: const NotificationParams(
        subtitle: 'Missed call',
        callbackText: 'Call back',
        showNotification: true,
        isShowCallback: true,
      ),
      extra: <String, dynamic>{
        'liveKitToken': data.liveKitToken.toString(),
        'roomId': data.roomId,
        'roomType': data.roomType?.value,
        'callType': data.callType?.value,
        'liveKitRoomSID': data.liveKitRoomSid,
        'roomCallId': data.roomCallId,
      },
      headers: <String, dynamic>{'platform': 'flutter'},
      android: AndroidParams(
        isCustomNotification: true,
        isShowLogo: false,
        ringtonePath: 'system_ringtone_default',
        // backgroundColor: '#0955fa',
        backgroundUrl: data.avatar,
        actionColor: '#4CAF50',
        incomingCallNotificationChannelName: 'Incoming Call',
        missedCallNotificationChannelName: 'Missed Call',
      ),
      ios: IOSParams(
        iconName: 'appIconWhite',
        handleType: '',
        supportsVideo: data.callType == CallType.video,
        maximumCallGroups: 2,
        maximumCallsPerCallGroup: 1,
        audioSessionMode: (data.callType == CallType.video) ? 'videoChat' : 'None',
        //None as `default` type in native, gameChat, measurement, moviePlayback, spokenAudio, videoChat, videoRecording, voiceChat, voicePrompt
        audioSessionActive: true,
        audioSessionPreferredSampleRate: 44100.0,
        audioSessionPreferredIOBufferDuration: 0.005,
        supportsDTMF: true,
        supportsHolding: true,
        supportsGrouping: false,
        supportsUngrouping: false,
        ringtonePath: 'system_ringtone_default',
        dialingEnable: data.roomType != RoomType.group,
      ),
    );
    return params;
  }

  Future<void> callkitIncomingHandler(CallEvent? event) async {
    final params = jsonDecode(
      jsonEncode(event?.body as Map<dynamic, dynamic>?),
    );

    CallKitParams? calling;
    String? actualRoomCallId;

    if (params != null) {
      calling = CallKitParams.fromJson(params);
      actualRoomCallId ??= calling.extra?['roomCallId'];
      actualRoomCallId ??= calling.id;
    }
    switch (event?.event) {
      case Event.actionCallIncoming:
        break;
      case Event.actionCallStart:
        // started an outgoing call
        break;
      case Event.actionCallAccept:
        // When we call `UChatCallkitIncoming.instance.setCallConnected(callData)`
        // Call kit will call this event with null extra data.
        // So if the event no extra data, do nothing.
        if (calling?.extra?.isNotEmpty != true) {
          return;
        }
        CallType? callType =
            calling?.extra?['callType'] != null ? CallType.fromString(calling?.extra?['callType']) : null;
        String callTypeString = callType == null
            ? 'unknown'
            : callType == CallType.video
                ? 'video'
                : 'voice';
        await useCallPerformance().startPerformanceCallingAccept(
          CallAttributesParams(
            roomCallId: actualRoomCallId,
            roomType: calling?.extra?['roomType'] as String?,
            callType: calling?.extra?['callType'] as String?,
            receivingFrom: ReceiveMethod.native,
          ),
        );
        GetIt.I<TaxonomyService>()
            .sendEvent(EventName.callAccepted, eventProperties: EventProperty.callAccepted('in-app', callTypeString));
        final data = RoomCallModel(
          title: calling?.nameCaller ?? '',
          imageUrl: calling?.avatar ?? '',
          imageBlurHash: calling?.extra?['imageBlurHash'] ?? '',
          roomId: calling?.extra?['roomId'] ?? '',
          roomCallId: actualRoomCallId ?? '',
          liveKitRoomSID: calling?.extra?['liveKitRoomSID'],
          callType: callType,
          roomType: calling?.extra?['roomType'] != null ? RoomType.from(calling?.extra?['roomType']) : null,
          callState: CallState.idle,
          liveKitToken: '',
          roomCallIdChain: calling?.extra?['roomCallIdChain'] ?? '',
          callConnectionType: CallConnectionType.accept,
        );
        final param = StartCallParam(
          callData: data,
        );
        await GetIt.I<StartCallUseCase>().call(param);
        break;
      case Event.actionCallDecline:
      // cancel call
      // declined an incoming call
      case Event.actionCallEnded:
      // end call form lock screen button ios
      case Event.actionCallTimeout:
        if (actualRoomCallId?.isNotEmpty == true && calling?.extra?['liveKitRoomSID']?.isNotEmpty == true) {
          final call = callCtl.callCtlList.firstWhereOrNull(
            (element) => element.callData.roomCallId == actualRoomCallId,
          );

          if (call == null && RoomType.from(calling?.extra?['roomType']) == RoomType.direct) {
            // Decline/ Cancel Incoming call callCtl.callCtlList is empty, call?.disconnect() will not work.
            // await UChatCallController.instance.handleDeclineCall(
            //   actualRoomCallId!,
            //   calling?.extra?['liveKitRoomSID'] ?? '',
            //   isCancel: true,
            // );

            // TODO: Check this
            final param = DeclineCallParam(
              roomCallModel: RoomCallModel.fromMap(calling!.extra!),
              isCancel: true,
            );
            await GetIt.I<DeclineCallUseCase>().call(param);
          } else {
            call?.disconnect('${event?.event} native incoming');
          }
        } else {
          if (callCtl.callCtlList.isEmpty) {
            callCtl.closeAnyCallScreen();
          }
          _log.w(
            'Error callkitIncomingHandler actualRoomCallId[$actualRoomCallId], liveKitRoomSID[${calling?.extra?['liveKitRoomSID']}] are null or empty',
          );
        }
        break;
      case Event.actionCallCallback:
        // only Android - click action `Call back` from missed call notification
        break;
      case Event.actionCallToggleHold:
        // only iOS
        if (GetPlatform.isIOS) {
          final controller = callCtl.callCtlList.firstWhereOrNull(
              (element) => element.callData.roomCallId?.toLowerCase() == actualRoomCallId?.toLowerCase());
          if (controller != null && params['isOnHold'] is bool) {
            controller.setMicFromCallKit(isMuted: params['isOnHold']);
          }
        }
        break;
      case Event.actionCallToggleMute:
        // only iOS
        if (GetPlatform.isIOS) {
          final controller = callCtl.callCtlList.firstWhereOrNull(
              (element) => element.callData.roomCallId?.toLowerCase() == actualRoomCallId?.toLowerCase());
          if (controller != null && params['isMuted'] is bool) {
            controller.setMicFromCallKit(isMuted: params['isMuted']);
          }
        }
        break;
      case Event.actionCallToggleDmtf:
        // only iOS
        break;
      case Event.actionCallToggleGroup:
        // only iOS
        break;
      case Event.actionCallToggleAudioSession:
        // only iOS
        break;
      case Event.actionDidUpdateDevicePushTokenVoip:
        // only iOS
        break;
      case Event.actionCallCustom:
        final ctl = callCtl.callCtlList.firstOrNull;

        if (params['isMuted'] != null) {
          ctl?.toggleMic(value: !(params['isMuted'] == true));
        }

        if (params['isSpeaker'] != null) {
          ctl?.toggleSpeaker(value: !params['isSpeaker'] == true);
        }

        if (params['isVideo'] != null) {
          ctl?.toggleCamera(value: params['isVideo']);
        }
        break;
      default:
        break;
    }
  }
}
