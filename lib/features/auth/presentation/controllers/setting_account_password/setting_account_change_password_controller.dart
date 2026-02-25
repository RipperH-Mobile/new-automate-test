import 'package:get/get.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/features/auth/domain/entities/verify_password_setting_account_entity.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_create_new_password_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_otp_verify_result_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_validate_password_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/two_fa_otp_receipt_method_arguments.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';

class SettingAccountChangePasswordController extends GetxController {
  Future<void> onContinue() async {
    final validatePasswordResult = await Get.toNamed(
      Routes.settingAccountValidatePassword,
      arguments: SettingAccountValidatePasswordArguments(
        actionType: AuthenticationActionType.settingPassword,
      ),
    );

    if (validatePasswordResult == null) return;

    if (validatePasswordResult is VerifyPasswordSettingAccountUnable2faEntity) {
      final user = UserController.instance.currentUser();

      await _updateNewPassword(
        verifyOtpResult: SettingAccountOtpVerifyResultArguments(
          actionToken: validatePasswordResult.actionToken,
          phoneOrEmail: user?.phoneNumber ?? user?.email ?? '',
          accountId: user?.id ?? '',
        ),
      );
      return;
    }

    final verifyOtpResult = await Get.toNamed(
      Routes.twoFaOtpReceiptMethod,
      arguments: TwoFaOtpReceiptMethodArguments(
        actionType: AuthenticationActionType.settingPassword,
        method: SelectedOtpType.phone,
      ),
    );

    if (verifyOtpResult == null) return;

    final updateNewPasswordResult = await _updateNewPassword(
      verifyOtpResult: verifyOtpResult,
    );

    if (updateNewPasswordResult == null) return;
  }

  Future<dynamic> _updateNewPassword({SettingAccountOtpVerifyResultArguments? verifyOtpResult}) async {
    return await Get.toNamed(
      Routes.settingAccountCreateNewPassword,
      arguments: SettingAccountCreateNewPasswordArguments(
        actionType: AuthenticationActionType.settingPassword,
        actionToken: verifyOtpResult?.actionToken ?? '',
        accountId: verifyOtpResult?.accountId ?? '',
        phoneOrEmail: verifyOtpResult?.phoneOrEmail ?? '',
      ),
    );
  }
}
