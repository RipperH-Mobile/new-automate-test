import 'package:get/get.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/entities/collections/user_collection.dart';
import 'package:uchat/entities/services/user_db.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/screens/setting_chats/setting_chats_controller.dart';
import 'package:uchat/screens/setting_chats_sound/setting_chats_sound_arguments.dart';

class SettingChatsSoundController extends GetxController {
  final SettingChatsSoundArguments args;

  SettingChatsSoundController({
    required this.args,
  });

  final newMessageSoundFriendSelected = ''.obs;
  final newMessageSoundMeSelected = ''.obs;

  final userCtl = Get.find<UserController>();
  final userChatSettingCtl = Get.find<SettingChatsController>();

  UserEntity? get user => userCtl.currentUser();
  final _userDb = UserDb();

  bool get isMe => args.isMe;

  @override
  void onInit() {
    newMessageSoundFriendSelected(user?.newMessageSoundFriendSelected ?? '');
    newMessageSoundMeSelected(user?.newMessageSoundMeSelected ?? '');
    super.onInit();
  }

  void handleBack() {
    Get.back();
  }

  void handleComplete() {
    final isSoundMeNotEmpty = newMessageSoundMeSelected.isNotEmpty;
    final isSoundFriendNotEmpty = newMessageSoundFriendSelected.isNotEmpty;

    if (user != null && isSoundMeNotEmpty && isSoundFriendNotEmpty) {
      userCtl.currentUser(
        user!.copyWith(
          newMessageSoundFriendSelected: newMessageSoundFriendSelected(),
          newMessageSoundMeSelected: newMessageSoundMeSelected(),
        ),
      );

      userChatSettingCtl.newMessageSoundFriendSelected(newMessageSoundFriendSelected());
      userChatSettingCtl.newMessageSoundMeSelected(newMessageSoundMeSelected());
      _userDb.updateUser(UserCollection.fromEntity(user!));
    }
    Get.back();
  }
}
