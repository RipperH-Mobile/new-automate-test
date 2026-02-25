import 'package:get/get.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_album_rename_controller.dart';

class ChatRoomDetailAlbumRenameBinding implements Bindings {
  @override
  void dependencies() {
    final tag = Get.parameters['id'] ?? 'NEW_ROOM';

    Get.put<ChatRoomDetailAlbumRenameController>(
      ChatRoomDetailAlbumRenameController(tag: tag),
      tag: tag,
    );
  }
}
