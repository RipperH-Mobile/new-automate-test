import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/call/livekit/parent/uchat_livekit_controller.dart';
import 'package:uchat/features/call/livekit/start_direct_call_controller.dart';
import 'package:uchat/features/call/livekit/start_group_call_controller.dart';
import 'package:uchat/features/call/presentation/views/widgets/livekit/participant_widget_direct_floating.dart';
import 'package:uchat/features/call/presentation/views/widgets/participants/participants_box.dart';
import 'package:uchat/features/call/presentation/views/widgets/participants/draggable_positioned_box.dart';
import 'package:uchat/widgets/call/participant_info.dart';

const double panelWidth = 125;
const double panelHeight = 200;

class FloatingCallScreen extends GetView<UChatCallController> {
  const FloatingCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final ctl = controller.callCtlList.firstOrNull;
        if (Get.isRegistered<StartDirectCallCtl>(tag: ctl?.callData.roomId)) {
          final directCtl = Get.find<StartDirectCallCtl>(tag: ctl?.callData.roomId);
          if (directCtl.directFloatingScreenShow) {
            final padding = AppSpace.space4;
            return DraggablePositionedBox(
              snapTopPosition: Get.mediaQuery.padding.top + padding,
              snapBottomPosition: Get.height - panelHeight - padding,
              snapLeftPosition: padding,
              snapRightPosition: Get.width - panelWidth - padding,
              child: GestureDetector(
                onTap: () {
                  unawaited(controller.openCallScreen(directCtl.callData));
                },
                child: Obx(
                  () {
                    return FloatingCallScreenImpl<StartDirectCallCtl>(
                      roomId: ctl!.callData.roomId!,
                    );
                  },
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        } else if (Get.isRegistered<StartGroupCallCtl>(tag: ctl?.callData.roomId)) {
          final groupCtl = Get.find<StartGroupCallCtl>(tag: ctl?.callData.roomId);
          if (groupCtl.groupFloatingScreenShow) {
            final padding = AppSpace.space4;
            return DraggablePositionedBox(
              snapTopPosition: Get.mediaQuery.padding.top + padding,
              // snapBottomPosition: 0,
              snapBottomPosition: Get.height - panelHeight - padding,
              snapLeftPosition: padding,
              snapRightPosition: Get.width - panelWidth - padding,
              child: GestureDetector(
                onTap: () {
                  unawaited(controller.openCallScreen(groupCtl.callData));
                },
                child: Obx(
                  () {
                    return FloatingCallScreenImpl<StartGroupCallCtl>(
                      roomId: ctl!.callData.roomId!,
                    );
                  },
                ),
              ),
            );
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class FloatingCallScreenImpl<C extends UChatLiveKitController> extends GetView<C> {
  final String roomId;

  const FloatingCallScreenImpl({super.key, required this.roomId});

  @override
  String? get tag => roomId;

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
  String? get title => controller.remoteParticipants.firstOrNull?.name ?? controller.callData.title;

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
    return Container(
      width: panelWidth,
      height: panelHeight,
      decoration: BoxDecoration(
        // TODO: fix shadow
        boxShadow: [
          const BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 2),
            spreadRadius: 0,
          )
        ],
        borderRadius: BorderRadius.circular(
          AppRadius.roundedXl,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.roundedXl),
        child: Obx(
          () {
            final participant = controller.otherParticipantList().elementAtOrNull(1);
            final pt = participant?.participant == null
                ? null
                : ParticipantTrackV2(
                    participant: participant!.participant,
                    type:
                        participant.isScreenShare ? ParticipantTrackType.kScreenShare : ParticipantTrackType.kUserMedia,
                  );

            return RemoteParticipantFloating(
              participant: pt?.participant as RemoteParticipant?,
              type: pt?.type,
              callData: controller.callData,
              uiState: controller.uiState(),
              overrideAvatarImage: image,
              overrideBlurHash: blurHash,
              floatingParticipant: Obx(
                () {
                  if (controller.cameraOn() == true && controller.liveKitReady()) {
                    final localParticipant = controller.localParticipant();
                    if (localParticipant != null) {
                      final local = localParticipant.participant as LocalParticipant?;
                      LocalTrackPublication<LocalVideoTrack>? videoPublication = local?.videoTrackPublications
                          .where((element) => element.source == localParticipant.type.lkVideoSourceType)
                          .firstOrNull;
                      if (videoPublication?.track != null) {
                        return Positioned(
                          top: AppSpace.space1,
                          right: AppSpace.space1,
                          child: ParticipantBox(
                            track: videoPublication!.track!,
                            height: 70,
                            width: 45,
                            radius: AppRadius.roundedXl - (AppSpace.space1 / 2),
                          ),
                        );
                      }
                    }
                  }
                  return const SizedBox.shrink();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
