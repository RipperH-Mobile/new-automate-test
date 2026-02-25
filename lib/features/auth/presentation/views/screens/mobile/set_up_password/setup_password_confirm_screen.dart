import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/presentation/controllers/set_up_password/setup_password_controller.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/input/app_text_field_password.dart';
import 'package:uchat/widgets/input/app_text_widget_password_incorrect.dart';

class SetupPasswordConfirmScreen extends GetView<SetupPasswordController> {
  const SetupPasswordConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: 'Password'.tr,
        actionButton: AppControlButton.forward(
          context: context,
          label: 'Later'.tr,
          onTap: controller.onLater,
        ),
        leadingButton: AppControlButton.back(
          context: context,
        ),
      ),
      body: SingleChildScrollView(
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
              height: AppSpace.space2,
            ),
            AppText.body3(
              'Finally, please enter your password again to confirm'.tr,
              context: context,
              color: context.theme.appColors.textDark,
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
