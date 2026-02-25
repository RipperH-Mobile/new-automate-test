import 'package:get/get.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_group_invite_link_controller.dart';

class ChatRoomDetailGroupInviteLinkBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ChatRoomDetailGroupInviteLinkController>(ChatRoomDetailGroupInviteLinkController());
  }
}
