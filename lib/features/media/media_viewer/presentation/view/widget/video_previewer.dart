import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_asset_path.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/utils/dimensions.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:video_player/video_player.dart';
import '../../controller/video_previewer_controller.dart';
import '../../controller/mini_controller.dart' as android_controller;

class VideoPreviewer extends GetView<VideoPreviewerController> {
  final String controllerTag;
  final String heroTag;
  final String videoThumbnailUrl;
  final String mediaUrl;
  final File? decryptedFile;
  final bool show;

  const VideoPreviewer({
    super.key,
    required this.controllerTag,
    required this.heroTag,
    required this.mediaUrl,
    required this.videoThumbnailUrl,
    this.decryptedFile,
    required this.show,
  });

  @override
  String get tag => controllerTag;

  @override
  Widget build(BuildContext context) {
    return ExtendedImageSlidePageHandler(
      child: Material(
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          child: Stack(
            children: [
              // Video player preview
              Align(
                alignment: Alignment.center,
                child: Obx(() {
                  final condition = !controller.isLoadingVideo;
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 50),
                    child: condition
                        ? AspectRatio(
                            aspectRatio: Platform.isAndroid
                                ? controller.androidMiniController?.value.aspectRatio ?? 1
                                : controller.playerController?.value.aspectRatio ?? 1,
                            child: Platform.isAndroid
                                ? android_controller.VideoPlayer(controller.androidMiniController!)
                                : VideoPlayer(controller.playerController!),
                          )
                        : const SizedBox.shrink(),
                  );
                }),
              ),

              // Preview video
              Positioned.fill(
                child: Obx(() {
                  Widget child;
                  if (controller.isLoadingVideo || controller.isError.value) {
                    child = ExtendedImage.network(
                      videoThumbnailUrl,
                      enableSlideOutPage: true,
                      mode: ExtendedImageMode.gesture,
                      headers: controller.httpCaller.apiHeader,
                      initGestureConfigHandler: (ExtendedImageState state) {
                        return GestureConfig(
                          inPageView: true,
                          initialScale: 1.0,
                          maxScale: 5.0,
                          animationMaxScale: 6.0,
                          initialAlignment: InitialAlignment.center,
                        );
                      },
                      clearMemoryCacheIfFailed: true,
                      clearMemoryCacheWhenDispose: true,
                      loadStateChanged: (state) {
                        if (state.extendedImageLoadState == LoadState.failed) {
                          return Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.white,
                              size: 40.wr,
                            ),
                          );
                        }

                        return null;
                      },
                    );
                  } else {
                    child = const SizedBox.shrink();
                  }

                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: child,
                  );
                }),
              ),

              // Loading indicator
              Align(
                alignment: Alignment.center,
                child: Obx(() {
                  final condition = controller.isLoadingVideo;
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: condition
                        ? Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: .3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(Colors.white),
                                  strokeWidth: 2,
                                  strokeCap: StrokeCap.round,
                                ),
                                SizedBox(height: 10.spMin),
                                Obx(
                                  () => Text(
                                    '${controller.bufferedPercentage.value.toStringAsFixed(0)}%',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  );
                }),
              ),

              // Show error message
              if (show)
                Align(
                  alignment: Alignment.center,
                  child: Obx(() {
                    Widget child;

                    if (!controller.isLoadingVideo && controller.isError.value) {
                      child = Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 75),
                          color: Colors.black.withValues(alpha: .8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                UChatAssetPath.infoTriangleIcon,
                                width: 70.spMin,
                                height: 70.spMin,
                                cacheWidth: 70.cacheSize,
                              ),
                              SizedBox(height: 20.spMin),
                              Text(
                                'Couldn\'t preview file'.tr,
                                style: const TextStyle(
                                  color: Color(0xFF999999),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 10.spMin),
                              Text(
                                'Since your device doesn\'t support this files. Please download this file instead.'.tr,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xFF999999),
                                  fontSize: 12,
                                ),
                              ),
                              if (!AppEnv.isProd) ...[
                                SizedBox(height: 15.spMin),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: GestureDetector(
                                    onLongPress: controller.copyErrorMessageToClipboard,
                                    child: Text(
                                      controller.errorMessage.value,
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                            ],
                          ),
                        ),
                      );
                    } else {
                      child = const SizedBox.shrink();
                    }

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: child,
                    );
                  }),
                )
            ],
          ),
        ),
      ),
      heroBuilderForSlidingPage: (widget) {
        return Hero(
          tag: heroTag,
          child: widget,
          flightShuttleBuilder: (
            BuildContext flightContext,
            Animation<double> animation,
            HeroFlightDirection flightDirection,
            BuildContext fromHeroContext,
            BuildContext toHeroContext,
          ) {
            final Hero hero;
            if (flightDirection == HeroFlightDirection.pop) {
              hero = fromHeroContext.widget as Hero;
            } else {
              hero = fromHeroContext.widget as Hero;
            }
            return hero.child;
          },
        );
      },
    );
  }
}
