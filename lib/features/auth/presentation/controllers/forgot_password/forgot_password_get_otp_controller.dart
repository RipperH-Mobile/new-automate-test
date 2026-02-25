import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/features/auth/data/models/requests/get_otp_forgot_password_request.dart';
import 'package:uchat/features/auth/data/models/requests/save_otp_response_request.dart';
import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/domain/use_cases/get_otp_forgot_password_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/get_otp_saved_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/save_otp_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/forgot_password_get_otp_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/verify_otp_forgot_password_arguments.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/widgets/dialog/uchat_dialog.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

final _log = useLogger();

class ForgotPasswordGetOtpController extends GetxController {
  final ForgotPasswordGetOtpArguments args;

  ForgotPasswordGetOtpController({
    required this.args,
  });

  void getOtpForgotPassword() async {
    try {
      final request = GetOtpForgotPasswordRequest(
        phoneOrEmail: args.phoneOrEmail,
        isForgotPassword: true,
        isEmail: false,
        isPhoneNumber: true,
      );
      await UChatLoading.show();
      final res = await GetIt.I<GetOtpForgotPasswordUseCase>().call(request);
      await UChatLoading.hide();
      final otpEntity = OtpEntity(
        actionToken: res.actionToken,
        firstGet: res.firstGet,
        ref: res.ref,
        timeout: res.timeout,
        token: res.token,
        type: res.type,
      );
      await GetIt.I<SaveOtpUseCase>().call(
        SaveOtpResponseRequest(
          phoneOrEmail: args.phoneOrEmail,
          otpEntity: otpEntity,
        ),
      );
      Get.toNamed(
        Routes.verifyOtpForgotPassword,
        arguments: VerifyOtpForgotPasswordArguments(
          phoneNumber: args.phoneOrEmail,
          phoneNumberDisplay: args.phoneNumberDisplay,
          otpEntity: otpEntity,
        ),
      );
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      if (e is ErrorAccountOtpCooldown) {
        try {
          final res = await GetIt.I<GetOtpSavedUseCase>().call(args.phoneOrEmail);
          Get.toNamed(
            Routes.verifyOtpForgotPassword,
            arguments: VerifyOtpForgotPasswordArguments(
              phoneNumber: args.phoneOrEmail,
              phoneNumberDisplay: args.phoneNumberDisplay,
              otpEntity: res,
              countDown: e.data?.countdown,
            ),
          );
        } catch (_) {
          UChatDialog.showCountDownOTPDialog(
            secondStart: e.data!.countdown!,
          );
        }
      } else if (e is FailedHostLookupException) {
        await UChatLoading.showTextAndIcon(
          status: 'You are offline.\nPlease try again\nlater.'.tr,
          assetPath: 'assets/images/close_with_circle_icon.png',
        );
      } else {
        _log.e('getOtpForgotPassword error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    }
  }
}
