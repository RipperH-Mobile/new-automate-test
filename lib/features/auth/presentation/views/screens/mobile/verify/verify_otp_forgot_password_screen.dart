import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/verify_otp/verify_otp_forgot_password_controller.dart';
import 'package:uchat/features/auth/presentation/views/widgets/verify_otp_layout.dart';

class VerifyOtpForgotPasswordScreen extends GetView<VerifyOtpForgotPasswordController> {
  const VerifyOtpForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return VerifyOtpLayout(
      appBarTitle: 'Forgot password'.tr,
      description: 'We’ve send an OTP to @value for verify your identity'.trParams(
        {
          'value': controller.args.phoneNumberDisplay ?? '',
        },
      ),
      refNo: controller.ref,
      isResendButtonEnable: controller.isResendButtonEnable,
      otpFocusNode: controller.otpFocusNode,
      otpTextController: controller.otpTextController,
      verify: controller.verifyOtpCode,
      requestOtp: controller.sendOtpRequest,
      handleOTPChange: controller.handleOTPChange,
      errorController: controller.errorController,
      errorMessage: controller.errorMessages,
      count: controller.start,
    );
  }
}
