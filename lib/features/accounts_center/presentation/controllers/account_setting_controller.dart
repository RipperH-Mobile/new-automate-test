import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/payloads/account/delete_account.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/domain/enums/passcode_mode.dart';
import 'package:uchat/core/domain/services/security_service.dart';
import 'package:uchat/core/domain/use_cases/get_user_by_id_use_case.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/presentation/arguments/passcode_arguments.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/entities/collections/user_collection.dart';
import 'package:uchat/features/accounts_center/domain/events/account_removed_event.dart';
import 'package:uchat/features/accounts_center/domain/events/account_updated_event.dart';
import 'package:uchat/features/accounts_center/domain/events/current_account_changed_event.dart';
import 'package:uchat/features/accounts_center/domain/services/accounts_center_service.dart';
import 'package:uchat/features/accounts_center/domain/use_cases/toggle_hidden_account_use_case.dart';
import 'package:uchat/features/accounts_center/presentation/arguments/account_setting_arguments.dart';
import 'package:uchat/features/auth/data/models/requests/multifactor_update_setting_request.dart';
import 'package:uchat/features/auth/data/models/requests/multifactor_validate_setting_request.dart';
import 'package:uchat/features/auth/domain/entities/multifactor_validate_entity.dart';
import 'package:uchat/features/auth/domain/entities/verify_password_setting_account_entity.dart';
import 'package:uchat/features/auth/domain/use_cases/check_password_required_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/delete_account_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/multifactor_update_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/multifactor_validate_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_otp_verify_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_otp_verify_result_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_validate_password_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/two_fa_otp_receipt_method_arguments.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/call/presentation/views/widgets/dialogs/action_unavailable_dialog.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_server_repository.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uuid/uuid.dart';

class AccountSettingIds {
  static const String userBox = 'account_setting_user_box';
  static const String phoneNumberBox = 'account_setting_phone_number_box';
  static const String emailBox = 'account_setting_email_box';
  static const String passwordBox = 'account_setting_password_box';
  static const String googleBox = 'account_setting_google_box';
  static const String appleBox = 'account_setting_apple_box';
  static const String facebookBox = 'account_setting_facebook_box';
  static const String twoFactorAuthBox = 'account_setting_two_factor_auth_box';
  static const String shortcutPasscodeBox = 'account_setting_shortcut_passcode_box';
  static const String hideAccountBox = 'account_setting_hide_account_box';
}

class AccountSettingController extends GetxController {
  final _log = useLogger();
  late UserEntity user;

  String phoneNumber = '';
  String email = '';
  String googleAccount = '';
  String appleId = '';
  String facebookAccount = '';
  bool allowMultiFactor = false;
  bool enableShortcutPasscode = false;
  bool enableHideAccount = false;

  StreamSubscription? _userUpdateSubscription;
  StreamSubscription? _currentAccountChangedSubscription;

  // Check disable function variables
  bool isGoToDevicesManagerButtonDisable = false;
  bool isDeleteAccountButtonDisable = false;
  bool isUpdateTwoFactorButtonDisable = false;
  bool isPinLockEnable = false;

  // Observables hasPassword
  bool get hasPassword {
    return user.hasPassword == true;
  }

  bool get googleAccountLinked {
    return user.linkAccounts?.google?.email != null;
  }

  bool get appleIdLinked {
    return user.linkAccounts?.apple?.id != null;
  }

  bool get facebookAccountLinked {
    return user.linkAccounts?.facebook?.email != null;
  }

  bool get isCurrentAccount {
    return UserController.instance.isCurrentUser(user.id ?? '');
  }

  @override
  void onInit() {
    super.onInit();

    final arg = Get.arguments as AccountSettingArguments;
    user = arg.user;

    _userUpdateSubscription = eventBus.on<UserUpdateEvent>().listen((event) {
      if (event.user.id == user.id) {
        user = user.update(event.user);
        updateUserInfo(event.user);
      }
    });

    _currentAccountChangedSubscription = eventBus.on<CurrentAccountChangedEvent>().listen((event) {
      update([AccountSettingIds.userBox]);
    });

    isPinLockEnable = GetIt.I<SecurityService>().hasPasscode;
    updateUserInfo(user);
    enableShortcutPasscode = user.shortcutPasscode != null;
    enableHideAccount = user.isMAHidden ?? false;
    update([
      AccountSettingIds.shortcutPasscodeBox,
      AccountSettingIds.hideAccountBox,
    ]);
  }

  @override
  void onClose() async {
    await _userUpdateSubscription?.cancel();
    await _currentAccountChangedSubscription?.cancel();

    super.onClose();
  }

  void updateUserInfo(UserEntity user) {
    getShortUserPhoneNumber(user.phoneNumber ?? '');
    getShortUserEmail(user.email ?? '');
    getShortUserGoogleAccount(user.linkAccounts?.google?.email ?? '');
    getShortUserAppleId(user.linkAccounts?.apple?.email ?? '');
    getShortUserFacebookAccount(user.linkAccounts?.facebook?.email ?? '');
    allowMultiFactor = user.accountSettings?.security?.allowMultiFactor ?? false;

    update([
      AccountSettingIds.phoneNumberBox,
      AccountSettingIds.emailBox,
      AccountSettingIds.googleBox,
      AccountSettingIds.appleBox,
      AccountSettingIds.facebookBox,
      AccountSettingIds.twoFactorAuthBox,
    ]);
  }

  void getShortUserPhoneNumber(String phoneNumber) {
    if (phoneNumber.isNotEmpty) {
      if (phoneNumber.length > 17) {
        phoneNumber = '${phoneNumber.substring(0, 17)}...';
      }

      this.phoneNumber = phoneNumber;
    } else {
      this.phoneNumber = '';
    }
  }

  void getShortUserEmail(String email) {
    if (email.isNotEmpty) {
      if (email.length > 20) {
        email = '${email.substring(0, 20)}...';
      }

      this.email = email;
    } else {
      this.email = 'Unregistered'.tr;
    }
  }

  void getShortUserGoogleAccount(String email) {
    if (email.isNotEmpty) {
      if (email.length > 20) {
        email = '${email.substring(0, 20)}...';
      }

      googleAccount = email;
    } else {
      googleAccount = 'Synced account'.tr;
    }
  }

  void getShortUserAppleId(String email) {
    if (email.isNotEmpty) {
      if (email.length > 20) {
        email = '${email.substring(0, 20)}...';
      }

      appleId = email;
    } else {
      appleId = 'Synced account'.tr;
    }
  }

  void getShortUserFacebookAccount(String email) {
    if (email.isNotEmpty) {
      if (email.length > 20) {
        email = '${email.substring(0, 20)}...';
      }

      facebookAccount = email;
    } else {
      facebookAccount = 'Synced account'.tr;
    }
  }

  void handleOpenAccountPhoneNumber(BuildContext context) async {
    if (!isCurrentAccount) {
      await UChatNewDialog.showAccountSettingUnavailableDialog(context, user);
      return;
    }

    Get.toNamed(Routes.settingAccountPhoneNumber);
  }

  void handleGoToSettingEmail(BuildContext context) async {
    if (!isCurrentAccount) {
      await UChatNewDialog.showAccountSettingUnavailableDialog(context, user);
      return;
    }

    if (user.email == null) {
      Get.toNamed(Routes.settingAccountEmailUnregistered);
    } else {
      Get.toNamed(Routes.settingAccountEmailV2);
    }
  }

  Future<void> handleOpenPassword(BuildContext context) async {
    if (!isCurrentAccount) {
      await UChatNewDialog.showAccountSettingUnavailableDialog(context, user);
      return;
    }

    if (hasPassword == true) {
      Get.toNamed(Routes.settingAccountChangePassword);
    } else {
      final result = await Get.toNamed(Routes.settingAccountPromptSetPassword);

      if (result == null) return;

      Get.toNamed(Routes.settingAccountChangePassword);
    }
  }

  Future<void> handleLinkGoogleAccount(BuildContext context) async {
    if (!isCurrentAccount) {
      await UChatNewDialog.showAccountSettingUnavailableDialog(context, user);
      return;
    }

    Get.toNamed(Routes.settingAccountUpdateGoogleAccount);
  }

  Future<void> handleLinkAppleId(BuildContext context) async {
    if (!isCurrentAccount) {
      await UChatNewDialog.showAccountSettingUnavailableDialog(context, user);
      return;
    }

    Get.toNamed(Routes.settingAccountUpdateAppleId);
  }

  Future<void> handleLinkFacebookAccount(BuildContext context) async {
    if (!isCurrentAccount) {
      await UChatNewDialog.showAccountSettingUnavailableDialog(context, user);
      return;
    }

    Get.toNamed(Routes.settingAccountUpdateFacebookAccount);
  }

  void handleGoToDevicesManager(BuildContext context) async {
    if (!isCurrentAccount) {
      await UChatNewDialog.showAccountSettingUnavailableDialog(context, user);
      return;
    }

    // Don't put this inside the try-catch block, otherwise it will end up executing the code in the finally block
    if (isGoToDevicesManagerButtonDisable) return;

    try {
      isGoToDevicesManagerButtonDisable = true;
      AppToast.showProcessingToast(Get.context!);

      //NOTE.check user have password or not
      final response = await GetIt.I<CheckPasswordRequiredUseCase>().call(NoParams()).timeout(const Duration(
            seconds: 30,
          ));

      isGoToDevicesManagerButtonDisable = false;
      AppToast.hideToast(Get.context!);

      if (response.passwordRequired) {
        //NOTE.fill password screen
        onTapManageDevicePasswordRequired();
      } else {
        //NOTE.get otp phone number screen
        final user = UserController.instance.currentUser();
        final phoneNumber = user?.phoneNumber ?? '';

        final result = await Get.toNamed(
          Routes.settingAccountOtpRequest,
          arguments: SettingAccountOtpVerifyArguments(
            actionType: AuthenticationActionType.devicesManager,
            phoneNumber: phoneNumber,
            method: SelectedOtpType.phone,
          ),
        );

        if (result == null) return;

        Get.toNamed(
          Routes.settingDevicesManager,
          arguments: result.actionToken,
        );
      }
    } on FailedHostLookupException catch (e, stackTrace) {
      _log.e('handleGoToDevicesManager failed, no internet.', e, stackTrace);
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } on TimeoutException {
      _log.e('onDeleteAccountAuthentication failed, timeout.');
      UChatNewDialog.showConnectionErrorDialog(context: Get.context!);
    } on DioException catch (e, stackTrace) {
      _log.e('handleGoToDevicesManager failed, connection error.', e, stackTrace);
      if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.connectionError) {
        UChatNewDialog.showConnectionErrorDialog(context: Get.context!);
      }
    } catch (e, stackTrace) {
      _log.e('handleGoToDevicesManager error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
    } finally {
      if (isGoToDevicesManagerButtonDisable) {
        isGoToDevicesManagerButtonDisable = false;
        AppToast.hideToast(Get.context!);
      }
    }
  }

  void onTapManageDevicePasswordRequired() async {
    try {
      //NOTE.validate password
      final validatePasswordResult = await Get.offNamed(
        Routes.settingAccountValidatePassword,
        arguments: SettingAccountValidatePasswordArguments(
          actionType: AuthenticationActionType.devicesManager,
        ),
      );

      if (validatePasswordResult == null) return;
      //NOTE.validate password success -> 2fa
      if (validatePasswordResult is VerifyPasswordSettingAccountUnable2faEntity) {
        final isUserAllowMultiFactor =
            UserController.instance.currentUser()?.accountSettings?.security?.allowMultiFactor;
        if (isUserAllowMultiFactor != true) {
          Get.toNamed(
            Routes.settingDevicesManager,
            arguments: validatePasswordResult.actionToken,
          );

          return;
        }
      }
      final verifyOtpResult = await Get.toNamed(
        Routes.twoFaOtpReceiptMethod,
        arguments: TwoFaOtpReceiptMethodArguments(
          actionType: AuthenticationActionType.devicesManager,
          method: SelectedOtpType.phone,
        ),
      );

      if (verifyOtpResult == null) return;

      //NOTE.2fa success -> manage all devices
      Get.toNamed(
        Routes.settingDevicesManager,
        arguments: verifyOtpResult.actionToken,
      );
    } on FailedHostLookupException catch (e, stackTrace) {
      _log.e('onTapManageDevicePasswordRequired failed, no internet.', e, stackTrace);
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('onTapManageDevicePasswordRequired error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
    }
  }

  void onCheckDeleteAccountAuthentication(BuildContext context) async {
    if (!isCurrentAccount) {
      await UChatNewDialog.showAccountSettingUnavailableDialog(context, user);
      return;
    }

    // Don't put this inside the try-catch block, otherwise it will end up executing the code in the finally block
    if (isDeleteAccountButtonDisable) return;

    try {
      GetIt.I<TaxonomyService>().sendEvent(
        EventName.accountDeactivationInitiated,
      );
      if (UserController.instance.currentUser()?.isCalling == true) {
        ActionUnavailableDialog.show();
        return;
      }

      isDeleteAccountButtonDisable = true;
      AppToast.showProcessingToast(Get.context!);

      /// Check if it required password or not
      dynamic result;
      final response = await GetIt.I<CheckPasswordRequiredUseCase>().call(NoParams()).timeout(const Duration(
            seconds: 30,
          ));

      isDeleteAccountButtonDisable = false;
      AppToast.hideToast(Get.context!);

      if (response.passwordRequired) {
        /// Go to password screen
        result = await _goToSettingAccountDeleteAccountWithPassword();
      } else {
        /// Go to OTP screen
        result = await Get.toNamed(
          Routes.settingAccountOtpRequest,
          arguments: SettingAccountOtpVerifyArguments(
            actionType: AuthenticationActionType.deleteAccount,
            phoneNumber: phoneNumber,
            method: SelectedOtpType.phone,
          ),
        );
      }

      if (result is SettingAccountOtpVerifyResultArguments) {
        showLeaveGroupAsAnOwnerDialog(result.actionToken);
      }
    } on FailedHostLookupException catch (e, stackTrace) {
      _log.e('onDeleteAccountAuthentication failed, no internet.', e, stackTrace);
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } on TimeoutException {
      _log.e('onDeleteAccountAuthentication failed, timeout.');
      UChatNewDialog.showConnectionErrorDialog(context: Get.context!);
    } on DioException catch (e, stackTrace) {
      _log.e('onDeleteAccountAuthentication failed, connection error.', e, stackTrace);
      if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.connectionError) {
        UChatNewDialog.showConnectionErrorDialog(context: Get.context!);
      }
    } catch (e, stackTrace) {
      _log.e('onDeleteAccountAuthentication error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
    } finally {
      if (isDeleteAccountButtonDisable) {
        isDeleteAccountButtonDisable = false;
        AppToast.hideToast(Get.context!);
      }
    }
  }

  Future<SettingAccountOtpVerifyResultArguments?> _goToSettingAccountDeleteAccountWithPassword() async {
    final validatePasswordResult = await Get.toNamed(
      Routes.settingAccountValidatePassword,
      arguments: SettingAccountValidatePasswordArguments(
        actionType: AuthenticationActionType.deleteAccount,
      ),
    );

    dynamic result;
    if (validatePasswordResult is VerifyPasswordSettingAccountEnable2faEntity) {
      /// Enable 2FA
      result = await Get.toNamed(
        Routes.twoFaOtpReceiptMethod,
        arguments: TwoFaOtpReceiptMethodArguments(
          actionType: AuthenticationActionType.deleteAccount,
          method: SelectedOtpType.phone,
        ),
      );
    } else if (validatePasswordResult is VerifyPasswordSettingAccountUnable2faEntity) {
      /// Unable 2FA
      result = SettingAccountOtpVerifyResultArguments(
        actionToken: validatePasswordResult.actionToken,
        phoneOrEmail: phoneNumber,
        accountId: UserController.instance.currentUser()?.id ?? '',
      );
    }

    return result;
  }

  Future<void> showLeaveGroupAsAnOwnerDialog(String actionToken) async {
    final response = await GetIt.I<ChatRoomServerRepository>().checkIsOwner();

    if (response) {
      /// Is me as an owner
      UChatNewDialog.showDialog(
        context: Get.context!,
        title: 'Leave group as owner'.tr,
        description:
            'If you leave this group, ownership will be transferred to the first member who joined after you.\nAre you sure you want to leave?'
                .tr,
        cancelText: 'Cancel'.tr,
        confirmText: 'Leave'.tr,
        onConfirm: () {
          showDialogDeleteAccount(actionToken: actionToken);
        },
        confirmTextColor: Get.context!.theme.appColors.textError,
        cancelTextColor: Get.context!.theme.appColors.textLight,
        isDestructive: true,
      );
    } else {
      showDialogDeleteAccount(actionToken: actionToken);
    }
  }

  void showDialogDeleteAccount({required String actionToken}) async {
    try {
      UChatNewDialog.showDialog(
        context: Get.context!,
        title: 'Delete account'.tr,
        confirmText: 'Delete'.tr,
        cancelText: 'Cancel'.tr,
        description: 'Do you want to permanently delete this account?'.tr,
        confirmTextColor: Get.context!.theme.appColors.textError,
        cancelTextColor: Get.context!.theme.appColors.textLight,
        isDestructive: true,
        onConfirm: () {
          onConfirmDeleteAccount(actionToken);
        },
      );
    } catch (e, stackTrace) {
      _log.e('showDialogDeleteAccount error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: ExceptionHandler.handle(e));
    }
  }

  void onConfirmDeleteAccount(String actionToken) async {
    try {
      await UChatNewDialog.showDialog(
        context: Get.context!,
        title: 'Confirm delete account'.tr,
        cancelText: 'Cancel'.tr,
        confirmText: 'Confirm'.tr,
        description:
            'Once you delete this account, you will not be able to recover any data. Please make sure that you want to delete this account.'
                .tr,
        confirmTextColor: Get.context!.theme.appColors.textError,
        cancelTextColor: Get.context!.theme.appColors.textLight,
        isDestructive: true,
        onConfirm: () async {
          GetIt.I<TaxonomyService>().sendEvent(
            EventName.accountDeleted,
          );

          /// Set [isLoggingOut] to true for prevent session expired dialog showing
          UserController.instance.isLoggingOut.value = true;
          await UChatCallController.instance.removeExistingCall();

          final currentUser = UserCollection.fromEntity(UserController.instance.currentUser()!);
          await GetIt.I<DeleteAccountUseCase>().call(DeleteAccountRequest(
            actionToken: actionToken,
            isarId: currentUser.isarId,
          ));

          // Use cleanupAfterDeleteAccount instead of going to logout screen
          // This properly clears currentUser, currentToken, and config
          final currentUserEntity = UserController.instance.currentUser();
          if (currentUserEntity != null) {
            await GetIt.I<AccountsCenterService>().cleanupAfterDeleteAccount(user: currentUserEntity);
          }
        },
      );
    } catch (e, stackTrace) {
      _log.e('onConfirmDeleteAccount error.', e, stackTrace);
      UserController.instance.isLoggingOut.value = false;
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: ExceptionHandler.handle(e));
    }
  }

  void handleToggleTwoFa(bool value, BuildContext context) async {
    if (!isCurrentAccount) {
      await UChatNewDialog.showAccountSettingUnavailableDialog(context, user);
      return;
    }

    if (isUpdateTwoFactorButtonDisable) return;

    GetIt.I<TaxonomyService>().sendEvent(
      EventName.twoFactorEnable,
      eventProperties: EventProperty.twoFactorEnable(value ? 'enabled' : 'disabled'),
    );
    final entity = await _multifactorValidate(value);

    isUpdateTwoFactorButtonDisable = false;
    AppToast.hideToast(Get.context!);

    if (entity is MultifactorValidateTurnOffEntity) {
      _turnOffMultiFactor(entity);
    } else if (entity is MultifactorValidateTurnOnEntity) {
      _turnOnMultiFactor(entity);
    }
  }

  Future<MultifactorValidateEntity?> _multifactorValidate(bool enableMultiFactor) async {
    try {
      isUpdateTwoFactorButtonDisable = true;
      AppToast.showProcessingToast(Get.context!);

      return await GetIt.I<MultifactorValidateUseCase>()
          .call(MultifactorValidateSettingRequest(
            enableMultiFactor: enableMultiFactor,
          ))
          .timeout(const Duration(seconds: 30));
    } on FailedHostLookupException catch (e, stackTrace) {
      _log.e('multifactorValidate failed, no internet.', e, stackTrace);
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      isUpdateTwoFactorButtonDisable = false;
      AppToast.hideToast(Get.context!);

      if (e is ApiException) {
        if (e.type == 'ERR_ACCOUNT_EMAIL_PASSWORD_REQUIRE') {
          UChatNewDialog.showSingleButtonDialog(
            context: Get.context!,
            barrierDismissible: true,
            title: 'Please set your\npassword and email'.tr,
            description: 'If you want to enable 2FA, you need to set up a password and email address.'.tr,
            confirmText: 'Got it'.tr,
            confirmTextColor: Get.context!.theme.appColors.textPrimary,
          );
        }
      } else if (e is TimeoutException) {
        _log.e('multifactorValidate failed, timeout.', e, stackTrace);
        UChatNewDialog.showConnectionErrorDialog(context: Get.context!);
      } else if (e is DioException) {
        _log.e('multifactorValidate failed, connection error.', e, stackTrace);
        if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.connectionError) {
          UChatNewDialog.showConnectionErrorDialog(context: Get.context!);
        }
      } else {
        _log.e('multifactorValidate error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    }

    return null;
  }

  Future<void> _turnOnMultiFactor(MultifactorValidateTurnOnEntity entity) async {
    try {
      await GetIt.I<MultifactorUpdateUseCase>().call(
        MultifactorUpdateSettingRequest(
          actionToken: entity.actionToken,
          enableMultiFactor: true,
        ),
      );
      allowMultiFactor = true;
      update([AccountSettingIds.twoFactorAuthBox]);
    } on FailedHostLookupException catch (e, stackTrace) {
      _log.e('turnOnTwoFa failed, no internet.', e, stackTrace);
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('turnOnTwoFa error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: ExceptionHandler.handle(e));
    }
  }

  Future<void> _turnOffMultiFactor(MultifactorValidateTurnOffEntity entity) async {
    try {
      final result = await Get.toNamed(
        Routes.settingAccountOtpRequest,
        arguments: SettingAccountOtpVerifyArguments(
          actionType: AuthenticationActionType.setting,
          phoneNumber: UserController.instance.currentUser.value?.phoneNumber,
          method: SelectedOtpType.phone,
        ),
      );

      if (result is SettingAccountOtpVerifyResultArguments) {
        await GetIt.I<MultifactorUpdateUseCase>().call(
          MultifactorUpdateSettingRequest(
            actionToken: result.actionToken,
            enableMultiFactor: false,
          ),
        );
        allowMultiFactor = false;
        update([AccountSettingIds.twoFactorAuthBox]);
      }
    } on FailedHostLookupException catch (e, stackTrace) {
      _log.e('turnOffTwoFa failed, no internet.', e, stackTrace);
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('turnOffTwoFa error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: ExceptionHandler.handle(e));
    }
  }

  void handleLogout() async {
    final userId = user.id;
    if (userId == null) return;

    if (UserController.instance.isCurrentUser(userId)) {
      try {
        await GetIt.I<AccountsCenterService>().logoutCurrentUser();
      } catch (e) {
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
      }
    } else {
      try {
        final result = await GetIt.I<AccountsCenterService>().logoutOtherUser(user);
        if (result == true) {
          eventBus.fire(AccountRemovedEvent(accountIds: [userId]));
          Get.back();
        }
      } catch (e, stackTrace) {
        useLogger().e('Logout other user error', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
      }
    }
  }

  void handleSwitchAccount() {
    GetIt.I<AccountsCenterService>().switchAccount(user);
  }

  void handleToggleShortcutPasscode(bool value) async {
    if (!isPinLockEnable) return;
    if (value) {
      // If toggle on, go to setup shortcut passcode screen
      final result = await Get.toNamed(
        Routes.passcode,
        arguments: PasscodeArguments(
          mode: PasscodeMode.setupShortcut,
          controllerTag: const Uuid().v4(),
          user: user,
        ),
      );
      // If setup not completed, Stop the function to not update the toggle state.
      if (result != true) return;
    } else {
      // If toggle off, Remove shortcut passcode data
      try {
        final userId = user.id;
        if (userId != null) {
          await GetIt.I<SecurityService>().setShortcutPasscode(userId: userId, passcode: null);
        }
      } catch (e, stackTrace) {
        useLogger().e('Remove shortcut passcode error', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
        return;
      }
    }
    enableShortcutPasscode = value;

    // Fire event to update user data in account center screen.
    final userId = user.id;
    if (userId != null) {
      final newUser = await GetIt.I<GetUserByIdUseCase>().call(GetUserByIdParams(userId: userId));
      if (newUser != null) {
        eventBus.fire(AccountUpdatedEvent(newUser));
      }
    }

    update([
      AccountSettingIds.shortcutPasscodeBox,
      AccountSettingIds.hideAccountBox,
    ]);
  }

  void handleChangeShortcutPasscode() {
    Get.toNamed(
      Routes.passcode,
      arguments: PasscodeArguments(
        mode: PasscodeMode.changeShortcut,
        controllerTag: const Uuid().v4(),
        user: user,
      ),
    );
  }

  void handleGoToPinLockSetting() async {
    await Get.toNamed(Routes.passcodeToggle);
    isPinLockEnable = GetIt.I<SecurityService>().hasPasscode;
    update([AccountSettingIds.shortcutPasscodeBox]);
  }

  void handleToggleHideAccount(bool value) async {
    if (!isPinLockEnable) return;

    final userId = user.id;

    if (userId == null) return;

    try {
      await GetIt.I<ToggleHiddenAccountUseCase>().call(
        ToggleHiddenAccountParams(
          accountId: userId,
          isHidden: value,
        ),
      );
      enableHideAccount = value;
      update([AccountSettingIds.hideAccountBox]);
    } catch (e, stackTrace) {
      useLogger().e('Toggle hide account error', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
    }
  }
}
