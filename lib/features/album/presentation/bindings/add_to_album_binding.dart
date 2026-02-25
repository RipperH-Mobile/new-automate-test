import 'package:get/get.dart';
import 'package:uchat/features/album/presentation/controllers/add_to_album_controller.dart';

class AddToAlbumBinding implements Bindings {
  @override
  void dependencies() {
    final tag = Get.parameters['id'] ?? 'NEW_ROOM';

    Get.put<AddToAlbumController>(
      AddToAlbumController(tag: tag),
      tag: tag,
    );
  }
}