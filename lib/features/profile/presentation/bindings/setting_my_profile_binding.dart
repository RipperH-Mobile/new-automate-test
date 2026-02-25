import 'package:get/get.dart';
import 'package:uchat/features/profile/presentation/profile_presentation.dart';

class SettingMyProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingMyProfileController>(SettingMyProfileController());
  }
}
