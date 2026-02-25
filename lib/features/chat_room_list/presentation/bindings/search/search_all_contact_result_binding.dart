import 'package:get/get.dart';
import 'package:uchat/features/chat_room_list/presentation/controllers/search/search_all_contact_result_controller.dart';

class SearchAllContactResultBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SearchAllContactResultController>(SearchAllContactResultController());
  }
}
