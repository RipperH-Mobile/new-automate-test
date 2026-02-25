import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/call/livekit/parent/uchat_livekit_controller.dart';
import 'package:uchat/features/call/presentation/views/screens/mobile/direct_call_layout.dart';
import 'package:uchat/features/call/presentation/views/widgets/buttons/call_action_button_speaker_impl.dart';
import 'package:uchat/features/call/presentation/views/widgets/component/call_internet_badge.dart';
import 'package:uchat/features/call/presentation/views/widgets/component/linear_dots_pause.dart';
import 'package:uchat/features/call/presentation/views/widgets/livekit/participant_image_background.dart';
import 'package:uchat/features/call/presentation/views/widgets/component/call_user_profile.dart';
import 'package:uchat/features/call/presentation/views/widgets/element/call_title.dart';
import 'package:uchat/features/call/presentation/views/widgets/livekit/participant_widget_direct_new.dart';
import 'package:uchat/features/call/presentation/views/widgets/panels/call_action_panel_video.dart';
import 'package:uchat/features/call/presentation/views/widgets/app_bar/app_bar_mobile.dart';
import 'package:uchat/features/call/presentation/views/widgets/element/call_status.dart';
import 'package:uchat/features/call/presentation/views/widgets/participants/participants_box.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_sync_use_case.dart';
import 'package:uchat/gen/assets.gen.dart';

class DirectCallScreenImpl<C extends UChatLiveKitController> extends GetView<C> {
  final String roomId;

  const DirectCallScreenImpl({super.key, required this.roomId});

  @override
  String? get tag => roomId;

  bool get isConnecting => controller.callData.callState == CallState.connecting;

  /// Get image from remote participant or call data
  /// If remote participant has metadata, get image from metadata
  /// For `Group call` there are 2 remote participants.
  String? get image {
    final pt = controller.remoteParticipants.firstOrNull;
    String? imageUrl = controller.getParticipantImage(pt);
    if (imageUrl?.isNotEmpty == true) {
      return imageUrl;
    }
    return controller.callData.imageUrl;
  }

  /// Get title from remote participant or call data
  /// If remote participant has metadata, get name from metadata
  /// For `Group call` there are 2 remote participants.
  String? get title {
    if (controller.callData.roomType != RoomType.group) {
      return controller.callData.title;
    }

    // For group call, and there are only 1 participant in group
    // Using direct call ui if using `controller.callData.title` it is group name
    // Get name from remote participant instead

    //! fix this on server to using nick name as well including direct and group.
    final pt = controller.remoteParticipants.firstOrNull;
    if (pt != null) {
      final contactData = GetIt.I<GetContactSyncUseCase>().call(pt.identity);
      return contactData?.nickname ?? pt.name;
    }
    return controller.callData.title;
  }

  /// Get blur hash from remote participant or call data
  /// If remote participant has metadata, get blur hash from metadata
  /// For `Group call` there are 2 remote participants.
  String? get blurHash {
    final pt = controller.remoteParticipants.firstOrNull;
    final bh = controller.getParticipantBlurHash(pt);
    if (bh?.isNotEmpty == true) {
      return bh;
    }
    return controller.callData.imageBlurHash ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return DirectCallLayout(
      actionsControl: buildActionsControlWidget(context),
      body: buildBodyWidget(context),
      appBar: buildAppBarWidget(context),
    );
  }

  Widget buildActionsControlWidget(BuildContext context) {
    return Obx(
      () {
        return CallActionPanelVideoWidget(
          isShow: controller.liveKitReady(),
          isVideoMode: controller.cameraOn() || controller.uiState() == UiCallState.video,
          onDecline: () => controller.disconnect('user pressed decline ($C)'),
          toggleCamera: controller.toggleCamera,
          toggleCameraSwitching: controller.switchCamera,
          toggleMic: controller.toggleMic,
          toggleSpeaker: controller.toggleSpeaker,
          micOn: controller.micOn(),
          cameraOn: controller.cameraOn(),
          speakerOn: controller.speakerOn(),
          audioOutputs: controller.audioOutputs(),
          onDeviceSelected: controller.selectAudioOutput,
          selectedDevice: controller.selectedAudioOutput(),
        );
      },
    );
  }

  CallAppBarMobile buildAppBarWidget(BuildContext context) {
    return CallAppBarMobile(
      title: Obx(
        () {
          return CallTitleWidget(
            title: title ?? 'Unknown'.tr,
          );
        },
      ),
      action: Obx(
        () {
          final uiState = controller.uiState();
          final remote = controller.remoteParticipant(0);

          if (uiState == UiCallState.video || uiState == UiCallState.voice) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (remote?.participant.connectionQuality != ConnectionQuality.excellent)
                  Assets.vectors.callInternetUnstable.svg(
                    height: AppSize.size6,
                  ),
                if (controller.enableWarMode())
                  Obx(() {
                    if (controller.isShareScreen() == true) {
                      return IconButton(
                        icon: Icon(
                          Icons.monitor_outlined,
                          color: context.theme.appColors.textPrimaryInverse,
                        ),
                        onPressed: () => controller.onDisableScreenShare(),
                        tooltip: 'unshare screen (experimental)',
                      );
                    } else {
                      return IconButton(
                        icon: Icon(
                          Icons.monitor,
                          color: context.theme.appColors.textPrimaryInverse,
                        ),
                        onPressed: () => controller.onEnableScreenShare(),
                        tooltip: 'share screen (experimental)',
                      );
                    }
                  }),
                if (controller.cameraOn() || uiState == UiCallState.video)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppSpace.space2,
                    ),
                    child: CallActionSpeakerButton(
                      selectedDevice: controller.selectedAudioOutput(),
                      audioOutputs: controller.audioOutputs(),
                      onPressed: controller.toggleSpeaker,
                      isActive: controller.speakerOn(),
                      sheetOffset: const Offset(0, 50),
                      sheetPosition: PopupMenuPosition.over,
                      small: true,
                      onDeviceSelected: (device) {
                        controller.selectAudioOutput(device);
                      },
                    ),
                  )
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget buildBodyWidget(BuildContext context) {
    return Stack(
      children: [
        Obx(
          () {
            return ParticipantImageBackground(
              image: image!,
              blurHash: blurHash!,
              opacity: controller.isRecording() ? 0.4 : 0.7,
            );
          },
        ),
        Obx(
          () {
            if (controller.callData.callState == CallState.idle) {
              const size = 20.0;
              return SafeArea(
                child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: size * 2,
                      child: FadeIn(
                        child: LinearDotsWithPause(
                          size: size,
                          color: context.theme.appColors.textPrimaryInverse,
                        ),
                      ),
                    )),
              );
            }
            final uiState = controller.uiState();
            if (uiState == UiCallState.ringing ||
                uiState == UiCallState.outgoing ||
                controller.callData.roomType == RoomType.group) {
              return SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: CallStatusWidget(
                    status: controller.isRecording() ? controller.callDuration() : controller.status(),
                    active: controller.isRecording() || controller.callData.callState == CallState.connecting,
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        Obx(
          () {
            final uiState = controller.uiState();
            final participant = controller.remoteParticipant(0);
            if (uiState == UiCallState.video || uiState == UiCallState.voice) {
              if (participant != null && isConnecting == false && participant.participant is RemoteParticipant) {
                return FadeIn(
                  delay: GetPlatform.isAndroid
                      ? const Duration(milliseconds: 500)
                      : Duration.zero, //POC, Fix flickering, camera mirror incorrect when initial on Android
                  child: RemoteParticipantWidgetNew(
                    participant: participant.participant as RemoteParticipant,
                    type: participant.type,
                    callData: controller.callData,
                    uiState: controller.uiState(),
                    // Group call if there are 2 participants, use image from livekit meta instead
                    // callData is group/direct room avatar image, it's not participant/user image
                    overrideAvatarImage: image,
                    callStatus: Obx(
                      () {
                        return CallStatusWidget(
                          status: controller.isRecording() ? controller.callDuration() : controller.status(),
                          active: controller.isRecording() || controller.callData.callState == CallState.connecting,
                        );
                      },
                    ),
                    floatingParticipant: Obx(
                      () {
                        if (controller.cameraOn() == true &&
                            controller.liveKitReady() &&
                            controller.localVideoTrackPublished()) {
                          return _localParticipantBox();
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                );
              } else {
                return CallUserProfileWidget(
                  uiState: uiState,
                  image: image!,
                  blurHash: blurHash!,
                  showBorder: true,
                  size: 120,
                );
              }
            }
            return CallUserProfileWidget(
              uiState: uiState,
              image: image!,
              blurHash: blurHash!,
              size: 168,
            );
          },
        ),
        Obx(
          () {
            if (controller.internetUnStable.value) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppSpace.space10,
                  ),
                  child: SafeArea(
                    child: FadeIn(
                      child: const CallInternetBadge(),
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        if (controller.callData.roomType == RoomType.group)
          Obx(
            () {
              if (controller.cameraOn() == true && controller.liveKitReady() && controller.localVideoTrackPublished()) {
                return _localParticipantBox();
              }
              return const SizedBox.shrink();
            },
          )
        else
          Obx(
            () {
              final uiState = controller.uiState();
              if (controller.cameraOn() == true &&
                  controller.liveKitReady() &&
                  controller.localVideoTrackPublished() &&
                  (uiState != UiCallState.video && uiState != UiCallState.voice)) {
                return _localParticipantBox();
              }
              return const SizedBox.shrink();
            },
          ),
      ],
    );
  }

  Widget _localParticipantBox() {
    final participant = controller.localParticipant();
    final local = participant?.participant as LocalParticipant?;
    LocalTrackPublication<LocalVideoTrack>? videoPublication =
        local?.videoTrackPublications.where((element) => element.source == TrackSource.camera).firstOrNull;
    return Positioned(
      right: AppSpace.space4,
      top: Get.mediaQuery.padding.top + AppBar().preferredSize.height,
      child: FadeIn(
        delay: GetPlatform.isAndroid
            ? const Duration(milliseconds: 500)
            : Duration.zero, //POC, Fix flickering, camera mirror incorrect when initial on Android
        child: ParticipantBox(
          track: videoPublication?.track,
        ),
      ),
    );
  }
}
