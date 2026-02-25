import 'package:get/get.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/entities/collections.dart';
import 'package:uchat/entities/services/user_db.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/screens/setting_chats/setting_chats_controller.dart';

class SettingChatsAnimationController extends GetxController {
  final newMessageAnimatedDuration = 500.obs;
  final newMessageAnimatedType = 0.obs;

  final userCtl = Get.find<UserController>();
  final userChatSettingCtl = Get.find<SettingChatsController>();
  UserEntity? get user => userCtl.currentUser();
  final _userDb = UserDb();

  @override
  void onInit() {
    newMessageAnimatedDuration(user?.newMessageAnimatedDuration ?? 0);
    newMessageAnimatedType(user?.newMessageAnimatedType ?? 0);
    super.onInit();
  }

  void handleBack() {
    Get.back();
  }

  void handleComplete() {
    if (user != null) {
      userCtl.currentUser(
        user!.copyWith(
          newMessageAnimatedDuration: newMessageAnimatedDuration().toInt(),
          newMessageAnimatedType: newMessageAnimatedType(),
        ),
      );
      userChatSettingCtl.newMessageAnimatedType(newMessageAnimatedType());
      userChatSettingCtl.newMessageAnimatedDuration(newMessageAnimatedDuration());
      _userDb.updateUser(UserCollection.fromEntity(user!));
    }
    Get.back();
  }
}
