import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/presentation/controllers/login/login_with_email_controller.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/input/app_text_field.dart';

class LoginWithEmailScreen extends GetView<LoginWithEmailController> {
  const LoginWithEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      appBar: AppBarDefault(
        title: 'Sign in'.tr,
        leadingButton: AppControlButton.back(
          context: context,
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.space6,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Assets.images.v2.iconEmailLogin.image(
              width: AppSize.size20,
              height: AppSize.size20,
            ),
            const SizedBox(
              height: AppSpace.space4,
            ),
            AppText.heading4(
              'Enter your email'.tr,
              context: context,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: AppSpace.space2,
            ),
            AppText.body2(
              'We will send an OTP to this email to verify your identity.'.tr,
              context: context,
              textAlign: TextAlign.center,
              color: context.theme.appColors.textLight,
            ),
            const SizedBox(
              height: AppSpace.space6,
            ),
            Obx(
              () {
                return AppTextField(
                  labelText: 'Email'.tr,
                  hintText: 'Example@email.com',
                  textEditController: controller.emailCtl,
                  inputType: TextInputType.emailAddress,
                  onChanged: controller.onEmailCtlChanged,
                  errorMsg: controller.errorMessage(),
                );
              },
            ),
            const SizedBox(
              height: AppSpace.space6,
            ),
            Obx(
              () {
                return AppFilledButton.primary(
                  context: context,
                  label: 'Continue'.tr,
                  onTap: controller.enableContinueButton
                      ? () {
                          controller.onContinue();
                        }
                      : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
