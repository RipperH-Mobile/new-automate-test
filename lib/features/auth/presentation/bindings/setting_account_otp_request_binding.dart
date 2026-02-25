import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/auth/domain/factories/get_otp_usecase_factory.dart';
import 'package:uchat/features/auth/domain/use_cases/get_otp_saved_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/save_otp_use_case.dart';
import 'package:uchat/features/auth/presentation/controllers/setting_acoount_otp/setting_account_otp_request_controller.dart';

class SettingAccountOtpRequestBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingAccountOtpController>(
      SettingAccountOtpController(
        args: Get.arguments,
        getOtpUseCase: GetOtpUseCaseFactory.create(Get.arguments.actionType),
        saveOtpUseCase: GetIt.I<SaveOtpUseCase>(),
        getOtpSavedUseCase: GetIt.I<GetOtpSavedUseCase>(),
      ),
    );
  }
}
