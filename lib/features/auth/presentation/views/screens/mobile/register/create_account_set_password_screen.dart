import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/presentation/controllers/register/create_account_set_password_controller.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/register/create_account_screen_layout.dart';
import 'package:uchat/features/auth/presentation/views/widgets/password_condition_check_list.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/input/app_text_field_password.dart';

class CreateAccountSetPasswordScreen extends GetView<CreateAccountSetPasswordController> {
  const CreateAccountSetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CreateAccountScreenLayout(
      heading: 'Create password'.tr,
      children: [
        AppTextFieldPassword(
          labelText: 'Password'.tr,
          hintText: 'Enter password'.tr,
          textEditController: controller.passwordController,
          onChanged: (value) {
            controller.onPasswordChanged(value);
          },
        ),
        const SizedBox(
          height: AppSpace.space4,
        ),
        AppText.body3(
          'Create a stronger password'.tr,
          context: context,
        ),
        const SizedBox(
          height: AppSpace.space3,
        ),
        Obx(
          () => PasswordConditionCheckList(
            condition: controller.passwordCondition.value,
          ),
        ),
        const SizedBox(
          height: AppSpace.space8,
        ),
        Obx(
          () => AppFilledButton.primary(
            context: context,
            label: 'Continue'.tr,
            onTap: controller.passwordCondition.value.isValid ? controller.onContinue : null,
          ),
        ),
      ],
    );
  }
}
