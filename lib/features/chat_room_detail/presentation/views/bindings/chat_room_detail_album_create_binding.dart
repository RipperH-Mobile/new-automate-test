import 'package:get/get.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_album_create_controller.dart';

class ChatRoomDetailAlbumCreateBinding implements Bindings {
  @override
  void dependencies() {
    final tag = Get.parameters['id'] ?? 'NEW_ROOM';

    Get.put<ChatRoomDetailAlbumCreateController>(
      ChatRoomDetailAlbumCreateController(tag: tag),
      tag: tag,
    );
  }
}
