import 'package:get/get.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_pack_detail_controller.dart';

class StickerPackDetailBinding extends Bindings {
  @override
  void dependencies() {
    final packId = Get.parameters['stickerPackId'];

    Get.put<StickerPackDetailController>(StickerPackDetailController(stickerPackId: packId!), tag: packId);
  }
}
