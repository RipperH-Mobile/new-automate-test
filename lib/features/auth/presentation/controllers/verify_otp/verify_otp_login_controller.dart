import 'dart:async';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/exceptions/multiple_account_limit_exceed_exception.dart';
import 'package:uchat/features/accounts_center/domain/use_cases/process_before_add_account_use_case.dart';
import 'package:uchat/features/auth/data/models/enum/link_account_type.dart';
import 'package:uchat/features/auth/data/models/requests/auth_sign_in_request.dart';
import 'package:uchat/features/auth/data/models/requests/check_user_exist_request.dart';
import 'package:uchat/features/auth/data/models/requests/save_otp_response_request.dart';
import 'package:uchat/features/auth/domain/entities/check_user_entity.dart';
import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/domain/use_cases/check_user_exist_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/clear_otp_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/save_otp_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/verify_otp_login_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/link_account_with_apple_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/link_account_with_email_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/link_account_with_facebook_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/link_account_with_google_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/login_welcome_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/verify_otp_login_arguments.dart';
import 'package:uchat/features/auth/presentation/controllers/base_controller/verify_otp_base_controller.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class VerifyOtpLoginController extends VerifyOtpBaseController {
  VerifyOtpLoginController({
    required this.args,
  });

  final VerifyOtpLoginArguments args;

  @override
  int? get initialCountDown => args.countDown;

  @override
  OtpEntity get initialOtpEntity => args.otpEntity;

  String get phoneOrEmail => args.phone ?? args.email ?? '';

  @override
  void handleOtpRequest() async {
    if (phoneOrEmail.isEmpty) {
      return;
    }
    final savedOtpReq = CheckUserExistRequest(
      phoneOrEmail: phoneOrEmail,
      isSignUp: false,
    );
    UChatLoading.show();
    try {
      final res = await GetIt.I<CheckUserExistUseCase>().call(savedOtpReq);
      await UChatLoading.hide();

      if (res is CheckUserOtpEntity) {
        isResendButtonEnable(false);
        token(res.token);
        ref(res.ref);
        handleDisableOTPBtn(
          timeout: diffInSecondHelper(
            res.timeout.toString(),
          ),
        );
        await GetIt.I<SaveOtpUseCase>().call(
          SaveOtpResponseRequest(
            phoneOrEmail: phoneOrEmail,
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
      }
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      handleErrorSendOtpRequest(e, stackTrace);
    }
  }

  @override
  void verifyOtpCode() async {
    if (phoneOrEmail.isEmpty) {
      return;
    }
    await UChatLoading.show(status: 'Please wait...'.tr);
    final req = AuthSignInRequest(
      token: token(),
      otp: otp(),
      phoneOrEmail: phoneOrEmail,
      isPhoneNumber: args.phone != null,
    );
    try {
      final res = await GetIt.I<VerifyOtpLoginUseCase>().call(req);
      await GetIt.I<ClearOtpUseCase>().call(phoneOrEmail);

      final userId = res.account?.id;
      UserEntity? userData = res.account;
      if (userId != null) {
        userData = await GetIt.I<ProcessBeforeAddAccountUseCase>().call(
          ProcessBeforeAddAccountParams(
            user: res.account!,
          ),
        );
      }

      final user = await setupUser(
        userData!,
        res.token!,
      );
      await UChatLoading.hide();
      errorMessages.value = null;
      clearOTP();
      if (user == null) {
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
        return;
      }
      if (args.linkAccountModel != null) {
        final linkAccountModel = args.linkAccountModel!;
        if (linkAccountModel.type == LinkAccountType.email) {
          Get.toNamed(
            Routes.linkAccountWithEmail,
            arguments: LinkAccountWithEmailArguments(
              linkAccountModel: linkAccountModel,
              setupPassword: true,
              user: user,
            ),
          );
        } else if (linkAccountModel.type == LinkAccountType.google) {
          Get.toNamed(
            Routes.linkAccountWithGoogle,
            arguments: LinkAccountWithGoogleArguments(
              linkAccountModel: linkAccountModel,
              setupPassword: true,
              user: user,
            ),
          );
        } else if (linkAccountModel.type == LinkAccountType.facebook) {
          Get.toNamed(
            Routes.linkAccountWithFacebook,
            arguments: LinkAccountWithFacebookArguments(
              linkAccountModel: linkAccountModel,
              setupPassword: true,
              user: user,
            ),
          );
        } else if (linkAccountModel.type == LinkAccountType.apple) {
          Get.toNamed(
            Routes.linkAccountWithApple,
            arguments: LinkAccountWithAppleArguments(
              linkAccountModel: linkAccountModel,
              setupPassword: true,
              user: user,
            ),
          );
        }
      } else {
        if (args.setupPassword) {
          Get.offAllNamed(Routes.setupPasswordNew);
        } else {
          Get.offAllNamed(
            Routes.loginWelcome,
            arguments: LoginWelcomeArguments(
              user: res.account!,
              token: res.token,
              waitSyncUserOnly: false,
            ),
          );
        }
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
      handleErrorVerifyOtpCode(e, stackTrace);
    } finally {
      await UChatLoading.hide();
    }
  }

  Future<UserEntity?> setupUser(
    UserEntity user,
    String token,
  ) async {
    // user = await GetIt.I<UpdateIsMasterUseCase>().call(user);
    await UserController.instance.setCurrentUser(
      user,
      token: token,
    );
    return user;
  }
}
