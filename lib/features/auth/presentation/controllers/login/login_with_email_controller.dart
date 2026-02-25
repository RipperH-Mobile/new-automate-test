import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/features/auth/data/models/enum/link_account_type.dart';
import 'package:uchat/features/auth/data/models/requests/save_otp_response_request.dart';
import 'package:uchat/features/auth/domain/entities/check_user_entity.dart';
import 'package:uchat/features/auth/domain/entities/link_account_auth_entity.dart';
import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/domain/use_cases/get_otp_saved_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/login_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/save_otp_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/login_password_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/login_with_phone_number_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/verify_otp_login_arguments.dart';
import 'package:uchat/features/auth/presentation/controllers/base_controller/enter_email_base_controller.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/widgets/dialog/uchat_dialog.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

class LoginWithEmailController extends EnterEmailBaseController {
  // For triggering the taxonomy event only once for each time user open login with email screen.
  bool alreadySendInputEmailTaxonomyEvent = false;

  @override
  void onEmailCtlChanged(String value) {
    if (!alreadySendInputEmailTaxonomyEvent) {
      GetIt.I<TaxonomyService>().sendEvent(EventName.inputEmail);
      alreadySendInputEmailTaxonomyEvent = true;
    }
    super.onEmailCtlChanged(value);
  }

  @override
  void onContinue() async {
    try {
      GetIt.I<TaxonomyService>().sendEvent(EventName.clickContinueEmail);
      UChatLoading.show();
      final entity = await GetIt.I<LoginUseCase>().call(
        CheckUserExistRequest(
          phoneOrEmail: emailCtl.text,
        ),
      );
      await UChatLoading.hide();
      switch (entity) {
        case CheckUserOtpEntity():
          final otpEntity = OtpEntity(
            actionToken: entity.actionToken,
            firstGet: entity.firstGet,
            ref: entity.ref,
            timeout: entity.timeout,
            token: entity.token,
            type: entity.type,
          );
          await GetIt.I<SaveOtpUseCase>().call(
            SaveOtpResponseRequest(
              phoneOrEmail: emailCtl.text,
              otpEntity: otpEntity,
            ),
          );
          Get.toNamed(
            Routes.verifyOtpLogin,
            arguments: VerifyOtpLoginArguments(
              email: emailCtl.text,
              otpEntity: otpEntity,
              setupPassword: true,
            ),
          );
          break;
        case CheckUserPasswordEntity():
          Get.toNamed(
            Routes.loginPassword,
            arguments: LoginPasswordArguments(
              email: emailCtl.text,
            ),
          );
          break;
      }
    } catch (e) {
      await UChatLoading.hide();
      if (e is ApiException && e.type == 'ERR_VALIDATE_PASSWORD_COOLDOWN') {
        Get.toNamed(
          Routes.loginPassword,
          arguments: LoginPasswordArguments(
            email: emailCtl.text,
            cooldown: e.data?.cooldown,
          ),
        );
      } else if (e is ErrorAccountOtpCooldown) {
        try {
          final res = await GetIt.I<GetOtpSavedUseCase>().call(emailCtl.text);
          Get.toNamed(
            Routes.verifyOtpLogin,
            arguments: VerifyOtpLoginArguments(
              email: emailCtl.text,
              otpEntity: res,
              countDown: e.data?.countdown,
              setupPassword: true,
            ),
          );
        } catch (_) {
          UChatDialog.showCountDownOTPDialog(
            secondStart: e.data!.countdown!,
          );
        }
      } else if (e is ErrorUserNotFoundException) {
        Get.back();
        Get.toNamed(
          Routes.loginWithPhoneNumber,
          arguments: LoginWithPhoneNumberArguments(
            linkAccountModel: LinkAccountAuthEntity(email: emailCtl.text, type: LinkAccountType.email),
          ),
        );
      } else if (e is ErrorAccountBanedException) {
        // TODO
      } else if (e is FailedHostLookupException) {
        await UChatLoading.showTextAndIcon(
          status: 'You are offline.\nPlease try again\nlater.'.tr,
          assetPath: 'assets/images/close_with_circle_icon.png',
        );
      } else {
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    }
  }
}
