import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/2fa/two_fa_otp_login_verify_controller.dart';
import 'package:uchat/features/auth/presentation/views/widgets/verify_otp_layout.dart';

class TwoFaOtpLoginVerifyScreen extends GetView<TwoFaOtpLoginVerifyController> {
  const TwoFaOtpLoginVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return VerifyOtpLayout(
      appBarTitle: controller.args.phoneNumberMask != null ? 'Verify your phone number'.tr : 'Verify your email'.tr,
      description: 'We’ve send an OTP to\n@value\nfor verify your identity'.trParams(
        {
          'value': controller.args.phoneNumberMask ?? controller.args.emailMask ?? '',
        },
      ),
      refNo: controller.ref,
      isResendButtonEnable: controller.isResendButtonEnable,
      otpFocusNode: controller.otpFocusNode,
      otpTextController: controller.otpTextController,
      verify: controller.verifyOtpCode,
      requestOtp: controller.handleOtpRequest,
      handleOTPChange: controller.handleOTPChange,
      errorController: controller.errorController,
      errorMessage: controller.errorMessages,
      count: controller.start,
    );
  }
}
