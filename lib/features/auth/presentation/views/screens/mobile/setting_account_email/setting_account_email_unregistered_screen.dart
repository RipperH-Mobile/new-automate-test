import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/presentation/controllers/setting_account_email/setting_account_email_v2_controller.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/button/app_outlined_button.dart';

class SettingAccountEmailUnregisteredScreen extends GetView<SettingAccountEmailV2Controller> {
  const SettingAccountEmailUnregisteredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.space14,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.images.emailLink.image(
              width: AppSize.size24,
              height: AppSize.size24,
            ),
            const SizedBox(
              height: AppSpace.space6,
            ),
            AppText.heading4(
              'Sync the new email for account?'.tr,
              context: context,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: AppSpace.space2,
            ),
            AppText.body3(
              'You haven’t registered your email yet. For added security, we kindly recommend connecting your email to this account'
                  .tr,
              context: context,
              color: context.theme.appColors.textLight,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: AppSpace.space6,
            ),
            AppFilledButton.primary(
              context: context,
              onTap: () => controller.onContinue(isChangeEmail: false),
              label: 'Continue'.tr,
            ),
            const SizedBox(
              height: AppSize.size4,
            ),
            AppOutlinedButton.defaultButton(
              context: context,
              onTap: () {
                Get.back();
              },
              label: 'Back'.tr,
            ),
          ],
        ),
      ),
    );
  }
}
