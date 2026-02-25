import 'package:camera/camera.dart';

enum CameraFlashMode {
  auto,
  always,
  off,
  torch,
  unknown;

  static CameraFlashMode fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'auto':
        return CameraFlashMode.auto;
      case 'always':
        return CameraFlashMode.always;
      case 'off':
        return CameraFlashMode.off;
      case 'torch':
        return CameraFlashMode.torch;
      default:
        return CameraFlashMode.unknown;
    }
  }

  static CameraFlashMode fromFlashMode(FlashMode flashMode) {
    switch (flashMode) {
      case FlashMode.auto:
        return CameraFlashMode.auto;
      case FlashMode.always:
        return CameraFlashMode.always;
      case FlashMode.off:
        return CameraFlashMode.off;
      case FlashMode.torch:
        return CameraFlashMode.torch;
    }
  }

  FlashMode get mode {
    switch (this) {
      case CameraFlashMode.auto:
        return FlashMode.auto;
      case CameraFlashMode.always:
        return FlashMode.always;
      case CameraFlashMode.off:
        return FlashMode.off;
      case CameraFlashMode.torch:
        return FlashMode.torch;
      case CameraFlashMode.unknown:
        return FlashMode.off; // Default to off for unknown modes
    }
  }
}
