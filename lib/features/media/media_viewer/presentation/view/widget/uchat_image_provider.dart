import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:uchat/utils/extension/extension_number.dart';

class UChatImageProvider {
  final ImageProvider<Object> provider;
  final double? width;
  final double? height;

  UChatImageProvider({
    required this.provider,
    this.width,
    this.height,
  });

  DecorationImage build() {
    final double widthImg = width ?? 1;
    final double heightImg = height ?? 1;

    if (widthImg > heightImg) {
      return DecorationImage(
        image: ExtendedResizeImage.resizeIfNeeded(
          provider: provider,
          cacheHeight: 80.cacheSize,
        ),
        fit: BoxFit.cover,
      );
    } else {
      return DecorationImage(
        image: ExtendedResizeImage.resizeIfNeeded(
          provider: provider,
          cacheWidth: 90.cacheSize,
        ),
        fit: BoxFit.cover,
      );
    }
  }
}
