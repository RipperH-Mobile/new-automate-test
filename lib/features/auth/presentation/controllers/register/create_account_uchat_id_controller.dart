import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/features/auth/domain/use_cases/verify_uchat_id_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/create_account_profile_avatar_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/create_account_uchat_id_arguments.dart';
import 'package:uchat/routes/app_pages.dart';

class CreateAccountUChatIDController extends GetxController {
  final CreateAccountUChatIDArguments args;

  final TextEditingController userIdController = TextEditingController();

  final isButtonEnabled = false.obs;
  final errorText = ''.obs;
  final showClearIcon = false.obs;

  bool alreadySendInputUChatIdTaxonomyEvent = false;

  // A single unified error message for local or server errors
  static const String kErrorMessage = 'The ID doesn’t match the conditions. Please try again.';
  static const int maxLength = 20;

  CreateAccountUChatIDController({required this.args});

  @override
  void onInit() {
    super.onInit();
    userIdController.addListener(_onUserIdChanged);
  }

  @override
  void onClose() {
    userIdController.dispose();
    super.onClose();
  }

  void _onUserIdChanged() {
    // Cancel any pending debounce so don't do multiple server calls
    EasyDebounce.cancel('uchatIdDebounce');

    if (alreadySendInputUChatIdTaxonomyEvent) {
      GetIt.I<TaxonomyService>().sendEvent(EventName.inputCreateUChatId);
      alreadySendInputUChatIdTaxonomyEvent = true;
    }

    final rawUserId = userIdController.text;

    // 1) If empty => clear error, disable button, hide clear icon
    if (rawUserId.trim().isEmpty) {
      showClearIcon.value = false;
      isButtonEnabled.value = false;
      errorText.value = '';
      return;
    } else {
      // If there's *some* text, show the clear icon
      showClearIcon.value = true;
    }

    // 2) Check if user typed uppercase
    //    If there's any uppercase letter => show error, user must fix it
    if (rawUserId != rawUserId.toLowerCase()) {
      errorText.value = kErrorMessage;
      isButtonEnabled.value = false;
      return;
    }

    // 3) If user typed beyond 20 chars, truncate right away
    if (rawUserId.length > maxLength) {
      final truncated = rawUserId.substring(0, maxLength);
      userIdController.text = truncated;
      // Move cursor to end
      userIdController.selection = TextSelection.collapsed(offset: truncated.length);
      // return here because the text changed, and `_onUserIdChanged`
      // will be called again.
      return;
    }

    // 4) Local validation: must match ^[a-z0-9._]+$ and length >= 8
    final userId = rawUserId.trim(); // already confirmed lowercase
    if (!_isValidLocally(userId)) {
      errorText.value = kErrorMessage;
      isButtonEnabled.value = false;
      return;
    }

    // 5) If local checks pass => do server check (debounced)
    EasyDebounce.debounce(
      'uchatIdDebounce',
      const Duration(milliseconds: 300),
      () => _checkServer(userId),
    );
  }

  // Local check function
  bool _isValidLocally(String userId) {
    // a) Must match ^[a-z0-9._]+$
    final isValidChars = RegExp(r'^[a-z0-9._]+$').hasMatch(userId);
    // b) Must be >= 8 chars
    if (!isValidChars || userId.length < 8) {
      return false;
    }
    return true;
  }

  // Debounced server check
  Future<void> _checkServer(String userId) async {
    try {
      await GetIt.I<VerifyUChatIdUseCase>().call(userId);
      // If no exception => ID is available
      errorText.value = '';
      isButtonEnabled.value = true;
    } catch (e) {
      // Any ApiException => same error message
      errorText.value = kErrorMessage;
      isButtonEnabled.value = false;
    }
  }

  void clearName() {
    userIdController.clear();
  }

  void onContinue() {
    // Make sure button is active
    if (!isButtonEnabled.value) return;

    GetIt.I<TaxonomyService>().sendEvent(EventName.clickContinueCreateUChatId);

    final userId = userIdController.text.trim().toLowerCase();

    Get.toNamed(
      Routes.createAccountProfileAvatar,
      arguments: CreateAccountProfileAvatarArguments(
        actionToken: args.actionToken,
        phoneNumber: args.phoneNumber,
        displayName: args.displayName,
        password: args.password,
        userID: userId,
      ),
    );
  }
}
