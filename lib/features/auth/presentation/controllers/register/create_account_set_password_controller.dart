import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/features/auth/domain/entities/password_condition_entity.dart';
import 'package:uchat/features/auth/presentation/arguments/create_account_confirm_password_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/create_account_set_password_arguments.dart';
import 'package:uchat/routes/app_pages.dart';

class CreateAccountSetPasswordController extends GetxController {
  final CreateAccountSetPasswordArguments args;

  CreateAccountSetPasswordController({required this.args});

  final TextEditingController passwordController = TextEditingController();
  final Rx<PasswordConditionEntity> passwordCondition = PasswordConditionEntity().obs;
  bool alreadySendInputCreatePassword = false;

  bool get isValid => passwordCondition.value.isValid;

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }

  void onPasswordChanged(String password) {
    if (!alreadySendInputCreatePassword) {
      GetIt.I<TaxonomyService>().sendEvent(EventName.inputCreatePassword);
      alreadySendInputCreatePassword = true;
    }
    passwordCondition.value = passwordCondition.value.copyWith(
      isLengthValid: password.length >= 8,
      isLowercaseValid: password.contains(RegExp(r'[a-z]')),
      isUppercaseValid: password.contains(RegExp(r'[A-Z]')),
      isNumberValid: password.contains(RegExp(r'[0-9]')),
      isSymbolValid: password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
    );
  }

  // If user taps 'Continue', navigate to confirm screen
  void onContinue() {
    if (!isValid) return;

    GetIt.I<TaxonomyService>().sendEvent(EventName.clickContinueCreatePassword);

    final newPassword = passwordController.text;

    // Pass the typed password to the confirm-password screen via arguments
    Get.toNamed(
      Routes.createAccountConfirmPassword,
      arguments: CreateAccountConfirmPasswordArguments(
        actionToken: args.actionToken,
        phoneNumber: args.phoneNumber,
        displayName: args.displayName,
        newPassword: newPassword,
      ),
    );
  }
}
