import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class CallUnableDialog {
  static Future<void> show({
    String? debugCode,
    dynamic exception,
  }) async {
    return UChatNewDialog.showSingleButtonWithIconDialog(
      svgIcon: Assets.vectors.callUnableDialogIcon.svg(),
      title: 'Unable to Connect'.tr,
      description: 'Please try calling again later@debugCode'.trParams({
        'debugCode': debugCode != null ? '($debugCode)' : '',
      }),
      confirmText: 'Got it'.tr,
      confirmTextColor: Get.context!.theme.appColors.textPrimary,
      exception: exception,
      isDestructive: true,
      onConfirm: () {
        Get.back();
      },
    );
  }
}
