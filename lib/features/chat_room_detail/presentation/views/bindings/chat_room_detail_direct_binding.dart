import 'package:get/get.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_direct_controller.dart';

class ChatRoomDetailDirectBinding implements Bindings {
  @override
  void dependencies() {
    final tag = Get.parameters['id'] ?? 'NEW_ROOM';

    Get.put<ChatRoomDetailDirectController>(
      tag: tag,
      ChatRoomDetailDirectController(
        tag: tag,
      ),
    );
  }
}
