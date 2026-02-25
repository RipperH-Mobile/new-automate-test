import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/auth/domain/use_cases/clear_otp_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/get_otp_two_fa_login_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/save_otp_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/verify_otp_login_use_case.dart';
import 'package:uchat/features/auth/presentation/controllers/2fa/two_fa_otp_login_verify_controller.dart';

class TwoFaOtpLoginVerifyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<TwoFaOtpLoginVerifyController>(
      TwoFaOtpLoginVerifyController(
        args: Get.arguments,
        getOtpTwoFaLoginUseCase: GetIt.I<GetOtpTwoFaLoginUseCase>(),
        saveOtpUseCase: GetIt.I<SaveOtpUseCase>(),
        verifyOtpLoginUseCase: GetIt.I<VerifyOtpLoginUseCase>(),
        clearOtpUseCase: GetIt.I<ClearOtpUseCase>(),
      ),
    );
  }
}
