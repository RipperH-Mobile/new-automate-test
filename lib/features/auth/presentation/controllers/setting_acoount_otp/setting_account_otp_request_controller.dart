import 'package:get/get.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/features/auth/data/models/requests/save_otp_response_request.dart';
import 'package:uchat/features/auth/domain/factories/get_otp_usecase_factory.dart';
import 'package:uchat/features/auth/domain/use_cases/get_otp_saved_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/save_otp_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_otp_verify_arguments.dart';
import 'package:uchat/features/auth/presentation/views/widgets/count_down_otp_dialog.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

final _log = useLogger();

class SettingAccountOtpController extends GetxController {
  final SettingAccountOtpVerifyArguments args;
  final IGetOtpUseCase getOtpUseCase;
  final SaveOtpUseCase saveOtpUseCase;
  final GetOtpSavedUseCase getOtpSavedUseCase;

  SettingAccountOtpController({
    required this.args,
    required this.getOtpUseCase,
    required this.saveOtpUseCase,
    required this.getOtpSavedUseCase,
  });

  String get title {
    if (args.socialActionType != null) {
      return args.socialActionType!.title;
    }

    return args.actionType.title;
  }

  String get getOtpTitle {
    if (args.socialActionType != null) {
      return args.socialActionType!.getOtpTitle;
    }

    return args.actionType.getOtpTitle;
  }

  void requestOtp() async {
    try {
      await UChatLoading.show();
      final request = getOtpUseCase.createRequest(args);
      final res = await getOtpUseCase.execute(request);
      final saveRequest = SaveOtpResponseRequest(
        phoneOrEmail: args.email ?? args.phoneNumber ?? '',
        otpEntity: res,
      );
      await saveOtpUseCase.call(saveRequest);
      await UChatLoading.hide();

      _gotoVerifyOtp();
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      if (e is ErrorAccountOtpCooldown) {
        _gotoVerifyOtp(initialCountdown: e.data?.countdown);
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

  Future<void> _gotoVerifyOtp({
    int? initialCountdown,
  }) async {
    try {
      final otpEntity = await getOtpSavedUseCase.call(args.email ?? args.phoneNumber ?? '');

      final result = await Get.toNamed(
        Routes.settingAccountOtpVerify,
        arguments: args.copyWith(
          actionType: args.actionType,
          otpEntity: otpEntity,
          email: args.email,
          phoneNumber: args.phoneNumber,
          method: args.method,
          socialActionType: args.socialActionType,
          countDown: initialCountdown,
        ),
      );

      if (result != null) Get.back(result: result);
    } catch (_) {
      CountDownOtpDialog.show(
        context: Get.context,
        countDownStart: initialCountdown,
      );
    }
  }
}
