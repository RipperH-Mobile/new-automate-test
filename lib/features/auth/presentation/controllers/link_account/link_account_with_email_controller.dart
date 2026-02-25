import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/exceptions/error_account_otp_cooldown.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/features/auth/data/models/requests/link_email_otp_request.dart';
import 'package:uchat/features/auth/data/models/requests/save_otp_response_request.dart';
import 'package:uchat/features/auth/domain/use_cases/get_otp_saved_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/link_account_with_email_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/save_otp_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/link_account_with_email_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/login_welcome_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/verify_otp_link_email_arguments.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/widgets/dialog/uchat_dialog.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

final _log = useLogger();

class LinkAccountWithEmailController extends GetxController {
  final LinkAccountWithEmailArguments args;

  LinkAccountWithEmailController({
    required this.args,
  });

  void onContinue() async {
    final req = LinkEmailOtpRequest(
      email: args.linkAccountModel.email,
    );
    final email = args.linkAccountModel.email;
    try {
      final otpEntity = await GetIt.I<LinkAccountWithEmailUseCase>().call(req);
      await UChatLoading.hide();
      GetIt.I<SaveOtpUseCase>().call(
        SaveOtpResponseRequest(
          phoneOrEmail: email,
          otpEntity: otpEntity,
        ),
      );
      Get.toNamed(
        Routes.verifyOtpLinkEmail,
        arguments: VerifyOtpLinkEmailArguments(
          phoneOrEmail: email,
          linkAccountModel: args.linkAccountModel,
          setupPassword: args.setupPassword,
          otpEntity: otpEntity,
        ),
      );
    } catch (e) {
      await UChatLoading.hide();
      if (e is ErrorAccountOtpCooldown) {
        try {
          final res = await GetIt.I<GetOtpSavedUseCase>().call(email);
          Get.toNamed(
            Routes.verifyOtpLinkEmail,
            arguments: VerifyOtpLinkEmailArguments(
              phoneOrEmail: email,
              linkAccountModel: args.linkAccountModel,
              setupPassword: args.setupPassword,
              otpEntity: res,
              countDown: e.data!.countdown,
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
        _log.e('link account with email', e);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    }
  }

  void goToHome() {
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
              user: args.user,
              waitSyncUserOnly: true,
            ),
          );
        },
      );
    }
  }
}
