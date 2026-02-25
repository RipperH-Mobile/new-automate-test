import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class ImageWithFrame {
  /// Process an image by adding a white background and padding
  ///
  /// [imagePath] - path to the image file
  /// [padding] - amount of padding to add (in pixels)
  /// [backgroundColor] - background color (default: white)
  ///
  /// Returns a File object of the processed image
  static Future<File> processImage({
    required String imagePath,
    int padding = 70,
  }) async {
    try {
      // Read the image file
      final File imageFile = File(imagePath);
      final Uint8List bytes = await imageFile.readAsBytes();

      // Decode the image
      final img.Image? originalImage = img.decodeImage(bytes);

      if (originalImage == null) {
        throw Exception('Failed to decode the image');
      }

      // Create a new image with white background and padding
      final int newWidth = originalImage.width + (padding * 2);
      final int newHeight = originalImage.height + (padding * 2);

      final img.Image newImage = img.Image(
        width: newWidth,
        height: newHeight,
      );

      // Fill with white background
      img.fill(newImage, color: img.ColorRgb8(255, 255, 255));

      // Draw the original image onto the new one with padding
      img.compositeImage(
        newImage,
        originalImage,
        dstX: padding,
        dstY: padding,
      );

      // Encode the image to PNG
      final Uint8List processedImageBytes = Uint8List.fromList(img.encodePng(newImage));

      // Save the processed image to a temporary file
      final Directory tempDir = await getTemporaryDirectory();
      final String tempPath = '${tempDir.path}/processed_${DateTime.now().millisecondsSinceEpoch}.png';
      final File processedFile = await File(tempPath).writeAsBytes(processedImageBytes);

      return processedFile;
    } catch (e) {
      throw Exception('Error processing image: $e');
    }
  }

  /// Process an image and return it as Uint8List
  ///
  /// [imagePath] - path to the image file
  /// [padding] - amount of padding to add (in pixels)
  /// [backgroundColor] - background color (default: white)
  ///
  /// Returns a Uint8List of the processed image data
  static Future<Uint8List> processImageAsBytes({
    required String imagePath,
    int padding = 70,
  }) async {
    try {
      // Read the image file
      final File imageFile = File(imagePath);
      final Uint8List bytes = await imageFile.readAsBytes();

      // Decode the image
      final img.Image? originalImage = img.decodeImage(bytes);

      if (originalImage == null) {
        throw Exception('Failed to decode the image');
      }

      // Create a new image with white background and padding
      final int newWidth = originalImage.width + (padding * 2);
      final int newHeight = originalImage.height + (padding * 2);

      final img.Image newImage = img.Image(
        width: newWidth,
        height: newHeight,
      );

      // Fill with white background
      img.fill(newImage, color: img.ColorRgb8(255, 255, 255));

      // Draw the original image onto the new one with padding
      img.compositeImage(
        newImage,
        originalImage,
        dstX: padding,
        dstY: padding,
      );

      // Encode the image to PNG
      final Uint8List processedImageBytes = Uint8List.fromList(img.encodePng(newImage));

      return processedImageBytes;
    } catch (e) {
      throw Exception('Error processing image: $e');
    }
  }
}
