import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/widgets/camera/handler/video_aspect_ratio_handler.dart';
import 'package:video_player/video_player.dart';

import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/app_button_size.dart';
import 'package:uchat/entities/enum/app_button_style.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';

class AppTakeVideoPreview extends StatefulWidget {
  const AppTakeVideoPreview({
    super.key,
    required this.video,
  });

  final File video;

  @override
  State<AppTakeVideoPreview> createState() => _AppTakeVideoPreviewState();
}

class _AppTakeVideoPreviewState extends State<AppTakeVideoPreview> {
  late VideoPlayerController controller;

  double? aspectRatio;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.file(widget.video)
      ..initialize().then(
        (_) {
          setState(() {});
          if (Platform.isAndroid) {
            aspectRatio = controller.value.size.aspectRatioWithRotation(
              rotationCorrection: controller.value.rotationCorrection,
            );
          } else {
            aspectRatio = controller.value.aspectRatio;
          }
        },
      );
    controller.setLooping(true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  double computeAspectRatio() {
    if (controller.value.size.width == 0 || controller.value.size.height == 0) {
      return 1.0; // Default aspect ratio
    }
    return controller.value.size.width / controller.value.size.height;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: AppSpace.space6,
                  left: AppSpace.space4,
                  right: AppSpace.space4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: Assets.vectors.xClose.svg(
                        colorFilter: ColorFilter.mode(
                          context.theme.appColors.iconPrimaryInverse,
                          BlendMode.srcIn,
                        ),
                      ),
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          StatefulBuilder(
            builder: (context, setState) {
              return GestureDetector(
                onTap: () async {
                  if (controller.value.isPlaying) {
                    await controller.pause();
                    setState(() {});
                  } else {
                    await controller.play();
                    setState(() {});
                  }
                },
                child: AspectRatio(
                  aspectRatio: aspectRatio ?? controller.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (controller.value.isInitialized) VideoPlayer(controller),
                      if (!controller.value.isPlaying)
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              AppRadius.roundedFull,
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 8,
                                sigmaY: 8,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(
                                  AppSpace.space3,
                                ),
                                decoration: BoxDecoration(
                                  color: context.theme.appColors.blanket,
                                  shape: BoxShape.circle,
                                ),
                                child: Assets.vectors.play.svg(),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: AppSpace.space2,
                  left: AppSpace.space4,
                  right: AppSpace.space4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppFilledButton.dark(
                      label: 'Retake'.tr,
                      context: context,
                      size: AppButtonSize.small,
                      style: AppButtonStyle.fullRounded,
                      isExpanded: false,
                      onTap: () {
                        Get.back();
                      },
                    ),
                    AppFilledButton.primary(
                      label: 'Sent'.tr,
                      icon: Assets.vectors.send.svg(
                        width: AppSpace.space6,
                        height: AppSpace.space6,
                      ),
                      iconAlignment: IconAlignment.end,
                      size: AppButtonSize.small,
                      style: AppButtonStyle.fullRounded,
                      isExpanded: false,
                      context: context,
                      onTap: () {
                        Get.back(
                          result: widget.video,
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
