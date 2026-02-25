import 'package:get/get.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_files_controller.dart';

class ChatRoomDetailFilesBinding implements Bindings {
  @override
  void dependencies() {
    final tag = Get.parameters['id'] ?? 'NEW_ROOM';

    Get.put<ChatRoomDetailFilesController>(
      ChatRoomDetailFilesController(tag: tag),
      tag: tag,
    );
  }
}
