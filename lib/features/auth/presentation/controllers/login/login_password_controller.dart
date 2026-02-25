import 'dart:async';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/exceptions/multiple_account_limit_exceed_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/features/accounts_center/domain/use_cases/process_before_add_account_use_case.dart';
import 'package:uchat/features/auth/data/models/enum/link_account_type.dart';
import 'package:uchat/features/auth/domain/entities/check_password_entity.dart';
import 'package:uchat/features/auth/domain/entities/verify_otp_login_entity.dart';
import 'package:uchat/features/auth/domain/use_cases/login_password_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/link_account_with_apple_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/link_account_with_email_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/link_account_with_facebook_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/link_account_with_google_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/login_password_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/two_fa_otp_login_receipt_method_arguments.dart';
import 'package:uchat/features/auth/presentation/controllers/base_controller/enter_password_base_controller.dart';
import 'package:uchat/features/auth/presentation/managers/setting_account_forgot_password_flow_manager.dart';
import 'package:uchat/features/home/home_controller.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

final _log = useLogger();

class LoginPasswordController extends EnterPasswordBaseController {
  final LoginPasswordArguments args;
  final SettingAccountForgotPasswordFlowManager forgotPasswordFlowManager;

  LoginPasswordController({
    required this.args,
    required this.forgotPasswordFlowManager,
  });

  @override
  int? get cooldown => args.cooldown;

  Future<UserEntity> setupUser(UserEntity user) async {
    await UserController.instance.setCurrentUser(user);
    return user;
  }

  @override
  void onContinue() async {
    try {
      final phoneOrEmail = args.phone ?? args.email ?? '';
      if (phoneOrEmail.isEmpty) {
        return;
      }
      UChatLoading.show();
      final checkPasswordEntity = await GetIt.I<LoginPasswordUseCase>().call(
        CheckUserExistWithPasswordRequest(
          password: passwordCtl.text,
          phoneOrEmail: phoneOrEmail,
        ),
      );
      await UChatLoading.hide();

      UserEntity? userEntity;

      if (checkPasswordEntity is CheckPasswordEntityEnableTwoFa) {
        final verifyOtpResult = await Get.toNamed(
          Routes.twoFaOtpLoginReceiptMethod,
          arguments: TwoFaOtpLoginReceiptMethodArguments(
            phoneOrEmail: phoneOrEmail,
            emailMask: checkPasswordEntity.email,
            phoneNumberMask: checkPasswordEntity.phoneNumber,
          ),
        );
        if (verifyOtpResult is VerifyOtpLoginEntity) {
          userEntity = verifyOtpResult.account!.copyWith(
            token: verifyOtpResult.token,
          );
        }
      } else if (checkPasswordEntity is CheckPasswordEntityUnableTwoFa) {
        //NOTE.need firebaseToken to use firebase online status
        userEntity = checkPasswordEntity.account!.copyWith(
          token: checkPasswordEntity.token,
          firebaseToken: checkPasswordEntity.firebaseToken,
        );
      }

      if (userEntity == null) {
        return;
      }

      userEntity = await GetIt.I<ProcessBeforeAddAccountUseCase>().call(
        ProcessBeforeAddAccountParams(
          user: userEntity,
        ),
      );

      GetIt.I<TaxonomyService>().sendEvent(EventName.loginSucceeded);

      if (args.linkAccountModel != null) {
        final linkAccountModel = args.linkAccountModel!;
        final user = await setupUser(userEntity);

        if (linkAccountModel.type == LinkAccountType.email) {
          Get.toNamed(
            Routes.linkAccountWithEmail,
            arguments: LinkAccountWithEmailArguments(
              linkAccountModel: linkAccountModel,
              user: user,
            ),
          );
        } else if (linkAccountModel.type == LinkAccountType.google) {
          Get.toNamed(
            Routes.linkAccountWithGoogle,
            arguments: LinkAccountWithGoogleArguments(
              linkAccountModel: linkAccountModel,
              user: user,
            ),
          );
        } else if (linkAccountModel.type == LinkAccountType.facebook) {
          Get.toNamed(
            Routes.linkAccountWithFacebook,
            arguments: LinkAccountWithFacebookArguments(
              linkAccountModel: linkAccountModel,
              user: user,
            ),
          );
        } else if (linkAccountModel.type == LinkAccountType.apple) {
          Get.toNamed(
            Routes.linkAccountWithApple,
            arguments: LinkAccountWithAppleArguments(
              linkAccountModel: linkAccountModel,
              user: user,
            ),
          );
        }
      } else {
        // Show splash before go to home screen to avoid showing home screen before data is loaded.
        // splash will be hidden in SyncService after sync completed.
        HomeController.instance.showSplash();
        // Go to home screen
        Get.offAllNamed(Routes.home);
        await setupUser(userEntity);
      }
    } on MultipleAccountLimitExceedException catch (_) {
      Get.offAllNamed(Routes.home);
      Get.toNamed(Routes.accountsCenter);
      UChatNewDialog.showSingleButtonDialogV2(
        context: Get.context!,
        title: 'You have added the maximum of accounts'.tr,
        description: 'You cannot add more account'.tr,
      );
    } catch (e, stackTrace) {
      if (e is ApiException) {
        if (e.type == 'ERR_ACCOUNT_LIMIT_PASSWORD_VALIDATION') {
          passwordAttempts.value = e.data?.counter ?? 0;
          errorMessage.value = 'The password you entered is incorrect. Please try again'.tr;
        } else if (e.type == 'ERR_VALIDATE_PASSWORD_COOLDOWN') {
          errorMessage.value = 'Too many incorrect attempts'.tr;
          cooldownTime.value = e.data?.cooldown ?? 0;
          passwordAttempts.value = 0;
          startCooldown();
        }
      } else {
        _log.e('Login password error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    } finally {
      await UChatLoading.hide();
    }
  }

  @override
  void onForgotPassword() async {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickForgotPassword);

    final phoneNumber = args.phone ?? '';
    final email = args.email ?? '';

    if (phoneNumber.isNotEmpty) {
      await forgotPasswordFlowManager.phoneNumberFlow(phoneNumber: phoneNumber);
    } else {
      await forgotPasswordFlowManager.emailFlow(email: email);
    }
  }
}
