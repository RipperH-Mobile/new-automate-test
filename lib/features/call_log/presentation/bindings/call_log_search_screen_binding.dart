import 'package:get/get.dart';
import 'package:uchat/features/call_log/presentation/controllers/call_log_search_screen_controller.dart';

class CallLogSearchScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CallLogSearchScreenController>(CallLogSearchScreenController());
  }
}
