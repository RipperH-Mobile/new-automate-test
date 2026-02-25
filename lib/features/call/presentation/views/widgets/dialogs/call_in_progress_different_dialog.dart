import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class CallInProgressDifferentDialog {
  static Future<void> show() async {
    return UChatNewDialog.showSingleButtonWithIconDialog(
      svgIcon: Assets.vectors.iconCallInProgress.svg(),
      title: 'Call in Progress'.tr,
      description: 'The same user is trying to start another call while already on a different device'.tr,
      confirmText: 'Got it'.tr,
      confirmTextColor: Get.context!.theme.appColors.textPrimary,
      isDestructive: true,
      onConfirm: () async {
        Get.back();
      },
    );
  }
}
