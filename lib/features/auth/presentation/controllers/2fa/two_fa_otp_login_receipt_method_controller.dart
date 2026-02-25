import 'package:get/get.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/features/auth/presentation/arguments/get_otp_two_fa_request_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/two_fa_otp_login_receipt_method_arguments.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';

class TwoFaOtpLoginReceiptMethodController extends GetxController {
  final TwoFaOtpLoginReceiptMethodArguments args;
  late Map<SelectedOtpType, String> methods;
  SelectedOtpType _methodSelected = SelectedOtpType.email;

  TwoFaOtpLoginReceiptMethodController({
    required this.args,
  });

  @override
  void onInit() {
    methods = {
      SelectedOtpType.phone: args.phoneNumberMask,
      SelectedOtpType.email: args.emailMask,
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
    GetOtpTwoFaRequestArguments getOtpTwoFaRequestArguments;

    if (_methodSelected == SelectedOtpType.phone) {
      getOtpTwoFaRequestArguments = GetOtpTwoFaRequestArguments(
        phoneOrEmail: args.phoneOrEmail,
        phoneNumberMask: args.phoneNumberMask,
      );
    } else {
      getOtpTwoFaRequestArguments = GetOtpTwoFaRequestArguments(
        phoneOrEmail: args.phoneOrEmail,
        emailMask: args.emailMask,
      );
    }

    final result = await Get.toNamed(
      Routes.twoFaOtpLoginRequest,
      arguments: getOtpTwoFaRequestArguments,
    );

    if (result != null) {
      Get.back(result: result);
    }
  }
}
