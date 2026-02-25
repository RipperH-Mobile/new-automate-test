import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/presentation/controllers/register/create_account_uchat_id_controller.dart';
import 'package:uchat/features/auth/presentation/views/screens/mobile/register/create_account_screen_layout.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/input/app_text_field.dart';

class CreateAccountUChatIDScreen extends GetView<CreateAccountUChatIDController> {
  const CreateAccountUChatIDScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CreateAccountScreenLayout(
      heading: 'Create UChat ID'.tr,
      subTitle:
          'You can use UChat ID to share with other users to add your friends instead of using your phone number.'.tr,
      secondSubTitle:
          'You can use a-z, 0-9, _ and . UChat ID must be at least 8 characters long and limit 20 characters.'.tr,
      children: [
        Obx(
          () {
            final hasError = controller.errorText.value.isNotEmpty;
            return AppTextField.withClear(
              labelText: 'UChat ID'.tr,
              hintText: 'Enter your UChat ID'.tr,
              textEditController: controller.userIdController,
              errorMsg: hasError ? controller.errorText.value.tr : null,
              isShowIcon: controller.showClearIcon.value,
              onIconTap: controller.clearName,
            );
          },
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
