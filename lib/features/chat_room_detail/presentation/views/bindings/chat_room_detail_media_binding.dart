import 'package:get/get.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_media_controller.dart';

class ChatRoomDetailMediaBinding implements Bindings {
  @override
  void dependencies() {
    final tag = Get.parameters['id'] ?? 'NEW_ROOM';

    Get.put<ChatRoomDetailMediaController>(
      ChatRoomDetailMediaController(tag: tag),
      tag: tag,
    );
  }
}
