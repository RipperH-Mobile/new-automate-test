import 'package:get/get.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/features/accounts_center/presentation/arguments/account_setting_arguments.dart';
import 'package:uchat/features/auth/data/models/requests/get_otp_method_forgot_password_request.dart';
import 'package:uchat/features/auth/data/models/requests/verify_token_forgot_password_request.dart';
import 'package:uchat/features/auth/domain/use_cases/get_otp_method_forgot_password_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/verify_token_forgot_password_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_create_new_password_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_otp_verify_arguments.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';
import 'package:uchat/utils/get_x_wrapper.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

class SettingAccountForgotPasswordFlowManager {
  final UserEntity? user;
  final GetOtpMethodForgotPasswordUseCase getOtpMethodForgotPasswordUseCase;
  final VerifyTokenForgotPasswordUseCase verifyTokenForgotPasswordUseCase;

  bool get isLoggedIn => user != null;

  SettingAccountForgotPasswordFlowManager({
    required this.getOtpMethodForgotPasswordUseCase,
    required this.verifyTokenForgotPasswordUseCase,
    this.user,
  });

  Future<void> accountSettingFlow() async {
    final is2FaEnabled = user?.accountSettings?.security?.allowMultiFactor ?? false;

    if (is2FaEnabled) {
      await emailFlow(email: user?.email ?? '');
    } else {
      await phoneNumberFlow(phoneNumber: user?.phoneNumber ?? '');
    }
  }

  Future<void> appLinkFlow({
    required String sessionId,
    required String token,
  }) async {
    try {
      UChatLoading.show();
      final verifyTokenResult = await verifyTokenForgotPasswordUseCase.call(
        VerifyTokenForgotPasswordRequest(
          sessionId: sessionId,
          token: token,
        ),
      );
      UChatLoading.hide();

      final updateNewPasswordResult = await GetXWrapper.toNamed(
        Routes.settingAccountCreateNewPassword,
        arguments: SettingAccountCreateNewPasswordArguments(
          actionType: AuthenticationActionType.forgotPassword,
          actionToken: verifyTokenResult.actionToken,
          accountId: verifyTokenResult.accountId,
          phoneOrEmail: verifyTokenResult.phone,
          enableChangePasswordSuccessToast: isLoggedIn,
        ),
      );

      if (updateNewPasswordResult == null) return;

      if (!isLoggedIn) {
        GetXWrapper.offAllNamed(Routes.forgotPasswordSetupSuccess);
        return;
      }

      GetXWrapper.offNamedUntil(
        Routes.accountSetting,
        (r) => r.settings.name == Routes.home,
        arguments: AccountSettingArguments(user: user!),
      );
    } catch (e) {
      UChatLoading.hide();

      if (e is ApiException && e.type == 'ERR_ACCOUNT_ACTION_TOKEN_EXPIRED') {
        UChatNewDialog.showSingleButtonDialog(
          context: GetXWrapper.context!,
          title: 'Link has expired',
          description: 'This reset password link has expired. Please request a new one.',
          confirmText: 'Got it'.tr,
          confirmTextColor: GetXWrapper.theme.appColors.textPrimary,
        );
        return;
      }

      UChatNewDialog.showGeneralErrorDialog(
        context: GetXWrapper.context!,
        e: ExceptionHandler.handle(e),
      );
    }
  }

  Future<void> emailFlow({
    required String email,
  }) async {
    try {
      UChatLoading.show();
      await getOtpMethodForgotPasswordUseCase.call(
        GetOtpMethodForgotPasswordRequest(
          phoneOrEmail: email,
        ),
      );
      UChatLoading.hide();

      await GetXWrapper.toNamed(Routes.settingAccountSentEmailForgotPassword);

      if (!isLoggedIn) return;

      GetXWrapper.offNamedUntil(
        Routes.accountSetting,
        (r) => r.settings.name == Routes.home,
        arguments: AccountSettingArguments(user: user!),
      );
    } catch (e) {
      UChatLoading.hide();

      if (e is ApiException && e.type == 'ERR_ACCOUNT_FORGOT_PASSWORD_COOLDOWN') {
        UChatNewDialog.showSingleButtonDialog(
          context: GetXWrapper.context!,
          title: 'You\'ve requested too many password resets',
          description: 'Please wait a few minutes before trying again.',
          confirmText: 'Got it'.tr,
          confirmTextColor: GetXWrapper.theme.appColors.textPrimary,
        );
        return;
      }

      UChatNewDialog.showGeneralErrorDialog(
        context: GetXWrapper.context!,
        e: ExceptionHandler.handle(e),
      );
    }
  }

  Future<void> phoneNumberFlow({
    required String phoneNumber,
  }) async {
    final verifyOtpResult = await GetXWrapper.toNamed(
      Routes.settingAccountOtpRequest,
      arguments: SettingAccountOtpVerifyArguments(
        actionType: AuthenticationActionType.forgotPassword,
        phoneNumber: phoneNumber,
        email: null,
        method: SelectedOtpType.phone,
      ),
    );

    if (verifyOtpResult == null) return;

    final updateNewPasswordResult = await GetXWrapper.toNamed(
      Routes.settingAccountCreateNewPassword,
      arguments: SettingAccountCreateNewPasswordArguments(
        actionType: AuthenticationActionType.forgotPassword,
        actionToken: verifyOtpResult?.actionToken ?? '',
        accountId: verifyOtpResult?.accountId ?? '',
        phoneOrEmail: verifyOtpResult?.phoneOrEmail ?? '',
        enableChangePasswordSuccessToast: isLoggedIn,
      ),
    );

    if (updateNewPasswordResult == null) return;

    if (!isLoggedIn) {
      GetXWrapper.offAllNamed(Routes.forgotPasswordSetupSuccess);
      return;
    }

    GetXWrapper.offNamedUntil(
      Routes.accountSetting,
      (r) => r.settings.name == Routes.home,
      arguments: AccountSettingArguments(user: user!),
    );
  }
}
