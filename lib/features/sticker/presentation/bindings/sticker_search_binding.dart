import 'package:get/get.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_search_controller.dart';

class StickerSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StickerSearchController());
  }
}
