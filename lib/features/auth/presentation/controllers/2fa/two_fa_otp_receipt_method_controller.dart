import 'package:get/get.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_otp_verify_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/two_fa_otp_receipt_method_arguments.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';
import 'package:uchat/utils/extension/extension_string.dart';

class TwoFaOtpReceiptMethodController extends GetxController {
  final TwoFaOtpReceiptMethodArguments args;
  late Map<SelectedOtpType, String> methods;
  SelectedOtpType _methodSelected = SelectedOtpType.email;

  TwoFaOtpReceiptMethodController({
    required this.args,
  });

  @override
  void onInit() {
    final user = UserController.instance.currentUser();
    methods = {
      SelectedOtpType.phone: user?.phoneNumber?.shortPhoneNumber() ?? '',
      SelectedOtpType.email: user?.email?.shortEmail() ?? '',
    };
    super.onInit();
  }

  @override
  void onReady() {
    final user = UserController.instance.currentUser();

    if (user?.phoneNumber?.isEmpty == true || user?.email?.isEmpty == true) {
      Get.back();
      return;
    }

    super.onReady();
  }

  void onMethodChanged(SelectedOtpType method) {
    _methodSelected = method;
  }

  Future<void> onContinue() async {
    final user = UserController.instance.currentUser();

    SettingAccountOtpVerifyArguments verifyArgument;

    if (_methodSelected == SelectedOtpType.email) {
      verifyArgument = SettingAccountOtpVerifyArguments(
        actionType: args.actionType,
        method: _methodSelected,
        email: user?.email,
        socialActionType: args.socialActionType,
        canGodModeByPassOtp: args.canGodModeByPassOtp,
      );
    } else {
      verifyArgument = SettingAccountOtpVerifyArguments(
        actionType: args.actionType,
        method: _methodSelected,
        phoneNumber: user?.phoneNumber,
        socialActionType: args.socialActionType,
        canGodModeByPassOtp: args.canGodModeByPassOtp,
      );
    }

    final result = await Get.toNamed(
      Routes.settingAccountOtpRequest,
      arguments: verifyArgument,
    );

    if (result != null) {
      Get.back(result: result);
    }
  }
}
