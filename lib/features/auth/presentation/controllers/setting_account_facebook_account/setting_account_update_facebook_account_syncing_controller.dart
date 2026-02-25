import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/exceptions/null_response_exception.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/auth/data/models/requests/sign_in_with_facebook_param.dart';
import 'package:uchat/features/auth/data/models/requests/update_linking_account_with_social_request.dart';
import 'package:uchat/features/auth/domain/entities/social_link_entity.dart';
import 'package:uchat/features/auth/domain/entities/verify_password_setting_account_entity.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/features/auth/domain/use_cases/check_password_required_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/sign_in_with_facebook_provider_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_otp_verify_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_otp_verify_result_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_validate_password_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/two_fa_otp_receipt_method_arguments.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class SettingAccountUpdateFacebookAccountSyncingController extends GetxController {
  final CheckPasswordRequiredUseCase checkPasswordRequiredUseCase;

  SettingAccountUpdateFacebookAccountSyncingController({
    required this.checkPasswordRequiredUseCase,
  });

  final isSyncedWithFacebookAccount = false.obs;
  final facebookAccount = ''.obs;

  StreamSubscription? _userUpdateSubscription;

  @override
  void onInit() {
    super.onInit();
    isSyncedWithFacebookAccount.value = UserController.instance.facebookAccountLinked;
    facebookAccount.value =
        UserController.instance.currentUser.value?.linkAccounts?.facebook?.email ?? 'Unregistered'.tr;

    _userUpdateSubscription = eventBus.on<UserUpdateEvent>().listen((event) {
      if (event.user.linkAccounts?.facebook?.email != facebookAccount.value) {
        isSyncedWithFacebookAccount.value = UserController.instance.facebookAccountLinked;
        facebookAccount.value = event.user.linkAccounts?.facebook?.email ?? 'Unregistered'.tr;
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
      final socialActionType = isUnlink ? SocialActionType.unSyncFacebookAccount : SocialActionType.syncFacebookAccount;

      final response = await checkPasswordRequiredUseCase.call(NoParams());
      if (response.passwordRequired) {
        await _goToSettingAccountFacebookAccountLinkWithPassword(socialActionType);
      } else {
        await _goToSettingAccountFacebookAccountLinkWithOtp(socialActionType);
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

  Future<void> _goToSettingAccountFacebookAccountLinkWithPassword(SocialActionType socialActionType) async {
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

        onUpdateFacebookAccount(socialActionType, verifyOtpResult.actionToken);
      } else if (validatePasswordResult is VerifyPasswordSettingAccountUnable2faEntity) {
        onUpdateFacebookAccount(socialActionType, validatePasswordResult.actionToken);
      }
    } catch (e, stackTrace) {
      _log.w('_goToSettingAccountFacebookAccountLinkWithPassword error.', e, stackTrace);
      rethrow;
    }
  }

  Future<void> _goToSettingAccountFacebookAccountLinkWithOtp(SocialActionType socialActionType) async {
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
        onUpdateFacebookAccount(socialActionType, result.actionToken);
      }
    } catch (e, stackTrace) {
      _log.w('_goToSettingAccountFacebookAccountLinkWithOtp error.', e, stackTrace);
      rethrow;
    }
  }

  void onUpdateFacebookAccount(SocialActionType socialActionType, String actionToken) async {
    try {
      bool isSync = socialActionType == SocialActionType.syncFacebookAccount;
      bool isSuccess = false;
      String toastText = 'You\'ve synced new Facebook account'.tr;

      if (isSync) {
        // To link with Facebook account
        final res = await handleLinkWithFacebookAccount(actionToken);
        AppToast.hideToast(Get.context!);

        isSuccess = res?.isSuccess == true;
        isSyncedWithFacebookAccount.value = isSuccess;
        facebookAccount.value = res?.facebookAccount ?? 'Unregistered'.tr;
      } else {
        // To unlink with Facebook account
        final res = await handleUnlinkWithFacebookAccount(actionToken);

        isSuccess = res?.isSuccess == true;
        toastText = 'You\'ve unlink Facebook account'.tr;
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
    } on NullResponseException catch (e) {
      _log.w('onUpdateFacebookAccount error.', e);
      if (e.message == 'permanently-denied') {
        UChatNewDialog.showDialog(
          context: Get.context!,
          title: 'Please allow tracking to sync Facebook with your account'.tr,
          description: 'You need to allow tracking to enable cross-app usage'.tr,
          confirmText: 'Go to setting'.tr,
          confirmTextColor: Get.context!.theme.appColors.textPrimary,
          cancelText: 'Cancel'.tr,
          cancelTextColor: Get.context!.theme.appColors.textLight,
          onConfirm: () {
            Get.back();
            openAppSettings();
          },
        );
      } else if (e.message != 'User-has-cancelled-login-with-facebook') {
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    } on ApiException catch (e) {
      _log.e('onUpdateFacebookAccount error.', e);
      if (e.type == 'ERR_ACCOUNT_FACEBOOK_ALREADY_EXIST') {
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
      _log.e('onUpdateFacebookAccount error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
    }
  }

  Future<SocialLinkEntity?> handleLinkWithFacebookAccount(String actionToken) async {
    final providerResponse = await GetIt.I<SignInWithFacebookProviderUseCase>().call(SignInWithFacebookParam(
      isShowToast: true,
    ));
    final facebookToken = providerResponse.token ?? '';

    if (facebookToken.isEmpty) return null;

    return await GetIt.I<AuthServerRepository>().settingAccountLinkAccountWithFacebook(
      UpdateLinkingAccountWithSocialRequest(
        token: facebookToken,
        actionToken: actionToken,
      ),
    );
  }

  Future<SocialLinkEntity?> handleUnlinkWithFacebookAccount(String actionToken) async {
    return await GetIt.I<AuthServerRepository>().settingAccountUnlinkAccountWithFacebook(actionToken);
  }
}
