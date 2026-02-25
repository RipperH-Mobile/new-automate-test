import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/setting_acoount_otp/setting_account_otp_verify_controller.dart';
import 'package:uchat/features/auth/presentation/views/widgets/verify_otp_layout.dart';
import 'package:uchat/utils/extension/extension.dart';

class SettingAccountOtpVerifyScreen extends GetView<SettingAccountOtpVerifyController> {
  const SettingAccountOtpVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return VerifyOtpLayout(
      appBarTitle: controller.title,
      description: 'We’ve send an OTP to\n@value\nfor verify your identity'.trParams(
        {
          'value': controller.args.phoneNumber != null
              ? '${controller.args.phoneNumber!.maskPhoneNumber()} '
              : '${controller.args.email}',
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
