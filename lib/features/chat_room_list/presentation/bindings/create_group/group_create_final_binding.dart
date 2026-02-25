import 'package:get/get.dart';
import 'package:uchat/screens.dart';

class GroupCreateFinalBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupCreateFinalController>(() => GroupCreateFinalController());
    Get.put<GroupCreateFinalController>(GroupCreateFinalController());
  }
}
