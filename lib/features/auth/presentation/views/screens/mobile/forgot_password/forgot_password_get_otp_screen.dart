import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/theme/app_colors_theme.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/presentation/controllers/forgot_password/forgot_password_get_otp_controller.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

@Deprecated('unused')
class ForgotPasswordGetOtpScreen extends GetView<ForgotPasswordGetOtpController> {
  const ForgotPasswordGetOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      appBar: AppBarDefault(
        title: 'Forgot Password'.tr,
        leadingButton: AppControlButton.back(
          context: context,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          AppSpace.space6,
        ),
        child: Column(
          children: [
            AppText.heading4(
              'Get OTP to reset password'.tr,
              context: context,
            ),
            const SizedBox(
              height: AppSpace.space2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText.body2(
                  'We will send an OTP to'.tr,
                  context: context,
                  color: AppColorsTheme.light().textLight,
                ),
                AppText.body2Bold(
                  controller.args.phoneNumberDisplay,
                  context: context,
                  color: AppColorsTheme.light().textDarkest,
                ),
              ],
            ),
            AppText.body2(
              'to verify your identity.'.tr,
              context: context,
              color: AppColorsTheme.light().textLight,
            ),
            const SizedBox(
              height: AppSpace.space8,
            ),
            AppFilledButton.primary(
              context: context,
              onTap: () {
                controller.getOtpForgotPassword();
              },
              label: 'Get OTP'.tr,
            )
          ],
        ),
      ),
    );
  }
}
