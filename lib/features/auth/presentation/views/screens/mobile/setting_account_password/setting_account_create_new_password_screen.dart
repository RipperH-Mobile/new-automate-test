import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/presentation/controllers/setting_account_password/setting_account_create_new_password_controller.dart';
import 'package:uchat/features/auth/presentation/views/widgets/password_input_field.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

class SettingAccountCreateNewPasswordScreen extends GetView<SettingAccountCreateNewPasswordController> {
  const SettingAccountCreateNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.surfaceDark,
      appBar: AppBarDefault(
        title: 'Change password'.tr,
        leadingButton: AppControlButton.back(
          context: context,
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.heading4(
              'Create new password'.tr,
              context: context,
              color: context.theme.appColors.textDarkest,
            ),
            const SizedBox(height: AppSpace.space6),
            Obx(
              () => PasswordInputField(
                textController: controller.newPasswordController,
                isPasswordObscured: controller.isNewPasswordObscured.value,
                togglePasswordVisibility: controller.toggleNewPasswordVisibility,
                onChanged: controller.onPasswordChanged,
                showWarning: controller.showOldPasswordWarning.value,
                labelText: 'Password'.tr,
                hintText: 'Enter password'.tr,
                normalBorderColor: context.theme.appColors.borderSelected,
                errorBorderColor: context.theme.appColors.textError,
                suffixIconColor: context.theme.appColors.textLighter,
              ),
            ),
            Obx(() {
              if (!controller.showOldPasswordWarning.value) {
                return const SizedBox.shrink();
              }

              return Padding(
                padding: const EdgeInsets.only(top: AppSpace.space2),
                child: AppText.body3(
                  'Unable to use old password'.tr,
                  context: context,
                  color: context.theme.appColors.textError,
                ),
              );
            }),
            const SizedBox(height: AppSpace.space4),
            AppText.body3(
              'Create a stronger password'.tr,
              context: context,
              color: context.theme.appColors.textDark,
            ),
            const SizedBox(height: AppSpace.space3),
            Obx(
              () => Column(
                children: [
                  _buildPasswordConditionItem(
                    context,
                    text: 'Use 8 or more characters'.tr,
                    isValid: controller.isLengthValid.value,
                  ),
                  const SizedBox(height: AppSpace.space2),
                  _buildPasswordConditionItem(
                    context,
                    text: 'Use a lowercase letter'.tr,
                    isValid: controller.hasLowercase.value,
                  ),
                  const SizedBox(height: AppSpace.space2),
                  _buildPasswordConditionItem(
                    context,
                    text: 'Use an uppercase letter'.tr,
                    isValid: controller.hasUppercase.value,
                  ),
                  const SizedBox(height: AppSpace.space2),
                  _buildPasswordConditionItem(
                    context,
                    text: 'Use a number'.tr,
                    isValid: controller.hasNumber.value,
                  ),
                  const SizedBox(height: AppSpace.space2),
                  _buildPasswordConditionItem(
                    context,
                    text: 'Use a symbol'.tr,
                    isValid: controller.hasSymbol.value,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpace.space8),
            Obx(
              () => AppFilledButton.primary(
                context: context,
                label: 'Continue'.tr,
                onTap: controller.isPasswordValid.value && !controller.isLoading.value
                    ? controller.submitNewPassword
                    : null,
              ),
            ),
            const SizedBox(height: AppSpace.space6),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordConditionItem(
    BuildContext context, {
    required String text,
    required bool isValid,
  }) {
    final validColor = context.theme.appColors.textPrimary;
    final invalidColor = context.theme.appColors.textLight;

    return Row(
      children: [
        Icon(
          isValid ? Icons.check : Icons.circle,
          color: isValid ? validColor : invalidColor,
          size: isValid ? AppSpace.space3 : AppSpace.space2,
        ),
        const SizedBox(width: AppSpace.space2),
        AppText.body3(
          text,
          context: context,
          color: isValid ? validColor : invalidColor,
        ),
      ],
    );
  }
}
