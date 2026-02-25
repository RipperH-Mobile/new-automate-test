import 'package:get/get.dart';
import 'package:uchat/features/chat_room_list/presentation/controllers/search/chat_search_messages_controller.dart';

class ChatSearchMessagesBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ChatSearchMessagesController>(
      ChatSearchMessagesController(
        args: Get.arguments,
      ),
    );
  }
}
