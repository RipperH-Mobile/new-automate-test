import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/presentation/controllers/forgot_password/forgot_password_controller.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/input/app_text_field_password.dart';
import 'package:uchat/widgets/input/app_text_widget_password_incorrect.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

class ForgotPasswordConfirmScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      appBar: AppBarDefault(
        title: 'Reset Password'.tr,
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
            AppText.heading4(
              'Confirm password'.tr,
              context: context,
            ),
            const SizedBox(
              height: AppSpace.space6,
            ),
            Obx(
              () => AppTextFieldPassword(
                labelText: 'Password'.tr,
                hintText: 'Enter password'.tr,
                errorWidget: controller.confirmPasswordError.isNotEmpty == true
                    ? AppTextWidgetPasswordIncorrect(
                        errorText: controller.confirmPasswordError.value ?? '',
                      )
                    : null,
                onChanged: (value) {
                  controller.onConfirmPasswordChanged(value);
                },
              ),
            ),
            const SizedBox(
              height: AppSpace.space8,
            ),
            Obx(
              () => AppFilledButton.primary(
                context: context,
                label: 'Continue'.tr,
                onTap: controller.confirmPassword.isNotEmpty
                    ? () {
                        controller.onContinue();
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
