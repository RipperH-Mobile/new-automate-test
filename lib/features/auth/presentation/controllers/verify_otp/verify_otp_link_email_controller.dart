import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/features/auth/data/models/requests/link_email_otp_request.dart';
import 'package:uchat/features/auth/data/models/requests/link_email_verify_otp_request.dart';
import 'package:uchat/features/auth/data/models/requests/save_otp_response_request.dart';
import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/domain/use_cases/clear_otp_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/link_account_with_email_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/save_otp_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/verify_otp_link_email_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/login_welcome_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/verify_otp_link_email_arguments.dart';
import 'package:uchat/features/auth/presentation/controllers/base_controller/verify_otp_base_controller.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/widgets.dart';

class VerifyOtpLinkEmailController extends VerifyOtpBaseController {
  VerifyOtpLinkEmailController({
    required this.args,
  });

  final VerifyOtpLinkEmailArguments args;

  @override
  int? get initialCountDown => args.countDown;

  @override
  OtpEntity get initialOtpEntity => args.otpEntity;

  @override
  void handleOtpRequest() async {
    final req = LinkEmailOtpRequest(
      email: args.linkAccountModel.email,
    );
    UChatLoading.show();
    try {
      final res = await GetIt.I<LinkAccountWithEmailUseCase>().call(req);
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
          phoneOrEmail: args.phoneOrEmail,
          otpEntity: OtpEntity(
            actionToken: res.actionToken,
            firstGet: res.firstGet,
            ref: res.ref,
            timeout: res.timeout,
            token: res.token,
            type: res.type,
          ),
        ),
      );
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      handleErrorSendOtpRequest(e, stackTrace);
    }
  }

  @override
  void verifyOtpCode() async {
    await UChatLoading.show(status: 'Please wait...'.tr);
    final req = LinkEmailVerifyOtpRequest(
      token: token(),
      otp: otp(),
    );
    try {
      final res = await GetIt.I<VerifyOtpLinkEmailUseCase>().call(req);
      await GetIt.I<ClearOtpUseCase>().call(args.phoneOrEmail);
      await UChatLoading.hide();
      errorMessages.value = null;
      clearOTP();
      if (args.setupPassword) {
        Get.offAllNamed(Routes.setupPasswordNew);
      } else {
        UserController.instance.checkAndResetUserSyncCompleted(
          onSyncComplete: () {
            Get.offAllNamed(Routes.home);
          },
          onSyncNotComplete: () {
            Get.offAllNamed(
              Routes.loginWelcome,
              arguments: LoginWelcomeArguments(
                user: res,
                waitSyncUserOnly: true,
              ),
            );
          },
        );
      }
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      handleErrorVerifyOtpCode(e, stackTrace);
    }
  }
}
