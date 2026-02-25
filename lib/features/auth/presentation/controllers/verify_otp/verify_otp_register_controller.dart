import 'dart:async';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/domain/entities/platform_document_entity.dart';
import 'package:uchat/core/domain/services/platform_document_service.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/auth/data/models/requests/check_user_exist_request.dart';
import 'package:uchat/features/auth/data/models/requests/save_otp_response_request.dart';
import 'package:uchat/features/auth/data/models/requests/verify_otp_request.dart';
import 'package:uchat/features/auth/domain/entities/check_user_entity.dart';
import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/domain/entities/verify_otp_entity.dart';
import 'package:uchat/features/auth/domain/use_cases/check_user_exist_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/clear_otp_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/save_otp_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/verify_otp_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/create_account_name_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/verify_otp_register_arguments.dart';
import 'package:uchat/features/auth/presentation/controllers/base_controller/verify_otp_base_controller.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/sheet/uchat_bottom_sheet.dart';

final _log = useLogger();

class VerifyOtpRegisterController extends VerifyOtpBaseController {
  VerifyOtpRegisterController({
    required this.args,
  });

  final VerifyOtpRegisterArguments args;

  @override
  int? get initialCountDown => args.countDown;

  @override
  OtpEntity get initialOtpEntity => args.otpEntity;

  String get phoneOrEmail => args.phone ?? args.email ?? '';

  final termDetailModel = Rxn<PlatformDocumentEntity>();

  @override
  void handleOtpRequest() async {
    if (phoneOrEmail.isEmpty) {
      return;
    }

    final savedOtpReq = CheckUserExistRequest(
      phoneOrEmail: phoneOrEmail,
      isSignUp: true,
    );
    UChatLoading.show();
    try {
      final entity = await GetIt.I<CheckUserExistUseCase>().call(savedOtpReq);
      await UChatLoading.hide();

      if (entity is CheckUserOtpEntity) {
        isResendButtonEnable(false);
        token(entity.token);
        ref(entity.ref);
        handleDisableOTPBtn(
          timeout: diffInSecondHelper(
            entity.timeout.toString(),
          ),
        );
        GetIt.I<SaveOtpUseCase>().call(
          SaveOtpResponseRequest(
            phoneOrEmail: phoneOrEmail,
            otpEntity: OtpEntity(
              actionToken: entity.actionToken,
              firstGet: entity.firstGet,
              ref: entity.ref,
              timeout: entity.timeout,
              token: entity.token,
              type: entity.type,
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
    final req = VerifyOTPRequest(
      token: token(),
      otp: otp(),
      phoneOrEmail: phoneOrEmail,
      actionName: AuthenticationActionType.signup,
    );
    try {
      final res = await GetIt.I<VerifyOtpUseCase>().call(req);
      await GetIt.I<ClearOtpUseCase>().call(phoneOrEmail);
      await UChatLoading.hide();
      errorMessages.value = null;
      clearOTP();
      // ignore: use_build_context_synchronously
      await _openTermAndCondition(res);
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      handleErrorVerifyOtpCode(e, stackTrace);
    }
  }

  Future<void> _openTermAndCondition(VerifyOtpEntity res) async {
    try {
      final value = await GetIt.I<PlatformDocumentService>().getTermsAndConditionsWithPrivacyUrlAndCurrentVersion();

      UChatBottomSheet.showTermAndConditionBottomSheet(
        // ignore: use_build_context_synchronously
        context: Get.context!,
        fileUrl: value.$1,
        onAccept: () {
          GetIt.I<PlatformDocumentService>().saveVersionTermAndCondition(value.$2);
          Get.offAndToNamed(
            Routes.createAccountName,
            arguments: CreateAccountNameArguments(
              actionToken: res.actionToken,
              phoneNumber: phoneOrEmail,
            ),
          );
        },
      );
    } catch (e) {
      _log.e('Error fetching term and condition', e);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
      );
    }
  }
}
