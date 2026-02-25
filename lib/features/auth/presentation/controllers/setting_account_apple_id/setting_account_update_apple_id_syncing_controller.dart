import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
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

class SettingAccountUpdateAppleIdSyncingController extends GetxController {
  final CheckPasswordRequiredUseCase checkPasswordRequiredUseCase;

  SettingAccountUpdateAppleIdSyncingController({
    required this.checkPasswordRequiredUseCase,
  });

  final isSyncedWithAppleId = false.obs;
  final appleId = ''.obs;

  StreamSubscription? _userUpdateSubscription;

  @override
  void onInit() {
    super.onInit();
    isSyncedWithAppleId.value = UserController.instance.appleIdLinked;
    appleId.value = UserController.instance.currentUser.value?.linkAccounts?.apple?.email ?? 'Unregistered'.tr;

    _userUpdateSubscription = eventBus.on<UserUpdateEvent>().listen((event) {
      if (event.user.linkAccounts?.apple?.email != appleId.value) {
        isSyncedWithAppleId.value = UserController.instance.appleIdLinked;
        appleId.value = event.user.linkAccounts?.apple?.email ?? 'Unregistered'.tr;
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
      final socialActionType = isUnlink ? SocialActionType.unSyncAppleId : SocialActionType.syncAppleId;

      final response = await checkPasswordRequiredUseCase.call(NoParams());
      if (response.passwordRequired) {
        await _goToSettingAccountAppleIdLinkWithPassword(socialActionType);
      } else {
        await _goToSettingAccountAppleIdLinkWithOtp(socialActionType);
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

  Future<void> _goToSettingAccountAppleIdLinkWithPassword(SocialActionType socialActionType) async {
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

        onUpdateAppleId(socialActionType, verifyOtpResult.actionToken);
      } else if (validatePasswordResult is VerifyPasswordSettingAccountUnable2faEntity) {
        onUpdateAppleId(socialActionType, validatePasswordResult.actionToken);
      }
    } catch (e, stackTrace) {
      _log.w('_goToSettingAccountAppleIdLinkWithPassword error.', e, stackTrace);
      rethrow;
    }
  }

  Future<void> _goToSettingAccountAppleIdLinkWithOtp(SocialActionType socialActionType) async {
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
        onUpdateAppleId(socialActionType, result.actionToken);
      }
    } catch (e, stackTrace) {
      _log.w('_goToSettingAccountAppleIdLinkWithOtp error.', e, stackTrace);
      rethrow;
    }
  }

  void onUpdateAppleId(SocialActionType socialActionType, String actionToken) async {
    try {
      bool isSync = socialActionType == SocialActionType.syncAppleId;
      bool isSuccess = false;
      String toastText = 'You\'ve synced new Apple ID'.tr;

      if (isSync) {
        // To link with Apple ID
        final res = await linkWithAppleId(actionToken);
        AppToast.hideToast(Get.context!);

        isSuccess = res?.isSuccess == true;
        isSyncedWithAppleId.value = isSuccess;
        appleId.value = res?.appleId ?? 'Unregistered'.tr;
      } else {
        // To unlink with Apple ID
        final res = await unlinkWithAppleId(actionToken);

        isSuccess = res.isSuccess == true;
        toastText = 'You\'ve unlink Apple ID'.tr;
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
      _log.e('onUpdateAppleId error.', e);
      if (e.type == 'ERR_ACCOUNT_APPLE_ID_ALREADY_EXIST') {
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
      _log.e('onUpdateAppleId error.', e, stackTrace);
      if (e is SignInWithAppleAuthorizationException && e.code.name == 'canceled') {
        return;
      }

      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
    }
  }

  Future<SocialLinkEntity?> linkWithAppleId(String actionToken) async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [AppleIDAuthorizationScopes.email],
    );

    String? identityToken = credential.identityToken;

    if (identityToken == null) return null;

    AppToast.showSyncToast(Get.context!);

    return await GetIt.I<AuthServerRepository>().settingAccountLinkAccountWithApple(
      UpdateLinkingAccountWithSocialRequest(
        token: identityToken,
        actionToken: actionToken,
      ),
    );
  }

  Future<SocialLinkEntity> unlinkWithAppleId(String actionToken) async {
    return await GetIt.I<AuthServerRepository>().settingAccountUnlinkAccountWithApple(actionToken);
  }
}
