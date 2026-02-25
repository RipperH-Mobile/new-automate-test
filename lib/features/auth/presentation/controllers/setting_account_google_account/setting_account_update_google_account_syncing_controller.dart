import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/auth/data/models/requests/update_linking_account_with_social_request.dart';
import 'package:uchat/features/auth/domain/entities/social_link_entity.dart';
import 'package:uchat/features/auth/domain/entities/verify_password_setting_account_entity.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/features/auth/domain/use_cases/check_password_required_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_otp_verify_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_otp_verify_result_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_validate_password_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/two_fa_otp_receipt_method_arguments.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class SettingAccountUpdateGoogleAccountSyncingController extends GetxController {
  final CheckPasswordRequiredUseCase checkPasswordRequiredUseCase;

  SettingAccountUpdateGoogleAccountSyncingController({
    required this.checkPasswordRequiredUseCase,
  });

  final isSyncedWithGoogleAccount = false.obs;
  final googleAccount = ''.obs;

  GoogleSignIn? googleSignIn;
  StreamSubscription? _userUpdateSubscription;

  @override
  void onInit() {
    super.onInit();

    googleSignIn = GoogleSignIn(scopes: ['email']);
    isSyncedWithGoogleAccount.value = UserController.instance.googleAccountLinked;
    googleAccount.value = UserController.instance.currentUser.value?.linkAccounts?.google?.email ?? 'Unregistered'.tr;

    _userUpdateSubscription = eventBus.on<UserUpdateEvent>().listen((event) {
      if (event.user.linkAccounts?.google?.email != googleAccount.value) {
        isSyncedWithGoogleAccount.value = UserController.instance.googleAccountLinked;
        googleAccount.value = event.user.linkAccounts?.google?.email ?? 'Unregistered'.tr;
      }
    });
  }

  @override
  void onClose() async {
    await _userUpdateSubscription?.cancel();

    super.onClose();
  }

  void onContinue({bool isUnlink = false}) async {
    try {
      final socialActionType = isUnlink ? SocialActionType.unSyncGoogleAccount : SocialActionType.syncGoogleAccount;

      final response = await checkPasswordRequiredUseCase.call(NoParams());
      if (response.passwordRequired) {
        await _goToSettingAccountGoogleAccountLinkWithPassword(socialActionType);
      } else {
        await _goToSettingAccountGoogleAccountLinkWithOtp(socialActionType);
      }
    } on FailedHostLookupException catch (e, stackTrace) {
      _log.e('checkPasswordRequired failed, no internet.', e, stackTrace);
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('checkPasswordRequired error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
    }
  }

  Future<void> _goToSettingAccountGoogleAccountLinkWithPassword(SocialActionType socialActionType) async {
    try {
      final validatePasswordResult = await Get.toNamed(
        Routes.settingAccountValidatePassword,
        arguments: SettingAccountValidatePasswordArguments(
          actionType: AuthenticationActionType.setting,
          socialActionType: socialActionType,
        ),
      );

      if (validatePasswordResult is VerifyPasswordSettingAccountEnable2faEntity) {
        final verifyOtpResult = await Get.toNamed(
          Routes.twoFaOtpReceiptMethod,
          arguments: TwoFaOtpReceiptMethodArguments(
            actionType: AuthenticationActionType.setting,
            method: SelectedOtpType.phone,
            socialActionType: socialActionType,
          ),
        );

        if (verifyOtpResult == null) return;

        onUpdateGoogleAccount(socialActionType, verifyOtpResult.actionToken);
      } else if (validatePasswordResult is VerifyPasswordSettingAccountUnable2faEntity) {
        onUpdateGoogleAccount(socialActionType, validatePasswordResult.actionToken);
      }
    } catch (e, stackTrace) {
      _log.w('_goToSettingAccountGoogleAccountLinkWithPassword error.', e, stackTrace);
      rethrow;
    }
  }

  Future<void> _goToSettingAccountGoogleAccountLinkWithOtp(SocialActionType socialActionType) async {
    try {
      final result = await Get.toNamed(
        Routes.settingAccountOtpRequest,
        arguments: SettingAccountOtpVerifyArguments(
          actionType: AuthenticationActionType.setting,
          phoneNumber: UserController.instance.currentUser.value?.phoneNumber,
          method: SelectedOtpType.phone,
          socialActionType: socialActionType,
        ),
      );

      if (result is SettingAccountOtpVerifyResultArguments) {
        onUpdateGoogleAccount(socialActionType, result.actionToken);
      }
    } catch (e, stackTrace) {
      _log.w('_goToSettingAccountGoogleAccountLinkWithOtp error.', e, stackTrace);
      rethrow;
    }
  }

  void onUpdateGoogleAccount(SocialActionType socialActionType, String actionToken) async {
    bool isSync = socialActionType == SocialActionType.syncGoogleAccount;

    try {
      bool isSuccess = false;
      String toastText = 'You\'ve synced new Google account'.tr;

      if (isSync) {
        // To link with Google account
        final res = await handleLinkWithGoogleAccount(actionToken);
        AppToast.hideToast(Get.context!);

        if (res?.isAccountUpdated == true) {
          isSuccess = res?.isSuccess == true;
          isSyncedWithGoogleAccount.value = isSuccess;
          googleAccount.value = res?.googleAccount ?? 'Unregistered'.tr;
        }
      } else {
        // To unlink with Google account
        final res = await handleUnlinkWithGoogleAccount(actionToken);

        isSuccess = res?.isSuccess == true;
        toastText = 'You\'ve unlink Google account'.tr;
        Get.back();
      }

      if (!isSuccess) return;

      AppToast.showToast(
        context: Get.context!,
        message: toastText,
        icon: Icon(
          Icons.check_circle_rounded,
          size: AppSize.size6,
          color: Get.context?.theme.appColors.iconInverse,
          blendMode: BlendMode.srcIn,
        ),
      );
    } on ApiException catch (e) {
      _log.e('onUpdateGoogleAccount error.', e);
      if (e.type == 'ERR_ACCOUNT_GMAIL_ALREADY_EXIST') {
        UChatNewDialog.showSingleButtonDialog(
          context: Get.context!,
          title: 'This account is already linked'.tr,
          description: 'You cannot connect with this account because it is already linked'.tr,
          confirmText: 'Got it'.tr,
          confirmTextColor: Get.theme.appColors.textPrimary,
        );
      } else {
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    } catch (e, stackTrace) {
      _log.e('onUpdateGoogleAccount error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
    }
  }

  Future<SocialLinkEntity?> handleLinkWithGoogleAccount(String actionToken) async {
    try {
      // Change google account
      if (isSyncedWithGoogleAccount.value) {
        final isChanged = await UChatNewDialog.showDialog(
          context: Get.context!,
          title: 'You need to unsync your current account before sync a new Google account'.tr,
          description: 'Do you want to confirm unsync @email ?'.trParams({
            'email': googleAccount.value,
          }),
          confirmText: 'Unsync'.tr,
          confirmTextColor: Get.context!.theme.appColors.textError,
          cancelText: 'Cancel'.tr,
          cancelTextColor: Get.context!.theme.appColors.textLight,
        );

        if (isChanged) {
          final unlinkResult = await handleUnlinkWithGoogleAccount(actionToken);
          if (unlinkResult?.isSuccess != true) {
            // Abort if unlinking failed to prevent inconsistent state.
            return SocialLinkEntity(isSuccess: false, isAccountUpdated: false);
          }
        } else {
          return SocialLinkEntity(isAccountUpdated: false);
        }
      }

      GoogleSignInAccount? acc = await googleSignIn?.signIn();

      AppToast.showSyncToast(Get.context!);
      final authentication = await acc?.authentication;

      if (acc == null) {
        _log.w('googleSignIn is null (user cancelled).');

        return null;
      }

      return await GetIt.I<AuthServerRepository>().settingAccountLinkAccountWithGoogle(
        UpdateLinkingAccountWithSocialRequest(
          token: authentication?.idToken ?? '',
          actionToken: actionToken,
        ),
      );
    } catch (e) {
      await handleUnlinkWithGoogleAccount(actionToken);
      rethrow;
    }
  }

  Future<SocialLinkEntity?> handleUnlinkWithGoogleAccount(String actionToken) async {
    if (await googleSignIn?.isSignedIn() == true || isSyncedWithGoogleAccount.value) {
      await googleSignIn?.disconnect();

      return await GetIt.I<AuthServerRepository>().settingAccountUnlinkAccountWithGoogle(actionToken);
    }

    return null;
  }
}
