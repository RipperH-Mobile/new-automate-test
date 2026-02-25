import 'package:get/get.dart';
import 'package:uchat/features/chat_room_list/presentation/controllers/search/search_all_message_result_controller.dart';

class SearchAllMessageResultBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SearchAllMessageResultController>(SearchAllMessageResultController());
  }
}
