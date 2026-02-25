import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/presentation/controllers/setting_acoount_otp/setting_account_otp_request_controller.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

class SettingAccountOtpRequestScreen extends GetView<SettingAccountOtpController> {
  const SettingAccountOtpRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.surfaceDark,
      appBar: AppBarDefault(
        title: controller.title,
        leadingButton: AppControlButton.back(
          context: context,
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
        child: Column(
          children: [
            if (controller.args.email != null) ...[
              Assets.images.v2.iconEmailLogin.image(
                width: AppSize.size20,
                height: AppSize.size20,
              ),
              const SizedBox(
                height: AppSpace.space6,
              ),
            ] else
              const SizedBox(height: AppSpace.space12),
            AppText.heading4(
              'Get OTP to @type '.trParams({'type': controller.getOtpTitle}),
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
                    text: controller.args.phoneNumber != null
                        ? ' ${controller.args.phoneNumber!.maskPhoneNumber()} '
                        : ' ${controller.args.email} ',
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
            const SizedBox(height: AppSpace.space12),
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
