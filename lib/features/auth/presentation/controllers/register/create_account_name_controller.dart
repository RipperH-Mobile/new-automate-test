import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/features/auth/presentation/arguments/create_account_name_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/create_account_set_password_arguments.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class CreateAccountNameController extends GetxController {
  final CreateAccountNameArguments args;

  late String actionToken;
  late String phoneNumber;

  final TextEditingController nameController = TextEditingController();

  final isButtonEnabled = false.obs;
  final showClearIcon = false.obs;
  static const int maxNameLength = 20;
  bool alreadySendInputNameTaxonomyEvent = false;

  CreateAccountNameController({required this.args});

  @override
  void onInit() {
    super.onInit();
    actionToken = args.actionToken;
    phoneNumber = args.phoneNumber;

    nameController.addListener(_onNameChanged);
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }

  void _onNameChanged() {
    if (!alreadySendInputNameTaxonomyEvent) {
      GetIt.I<TaxonomyService>().sendEvent(EventName.inputCreateName);
      alreadySendInputNameTaxonomyEvent = true;
    }
    String displayName = nameController.text;

    //  If user typed beyond 20 chars, truncate.
    if (displayName.characters.length > maxNameLength) {
      displayName = displayName.characters.take(maxNameLength).string;
      nameController.text = displayName;
      // Put the cursor at the end
      nameController.selection = TextSelection.collapsed(offset: displayName.length);
    }

    //  If there's any text, show Clear icon and enable button.
    if (displayName.trim().isNotEmpty) {
      isButtonEnabled.value = true;
      showClearIcon.value = true;
    } else {
      // If empty, disable button and hide Clear icon
      isButtonEnabled.value = false;
      showClearIcon.value = false;
    }
  }

  void clearName() {
    nameController.clear();
  }

  // If user hits the system back or an app bar back button
  void onBackPressed(BuildContext context) {
    _showDiscardDialog(context);
  }

  // Show "Discard account creation?" dialog
  void _showDiscardDialog(BuildContext context) {
    UChatNewDialog.showDialog(
      context: context,
      title: 'Discard account creation'.tr,
      description: 'Do you want to cancel account creation?'.tr,
      cancelText: 'Cancel'.tr,
      confirmText: 'Confirm'.tr,
      confirmTextColor: context.theme.appColors.textPrimary,
      cancelTextColor: context.theme.appColors.textLight,
      isDestructive: true,
      onConfirm: () => Get.offAllNamed(Routes.welcome),
    );
  }

  void onContinue() {
    // Validate one more time
    final displayName = nameController.text.trim();
    if (displayName.isEmpty || displayName.characters.length > maxNameLength) {
      return;
    }

    GetIt.I<TaxonomyService>().sendEvent(EventName.clickContinueCreateName);
    // Navigate to "Set Password" screen
    Get.toNamed(
      Routes.createAccountSetPassword,
      arguments: CreateAccountSetPasswordArguments(
        actionToken: actionToken,
        phoneNumber: phoneNumber,
        displayName: displayName,
      ),
    );
  }
}
