import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/presentation/controllers/forgot_password/forgot_password_controller.dart';
import 'package:uchat/features/auth/presentation/views/widgets/password_condition_check_list.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/input/app_text_field_password.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

class ForgotPasswordSetupNewPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordSetupNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      appBar: AppBarDefault(
        title: 'Reset Password'.tr,
        leadingButton: AppControlButton.back(
          context: context,
        ),
        automaticallyImplyLeading: false,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.space6,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppText.heading4(
              'Create password'.tr,
              context: context,
            ),
            const SizedBox(
              height: AppSpace.space6,
            ),
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
              height: AppSpace.space6,
            ),
            Obx(
              () => AppFilledButton.primary(
                context: context,
                label: 'Continue'.tr,
                onTap: controller.passwordCondition.value.isValid
                    ? () {
                        Get.toNamed(
                          Routes.forgotPasswordSetupNewPasswordConfirm,
                          arguments: controller.args,
                        );
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
