import 'package:get/get.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_gift_choose_friend_controller.dart';

class StickerGiftChooseFriendBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StickerGiftChooseFriendController>(StickerGiftChooseFriendController());
  }
}
