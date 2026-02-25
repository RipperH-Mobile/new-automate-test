import 'dart:ui';

import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:uchat/features/chat_room_list/presentation/controllers/chat_list_controller.dart';
import 'package:uchat/lang/lang.dart';

class SettingChangeLanguageController extends GetxController {
  final currentLocaleTag = ''.obs;

  @override
  void onInit() {
    currentLocaleTag(Get.locale?.toLanguageTag());
    super.onInit();
  }

  void handleBack() {
    Get.back();
  }

  void changeLocale(Locale locale) {
    Get.updateLocale(locale);
    saveLocaleSetting(locale);
    currentLocaleTag(locale.toLanguageTag());

    OneSignal.User.setLanguage(getOneSignalLangCode(locale));

    if (Get.isRegistered<ChatListController>()) {
      ChatListController.instance.sortedRoomList();
    }
  }
}
