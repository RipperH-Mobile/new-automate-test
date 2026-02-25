import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/presentation/controllers/register/create_account_confirm_password_controller.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/register/create_account_screen_layout.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/input/app_text_field_password.dart';
import 'package:uchat/widgets/input/app_text_widget_password_incorrect.dart';

class CreateAccountConfirmPasswordScreen extends GetView<CreateAccountConfirmPasswordController> {
  const CreateAccountConfirmPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CreateAccountScreenLayout(
      heading: 'Confirm Password'.tr,
      children: [
        Obx(
          () {
            return AppTextFieldPassword(
              labelText: 'Password'.tr,
              hintText: 'Enter password'.tr,
              textEditController: controller.confirmPasswordController,
              errorWidget: controller.errorText.value.isNotEmpty
                  ? AppTextWidgetPasswordIncorrect(
                      errorText: controller.errorText.value,
                    )
                  : null,
            );
          },
        ),
        const SizedBox(
          height: AppSpace.space8,
        ),
        Obx(
          () => AppFilledButton.primary(
            context: context,
            label: 'Confirm this password'.tr,
            onTap: controller.isButtonEnabled.value ? controller.onConfirm : null,
          ),
        ),
      ],
    );
  }
}
