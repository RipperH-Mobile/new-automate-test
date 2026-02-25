import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/features/auth/presentation/arguments/create_account_confirm_password_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/create_account_uchat_id_arguments.dart';
import 'package:uchat/routes/app_pages.dart';

class CreateAccountConfirmPasswordController extends GetxController {
  final CreateAccountConfirmPasswordArguments args;

  CreateAccountConfirmPasswordController({required this.args});

  // The text that user enters on this confirm screen
  final TextEditingController confirmPasswordController = TextEditingController();

  final isButtonEnabled = false.obs;
  final errorText = ''.obs;

  bool alreadySendInputConfirmPasswordTaxonomyEvent = false;

  @override
  void onInit() {
    super.onInit();

    confirmPasswordController.addListener(() {
      if (!alreadySendInputConfirmPasswordTaxonomyEvent) {
        // Send taxonomy event only once when user starts typing
        GetIt.I<TaxonomyService>().sendEvent(EventName.inputConfirmPassword);
        alreadySendInputConfirmPasswordTaxonomyEvent = true;
      }
      final confirmText = confirmPasswordController.text.trim();

      if (confirmText.isEmpty) {
        // Nothing typed yet => disable button, clear error
        errorText.value = '';
        isButtonEnabled.value = false;
      } else {
        // As soon as user typed something => enable button (we'll do the final check in onConfirm())
        errorText.value = '';
        isButtonEnabled.value = true;
      }
    });
  }

  @override
  void onClose() {
    confirmPasswordController.dispose();
    super.onClose();
  }

  void onConfirm() {
    if (!isButtonEnabled.value) return;

    final typedConfirmPassword = confirmPasswordController.text.trim();

    // Check if typedConfirmPassword == original newPassword from the previous screen
    if (typedConfirmPassword != args.newPassword) {
      errorText.value = 'Passwords do not match, Please try again.'.tr;
      return;
    }

    // If match => navigate to next step (Create UChat ID, etc.)
    Get.offNamed(
      Routes.createAccountUChatID,
      arguments: CreateAccountUChatIDArguments(
        actionToken: args.actionToken,
        phoneNumber: args.phoneNumber,
        displayName: args.displayName,
        password: args.newPassword,
      ),
    );
  }
}
