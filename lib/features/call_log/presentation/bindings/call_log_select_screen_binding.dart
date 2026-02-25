import 'package:get/get.dart';
import 'package:uchat/features/call_log/presentation/controllers/call_log_select_screen_controller.dart';

class CallLogSelectScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CallLogSelectScreenController>(CallLogSelectScreenController());
  }
}
