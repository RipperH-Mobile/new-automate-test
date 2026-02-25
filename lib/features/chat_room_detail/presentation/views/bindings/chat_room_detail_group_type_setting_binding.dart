import 'package:get/get.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_group_type_setting_controller.dart';

class ChatRoomDetailGroupTypeSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ChatRoomDetailGroupTypeSettingController>(ChatRoomDetailGroupTypeSettingController());
  }
}
