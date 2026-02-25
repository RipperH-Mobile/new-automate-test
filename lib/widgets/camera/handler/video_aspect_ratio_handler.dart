import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';

/// Handler for calculating correct aspect ratio for video files
/// Especially handles Android video rotation issues where video metadata
/// may not reflect the actual display orientation
class VideoAspectRatioHandler {
  /// Calculate correct aspect ratio for video preview
  /// Takes into account rotation correction and original dimensions
  /// Automatically detects if video is portrait or landscape
  ///
  /// Parameters:
  /// - [width]: Original video width from metadata
  /// - [height]: Original video height from metadata
  /// - [rotationCorrection]: Rotation correction value (0, 90, 180, 270)
  ///
  /// Returns: Calculated aspect ratio (width/height)
  ///
  /// Example:
  /// ```dart
  /// final aspectRatio = VideoAspectRatioHandler.calculateAspectRatio(
  ///   width: 3840,
  ///   height: 2160,
  ///   rotationCorrection: 90,
  /// );
  /// // Result: 0.5625 (9:16 aspect ratio for portrait video)
  /// ```
  static double calculateAspectRatio({
    required double width,
    required double height,
    required int rotationCorrection,
  }) {
    // Automatically detect if video is portrait mode
    bool isPortraitMode = isLikelyPortraitVideo(
      width: width,
      height: height,
      rotationCorrection: rotationCorrection,
    );

    // Debug information
    if (kDebugMode) {
      debugPrint('=== Video Aspect Ratio Calculation ===');
      debugPrint('Original dimensions: ${width}x$height');
      debugPrint('Rotation correction: $rotationCorrection°');
      debugPrint('Auto-detected portrait mode: $isPortraitMode');
    }

    // Determine if rotation requires dimension swap
    bool shouldSwapDimensions = _shouldSwapDimensions(
      rotationCorrection: rotationCorrection,
      isPortraitMode: isPortraitMode,
    );

    // Calculate final dimensions
    double finalWidth, finalHeight;

    if (shouldSwapDimensions) {
      // Swap dimensions for rotated video
      finalWidth = height;
      finalHeight = width;
    } else {
      // Keep original dimensions
      finalWidth = width;
      finalHeight = height;
    }

    // Calculate aspect ratio
    double aspectRatio = finalWidth / finalHeight;

    if (kDebugMode) {
      debugPrint('Final dimensions: ${finalWidth}x$finalHeight');
      debugPrint('Calculated aspect ratio: $aspectRatio');
      debugPrint('Aspect ratio description: ${_getAspectRatioDescription(aspectRatio)}');
      debugPrint('==========================================');
    }

    return aspectRatio;
  }

  static (double width, double height) computeDimensions({
    required double width,
    required double height,
    required int rotationCorrection,
  }) {
    // Automatically detect if video is portrait mode
    bool isPortraitMode = isLikelyPortraitVideo(
      width: width,
      height: height,
      rotationCorrection: rotationCorrection,
    );

    bool shouldSwapDimensions = _shouldSwapDimensions(
      rotationCorrection: rotationCorrection,
      isPortraitMode: isPortraitMode,
    );

    if (shouldSwapDimensions) {
      return (height, width);
    } else {
      return (width, height);
    }
  }

  /// Determine if dimensions should be swapped based on rotation and mode
  static bool _shouldSwapDimensions({
    required int rotationCorrection,
    required bool isPortraitMode,
  }) {
    // Android commonly reports video with 90° rotation for portrait videos
    // This means the actual display orientation is rotated from metadata dimensions

    if (Platform.isAndroid) {
      // For Android portrait videos with 90° or 270° rotation
      if (isPortraitMode && (rotationCorrection == 90 || rotationCorrection == 270)) {
        return true;
      }

      // For landscape videos with 90° or 270° rotation that should be portrait
      if (!isPortraitMode && (rotationCorrection == 90 || rotationCorrection == 270)) {
        // Additional logic can be added here if needed
        return false;
      }
    }

    // For iOS or other cases, usually no swap needed
    return false;
  }

  /// Get descriptive text for aspect ratio value
  static String _getAspectRatioDescription(double aspectRatio) {
    if (aspectRatio > 1.7 && aspectRatio < 1.8) {
      return '16:9 Landscape';
    } else if (aspectRatio > 0.55 && aspectRatio < 0.58) {
      return '9:16 Portrait';
    } else if (aspectRatio > 1.3 && aspectRatio < 1.4) {
      return '4:3 Standard';
    } else if (aspectRatio > 0.7 && aspectRatio < 0.8) {
      return '3:4 Portrait';
    } else if (aspectRatio > 0.9 && aspectRatio < 1.1) {
      return '1:1 Square';
    } else if (aspectRatio > 1.0) {
      return 'Custom Landscape';
    } else {
      return 'Custom Portrait';
    }
  }

  /// Calculate aspect ratio from video file path
  /// This is a convenience method that attempts to determine orientation
  /// from file metadata (requires video_player or similar package)
  ///
  /// Example:
  /// ```dart
  /// final aspectRatio = await VideoAspectRatioHandler.calculateFromFile(
  ///   filePath: '/path/to/video.mp4'
  /// );
  /// ```
  static Future<double> calculateFromFile(String filePath) async {
    // This method would require video metadata extraction
    // Implementation depends on available packages like video_player, ffmpeg_kit, etc.
    // For now, return a default value and log a warning

    if (kDebugMode) {
      debugPrint('Warning: calculateFromFile not implemented yet');
      debugPrint('Please use calculateAspectRatio with explicit parameters');
    }

    // Return a reasonable default (16:9 landscape)
    return 16.0 / 9.0;
  }

  /// Validate aspect ratio value
  /// Ensures the calculated aspect ratio is within reasonable bounds
  static double validateAspectRatio(double aspectRatio) {
    // Clamp to reasonable video aspect ratio range
    // Most videos are between 0.5 (ultra portrait) and 2.4 (ultra wide)
    double validatedRatio = aspectRatio.clamp(0.1, 10.0);

    if (validatedRatio != aspectRatio && kDebugMode) {
      debugPrint('Warning: Aspect ratio $aspectRatio was clamped to $validatedRatio');
    }

    return validatedRatio;
  }

  /// Get common aspect ratio presets
  /// Useful for UI selection or fallback values
  static Map<String, double> getCommonAspectRatios() {
    return {
      '16:9 Landscape': 16.0 / 9.0, // 1.777...
      '9:16 Portrait': 9.0 / 16.0, // 0.5625
      '4:3 Standard': 4.0 / 3.0, // 1.333...
      '3:4 Portrait': 3.0 / 4.0, // 0.75
      '1:1 Square': 1.0, // 1.0
      '21:9 Cinematic': 21.0 / 9.0, // 2.333...
    };
  }

  /// Detect orientation from aspect ratio
  /// Returns 'portrait', 'landscape', or 'square'
  static String detectOrientation(double aspectRatio) {
    if (aspectRatio > 1.1) {
      return 'landscape';
    } else if (aspectRatio < 0.9) {
      return 'portrait';
    } else {
      return 'square';
    }
  }

  /// Helper method to determine if video is likely portrait based on dimensions
  /// This helps when isPortraitMode parameter is not available
  static bool isLikelyPortraitVideo({
    required double width,
    required double height,
    required int rotationCorrection,
  }) {
    // If rotation is 90° or 270°, dimensions are swapped in metadata
    // So we need to check the dimensions after applying rotation
    if (rotationCorrection == 90 || rotationCorrection == 270) {
      // After 90°/270° rotation: original width becomes height, original height becomes width
      // So if original width > original height, the final result will be portrait
      return width > height; // Original width > original height means portrait after rotation
    }

    // For 0° or 180° rotation, dimensions are not swapped
    // Check dimensions directly
    return height > width; // Original height > original width means portrait
  }
}

/// Extension for easy aspect ratio calculations on Size objects
extension VideoSizeExtension on Size {
  /// Calculate aspect ratio with rotation correction
  /// Automatically detects portrait/landscape orientation
  double aspectRatioWithRotation({
    required int rotationCorrection,
  }) {
    return VideoAspectRatioHandler.calculateAspectRatio(
      width: width,
      height: height,
      rotationCorrection: rotationCorrection,
    );
  }
}

/*
=============================================================================
USAGE EXAMPLES:
=============================================================================

1. Basic Usage (Simplified - No need to specify isPortraitMode):
```dart
final aspectRatio = VideoAspectRatioHandler.calculateAspectRatio(
  width: 3840,
  height: 2160,
  rotationCorrection: 90,
);
// Result: 0.5625 (correct 9:16 portrait ratio - auto-detected)
```

2. Using with Size object:
```dart
final videoSize = Size(3840, 2160);
final aspectRatio = videoSize.aspectRatioWithRotation(
  rotationCorrection: 90,
);
// Auto-detects portrait/landscape orientation
```

3. Validation:
```dart
double rawRatio = calculateSomeRatio();
double safeRatio = VideoAspectRatioHandler.validateAspectRatio(rawRatio);
```

4. Orientation detection:
```dart
String orientation = VideoAspectRatioHandler.detectOrientation(aspectRatio);
print('Video orientation: $orientation'); // 'portrait', 'landscape', or 'square'
```

5. Using common presets:
```dart
final presets = VideoAspectRatioHandler.getCommonAspectRatios();
double landscapeRatio = presets['16:9 Landscape']!; // 1.777...
```

6. Check if video is likely portrait (helper method):
```dart
bool isPortrait = VideoAspectRatioHandler.isLikelyPortraitVideo(
  width: 3840,
  height: 2160,
  rotationCorrection: 90,
);
// Result: true (auto-detected based on dimensions and rotation)
```

=============================================================================
INTEGRATION WITH VIDEO PREVIEW:
=============================================================================

In your video preview widget (Simplified usage):
```dart
Widget buildVideoPreview() {
  // Your video metadata
  double videoWidth = 3840;
  double videoHeight = 2160;
  int rotation = 90;

  // Calculate correct aspect ratio (auto-detects portrait/landscape)
  double aspectRatio = VideoAspectRatioHandler.calculateAspectRatio(
    width: videoWidth,
    height: videoHeight,
    rotationCorrection: rotation,
  );

  return AspectRatio(
    aspectRatio: aspectRatio,
    child: VideoPlayer(videoController),
  );
}
```

=============================================================================
*/
