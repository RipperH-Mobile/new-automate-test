import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:uchat/core/infrastructure/analytics/enum/receive_method.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/performance_service.dart';
import 'package:uchat/core/infrastructure/analytics/call_performance_service.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/call/call_kit_incoming.dart';
import 'package:uchat/features/call/call_system_audio.dart';
import 'package:uchat/features/call/data/models/models/room_call_model.dart';
import 'package:uchat/features/call/livekit/parent/uchat_livekit_controller.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/call/utils/extend_duration.dart';
import 'package:vibration/vibration.dart';

import '../../../core/infrastructure/analytics/taxonomy_service.dart';

class StartDirectCallCtl extends UChatLiveKitController {
  StartDirectCallCtl({required super.callData});

  @override
  bool get isNotExisting => Get.isRegistered<StartDirectCallCtl>(tag: callData.roomId) != true;

  Timer? timerCallTimeOut;
  Timer? timerCallPing;

  bool get directFloatingScreenShow {
    return (isParticipantOpenCamera() || cameraOn()) &&
        callData.callState == CallState.connected &&
        callCtl.isCallScreenMinimize();
  }

  bool isUnstableNetwork(Participant<TrackPublication<Track>> participant) {
    return (participant.connectionQuality == ConnectionQuality.poor ||
        participant.connectionQuality == ConnectionQuality.lost ||
        participant.connectionQuality == ConnectionQuality.unknown);
  }

  DateTime? callStartCallAt;

  final callingParticipantMatching = usePerformance().newTrace('calling-LiveKit-participant-matching');

  final _log = useLogger();

  @override
  startCallTimer() async {
    if (isRecording.value) {
      return;
    }
    isRecording.value = true;
    useCallPerformance().stopPerformanceCallingAccept(
      receiveMethod: ReceiveMethod.socket,
    );
    useCallPerformance().stopPerformanceCallingAccept(
      receiveMethod: ReceiveMethod.native,
    );

    // Save to local storage in case of app crash/ user clear app
    // When open exiting call, we will get this value to continue the call
    if (callStartCallAt == null) {
      // user Vibration because haptic so light for Vibration
      if (await Vibration.hasVibrator() == true) {
        Vibration.vibrate(duration: 250);
      }

      if (callData.callConnectionType == CallConnectionType.accept) {
        callCtl.config.authenticated.saveConfig(
          key: callStartCallAtKey,
          value: room?.localParticipant?.joinedAt.toLocal() ?? DateTime.now(),
        );
      } else {
        callCtl.config.authenticated.saveConfig(
          key: callStartCallAtKey,
          value: room?.remoteParticipants.values.toList().firstOrNull?.joinedAt.toLocal() ?? DateTime.now(),
        );
      }
    }
    if (callTimer == null) {
      if (callData.callConnectionType == CallConnectionType.start) {
        debugPrint('Call setCallConnected: ${callData.roomCallId} ${callData.callConnectionType}');
        await UChatCallkitIncoming.instance.setCallConnected(callData);
      }
    }
    final DateTime startAt = callStartCallAt ?? DateTime.now();

    callTimer ??= Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        final diff = DateTime.now().difference(startAt);
        callDuration.value = diff.toMMSS();
        callUiRefreshCheck = !callUiRefreshCheck;
        if (isDisconnected.value) {
          isRecording.value = false;
          timer.cancel();
        }
      },
    );
  }

  @override
  toggleCameraHelper() async {
    await super.toggleCameraHelper();
    if (callData.callState == CallState.connecting) {
      uiState.value = UiCallState.outgoing;
    } else if (cameraOn()) {
      uiState.value = UiCallState.video;
    } else {
      uiState.value = UiCallState.voice;
    }
  }

  @override
  void openCallScreen<C extends UChatLiveKitController>() {
    /// Need to explicitly class type.
    /// Don't remove
    super.openCallScreen<StartDirectCallCtl>();
  }

  @override
  void roomDataListener(RoomCallModel? data) {
    // This event is called when the room data is updated.
    // it always call
    switch (data?.callState) {
      case CallState.idle:
        status.value = 'Connecting...'.tr;
        break;
      case CallState.connecting:
        EventProperty.getNetworkTypeForEventParams().then((String networkType) {
          String callType = callData.callType == CallType.video ? 'video' : 'voice';
          GetIt.I<TaxonomyService>()
              .sendEvent(EventName.callStarted, eventProperties: EventProperty.callStarted(callType, networkType));
        });
        status.value = 'Calling...'.tr;
        playDialingSound();
        break;
      case CallState.connected:
        status.value = 'Connected...'.tr;
        debugPrint('Call connected: ${callData.roomCallId}');
        onConnected();
        callingParticipantMatching.stop();
        break;
      case CallState.disconnecting:
        status.value = 'Disconnecting...'.tr;
        break;
      case CallState.disconnected:
        status.value = 'Disconnected...'.tr;
        break;
      case CallState.paused:
        if (callData.callConnectionType == CallConnectionType.start) {
          callingParticipantMatching.start();
        }
        status.value = 'Connecting...'.tr;
        timerCallTimeOut?.cancel();
        break;
      default:
        break;
    }
  }

  @override
  onInit() async {
    super.onInit();
    // Prevent decline call when app is in background or call type is accept
    if (callData.callConnectionType == CallConnectionType.start) {
      timerCallTimeOut = Timer(
        const Duration(minutes: 1),
        () async {
          if (callData.callState != CallState.connected) {
            disconnect('Call timeout (Flutter timer)');
          }
          timerCallTimeOut?.cancel();
        },
      );
    }

    if (callData.callConnectionType == CallConnectionType.accept) {
      callingParticipantMatching.start();
    }
  }

  @override
  onClose() async {
    await callUiStateSubscription?.cancel();
    timerCallTimeOut?.cancel();
    timerCallPing?.cancel();
    callingParticipantMatching.stop();
    super.onClose();
  }

  @override
  Future<void> connect<C extends UChatLiveKitController>() async {
    final livekitCallTrace = usePerformance().create('performance_calling_livekit_connect', useFpsMonitoring: true)
      ..start();
    if (callData.callType == CallType.video) {
      cameraOn(true);
    }
    await super.connect<StartDirectCallCtl>();

    if (callData.callConnectionType == CallConnectionType.start) {
      final List<RemoteParticipant>? rawParticipantList = room?.remoteParticipants.values.toList();
      if (callData.callState == CallState.idle && (rawParticipantList == null || rawParticipantList.isEmpty)) {
        callState = CallState.connecting;
        uiState.value = UiCallState.ringing;
      } else {
        callState = CallState.connected;
      }
    }

    if (callData.callConnectionType == CallConnectionType.accept) {
      callState = CallState.connected;
    }

    livekitCallTrace.putAttribute('call_connection_type', callData.callConnectionType?.name ?? 'unknown');

    super.setUpStartCallListeners();
    room?.addListener(onRoomDidUpdate);
    livekitCallTrace.stop();
  }

  @override
  Future<void> disconnect<C extends UChatLiveKitController>(String reason) async {
    /// Need to explicitly class type.
    if (callData.roomCallId?.isNotEmpty == false) {
      return;
    }

    // if (callData.roomCallId?.isNotEmpty == false || callData.liveKitRoomSID?.isNotEmpty == false) {
    //   return;
    // }

    await super.disconnect<StartDirectCallCtl>(reason);
  }

  @override
  Future<void> beforeRemoveTask() async {
    callCtl.callDuration.value = callDuration.value;

    await super.beforeRemoveTask();
  }

  @override
  liveKitCancelEventAndDisconnect() async {
    room?.removeListener(onRoomDidUpdate);
    await super.liveKitCancelEventAndDisconnect();
  }

  @override
  onRoomDisconnectedEvent(RoomDisconnectedEvent event) {
    callState = CallState.disconnected;
    super.onRoomDisconnectedEvent(event);
  }

  @override
  onActiveSpeakersChangedEvent(ActiveSpeakersChangedEvent event) {
    final remoteActive = event.speakers.any((e) {
      return e is! LocalParticipant;
    });

    if (callData.callState == CallState.connecting && remoteActive) {
      stopSound();
      callState = CallState.connected;
    }

    super.onActiveSpeakersChangedEvent(event);
  }

  @override
  onParticipantConnectedEvent(ParticipantConnectedEvent event) async {}

  @override
  onTrackSubscribedEvent(TrackSubscribedEvent event) async {
    onLiveKitConnected();
    super.onTrackSubscribedEvent(event);
  }

  void onLiveKitConnected() {
    callState = CallState.connected;
    EventProperty.getNetworkTypeForEventParams().then((String networkType) {
      String callType = callData.callType == CallType.video ? 'video' : 'voice';
      String networkQuality = super.localParticipant()?.participant.connectionQuality.name ?? 'unknown';
      GetIt.I<TaxonomyService>().sendEvent(EventName.callConnected,
          eventProperties: EventProperty.callConnected(callType, networkType, networkQuality));
    });
  }

  @override
  void onDataReceivedEvent(DataReceivedEvent event) {}

  @override
  onRoomDidUpdate() async {
    if (callData.callState == CallState.connected) {
      final List<RemoteParticipant>? rawParticipantList = room?.remoteParticipants.values.toList();
      if (rawParticipantList == null || rawParticipantList.isEmpty) {
        internetUnStable.value = true;
        return;
      }
    }
    super.onRoomDidUpdate();
  }

  @override
  void onParticipantConnectionQualityUpdatedEvent(ParticipantConnectionQualityUpdatedEvent event) {
    super.onParticipantConnectionQualityUpdatedEvent(event);
    if (event.participant is! LocalParticipant) return;

    if (isUnstableNetwork(event.participant)) {
      internetUnStable.value = true;
    } else {
      final List<RemoteParticipant>? rawParticipantList = room?.remoteParticipants.values.toList();
      if (rawParticipantList?.isNotEmpty == true) {
        internetUnStable.value = false;
      }
    }

    if (isUnstableNetwork(event.participant) && cameraOn.value) {
      AppToast.showInternetUnstableToast(
        Get.context!,
        onConfirm: () {
          AppToast.hideToast(Get.context!);
          if (cameraOn.value) {
            toggleCamera();
          }
        },
      );
    }
  }

  void onConnected() {
    // This code is called in onRoomDidUpdate in Function `initialExternalOutputDevice`
    // toggleSpeakerHelper(value: callData.callType == CallType.video);
    // call 3 time
    uiState.value = callData.callType == CallType.video ? UiCallState.video : UiCallState.voice;
    timerCallTimeOut?.cancel();
    startCallTimer();
    stopSound();
  }

  void stopSound() async {
    if (!isStopAllSound) {
      try {
        await UChatCallSystemAudio.instance.stopAllSounds();
        isStopAllSound = true;
      } catch (e) {
        _log.e('Error stop all sound: ', e);
      }
    }
  }
}
