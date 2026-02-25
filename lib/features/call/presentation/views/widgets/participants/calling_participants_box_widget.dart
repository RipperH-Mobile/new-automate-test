import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/call/data/models/models/room_call_model.dart';
import 'package:uchat/features/call/presentation/views/widgets/element/avatar.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/blurhash.dart';
import 'package:uchat/widgets/animation/widget_bouncing.dart';
import 'package:uchat/widgets/app_text.dart';

class CallingParticipantsBoxWidget extends StatelessWidget {
  const CallingParticipantsBoxWidget({
    super.key,
    required this.videoTrack,
    required this.callData,
    this.forceFullScreen = false,
    this.isShowFullNetwork = false,
    this.isSpeaking = false,
    this.isMute = false,
    this.isConnectionPoor = false,
    this.name,
    this.hideParticipantInfo = false,
    this.imageUrl,
    this.isScreenShare,
  });

  // NOTE. real model of participant is ParticipantTrack
  // ParticipantTrack participant,
  final VideoTrack? videoTrack;
  final bool isSpeaking;
  final bool isMute;
  final bool isConnectionPoor;
  final RoomCallModel callData;
  final bool forceFullScreen;
  final bool isShowFullNetwork;
  final String? name;
  final bool hideParticipantInfo;
  final String? imageUrl;
  final bool? isScreenShare;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(15);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 1500),
      reverseDuration: const Duration(seconds: 10),
      child:
          //  !visible? const SizedBox.shrink():
          BouncingGesture(
        initialEnable: false,
        bouncingDurationMilliseconds: 100,
        isActionWidgetUpdateEnable: false,
        onTap: () {},
        child: StatefulBuilder(
          builder: (_, setState) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: Border.all(
                    color: isSpeaking == true
                        ? context.theme.appColors.borderLighter
                        : context.theme.appColors.borderSelected,
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignInside),
              ),
              child: Stack(
                children: [
                  if (videoTrack != null && !videoTrack!.muted) ...[
                    LayoutBuilder(builder: (context, c) {
                      // if ratio is maxWidth, maxHeight is diff more than 0.1
                      // using RTCVideoViewObjectFit.RTCVideoViewObjectFitContain
                      // else using RTCVideoViewObjectFit.RTCVideoViewObjectFitCover
                      VideoViewFit fit = VideoViewFit.cover;
                      if (c.maxWidth > c.maxHeight) {
                        fit = VideoViewFit.contain;
                      }
                      return ClipRRect(
                        borderRadius: borderRadius,
                        child: VideoTrackRenderer(
                          renderMode: VideoRenderMode.auto,
                          videoTrack!,
                          fit: isScreenShare == true ? VideoViewFit.contain : fit,
                        ),
                      );
                    }),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space2, vertical: AppSpace.space2),
                        child: AppText.body1Bold(
                          name ?? 'Unknown'.tr,
                          context: context,
                          color: context.theme.appColors.textPrimaryInverse,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ] else ...[
                    ClipRRect(
                      borderRadius: borderRadius,
                      child: BlurHash(
                        hash: blurhashDefault(callData.imageBlurHash),
                        imageFit: BoxFit.cover,
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: SizedBox(
                              width: 80.spMin,
                              height: 80.spMin,
                              child: AvatarWidget(
                                avatar: callData.imageUrl,
                                radius: 40.spMin,
                                blurHash: callData.imageBlurHash,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: AppSpace.space3,
                              right: AppSpace.space2,
                              left: AppSpace.space2,
                            ),
                            child: AppText.body1Bold(
                              name ?? 'Unknown'.tr,
                              context: context,
                              color: context.theme.appColors.textPrimaryInverse,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                  if (isMute && !hideParticipantInfo)
                    Padding(
                      padding: const EdgeInsets.only(
                        right: AppSpace.space2,
                        left: AppSpace.space2,
                        top: AppSpace.space2,
                      ),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Assets.vectors.callMuteMicButton.svg(
                          width: 40.spMin,
                          height: 40.spMin,
                        ),
                      ),
                    ),
                  if (isConnectionPoor && !hideParticipantInfo)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: AppSpace.space2,
                        top: AppSpace.space2,
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Assets.vectors.callInternetUnstable.svg(
                          width: 20.spMin,
                          height: 20.spMin,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
