import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/features/auth/data/models/requests/save_otp_response_request.dart';
import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/domain/factories/get_otp_usecase_factory.dart';
import 'package:uchat/features/auth/domain/factories/verify_otp_usecase_factory.dart';
import 'package:uchat/features/auth/domain/use_cases/clear_otp_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/save_otp_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_otp_verify_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_otp_verify_result_arguments.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/auth/presentation/controllers/base_controller/verify_otp_base_controller.dart';
import 'package:uchat/features/auth/presentation/views/widgets/count_down_otp_dialog.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class SettingAccountOtpVerifyController extends VerifyOtpBaseController {
  final SettingAccountOtpVerifyArguments args;
  final IGetOtpUseCase getOtpUseCase;
  final SaveOtpUseCase saveOtpUseCase;
  final IVerifyOtpUseCase verifyOtpUseCase;
  final ClearOtpUseCase clearOtpUseCase;

  SettingAccountOtpVerifyController({
    required this.args,
    required this.getOtpUseCase,
    required this.saveOtpUseCase,
    required this.verifyOtpUseCase,
    required this.clearOtpUseCase,
  });

  String get title {
    if (args.socialActionType != null) {
      return args.socialActionType!.title;
    }

    return args.actionType.title;
  }

  @override
  int? get initialCountDown => args.countDown;

  @override
  OtpEntity get initialOtpEntity => args.otpEntity ?? const OtpEntity();

  @override
  void handleOtpRequest() async {
    UChatLoading.show();
    try {
      // clear previous OTP data, errors, and input
      clearOTP();

      final otpRequest = getOtpUseCase.createRequest(args);
      final otpResponse = await getOtpUseCase.execute(otpRequest);
      await UChatLoading.hide();
      isResendButtonEnable(false);
      token(otpResponse.token);
      ref(otpResponse.ref);
      handleDisableOTPBtn(
        timeout: diffInSecondHelper(
          otpResponse.timeout.toString(),
        ),
      );
      final request = SaveOtpResponseRequest(
        phoneOrEmail: args.phoneNumber ?? args.email ?? '',
        otpEntity: OtpEntity(
          actionToken: otpResponse.actionToken,
          firstGet: otpResponse.firstGet,
          ref: otpResponse.ref,
          timeout: otpResponse.timeout,
          token: otpResponse.token,
          type: otpResponse.type,
        ),
      );
      await saveOtpUseCase.call(request);
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      clearOTP();
      if (e is ErrorAccountOtpCooldown) {
        CountDownOtpDialog.show(
          context: Get.context,
          countDownStart: e.data?.countdown,
        );
      } else if (e is FailedHostLookupException) {
        await UChatLoading.showTextAndIcon(
          status: 'You are offline.\nPlease try again\nlater.'.tr,
          assetPath: 'assets/images/close_with_circle_icon.png',
        );
      } else {
        _log.e('Error resend OTP', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      }
    }
  }

  @override
  void verifyOtpCode() async {
    await UChatLoading.show(status: 'Please wait...'.tr);

    try {
      final request = verifyOtpUseCase.createRequest(
        args.copyWith(
          otp: otp(),
          otpEntity: args.otpEntity?.copyWith(
            token: token(),
          ),
        ),
      );
      final response = await verifyOtpUseCase.execute(request);
      await clearOtpUseCase.call(args.phoneNumber ?? args.email ?? '');
      await UChatLoading.hide();
      errorMessages.value = null;
      clearOTP();
      Get.back(
        result: SettingAccountOtpVerifyResultArguments(
          actionToken: response.actionToken,
          phoneOrEmail: args.phoneNumber ?? args.email ?? '',
          accountId: response.accountId,
        ),
      );
    } catch (e, stackTrace) {
      clearOTP();
      await UChatLoading.hide();
      if (e is ErrorAccountActionTokenExpired) {
        UChatNewDialog.showSingleButtonDialog(
          context: Get.context!,
          title: 'Failed to connect to system.'.tr,
          description: '(Please try again)'.tr,
          confirmText: 'OK'.tr,
          confirmTextColor: Get.theme.appColors.textPrimary,
        );
      } else if (e is ErrorAccountOtpExpired) {
        errorMessages.value = 'The OTP has expired and cannot be used. Please request a new OTP.'.tr;
      } else if (e is ErrorAccountInvalidOtpToken) {
        errorMessages.value = 'Incorrect OTP code, Please try again.'.tr;
        errorController.add(ErrorAnimationType.shake);
      } else if (e is FailedHostLookupException) {
        UChatLoading.showTextAndIcon(
          status: 'You are offline.\nPlease try again\nlater.'.tr,
          assetPath: 'assets/images/close_with_circle_icon.png',
        );
      } else {
        _log.e('Error verify OTP', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    }
  }
}
