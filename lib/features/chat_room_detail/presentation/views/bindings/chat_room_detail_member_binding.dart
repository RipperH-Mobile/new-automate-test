import 'package:get/get.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_member_controller.dart';

class ChatRoomDetailMemberBinding implements Bindings {
  @override
  void dependencies() {
    final tag = Get.parameters['id'] ?? 'NEW_ROOM';

    Get.put<ChatRoomDetailMemberController>(
      ChatRoomDetailMemberController(tag: tag),
      tag: tag,
    );
  }
}
