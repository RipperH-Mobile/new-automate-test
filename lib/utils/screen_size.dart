import 'package:get/get.dart';

/// Whether screen is smaller than specific length
/// used for checking and making custom ui for device with small screen
bool get isSmallScreen {
  return Get.width < 400;
}
