import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/auth/domain/factories/get_otp_usecase_factory.dart';
import 'package:uchat/features/auth/domain/factories/verify_otp_usecase_factory.dart';
import 'package:uchat/features/auth/domain/use_cases/clear_otp_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/save_otp_use_case.dart';
import 'package:uchat/features/auth/presentation/controllers/setting_acoount_otp/setting_account_otp_verify_controller.dart';

class SettingAccountOtpVerifyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingAccountOtpVerifyController>(
      SettingAccountOtpVerifyController(
        args: Get.arguments,
        getOtpUseCase: GetOtpUseCaseFactory.create(Get.arguments.actionType),
        saveOtpUseCase: GetIt.I<SaveOtpUseCase>(),
        verifyOtpUseCase: VerifyOtpUseCaseFactory.create(Get.arguments.actionType),
        clearOtpUseCase: GetIt.I<ClearOtpUseCase>(),
      ),
    );
  }
}
