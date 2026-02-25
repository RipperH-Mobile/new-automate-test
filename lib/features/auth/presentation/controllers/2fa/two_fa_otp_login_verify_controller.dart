import 'package:get/get.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/features/auth/data/models/requests/get_otp_two_fa_login_request.dart';
import 'package:uchat/features/auth/data/models/requests/save_otp_response_request.dart';
import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/domain/use_cases/clear_otp_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/get_otp_two_fa_login_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/save_otp_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/verify_otp_login_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/verify_otp_two_fa_arguments.dart';
import 'package:uchat/features/auth/presentation/controllers/base_controller/verify_otp_base_controller.dart';
import 'package:uchat/widgets.dart';

class TwoFaOtpLoginVerifyController extends VerifyOtpBaseController {
  TwoFaOtpLoginVerifyController({
    required this.args,
    required this.getOtpTwoFaLoginUseCase,
    required this.saveOtpUseCase,
    required this.verifyOtpLoginUseCase,
    required this.clearOtpUseCase,
  });

  final VerifyOtpTwoFaArguments args;
  final GetOtpTwoFaLoginUseCase getOtpTwoFaLoginUseCase;
  final SaveOtpUseCase saveOtpUseCase;
  final VerifyOtpLoginUseCase verifyOtpLoginUseCase;
  final ClearOtpUseCase clearOtpUseCase;

  @override
  int? get initialCountDown => args.countDown;

  @override
  OtpEntity get initialOtpEntity => args.otpEntity;

  String get phoneOrEmail => args.phoneOrEmail;

  @override
  void handleOtpRequest() async {
    if (phoneOrEmail.isEmpty) {
      return;
    }
    // clear previous OTP data, errors, and input
    clearOTP();

    final request = GetOtpTwoFaLoginRequest(
      phoneOrEmail: phoneOrEmail,
      isEmail: args.emailMask != null,
      isPhoneNumber: args.phoneNumberMask != null,
    );
    UChatLoading.show();
    try {
      final res = await getOtpTwoFaLoginUseCase.call(request);
      await UChatLoading.hide();

      isResendButtonEnable(false);
      token(res.token);
      ref(res.ref);
      handleDisableOTPBtn(
        timeout: diffInSecondHelper(
          res.timeout.toString(),
        ),
      );

      saveOtpUseCase.call(
        SaveOtpResponseRequest(
          phoneOrEmail: phoneOrEmail,
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
    if (phoneOrEmail.isEmpty) {
      return;
    }
    await UChatLoading.show(status: 'Please wait...'.tr);
    final req = AuthSignInRequest(
      token: token(),
      otp: otp(),
      phoneOrEmail: phoneOrEmail,
      isPhoneNumber: args.phoneNumberMask != null,
    );
    try {
      final res = await verifyOtpLoginUseCase.call(req);
      await clearOtpUseCase.call('${args.phoneOrEmail}_${args.phoneNumberMask}');
      await clearOtpUseCase.call('${args.phoneOrEmail}_${args.emailMask}');
      await UChatLoading.hide();
      errorMessages.value = null;
      clearOTP();
      Get.back(
        result: res,
      );
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      handleErrorVerifyOtpCode(e, stackTrace);
    }
  }
}
