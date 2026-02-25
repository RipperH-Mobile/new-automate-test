import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/features/call/call_kit_incoming.dart';
import 'package:uchat/features/call/data/models/models/room_call_model.dart';
import 'package:uchat/features/call/livekit/parent/uchat_livekit_controller.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/call/utils/extend_duration.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:vibration/vibration.dart';

enum ToastType { connected, disconnected }

class StartGroupCallCtl extends UChatLiveKitController {
  StartGroupCallCtl({required super.callData});

  @override
  bool get isNotExisting => Get.isRegistered<StartGroupCallCtl>(tag: callData.roomId) != true;

  Duration toastDuration = Duration.zero;
  Timer? toastTimer;
  ToastType? toastType;
  final pConnectedNameToast = [].obs;
  final toastMessage = ''.obs;
  final toastSecondsDebug = 0.obs;
  static const maxToastSeconds = 3;

  bool get groupFloatingScreenShow {
    final pt = otherParticipantList.any((e) => e.participant.videoTrackPublications.firstOrNull?.muted == false);
    return (pt || cameraOn()) && callData.callState == CallState.connected && callCtl.isCallScreenMinimize();
  }

  @override
  onClose() {
    toastTimer?.cancel();
    ScaffoldMessenger.of(Get.context!).clearSnackBars();
    super.onClose();
  }

  @override
  startCallTimer() {
    isRecording.value = true;
    // user Vibration because haptic so light for Vibration
    Vibration.hasVibrator().then((hasVibrator) {
      if (hasVibrator) {
        Vibration.vibrate(duration: 250);
      }
      callTimer ??= Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          DateTime? startTimer;
          startTimer = callData.startCallAt;
          if (startTimer == null) return;

          final diff = DateTime.now().difference(startTimer);
          callDuration.value = diff.toMMSS();
          callUiRefreshCheck = !callUiRefreshCheck;
          if (isDisconnected.value) {
            isRecording.value = false;
            timer.cancel();
          }
        },
      );
    });
  }

  @override
  void roomDataListener(RoomCallModel? data) {
    switch (data?.callState) {
      case CallState.idle:
        status.value = 'Connecting...';
        break;
      case CallState.connecting:
        EventProperty.getNetworkTypeForEventParams().then((String networkType) {
          String callType = callData.callType == CallType.video ? 'video' : 'voice';
          GetIt.I<TaxonomyService>()
              .sendEvent(EventName.callStarted, eventProperties: EventProperty.callStarted(callType, networkType));
        });
        status.value = 'Calling...';
        break;
      case CallState.connected:
        status.value = 'Connected...';
        uiState.value = callData.callType == CallType.video ? UiCallState.video : UiCallState.voice;

        break;
      case CallState.disconnecting:
        status.value = 'Disconnecting...';
        break;
      case CallState.disconnected:
        status.value = 'Disconnected...';
        break;
      case CallState.paused:
        status.value = 'Paused...';
        break;
      default:
        break;
    }
  }

  @override
  void callUiStateListener(UiCallState? data) {
    switch (data) {
      case UiCallState.ringing:
        break;
      case UiCallState.outgoing:
        break;
      case UiCallState.voice:
        break;
      case UiCallState.video:
        if (speakerOn.value == false) {
          speakerOn.value = true;
          initialExternalOutputDevice();
        }

        // if (speakerOn.value == false) {
        //   toggleSpeakerHelper(
        //     'start group call UiCallState.video',
        //     value: true,
        //     isVideoMode: true,
        //     forceSpeakerOutput: false,
        //   );
        //   speakerOn.value = true;
        // }
        break;
      default:
        break;
    }
  }

  @override
  Future<void> connect<C extends UChatLiveKitController>() async {
    if (callData.callType == CallType.video) {
      cameraOn(true);
    }
    await super.connect<StartGroupCallCtl>();
    callData.startCallAt ??= DateTime.now();
    callState = CallState.connected;
    UChatCallkitIncoming.instance.setCallConnected(callData);
    startCallTimer();
    setUpStartCallListeners();
    EventProperty.getNetworkTypeForEventParams().then((String networkType) {
      String callType = callData.callType == CallType.video ? 'video' : 'voice';
      String networkQuality = super.localParticipant()?.participant.connectionQuality.name ?? 'unknown';
      GetIt.I<TaxonomyService>().sendEvent(EventName.callConnected,
          eventProperties: EventProperty.callConnected(callType, networkType, networkQuality));
    });
    room?.addListener(onRoomDidUpdate);
  }

  @override
  onRoomDidUpdate() async {
    if (callData.callState == CallState.idle) {
      callState = CallState.connecting;
      uiState.value = UiCallState.ringing;
    }
    super.onRoomDidUpdate();
  }

  @override
  Future<void> disconnect<C extends UChatLiveKitController>(String reason) async {
    /// Need to explicitly class type.
    try {
      await super.disconnect<StartGroupCallCtl>(reason);
    } catch (e) {
      debugPrint('Disconnect error: $e');
    }
  }

  @override
  liveKitCancelEventAndDisconnect() async {
    room?.removeListener(onRoomDidUpdate);
    super.liveKitCancelEventAndDisconnect();
  }

  @override
  onRoomDisconnectedEvent(RoomDisconnectedEvent event) {}

  @override
  onActiveSpeakersChangedEvent(ActiveSpeakersChangedEvent event) {
    super.onActiveSpeakersChangedEvent(event);
    sortParticipants(event: event);
  }

  @override
  onParticipantConnectedEvent(ParticipantConnectedEvent event) async {
    super.onParticipantConnectedEvent(event);
    if (callData.startCallAt == null) {
      callData.startCallAt = DateTime.now();
      callState = CallState.connected;
      startCallTimer();
    }
    showToast(event.participant.name, ToastType.connected, context: Get.context!);
  }

  @override
  void onParticipantDisconnectedEvent(ParticipantDisconnectedEvent event) {
    super.onParticipantDisconnectedEvent(event);
    showToast(event.participant.name, ToastType.disconnected, context: Get.context!);
  }

  @override
  void onParticipantConnectionQualityUpdatedEvent(ParticipantConnectionQualityUpdatedEvent event) {
    super.onParticipantConnectionQualityUpdatedEvent(event);
    if (event.participant is LocalParticipant && event.participant.connectionQuality != ConnectionQuality.excellent) {
      internetUnStable.value = true;
    } else {
      internetUnStable.value = false;
    }
  }

  void showToast(String participantName, ToastType toastType, {required BuildContext context}) {
    if (this.toastType != null && toastType != this.toastType) {
      _resetToast(context);
    }

    this.toastType = toastType;

    pConnectedNameToast.add(participantName);
    toastMessage.value = _generateToastMessage(toastType);

    if (toastDuration.inSeconds > 0) {
      toastDuration = Duration(seconds: max(maxToastSeconds, min(toastDuration.inSeconds + 1, maxToastSeconds)));
      return;
    }

    _startToastTimer(context);
    AppToast.showCustomToast(
      context: context,
      widget: _buildToastWidget(context, toastType),
      duration: const Duration(days: 1),
    );
  }

  void _resetToast(BuildContext context) {
    toastTimer?.cancel();
    toastTimer = null;
    pConnectedNameToast.value = [];
    toastDuration = Duration.zero;
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  String _generateToastMessage(ToastType toastType) {
    final latestParticipant = pConnectedNameToast.last;
    final type = toastType == ToastType.connected ? 'joined'.tr : 'left'.tr;
    if (pConnectedNameToast.length > 1) {
      final number = (pConnectedNameToast.length - 1).toString();
      return '@latestParticipant and @number others @type the group call'.trParams({
        'latestParticipant': latestParticipant,
        'number': number,
        'type': type,
      });
    } else {
      return '@latestParticipant @type the group call'.trParams({
        'latestParticipant': latestParticipant,
        'type': type,
      });
    }
  }

  void _startToastTimer(BuildContext context) {
    toastTimer?.cancel();
    toastDuration = const Duration(seconds: maxToastSeconds);
    toastSecondsDebug.value = toastDuration.inSeconds;
    toastTimer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (toastDuration.inSeconds <= 0) {
          _resetToast(context);
          timer.cancel();
        } else {
          toastDuration -= const Duration(seconds: 1);
          toastSecondsDebug.value = toastDuration.inSeconds;
        }
      },
    );
  }

  Widget _buildToastWidget(BuildContext context, ToastType toastType) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 20.spMin,
          height: 20.spMin,
          child: toastType == ToastType.connected
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Assets.vectors.account.svg(width: 16.spMin, height: 16.spMin),
                    Align(
                      alignment: Alignment.topRight,
                      child: Assets.vectors.add.svg(
                        width: 6.spMin,
                        height: 6.spMin,
                        colorFilter: ColorFilter.mode(
                          context.theme.appColors.iconInverse,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                )
              : Assets.vectors.iconLeaveGroup.svg(
                  width: 16.spMin,
                  height: 16.spMin,
                  colorFilter: ColorFilter.mode(
                    context.theme.appColors.iconInverse,
                    BlendMode.srcIn,
                  ),
                ),
        ),
        AppSpace.space2.horizontalSpace,
        Expanded(
          child: Obx(() {
            return AppText.body3Bold(
              toastMessage(),
              context: context,
              color: context.theme.appColors.iconInverse,
            );
          }),
        ),
      ],
    );
  }
}
