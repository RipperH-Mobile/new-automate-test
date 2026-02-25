import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class CallBusyDialog {
  static Future<void> show() async {
    return UChatNewDialog.showSingleButtonWithIconDialog(
      svgIcon: Assets.vectors.callBusyDialogIcon.svg(),
      title: 'Busy on Another Call'.tr,
      description: 'The recipient is on another call. Try again later'.tr,
      confirmText: 'Got it'.tr,
      confirmTextColor: Get.context!.theme.appColors.textPrimary,
      isDestructive: true,
      onConfirm: () {
        Get.back();
      },
    );
  }
}
