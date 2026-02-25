import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/presentation/controllers/setting_account_forgot_password/setting_account_sent_email_forgot_password_controller.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';

class SettingAccountSentEmailForgotPasswordScreen extends GetView<SettingAccountSentEmailForgotPasswordController> {
  const SettingAccountSentEmailForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: 'Forgot password'.tr,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.space16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppSpace.space3,
            children: [
              AppText.heading4(
                'We’ve sent you an email to reset password'.tr,
                context: context,
                color: context.theme.appColors.textDarkest,
                textAlign: TextAlign.center,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Please check your email and press '.tr,
                  style: context.theme.appTexts.body3.copyWith(
                    color: context.theme.appColors.textLight,
                  ),
                  children: [
                    TextSpan(
                      text: 'Set a new password',
                      style: context.theme.appTexts.body3Bold.copyWith(
                        color: context.theme.appColors.textLight,
                      ),
                    ),
                    TextSpan(
                      text: ' to set a new password.'.tr,
                      style: context.theme.appTexts.body3.copyWith(
                        color: context.theme.appColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: AppSpace.space6,
          right: AppSpace.space6,
          bottom: AppSpace.space10,
        ),
        child: AppFilledButton.primary(
          context: context,
          label: 'Got it'.tr,
          onTap: controller.gotIt,
        ),
      ),
    );
  }
}
