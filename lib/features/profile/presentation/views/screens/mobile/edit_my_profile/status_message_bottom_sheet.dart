// status_message_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/profile/presentation/profile_presentation.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/input/app_text_field.dart';

class StatusMessageBottomSheet extends StatelessWidget {
  final String? initialValue;

  const StatusMessageBottomSheet({
    super.key,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingMyProfileStatusMessageController());

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
                  'Status'.tr,
                  context: context,
                  color: context.theme.appColors.textDarkest,
                  textAlign: TextAlign.center,
                ),
                Obx(() {
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
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpace.space4,
              vertical: AppSpace.space2,
            ),
            child: Obx(
              () => AppTextField.withClear(
                labelText: 'Status'.tr,
                hintText: 'Status'.tr,
                textEditController: controller.inputController,
                isShowIcon: controller.showClearIcon.value,
                focusNode: controller.focusNode,
                onIconTap: controller.clearStatusMessage,
                maxLength: controller.maxLength.value,
                onChanged: controller.onStatusMessageChange,
                autoFocus: true,
                minLines: 2,
                maxLines: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
