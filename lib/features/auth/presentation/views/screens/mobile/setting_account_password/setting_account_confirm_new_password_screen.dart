import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/presentation/controllers/setting_account_password/setting_account_confirm_new_password_controller.dart';
import 'package:uchat/features/auth/presentation/views/widgets/password_input_field.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

class SettingAccountConfirmNewPasswordScreen extends GetView<SettingAccountConfirmNewPasswordController> {
  const SettingAccountConfirmNewPasswordScreen({super.key});

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
              'Confirm password'.tr,
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
                showWarning: controller.showPasswordNotMatchWarning.value,
                labelText: 'Password'.tr,
                hintText: 'Enter password'.tr,
                normalBorderColor: context.theme.appColors.borderSelected,
                errorBorderColor: context.theme.appColors.textError,
                suffixIconColor: context.theme.appColors.textLighter,
              ),
            ),
            Obx(() {
              if (!controller.showPasswordNotMatchWarning.value) {
                return const SizedBox.shrink();
              }

              return Padding(
                padding: const EdgeInsets.only(top: AppSpace.space2),
                child: AppText.body3(
                  'Password do not match, Please try again.'.tr,
                  context: context,
                  color: context.theme.appColors.textError,
                ),
              );
            }),
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
}
