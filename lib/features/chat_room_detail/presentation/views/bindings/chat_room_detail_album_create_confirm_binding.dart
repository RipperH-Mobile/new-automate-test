import 'package:get/get.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_album_create_confirm_controller.dart';

class ChatRoomDetailAlbumCreateConfirmBinding implements Bindings {
  @override
  void dependencies() {
    final tag = Get.parameters['id'] ?? 'NEW_ROOM';

    Get.put<ChatRoomDetailAlbumCreateConfirmController>(
      ChatRoomDetailAlbumCreateConfirmController(tag: tag),
      tag: tag,
    );
  }
}
