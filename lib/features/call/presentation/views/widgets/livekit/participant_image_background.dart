import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:uchat/utils/blurhash.dart';
import 'dart:math' as math;
import 'package:uchat/utils/image/uchat_image.dart';

class ParticipantImageBackground extends StatelessWidget {
  final String image;
  final String blurHash;
  final double? widthScreen;
  final double? heightScreen;
  final double? opacity;

  const ParticipantImageBackground({
    super.key,
    required this.image,
    required this.blurHash,
    this.widthScreen,
    this.heightScreen,
    this.opacity,
  });

  Widget _background() {
    return LayoutBuilder(builder: (context, constraints) {
      if (image.isEmpty) {
        return const SizedBox();
      }

      return SizedBox(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: UChatImage.network(
          image,
          fit: BoxFit.cover,
          customLoadingWidget: (state) {
            return BlurHash(
              hash: blurhashDefault(blurHash),
              imageFit: BoxFit.cover,
            );
          },
          customErrorWidget: (state) {
            return BlurHash(
              hash: blurhashDefault(blurHash),
              imageFit: BoxFit.cover,
            );
          },
          customImageWidget: (state) {
            return SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: [
                  state.completedWidget,
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 200,
                        sigmaY: 200,
                      ),
                      child: Container(
                        color: Colors.black.withOpacity(opacity ?? 0.4),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          clearMemoryCacheIfFailed: true,
          useUChatHeader: false,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (ctx, constraints) {
            if (image.isEmpty && blurHash.isEmpty) {
              return Icon(
                Icons.videocam_off_outlined,
                color: Colors.blue,
                size: math.min(constraints.maxHeight, constraints.maxWidth) * 0.3,
              );
            }
            return _background();
          },
        ),
      );
}
