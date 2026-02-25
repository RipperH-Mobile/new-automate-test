import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

abstract class VerifyOtpBaseController extends GetxController {
  final otp = ''.obs;
  final token = ''.obs;
  final ref = ''.obs;
  final errorMessages = RxnString();
  final isResendButtonEnable = false.obs;
  final otpTextController = TextEditingController();
  final otpFocusNode = FocusNode();
  final reCaptchaToken = ''.obs;
  final errorController = StreamController<ErrorAnimationType>();
  final isInitialized = false.obs;

  Timer? _timer;
  final start = 60.obs;

  // TODO: implement this
  OtpEntity get initialOtpEntity;
  int? get initialCountDown;

  @override
  void onInit() async {
    _initialValue();
    // if (GetPlatform.isMobile) {
    //   reCaptchaInitClient();
    // }
    handleDisableOTPBtn(timeout: initialCountDown);
    super.onInit();
  }

  @override
  void onClose() {
    otpTextController.dispose();
    otpFocusNode.unfocus();
    otpFocusNode.dispose();
    _timer?.cancel();
    super.onClose();
  }

  /// example:
  /// UChatLoading.show();
  ///
  /// try {} catch (e, stackTrace) {
  ///
  ///   await UChatLoading.hide();
  ///
  ///   handleErrorSendOtpRequest(e, stackTrace);
  ///
  /// }
  void handleOtpRequest();

  /// example:
  /// UChatLoading.show();
  ///
  /// try {} catch (e, stackTrace) {
  ///  await UChatLoading.hide();
  ///
  ///  handleErrorVerifyOtpCode(e, stackTrace);
  /// }
  void verifyOtpCode();

  void _initialValue() {
    token.value = initialOtpEntity.token ?? '';
    ref.value = initialOtpEntity.ref ?? '';
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start.value == 0) {
          isResendButtonEnable(true);
          timer.cancel();
        } else {
          start.value--;
        }
      },
    );
  }

  // ignore: unused_element
  int? diffInSecondHelper(String? value) {
    if (value == null) return null;
    final dateTimeBase = DateTime.parse(value);
    return dateTimeBase.difference(DateTime.now()).inSeconds;
  }

  void handleOTPChange(String value) {
    otp(value);
    errorMessages.value = null;
  }

  void handleDisableOTPBtn({int? timeout = 60}) {
    start(timeout);
    _startTimer();
    isResendButtonEnable(false);
  }

  // Future<void> reCaptchaInitClient() async {
  //   String siteKey = Platform.isIOS || Platform.isMacOS ? AppEnv.reCaptchaIosSiteKey : AppEnv.reCaptchaAndroidSiteKey;
  //   final response = await authServerRepository.reCaptchaFetchClient(siteKey);
  //   response.fold(
  //     (e) {
  //       Get.back();
  //     },
  //     (res) {
  //       isInitialized(res.isBlank != null);
  //     },
  //   );
  // }

  void clearOTP() {
    otp.value = '';
    otpTextController.text = '';
    otpTextController.clear();
    otpFocusNode.requestFocus();
    errorMessages.value = null;
  }

  void sendOtpRequest() async {
    // TODO: implement reCaptcha
    // if (GetPlatform.isMobile) {
    //   await _reCaptchaExecute();
    // }
    handleOtpRequest();
  }

  // ignore: unused_element
  void handleErrorVerifyOtpCode(
    Object e,
    StackTrace stackTrace,
  ) {
    clearOTP();
    if (e is ErrorAccountActionTokenExpired) {
      UChatDialog.showActionTokenExpireDialog();
    } else if (e is ErrorAccountOtpExpired) {
      errorMessages.value = 'This OTP has expired. Please request a new OTP again.'.tr;
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

  // ignore: unused_element
  void handleErrorSendOtpRequest(
    Object e,
    StackTrace stackTrace,
  ) async {
    clearOTP();
    if (e is ErrorAccountOtpCooldown) {
      UChatDialog.showCountDownOTPDialog(
        secondStart: e.data!.countdown!,
      );
    } else if (e is FailedHostLookupException) {
      await UChatLoading.showTextAndIcon(
        status: 'You are offline.\nPlease try again\nlater.'.tr,
        assetPath: 'assets/images/close_with_circle_icon.png',
      );
    } else {
      _log.e('Error request OTP', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
    }
  }
}
