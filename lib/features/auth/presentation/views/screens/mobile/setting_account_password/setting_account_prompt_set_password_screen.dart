import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/presentation/controllers/setting_account_password/setting_account_prompt_set_password_controller.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/button/app_outlined_button.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

class SettingAccountPromptSetPasswordScreen extends GetView<SettingAccountPromptSetPasswordController> {
  const SettingAccountPromptSetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.surfaceDark,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.space14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.vectors.iconSetupNewPassword.svg(
                width: AppSpace.space24,
                height: AppSpace.space24,
              ),
              const SizedBox(height: AppSpace.space6),
              AppText.heading4(
                'Create new password'.tr,
                context: context,
                color: context.theme.appColors.textDarkest,
              ),
              const SizedBox(height: AppSpace.space2),
              AppText.body3(
                'You haven\'t set a password yet. You can set a new password for added security'.tr,
                context: context,
                color: context.theme.appColors.textLight,
              ),
              const SizedBox(height: AppSpace.space6),
              AppFilledButton.primary(
                context: context,
                label: 'Continue'.tr,
                onTap: controller.onContinue,
              ),
              const SizedBox(height: AppSpace.space4),
              AppOutlinedButton.defaultButton(
                context: context,
                label: 'Back'.tr,
                onTap: controller.onBack,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
