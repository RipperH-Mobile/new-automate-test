import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/features/media/media_viewer/presentation/view/widget/hero_widget.dart';
import 'package:uchat/features/media/media_viewer/presentation/view/widget/photo_previewer_controller.dart';
import 'package:uchat/utils/image/uchat_network_image_provider.dart';

class PhotoPreviewerDesktop extends StatelessWidget {
  final String controllerTag;
  final String heroTag;
  final String mediaUrl;
  final String? thumbnailUrl;
  final GlobalKey<ExtendedImageSlidePageState> slidePagekey;

  const PhotoPreviewerDesktop({
    super.key,
    required this.controllerTag,
    required this.heroTag,
    required this.slidePagekey,
    required this.mediaUrl,
    this.thumbnailUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PhotoPreviewerController(),
      tag: controllerTag,
      builder: (controller) {
        return HeroWidget(
          tag: heroTag,
          slidePagekey: slidePagekey,
          slideType: SlideType.onlyImage,
          child: PhotoView(
            imageProvider: thumbnailUrl != null
                ? ExtendedResizeImage.resizeIfNeeded(
                    provider: FileImage(File(thumbnailUrl!)),
                  )
                : ExtendedResizeImage.resizeIfNeeded(
                    provider: UChatNetworkImageProvider(
                      mediaUrl,
                      headers: HttpCaller().apiHeader,
                      cache: true,
                      retries: 2,
                    ),
                  ),
            loadingBuilder: (context, event) {
              if (event == null) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeCap: StrokeCap.round,
                    strokeWidth: 2.5,
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  value: event.cumulativeBytesLoaded / event.expectedTotalBytes!,
                  strokeCap: StrokeCap.round,
                  strokeWidth: 2.5,
                ),
              );
            },
            controller: controller.photoController,
            filterQuality: FilterQuality.high,
            initialScale: PhotoViewComputedScale.contained,
            maxScale: controller.maxScale,
            minScale: controller.minScale,
          ),
        );
      },
    );
  }
}
