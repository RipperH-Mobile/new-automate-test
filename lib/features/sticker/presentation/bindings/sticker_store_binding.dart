import 'package:get/get.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_store_controller.dart';

class StickerStoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StickerStoreController>(StickerStoreController());
  }
}
