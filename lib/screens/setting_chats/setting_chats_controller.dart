import 'package:get/get.dart';
import 'package:uchat/controllers/app_settings_controller.dart';
import 'package:uchat/controllers/audio_controller.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/entities/collections.dart';
import 'package:uchat/entities/services/user_db.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/screens/setting_chats_sound/setting_chats_sound_arguments.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets/loading/loading.dart';

class SettingChatsController extends GetxController {
  final isMobile = UChatScreenUtil.instance.isMobile;

  final userCtl = Get.find<UserController>();

  UserEntity? get user => userCtl.currentUser();
  final _userDb = UserDb();

  final isNewMsgSoundEnable = false.obs;
  final isNewMsgAnimatedEnable = false.obs;
  final newMessageAnimatedDuration = 500.obs;
  final newMessageAnimatedType = 0.obs;
  final newMessageSoundFriendSelected = ''.obs;
  final newMessageSoundMeSelected = ''.obs;

  final saveDirectoryPath = ''.obs;

  AppSettingsController get appSettingsController => Get.find<AppSettingsController>();

  @override
  void onInit() {
    saveDirectoryPath(FileService.instance.desktopSaveTargetDirectoryPath);
    isNewMsgSoundEnable(user?.isNewMessageSoundEnable ?? false);
    isNewMsgAnimatedEnable(user?.isNewMessageAnimatedEnable ?? false);
    newMessageAnimatedDuration(user?.newMessageAnimatedDuration ?? 0);
    newMessageAnimatedType(user?.newMessageAnimatedType ?? 0);
    newMessageSoundFriendSelected(user?.newMessageSoundFriendSelected ?? '');
    newMessageSoundMeSelected(user?.newMessageSoundMeSelected ?? '');

    super.onInit();
  }

  void toggleNewMsgSoundEnable(bool? value) {
    if (value == null) return;
    isNewMsgSoundEnable(value);
    if (user != null) {
      userCtl.currentUser(
        user!.copyWith(
          isNewMessageSoundEnable: isNewMsgSoundEnable(),
        ),
      );
      _userDb.updateUser(UserCollection.fromEntity(user!));
    }
  }

  void toggleNewMsgAnimatedEnable(bool? value) {
    if (value == null) return;
    isNewMsgAnimatedEnable(value);
    if (user != null) {
      userCtl.currentUser(
        user!.copyWith(
          isNewMessageAnimatedEnable: isNewMsgAnimatedEnable(),
        ),
      );
      _userDb.updateUser(UserCollection.fromEntity(user!));
    }
  }

  void handleResetNewMsgSound() async {
    await UChatLoading.show(status: 'Resetting...'.tr);
    if (user != null) {
      userCtl.currentUser(
        user!.copyWith(
          newMessageSoundFriendSelected: getMessageFriendFileName,
          newMessageSoundMeSelected: getMessageMeFileName,
        ),
      );
      await _userDb.updateUser(UserCollection.fromEntity(user!));
      newMessageSoundFriendSelected(getMessageFriendFileName);
      newMessageSoundMeSelected(getMessageMeFileName);
    }
    await UChatLoading.success(message: 'Done'.tr);
  }

  void handleResetNewMsgAnimation() async {
    await UChatLoading.show(status: 'Resetting...'.tr);
    if (user != null) {
      userCtl.currentUser(
        user!.copyWith(
          newMessageAnimatedDuration: 300,
          newMessageAnimatedType: 1,
        ),
      );
      await _userDb.updateUser(UserCollection.fromEntity(user!));
      newMessageAnimatedDuration(300);
      newMessageAnimatedType(1);
    }
    await UChatLoading.success(message: 'Done'.tr);
  }

  void handleBack() {
    Get.back();
  }

  void handleHiddenChats() {
    if (isMobile) {
      Get.toNamed(Routes.settingChatHidden);
    } else {
      appSettingsController.setRoutesSettingRightPanel(routes: Routes.settingChatHidden);
    }
  }

  void handleSoundSetting({required bool isMe}) {
    if (isMobile) {
      Get.toNamed(
        Routes.settingChatSound,
        arguments: SettingChatsSoundArguments(
          isMe: isMe,
        ),
      );
    } else {
      appSettingsController.setRoutesSettingRightPanel(routes: Routes.settingChatSound);
    }
  }

  void handleAnimationSetting() {
    if (isMobile) {
      Get.toNamed(Routes.settingChatAnimation);
    } else {
      appSettingsController.setRoutesSettingRightPanel(routes: Routes.settingChatAnimation);
    }
  }

  Future<void> handleSettingSaveDirectory() async {
    final fileServiceInstance = FileService.instance;

    final directoryPath = await fileServiceInstance.getDirectoryPath();

    if (directoryPath != null) {
      fileServiceInstance.desktopSaveTargetDirectoryPath = directoryPath;
      saveDirectoryPath(fileServiceInstance.desktopSaveTargetDirectoryPath);
    }
  }
}
