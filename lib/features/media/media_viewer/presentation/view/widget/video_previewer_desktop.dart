import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'package:uchat/utils/dimensions.dart';

import '../../controller/video_previewer_controller.dart';

class VideoPreviewerDesktop extends GetView<VideoPreviewerController> {
  final String controllerTag;
  final String heroTag;
  final String videoThumbnailUrl;
  final String mediaUrl;
  final void Function()? fullScreenToggle;

  const VideoPreviewerDesktop({
    super.key,
    required this.controllerTag,
    required this.heroTag,
    required this.mediaUrl,
    required this.videoThumbnailUrl,
    this.fullScreenToggle,
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
                            aspectRatio: controller.playerController?.value.aspectRatio ?? 1,
                            child: VideoPlayer(controller.playerController!),
                          )
                        : const SizedBox.shrink(),
                  );
                }),
              ),

              // Preview video
              Positioned.fill(
                child: Obx(() {
                  final condition = controller.isLoadingVideo;
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: condition
                        ? ExtendedImage.network(
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
                          )
                        : const SizedBox.shrink(),
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
                            child: const CupertinoActivityIndicator(),
                          )
                        : const SizedBox.shrink(),
                  );
                }),
              ),
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
