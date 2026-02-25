import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/presentation/controllers/2fa/two_fa_otp_login_request_controller.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';

class TwoFaOtpLoginRequestScreen extends GetView<TwoFaOtpLoginRequestController> {
  const TwoFaOtpLoginRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: controller.args.phoneNumberMask != null ? 'Verify your phone number'.tr : 'Verify your email'.tr,
        leadingButton: AppControlButton.back(
          context: context,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
        child: Column(
          children: [
            const SizedBox(
              height: AppSpace.space20,
            ),
            AppText.heading4(
              'Get OTP to Sign in'.tr,
              context: context,
              color: context.theme.appColors.textDarkest,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpace.space2),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'We will send an OTP to'.tr,
                style: context.theme.appTexts.body2.copyWith(
                  color: context.theme.appColors.textLighter,
                ),
                children: [
                  TextSpan(
                    text: ' ${controller.args.phoneNumberMask ?? controller.args.emailMask} ',
                    style: context.theme.appTexts.body2Bold.copyWith(
                      color: context.theme.appColors.textDarkest,
                    ),
                  ),
                  TextSpan(
                    text: 'to verify your identity.'.tr,
                    style: context.theme.appTexts.body2.copyWith(
                      color: context.theme.appColors.textLighter,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: AppSpace.space16,
            ),
            AppFilledButton.primary(
              context: context,
              label: 'Get OTP'.tr,
              onTap: controller.requestOtp,
            ),
          ],
        ),
      ),
    );
  }
}
