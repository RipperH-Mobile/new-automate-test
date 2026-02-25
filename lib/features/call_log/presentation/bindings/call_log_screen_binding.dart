import 'package:get/get.dart';
import 'package:uchat/features/call_log/presentation/controllers/call_log_screen_controller.dart';

class CallLogScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CallLogScreenController>(() => CallLogScreenController());
  }
}
