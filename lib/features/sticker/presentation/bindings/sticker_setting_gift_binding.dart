import 'package:get/get.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_setting_gift_controller.dart';

class StickerSettingGiftBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StickerSettingGiftController>(
      StickerSettingGiftController(),
    );
  }
}
