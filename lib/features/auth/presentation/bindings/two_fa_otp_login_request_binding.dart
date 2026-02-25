import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/auth/domain/use_cases/get_otp_two_fa_login_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/get_otp_saved_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/save_otp_use_case.dart';
import 'package:uchat/features/auth/presentation/controllers/2fa/two_fa_otp_login_request_controller.dart';

class TwoFaOtpLoginRequestBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<TwoFaOtpLoginRequestController>(
      TwoFaOtpLoginRequestController(
        args: Get.arguments,
        getOtpSavedUseCase: GetIt.I<GetOtpSavedUseCase>(),
        getOtpUseCase: GetIt.I<GetOtpTwoFaLoginUseCase>(),
        saveOtpUseCase: GetIt.I<SaveOtpUseCase>(),
      ),
    );
  }
}
