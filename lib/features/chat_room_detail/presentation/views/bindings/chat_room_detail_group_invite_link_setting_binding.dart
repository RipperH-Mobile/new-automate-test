import 'package:get/get.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_group_invite_link_setting_controller.dart';

class ChatRoomDetailGroupInviteLinkSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ChatRoomDetailGroupInviteLinkSettingController>(
      ChatRoomDetailGroupInviteLinkSettingController(),
    );
  }
}
