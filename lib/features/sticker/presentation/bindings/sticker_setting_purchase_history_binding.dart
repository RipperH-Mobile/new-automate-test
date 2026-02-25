import 'package:get/get.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_setting_purchase_history_controller.dart';

class StickerSettingPurchaseHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StickerSettingPurchaseHistoryController>(
      StickerSettingPurchaseHistoryController(),
    );
  }
}
