import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/presentation/controllers/set_up_password/setup_password_controller.dart';
import 'package:uchat/features/auth/presentation/views/widgets/password_condition_check_list.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/input/app_text_field_password.dart';

class SetupPasswordCreateScreen extends GetView<SetupPasswordController> {
  const SetupPasswordCreateScreen({super.key});

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
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.space6,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppText.heading4(
              'Create a password to enhance the highest level of security'.tr,
              context: context,
            ),
            const SizedBox(
              height: AppSpace.space2,
            ),
            AppText.body3(
              'Please create a password that ensures the highest level of security for your account, in order to protect your personal information of your online activities'
                  .tr,
              context: context,
              color: context.theme.appColors.textDark,
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
                        Get.toNamed(Routes.setupPasswordNewConfirm);
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
