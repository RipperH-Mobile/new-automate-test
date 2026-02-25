import 'package:get/get.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_favorite_controller.dart';

class StickerFavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StickerFavoriteController());
  }
}
