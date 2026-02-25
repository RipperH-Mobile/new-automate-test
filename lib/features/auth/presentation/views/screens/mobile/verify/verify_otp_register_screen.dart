import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/verify_otp/verify_otp_register_controller.dart';
import 'package:uchat/features/auth/presentation/views/widgets/verify_otp_layout.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';

class VerifyOtpRegisterScreen extends GetView<VerifyOtpRegisterController> {
  const VerifyOtpRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return VerifyOtpLayout(
      appBarTitle: 'Verify your phone number'.tr,
      description: 'We’ve send an OTP to @value for verify your identity'.trParams(
        {
          'value': controller.args.phone != null
              ? AuthenticationHelper.getCensoredPhoneNumberAndCountryWithXAlphabet(
                  phoneNumber: controller.args.phone!,
                  countryCode: controller.args.countryCode,
                )
              : controller.args.email ?? '',
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
