import 'package:get/get.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_manage_controller.dart';

class StickerManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StickerManageController());
  }
}
