import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

extension ImageBackgroundProcessor on ImageProvider {
  /// Processes the image to determine if the background is light or dark
  /// Returns true if the background is light, false if dark, null if processing fails
  Future<bool?> processBackgroundLightness({
    Size size = const Size(500, 100),
    Rect? region,
  }) async {
    try {
      final paletteGenerator = await PaletteGenerator.fromImageProvider(
        this,
        size: size,
        region: region ?? Rect.fromLTWH(0, 0, size.width, size.height),
      );

      final imageColor = paletteGenerator.dominantColor?.color;
      if (imageColor == null) return null;

      final grayScale = (0.299 * imageColor.r) + (0.587 * imageColor.g) + (0.114 * imageColor.b);

      return grayScale > 128;
    } catch (e) {
      return null;
    }
  }

  /// Gets the dominant color from the image
  Future<Color?> getDominantColor({
    Size size = const Size(500, 100),
    Rect? region,
  }) async {
    try {
      final paletteGenerator = await PaletteGenerator.fromImageProvider(
        this,
        size: size,
        region: region ?? Rect.fromLTWH(0, 0, size.width, size.height),
      );

      return paletteGenerator.dominantColor?.color;
    } catch (e) {
      return null;
    }
  }
}

extension StringImageProcessor on String {
  /// Processes background from asset image path
  Future<bool?> processAssetImageBackground({
    Size size = const Size(500, 100),
    Rect? region,
  }) async {
    if (isEmpty) return null;

    try {
      final imageProvider = AssetImage(this);
      return await imageProvider.processBackgroundLightness(
        size: size,
        region: region,
      );
    } catch (e) {
      return null;
    }
  }
}
