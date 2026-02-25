import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class ActionUnavailableDialog {
  static Future<void> show() async {
    return UChatNewDialog.showSingleButtonDialog(
      context: Get.context!,
      title: 'Action unavailable'.tr,
      description:
          'You can\'t do this action with this friend while on a call. Please end the call first and try again.'.tr,
      confirmText: 'Got it'.tr,
      confirmTextColor: Get.context!.theme.appColors.textPrimary,
      isDestructive: true,
      onConfirm: () {
        Get.back();
      },
    );
  }
}
