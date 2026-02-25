import 'package:get/get.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_create_new_password_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_otp_verify_arguments.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';

class SettingAccountPromptSetPasswordController extends GetxController {
  Future<void> onContinue() async {
    final user = UserController.instance.currentUser.value;
    final phoneNumber = user?.phoneNumber ?? '';
    final email = user?.email ?? '';
    final method = phoneNumber.isNotEmpty ? SelectedOtpType.phone : SelectedOtpType.email;

    final verifyOtpResult = await Get.toNamed(
      Routes.settingAccountOtpRequest,
      arguments: SettingAccountOtpVerifyArguments(
        actionType: AuthenticationActionType.settingPassword,
        phoneNumber: method == SelectedOtpType.phone ? phoneNumber : null,
        email: method == SelectedOtpType.email ? email : null,
        method: method,
      ),
    );

    if (verifyOtpResult == null) return;

    final updateNewPasswordResult = await Get.toNamed(
      Routes.settingAccountCreateNewPassword,
      arguments: SettingAccountCreateNewPasswordArguments(
        actionType: AuthenticationActionType.settingPassword,
        actionToken: verifyOtpResult.actionToken,
        accountId: verifyOtpResult?.accountId ?? '',
        phoneOrEmail: verifyOtpResult?.phoneOrEmail ?? '',
      ),
    );

    if (updateNewPasswordResult == null) return;

    Get.back(result: true);
  }

  void onBack() {
    Get.back();
  }
}
