import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/verify_otp/verify_otp_link_email_controller.dart';
import 'package:uchat/features/auth/presentation/views/widgets/verify_otp_layout.dart';

class VerifyOtpLinkEmailScreen extends GetView<VerifyOtpLinkEmailController> {
  const VerifyOtpLinkEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return VerifyOtpLayout(
      appBarTitle: 'Verify email'.tr,
      description: 'We’ve send an OTP to @value for verify your identity'.trParams(
        {
          'value': controller.args.linkAccountModel.email,
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
