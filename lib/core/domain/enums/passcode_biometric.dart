import 'package:get/get.dart';

enum PasscodeBiometric {
  none,
  faceId,
  touchId,
  fingerprint;

  static PasscodeBiometric fromString(String value) {
    switch (value.toLowerCase()) {
      case 'face id':
        return PasscodeBiometric.faceId;
      case 'touch id':
        return PasscodeBiometric.touchId;
      case 'fingerprint':
        return PasscodeBiometric.fingerprint;
      default:
        return PasscodeBiometric.none;
    }
  }

  String get value {
    switch (this) {
      case PasscodeBiometric.faceId:
        return 'Face ID';
      case PasscodeBiometric.touchId:
        return 'Touch ID';
      case PasscodeBiometric.fingerprint:
        return 'Fingerprint';
      default:
        return 'None';
    }
  }

  @override
  toString() {
    switch (this) {
      case PasscodeBiometric.faceId:
        return 'Face ID'.tr;
      case PasscodeBiometric.touchId:
        return 'Touch ID'.tr;
      case PasscodeBiometric.fingerprint:
        return 'Fingerprint'.tr;
      default:
        return 'None'.tr;
    }
  }
}
