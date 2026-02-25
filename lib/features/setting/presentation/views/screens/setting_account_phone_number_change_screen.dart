import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/presentation/views/widgets/login_with_phone_number_input.dart';
import 'package:uchat/features/setting/presentation/controllers/setting_account_phone_number_change_controller.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';

class SettingAccountPhoneNumberChangeScreen extends GetView<SettingAccountPhoneNumberChangeController> {
  const SettingAccountPhoneNumberChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      appBar: AppBarDefault(
        title: 'Change phone number'.tr,
        leadingButton: AppControlButton.back(
          context: context,
        ),
      ),
      resizeToAvoidBottomInset: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.space6,
        ),
        child: Column(
          children: [
            Assets.images.v2.phoneSignIn.image(
              width: 60,
            ),
            const SizedBox(
              height: AppSpace.space4,
            ),
            AppText.heading4(
              'Enter your phone number'.tr,
              context: context,
            ),
            const SizedBox(
              height: AppSpace.space2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpace.space8,
              ),
              child: AppText.body3(
                'We will send an OTP to this number to verify your identity.'.tr,
                context: context,
                textAlign: TextAlign.center,
                color: context.theme.appColors.textLight,
              ),
            ),
            const SizedBox(
              height: AppSpace.space6,
            ),
            // const LoginWithPhoneNumberInput(),
            const PhoneNumberInput<SettingAccountPhoneNumberChangeController>(),
            const SizedBox(
              height: AppSpace.space8,
            ),
            Obx(
              () {
                return AppFilledButton.primary(
                  context: context,
                  label: 'Continue'.tr,
                  onTap: controller.enableContinueButton ? controller.onContinue : null,
                );
              },
            ),
            const SizedBox(
              height: AppSpace.space6,
            ),
          ],
        ),
      ),
    );
  }
}
