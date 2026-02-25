import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class CallInProgressDialog {
  static Future<void> show() async {
   return UChatNewDialog.showSingleButtonWithIconDialog(
      svgIcon: Assets.vectors.iconCallInProgress.svg(),
      title: 'Call in Progress'.tr,
      description: 'This user is already on a call and cannot initiate another one at the moment.'.tr,
      confirmText: 'Got it'.tr,
      confirmTextColor: Get.context!.theme.appColors.textPrimary,
      isDestructive: true,
      onConfirm: () async {
        Get.back();
      },
    );
  }
}
