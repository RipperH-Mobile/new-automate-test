import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/auth/data/models/requests/get_otp_forgot_password_request.dart';
import 'package:uchat/features/auth/data/models/requests/save_otp_response_request.dart';
import 'package:uchat/features/auth/data/models/requests/verify_otp_request.dart';
import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/domain/use_cases/clear_otp_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/get_otp_forgot_password_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/save_otp_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/verify_otp_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/forgot_password_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/verify_otp_forgot_password_arguments.dart';
import 'package:uchat/features/auth/presentation/controllers/base_controller/verify_otp_base_controller.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';
import 'package:uchat/widgets.dart';

class VerifyOtpForgotPasswordController extends VerifyOtpBaseController {
  VerifyOtpForgotPasswordController({
    required this.args,
  });

  final VerifyOtpForgotPasswordArguments args;

  @override
  int? get initialCountDown => args.countDown;

  @override
  OtpEntity get initialOtpEntity => args.otpEntity;

  String get phoneNumber => args.phoneNumber ?? '';

  @override
  void handleOtpRequest() async {
    if (phoneNumber.isEmpty) {
      return;
    }
    // clear previous OTP data, errors, and input
    clearOTP();

    final request = GetOtpForgotPasswordRequest(
      phoneOrEmail: phoneNumber,
      isForgotPassword: true,
      isEmail: false,
      isPhoneNumber: true,
    );
    UChatLoading.show();
    try {
      final res = await GetIt.I<GetOtpForgotPasswordUseCase>().call(request);

      await UChatLoading.hide();
      isResendButtonEnable(false);
      token(res.token);
      ref(res.ref);
      handleDisableOTPBtn(
        timeout: diffInSecondHelper(
          res.timeout.toString(),
        ),
      );

      GetIt.I<SaveOtpUseCase>().call(
        SaveOtpResponseRequest(
          phoneOrEmail: phoneNumber,
          otpEntity: res,
        ),
      );
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      handleErrorSendOtpRequest(e, stackTrace);
    }
  }

  @override
  void verifyOtpCode() async {
    if (phoneNumber.isEmpty) {
      return;
    }
    await UChatLoading.show(status: 'Please wait...'.tr);
    final req = VerifyOTPRequest(
      token: token(),
      otp: otp(),
      phoneOrEmail: phoneNumber,
      actionName: AuthenticationActionType.forgotPassword,
    );
    try {
      final res = await GetIt.I<VerifyOtpUseCase>().call(req);
      await GetIt.I<ClearOtpUseCase>().call(phoneNumber);
      await UChatLoading.hide();
      errorMessages.value = null;
      clearOTP();
      Get.offAndToNamed(
        Routes.forgotPasswordSetupNewPassword,
        arguments: ForgotPasswordArguments(
          actionToken: res.actionToken,
          phoneOrEmail: phoneNumber,
        ),
      );
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      handleErrorVerifyOtpCode(e, stackTrace);
    }
  }
}
