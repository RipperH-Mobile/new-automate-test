import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/features/profile/presentation/profile_presentation.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class SettingMyProfileStatusMessageController extends GetxController {
  final userCtl = Get.find<UserController>();

  UserEntity? get user => userCtl.currentUser();

  TextEditingController inputController = TextEditingController();
  FocusNode focusNode = FocusNode();

  final newStatusMessage = ''.obs;
  final maxLength = AppEnv.statusMessageLengthLimit.obs;
  final isChanged = false.obs;
  final showClearIcon = false.obs;
  final isDoneEnabled = false.obs;

  String? initialValue;

  @override
  void onInit() {
    super.onInit();
    // Listen to text changes
    inputController.addListener(_onTextChanged);
  }

  void setInitialValue(String? value) {
    initialValue = value ?? user?.originalStatusMessage ?? '';
    inputController.text = initialValue!;
    newStatusMessage.value = initialValue!;
    _updateDoneButtonState();
  }

  void _onTextChanged() {
    final currentValue = inputController.text; // Don't trim for status - allow spaces
    newStatusMessage.value = currentValue;

    // Check if text changed from initial value
    final originalStatus = initialValue ?? user?.originalStatusMessage ?? '';
    final hasChanged = currentValue != originalStatus;
    isChanged.value = hasChanged;

    // Show clear icon if there's text
    showClearIcon.value = currentValue.isNotEmpty;

    // Update done button state
    _updateDoneButtonState();
  }

  void _updateDoneButtonState() {
    // For status message: Always enable Done button if there's any change
    // Users can save empty status (unlike display name)
    isDoneEnabled.value = isChanged.value;
  }

  void clearStatusMessage() {
    inputController.clear();
  }

  @override
  void onClose() {
    inputController.removeListener(_onTextChanged);
    inputController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  void handleBack() async {
    if (isChanged.value) {
      // Show confirmation dialog if there are changes
      await UChatNewDialog.showDialog(
        context: Get.context!,
        title: 'Discard edit'.tr,
        description: 'Are you sure you want to discard your changes?'.tr,
        cancelText: 'Cancel'.tr,
        confirmText: 'Confirm'.tr,
        cancelTextColor: Get.context!.theme.appColors.textLight,
        confirmTextColor: Get.context!.theme.appColors.textPrimary,
        isDestructive: true,
        onCancel: () {
          // User wants to stay and continue editing
          Get.back(); // Close the dialog only
        },
        onConfirm: () {
          // User wants to discard changes
          Get.back(); // Close the bottom sheet
        },
        barrierDismissible: false, // Prevent closing by tapping outside
      );
    } else {
      // No changes, just close the bottom sheet
      Get.back();
    }
  }

  void handleFinish() {
    if (isDoneEnabled.value) {
      // Return the new status message (can be empty)
      Get.back(result: newStatusMessage.value);
    }
  }

  void onStatusMessageChange(String value) {
    // This method is kept for compatibility but _onTextChanged handles the logic
    newStatusMessage.value = value; // Don't trim for status message

    if (!UChatScreenUtil.instance.isMobilePlatform) {
      if (Get.isRegistered<SettingMyProfileController>()) {
        Get.find<SettingMyProfileController>().descriptionPreview(newStatusMessage.value);
      }
    }
  }
}
