import 'package:get/get.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/themes/util.dart';

class SettingChangeFontController extends GetxController {
  final fontTheme = ''.obs;
  final isChangedFont = false.obs;

  UserController get userCtl {
    return Get.find<UserController>();
  }

  @override
  void onInit() {
    fontTheme(UTheme().themeName);
    isChangedFont(UTheme().themeName != 'Origins');

    super.onInit();
  }

  void handleChangeFont(String font) {
    // Prevent changing font if user enable previewFont is false
    if (!userCtl.previewFont) return;

    isChangedFont(fontTheme() != font);

    if (font == 'Noto') {
      fontTheme(font);
    } else if (font == 'NotoLooped') {
      fontTheme(font);
    } else if (font == 'BaiJamjuree') {
      fontTheme(font);
    }

    if (!isChangedFont()) fontTheme('Origins');

    UTheme().changeTheme(fontTheme());
  }
}
