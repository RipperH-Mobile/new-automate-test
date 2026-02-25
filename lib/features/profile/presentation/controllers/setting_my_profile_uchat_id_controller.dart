import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/data/data_sources/account_service.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/features/profile/presentation/profile_presentation.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class SettingMyProfileUchatIdController extends GetxController {
  final userCtl = Get.find<UserController>();

  UserEntity? get user => userCtl.currentUser();

  TextEditingController inputController = TextEditingController();
  FocusNode focusNode = FocusNode();

  final newUsername = ''.obs;
  final maxLength = AppEnv.userIDLengthLimit.obs;
  final isChanged = false.obs;
  final showClearIcon = false.obs;
  final isDoneEnabled = false.obs;
  final errorText = ''.obs;
  final hasError = false.obs;
  final isPreviewMode = false.obs;
  final isValid = false.obs;

  String? initialValue;
  bool isFirstTime = true;

  // Error messages (specific messages for each case)
  static const String kErrorInvalidConditions = 'The ID doesn\'t match the conditions. Please try again.';
  static const String kErrorAlreadyExist = 'This UChat ID is already exist.';
  static const String kErrorOldUsername = 'You cannot use your old UChat ID.';
  static const int maxLengthLimit = 20;

  void setInitialValue(String? value) {
    initialValue = value ?? user?.username ?? '';

    // Check if user has already changed username (preview mode)
    isPreviewMode.value = user?.lastEditUsernameAt != null;

    if (initialValue!.isNotEmpty) {
      inputController.text = initialValue!;
      newUsername.value = initialValue!;
    }

    _updateDoneButtonState();
    inputController.addListener(_onUsernameChanged);
  }

  void _onUsernameChanged() {
    if (isFirstTime) {
      isFirstTime = false;
      return;
    }
    
    // Cancel any pending debounce so don't do multiple server calls
    EasyDebounce.cancel('uchatIdDebounce');

    final rawUserId = inputController.text;

    // 1) If empty => clear error, disable button, hide clear icon
    if (rawUserId.trim().isEmpty) {
      showClearIcon.value = false;
      _clearError();
      _clearValidState();
      _updateChangedState();
      _updateDoneButtonState();
      return;
    } else {
      // If there's *some* text, show the clear icon
      showClearIcon.value = true;
    }

    // 2) Check if user typed uppercase
    //    If there's any uppercase letter => show error, user must fix it
    if (rawUserId != rawUserId.toLowerCase()) {
      _showError(kErrorInvalidConditions);
      _clearValidState();
      _updateChangedState();
      _updateDoneButtonState();
      return;
    }

    // 3) If user typed beyond 20 chars, truncate right away
    if (rawUserId.length > maxLengthLimit) {
      final truncated = rawUserId.substring(0, maxLengthLimit);
      inputController.text = truncated;
      // Move cursor to end
      inputController.selection = TextSelection.collapsed(offset: truncated.length);
      // return here because the text changed, and `_onUsernameChanged`
      // will be called again.
      return;
    }

    // 4) Local validation: must match ^[a-z0-9._]+$ and length >= 8
    final userId = rawUserId.trim(); // already confirmed lowercase
    newUsername.value = userId;
    _updateChangedState();

    if (!_isValidLocally(userId)) {
      _showError(kErrorInvalidConditions);
      _clearValidState();
      _updateDoneButtonState();
      return;
    }

    // 5) If local checks pass => do server check (debounced)
    _clearError(); // Clear error before server validation
    EasyDebounce.debounce(
      'uchatIdDebounce',
      const Duration(milliseconds: 300),
      () => _checkServer(userId),
    );
  }

  void _updateChangedState() {
    // Check if text changed from initial value
    final currentValue = inputController.text.trim().toLowerCase();
    final hasChanged = currentValue != (initialValue ?? user?.username ?? '');
    isChanged.value = hasChanged;
  }

  // Local check function
  bool _isValidLocally(String userId) {
    // a) Must match ^[a-z0-9._]+$
    final isValidChars = RegExp(r'^[a-z0-9._]+$').hasMatch(userId);

    // b) Must be >= 8 chars
    if (!isValidChars || userId.length < 8) {
      return false;
    }

    // c) First and last characters cannot be . or _
    if (userId.startsWith('.') || userId.startsWith('_') || userId.endsWith('.') || userId.endsWith('_')) {
      return false;
    }

    return true;
  }

  // Debounced server check with specific error handling
  Future<void> _checkServer(String userId) async {
    try {
      final isValidOnServer = await AccountService().checkIsUsernameValid(userId);
      if (isValidOnServer) {
        // Server says it's valid and available
        isValid.value = true;
        _clearError();
      }
    } on ApiException catch (e) {
      _log.i('ApiException username validation: ${e.type} : ${e.message}');

      // Handle specific error types with specific messages
      switch (e.type) {
        case 'ERR_ACCOUNT_USERNAME_ALREADY_EXIST':
          _showError(kErrorAlreadyExist);
          break;
        case 'ERR_ACCOUNT_CANNOT_UPDATE_SAME_USERNAME':
          _showError(kErrorOldUsername);
          break;
        case 'ERR_ACCOUNT_INVALID_USERNAME':
        default:
          _showError(kErrorInvalidConditions);
          break;
      }
      _clearValidState();
    } catch (e, stackTrace) {
      handleException(
        e,
        onFailedHostLookupException: () {
          _showError('You are offline. Please try again later.');
        },
        onUnknownException: () {
          _log.e('Username validation error', e, stackTrace);
          _showError('Error');
        },
      );
      _clearValidState();
    } finally {
      _updateDoneButtonState();
    }
  }

  void _showError(String message) {
    errorText.value = message.tr;
    hasError.value = true;
  }

  void _clearError() {
    errorText.value = '';
    hasError.value = false;
  }

  void _clearValidState() {
    isValid.value = false;
  }

  void _updateDoneButtonState() {
    final currentValue = inputController.text.trim();

    // Done button is enabled ONLY when ALL these conditions are met:
    // 1. Text is not empty
    // 2. Text has changed from initial value
    // 3. Has no errors
    // 4. Is valid (passed server validation)
    // 5. Not in preview mode
    isDoneEnabled.value =
        currentValue.isNotEmpty && isChanged.value && !hasError.value && isValid.value && !isPreviewMode.value;
  }

  void clearUsername() {
    inputController.clear();
  }

  @override
  void onClose() {
    inputController.removeListener(_onUsernameChanged);
    EasyDebounce.cancelAll();
    inputController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  void handleBack() async {
    if (isChanged.value && !isPreviewMode.value) {
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
        onCancel: () => Get.back(),
        onConfirm: () => Get.back(),
        barrierDismissible: false,
      );
    } else {
      Get.back();
    }
  }

  void handleFinish() async {
    // Additional safety check - Done button should only work when all conditions are met
    if (!isDoneEnabled.value || isPreviewMode.value || hasError.value || !isValid.value) {
      return;
    }

    // Show warning dialog before saving
    final isConfirm = await UChatNewDialog.showDialog(
      context: Get.context!,
      title: 'Edit UChat ID'.tr,
      description: 'You can only change your UChat ID once. Are you sure you want to do this?'.tr,
      cancelText: 'Cancel'.tr,
      confirmText: 'Confirm'.tr,
      cancelTextColor: Get.context!.theme.appColors.textLight,
      confirmTextColor: Get.context!.theme.appColors.textPrimary,
      onCancel: () => Get.back(),
      onConfirm: () => true,
    );

    if (isConfirm == true) {
      Get.back(result: newUsername.value);
    }
  }

  void onUsernameChange(String value) {
    // This method is kept for compatibility but _onUsernameChanged handles the logic
    if (!UChatScreenUtil.instance.isMobilePlatform) {
      if (Get.isRegistered<SettingMyProfileController>()) {
        Get.find<SettingMyProfileController>().userIdPreview(newUsername.value);
      }
    }
  }
}
