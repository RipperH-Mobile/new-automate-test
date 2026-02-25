import 'package:dlibphonenumber/dlibphonenumber.dart' as dlib;
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/features/auth/data/models/requests/save_otp_response_request.dart';
import 'package:uchat/features/auth/domain/entities/check_user_entity.dart';
import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/domain/use_cases/check_user_exist_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/get_otp_saved_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/save_otp_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/login_password_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/login_with_phone_number_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/verify_otp_login_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/verify_otp_register_arguments.dart';
import 'package:uchat/features/auth/presentation/controllers/base_controller/enter_phone_number_base_controller.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class LoginWithPhoneNumberController extends EnterPhoneNumberBaseController {
  static LoginWithPhoneNumberController get to => Get.find();

  bool alreadySendInputPhoneNumberTaxonomyEvent = false;

  final LoginWithPhoneNumberArguments? args;

  LoginWithPhoneNumberController({
    this.args,
  });

  final _log = useLogger();

  @override
  void onPhoneCtlChanged(value) {
    if (!alreadySendInputPhoneNumberTaxonomyEvent) {
      GetIt.I<TaxonomyService>().sendEvent(EventName.inputPhoneNumber);
      alreadySendInputPhoneNumberTaxonomyEvent = true;
    }
    super.onPhoneCtlChanged(value);
  }

  @override
  void onContinue() async {
    if (errorMessagePhone.value.isNotEmpty) {
      return;
    }

    final phoneNumber = phoneInputCtl.phoneNumber().phoneNumber;
    final countryCode = currentCountry.value?.phoneCode ?? '';

    if (phoneNumber == null || phoneNumber.isEmpty) {
      return;
    }

    GetIt.I<TaxonomyService>().sendEvent(EventName.clickContinuePhoneNumber);

    final newPhoneNumber = dlib.PhoneNumberUtil.instance.parse(phoneNumber, currentCountry.value?.countryCode);
    final phoneNumberFormat = dlib.PhoneNumberUtil.instance.format(newPhoneNumber, dlib.PhoneNumberFormat.e164);

    await UChatLoading.show();
    final req = CheckUserExistRequest(
      phoneOrEmail: phoneNumberFormat,
      isSignUp: false,
    );

    try {
      final entity = await GetIt.I<CheckUserExistUseCase>().call(req);
      await UChatLoading.hide();
      switch (entity) {
        case CheckUserOtpEntity():
          final otpResponse = OtpEntity(
            actionToken: entity.actionToken,
            firstGet: entity.firstGet,
            ref: entity.ref,
            timeout: entity.timeout,
            token: entity.token,
            type: entity.type,
          );
          GetIt.I<SaveOtpUseCase>().call(
            SaveOtpResponseRequest(
              phoneOrEmail: phoneNumber,
              otpEntity: otpResponse,
            ),
          );
          Get.toNamed(
            Routes.verifyOtpLogin,
            arguments: VerifyOtpLoginArguments(
              phone: phoneNumberFormat,
              countryCode: countryCode,
              otpEntity: otpResponse,
              linkAccountModel: args?.linkAccountModel,
              setupPassword: true,
            ),
          );
          break;
        case CheckUserPasswordEntity():
          Get.toNamed(
            Routes.loginPassword,
            arguments: LoginPasswordArguments(
              phone: phoneNumberFormat,
              linkAccountModel: args?.linkAccountModel,
            ),
          );
          break;
      }
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      if (e is ErrorAccountOtpCooldown) {
        try {
          final entity = await GetIt.I<GetOtpSavedUseCase>().call(phoneNumber);
          Get.toNamed(
            Routes.verifyOtpLogin,
            arguments: VerifyOtpLoginArguments(
              phone: phoneNumberFormat,
              countryCode: countryCode,
              otpEntity: entity,
              linkAccountModel: args?.linkAccountModel,
              setupPassword: true,
              countDown: e.data?.countdown,
            ),
          );
        } catch (_) {
          UChatDialog.showCountDownOTPDialog(
            secondStart: e.data!.countdown!,
          );
        }
      } else if (e is ErrorUserNotFoundException) {
        _getOtpRegister(
          phoneNumber: phoneNumberFormat,
          countryCode: countryCode,
        );
      } else if (e is ErrorAccountBanedException) {
        String? content =
            Get.locale?.languageCode.toUpperCase() == 'TH' ? e.data?.bannedContentTH : e.data?.bannedContentEN;
        UChatNewDialog.showAccountBannedDialog(
            context: Get.context!,
            content: content,
            onConfirm: () {
              Get.back();
            });
      } else if (e is FailedHostLookupException) {
        await UChatLoading.showTextAndIcon(
          status: 'You are offline.\nPlease try again\nlater.'.tr,
          assetPath: 'assets/images/close_with_circle_icon.png',
        );
      } else {
        _log.e('Error in checkUserExist', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    }
  }

  void _getOtpRegister({
    required String phoneNumber,
    required String countryCode,
  }) async {
    try {
      await UChatLoading.show();
      final savedOtpReq = CheckUserExistRequest(
        phoneOrEmail: phoneNumber,
        isSignUp: true,
      );

      final entity = await GetIt.I<CheckUserExistUseCase>().call(savedOtpReq);
      await UChatLoading.hide();
      if (entity is CheckUserOtpEntity) {
        final otpResponse = OtpEntity(
          actionToken: entity.actionToken,
          firstGet: entity.firstGet,
          ref: entity.ref,
          timeout: entity.timeout,
          token: entity.token,
          type: entity.type,
        );
        GetIt.I<SaveOtpUseCase>().call(
          SaveOtpResponseRequest(
            phoneOrEmail: phoneNumber,
            otpEntity: otpResponse,
          ),
        );
        Get.toNamed(
          Routes.verifyOtpRegister,
          arguments: VerifyOtpRegisterArguments(
            phone: phoneNumber,
            countryCode: countryCode,
            otpEntity: otpResponse,
          ),
        );
      }
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      if (e is ErrorAccountOtpCooldown) {
        try {
          final res = await GetIt.I<GetOtpSavedUseCase>().call(phoneNumber);
          Get.toNamed(
            Routes.verifyOtpRegister,
            arguments: VerifyOtpRegisterArguments(
              phone: phoneNumber,
              countryCode: countryCode,
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
        _log.e('Error in getOtpRegister', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    }
  }

  @override
  void onOpenCountryListBottomSheet() {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickCountryPhoneNumber);
    super.onOpenCountryListBottomSheet();
  }
}
