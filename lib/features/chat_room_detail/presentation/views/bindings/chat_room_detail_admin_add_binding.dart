import 'package:get/get.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_admin_add_argument.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_admin_add_controller.dart';

class ChatRoomDetailAdminAddBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as ChatRoomDetailAdminAddArgument;
    Get.put<ChatRoomDetailAdminAddController>(
      ChatRoomDetailAdminAddController(
        args: args,
      ),
      tag: args.roomId,
    );
  }
}
