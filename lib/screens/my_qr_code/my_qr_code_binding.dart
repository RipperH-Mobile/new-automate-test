import 'package:get/get.dart';

import 'my_qr_code_controller.dart';

class MyQrCodeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<MyQrCodeController>(MyQrCodeController());
  }
}
