// uchat_id_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/profile/presentation/controllers/setting_my_profile_uchat_id_controller.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/input/app_text_field.dart';

class UChatIdBottomSheet extends StatelessWidget {
  final String? initialValue;

  const UChatIdBottomSheet({
    super.key,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingMyProfileUchatIdController());

    // Set initial value
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setInitialValue(initialValue);
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false, // Keep bottom sheet in place
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpace.space4,
              vertical: AppSpace.space6,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: controller.handleBack,
                  child: AppText.body1(
                    'Cancel'.tr,
                    context: context,
                    color: context.theme.appColors.textPrimary,
                  ),
                ),
                AppText.title3(
                  'UChat ID'.tr,
                  context: context,
                  color: context.theme.appColors.textDarkest,
                  textAlign: TextAlign.center,
                ),
                // Show Done button only if user hasn't changed UChat ID before
                Obx(() {
                  if (controller.isPreviewMode.value) {
                    // In preview mode, no Done button
                    return const SizedBox(width: 48); // Same width as Cancel for centering
                  }

                  return GestureDetector(
                    onTap: controller.isDoneEnabled.value ? controller.handleFinish : null,
                    child: AppText.body1Bold(
                      'Done'.tr,
                      context: context,
                      color: controller.isDoneEnabled.value
                          ? context.theme.appColors.textPrimary
                          : context.theme.appColors.textDisable,
                    ),
                  );
                }),
              ],
            ),
          ),

          // Content area
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpace.space4,
                vertical: AppSpace.space2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text field
                  Obx(
                    () => AppTextField.withClear(
                      labelText: 'UChat ID'.tr,
                      hintText: 'Enter your UChat ID'.tr,
                      textEditController: controller.inputController,
                      isShowIcon: controller.showClearIcon.value,
                      focusNode: controller.focusNode,
                      onIconTap: controller.clearUsername,
                      maxLength: controller.maxLength.value,
                      onChanged: controller.onUsernameChange,
                      autoFocus: !controller.isPreviewMode.value, // Only autofocus in edit mode
                      enable: !controller.isPreviewMode.value, // Disable in preview mode
                      errorMsg: controller.hasError.value && !controller.isPreviewMode.value
                          ? controller.errorText.value
                          : null,
                    ),
                  ),

                  const SizedBox(height: AppSpace.space4),

                  // Information text
                  Obx(() {
                    if (controller.isPreviewMode.value) {
                      // Preview mode message
                      return AppText.body3(
                        'You have previously changed your UChat ID. Further changes are not allowed.'.tr,
                        context: context,
                        color: context.theme.appColors.textLight,
                      );
                    } else {
                      // Edit mode instructions
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.body3(
                            'You can use a-z, 0-9, _ and . UChat ID must be at least 8 characters long and limit 20 characters.'
                                .tr,
                            context: context,
                            color: context.theme.appColors.textLight,
                          ),
                          const SizedBox(height: AppSpace.space2),
                          AppText.body3(
                            'First and last characters cannot be a period (.) or an underscore (_)'.tr,
                            context: context,
                            color: context.theme.appColors.textLight,
                          ),
                        ],
                      );
                    }
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
