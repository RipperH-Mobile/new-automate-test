import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/presentation/controllers/2fa/two_fa_otp_login_receipt_method_controller.dart';
import 'package:uchat/features/auth/presentation/views/widgets/otp_receipt_method_selection.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

class TwoFaOtpLoginReceiptMethodScreen extends GetView<TwoFaOtpLoginReceiptMethodController> {
  const TwoFaOtpLoginReceiptMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.surfaceDark,
      appBar: AppBarDefault(
        title: 'OTP receipt method'.tr,
        leadingButton: AppControlButton.back(
          context: context,
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpace.space4),
            AppText.body3(
              'Choose a method to receive the OTP code'.tr,
              context: context,
              color: context.theme.appColors.textLighter,
            ),
            const SizedBox(height: AppSpace.space4),
            OtpReceiptMethodSelection(
              initialPhoneNumber: controller.methods[SelectedOtpType.phone] ?? '',
              initialEmail: controller.methods[SelectedOtpType.email] ?? '',
              onMethodSelected: controller.onMethodChanged,
            ),
            const SizedBox(height: AppSpace.space8),
            AppFilledButton.primary(
              context: context,
              label: 'Continue'.tr,
              onTap: controller.onContinue,
            ),
          ],
        ),
      ),
    );
  }
}
