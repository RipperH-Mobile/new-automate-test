import 'package:get/get.dart';
import 'package:uchat/screens.dart';

class GroupProfilePickerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupProfilePickerScreenController>(() => GroupProfilePickerScreenController());
    Get.put<GroupProfilePickerScreenController>(GroupProfilePickerScreenController());
  }
}
