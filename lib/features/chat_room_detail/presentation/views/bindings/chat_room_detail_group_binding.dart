import 'package:get/get.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_group_controller.dart';

class ChatRoomDetailGroupBinding implements Bindings {
  @override
  void dependencies() {
    final tag = Get.parameters['id'] ?? 'NEW_ROOM';

    Get.put<ChatRoomDetailGroupController>(
      tag: tag,
      ChatRoomDetailGroupController(
        tag: tag,
      ),
    );
  }
}
