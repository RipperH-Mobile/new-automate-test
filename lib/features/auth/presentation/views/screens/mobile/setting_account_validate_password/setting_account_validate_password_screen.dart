import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/presentation/controllers/setting_account_validate_password/setting_account_validate_password_controller.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/input/app_text_field_password.dart';
import 'package:uchat/widgets/input/app_text_widget_password_incorrect.dart';

class SettingAccountValidatePasswordScreen extends GetView<SettingAccountValidatePasswordController> {
  const SettingAccountValidatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      appBar: AppBarDefault(
        title: controller.getOtpTitle,
        leadingButton: AppControlButton.back(
          context: context,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.space6,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppText.heading4(
                'Enter your password'.tr,
                context: context,
              ),
              const SizedBox(
                height: AppSpace.space6,
              ),
              Obx(
                () {
                  final errorCount = controller.passwordAttempts.value;
                  return AppTextFieldPassword(
                    labelText: 'Password'.tr,
                    hintText: 'Enter your password'.tr,
                    textEditController: controller.passwordCtl,
                    onChanged: controller.onPasswordCtlChanged,
                    errorWidget: controller.errorMessage.value.isNotEmpty
                        ? AppTextWidgetPasswordIncorrect(
                            errorCount: errorCount,
                            errorText: controller.errorMessage.value,
                          )
                        : null,
                  );
                },
              ),
              const SizedBox(
                height: AppSpace.space4,
              ),
              GestureDetector(
                child: AppText.body3(
                  'Forgot password?'.tr,
                  context: context,
                  color: context.theme.appColors.textPrimary,
                ),
                onTap: () {
                  controller.onForgotPassword();
                },
              ),
              const SizedBox(
                height: AppSpace.space8,
              ),
              Obx(
                () {
                  return AppFilledButton.primary(
                    context: context,
                    label: controller.cooldownTime.value < 1
                        ? 'Continue'.tr
                        : 'Access block for @time minute'
                            .trParams({'time': controller.getFormattedTime(controller.cooldownTime.value)}),
                    onTap: controller.enableButton
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
      ),
    );
  }
}
