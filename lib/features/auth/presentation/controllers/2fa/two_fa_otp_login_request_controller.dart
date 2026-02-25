import 'package:get/get.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/features/auth/data/models/requests/get_otp_two_fa_login_request.dart';
import 'package:uchat/features/auth/data/models/requests/save_otp_response_request.dart';
import 'package:uchat/features/auth/domain/use_cases/get_otp_two_fa_login_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/get_otp_saved_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/save_otp_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/get_otp_two_fa_request_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/verify_otp_two_fa_arguments.dart';
import 'package:uchat/features/auth/presentation/views/widgets/count_down_otp_dialog.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

final _log = useLogger();

class TwoFaOtpLoginRequestController extends GetxController {
  final GetOtpTwoFaRequestArguments args;
  final GetOtpTwoFaLoginUseCase getOtpUseCase;
  final SaveOtpUseCase saveOtpUseCase;
  final GetOtpSavedUseCase getOtpSavedUseCase;

  TwoFaOtpLoginRequestController({
    required this.args,
    required this.getOtpUseCase,
    required this.saveOtpUseCase,
    required this.getOtpSavedUseCase,
  });

  String get key => '${args.phoneOrEmail}_${args.emailMask ?? args.phoneNumberMask}';

  void requestOtp() async {
    try {
      await UChatLoading.show();
      final request = GetOtpTwoFaLoginRequest(
        phoneOrEmail: args.phoneOrEmail,
        isEmail: args.emailMask != null,
        isPhoneNumber: args.phoneNumberMask != null,
      );
      final res = await getOtpUseCase.call(request);
      await UChatLoading.hide();
      final saveRequest = SaveOtpResponseRequest(
        phoneOrEmail: key,
        otpEntity: res,
      );
      await saveOtpUseCase.call(saveRequest);

      final result = await Get.toNamed(
        Routes.twoFaOtpLoginVerify,
        arguments: VerifyOtpTwoFaArguments(
          otpEntity: res,
          phoneOrEmail: args.phoneOrEmail,
          emailMask: args.emailMask,
          phoneNumberMask: args.phoneNumberMask,
        ),
      );

      if (result != null) Get.back(result: result);
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      if (e is ErrorAccountOtpCooldown) {
        try {
          final res = await getOtpSavedUseCase.call(key);
          final result = await Get.toNamed(
            Routes.twoFaOtpLoginVerify,
            arguments: VerifyOtpTwoFaArguments(
              otpEntity: res,
              phoneOrEmail: args.phoneOrEmail,
              emailMask: args.emailMask,
              phoneNumberMask: args.phoneNumberMask,
              countDown: e.data?.countdown,
            ),
          );
          if (result != null) Get.back(result: result);
        } catch (_) {
          CountDownOtpDialog.show(
            context: Get.context,
            countDownStart: e.data?.countdown,
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
