import 'package:get/get.dart';
import 'package:uchat/features/chat_room_list/presentation/controllers/search/chat_search_controller.dart';

class ChatSearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ChatSearchController>(ChatSearchController());
  }
}
