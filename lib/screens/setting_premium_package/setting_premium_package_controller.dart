import 'package:get/get.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/widgets.dart';

class SettingPremiumPackageController extends GetxController {
  UserEntity? get user => UserController.instance.currentUser();

  void handleCancelSubPremium() {
    if ((GetPlatform.isAndroid && UserController.instance.isSubscribeApple) ||
        (GetPlatform.isIOS && UserController.instance.isSubscribeGoogle)) {
      UChatDialog.showBlockCrossPlatformProcess();
    } else {
      Get.toNamed(Routes.premiumCancel);
    }
  }
}
