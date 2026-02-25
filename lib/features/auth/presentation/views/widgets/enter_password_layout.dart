import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/input/app_text_field_password.dart';
import 'package:uchat/widgets/input/app_text_widget_password_incorrect.dart';

class EnterPasswordLayout extends StatelessWidget {
  const EnterPasswordLayout({
    super.key,
    required this.title,
    required this.onForgotPassword,
    required this.onContinue,
    required this.passwordAttempts,
    required this.errorMessage,
    required this.password,
    required this.passwordCtl,
    required this.cooldownTime,
    required this.onPasswordCtlChanged,
    required this.getFormattedTime,
  });

  final String title;
  final VoidCallback onForgotPassword;
  final VoidCallback onContinue;
  final RxInt passwordAttempts;
  final RxString errorMessage;
  final RxString password;
  final TextEditingController passwordCtl;
  final RxInt cooldownTime;
  final Function(String) onPasswordCtlChanged;
  final String Function(int) getFormattedTime;

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      appBar: AppBarDefault(
        title: title,
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
                  final errorCount = passwordAttempts.value;
                  return AppTextFieldPassword(
                    labelText: 'Password'.tr,
                    hintText: 'Enter your password'.tr,
                    textEditController: passwordCtl,
                    onChanged: onPasswordCtlChanged,
                    errorWidget: errorMessage.value.isNotEmpty
                        ? AppTextWidgetPasswordIncorrect(
                            errorCount: errorCount,
                            errorText: errorMessage.value,
                          )
                        : null,
                  );
                },
              ),
              const SizedBox(
                height: AppSpace.space4,
              ),
              GestureDetector(
                onTap: onForgotPassword,
                child: AppText.body3(
                  'Forgot password?'.tr,
                  context: context,
                  color: context.theme.appColors.textPrimary,
                ),
              ),
              const SizedBox(
                height: AppSpace.space8,
              ),
              Obx(
                () {
                  return AppFilledButton.primary(
                    context: context,
                    label: cooldownTime.value < 1
                        ? 'Continue'.tr
                        : 'Access block for @time minute'.trParams({'time': getFormattedTime(cooldownTime.value)}),
                    onTap: password.isNotEmpty && cooldownTime.value == 0
                        ? () {
                            onContinue();
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
