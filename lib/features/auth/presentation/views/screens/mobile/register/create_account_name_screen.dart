import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/presentation/controllers/register/create_account_name_controller.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/register/create_account_screen_layout.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/input/app_text_field.dart';

class CreateAccountNameScreen extends GetView<CreateAccountNameController> {
  const CreateAccountNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CreateAccountScreenLayout(
      heading: 'Enter your profile name'.tr,
      onPressedBack: () => controller.onBackPressed(context),
      children: [
        Obx(
          () => AppTextField.withClear(
            labelText: 'Name'.tr,
            hintText: 'Enter your name'.tr,
            textEditController: controller.nameController,
            isShowIcon: controller.showClearIcon.value,
            onIconTap: controller.clearName,
            maxLength: 20,
          ),
        ),
        const SizedBox(
          height: AppSpace.space8,
        ),
        Obx(
          () => AppFilledButton.primary(
            context: context,
            label: 'Continue'.tr,
            onTap: controller.isButtonEnabled.value ? controller.onContinue : null,
          ),
        ),
      ],
    );
  }
}
