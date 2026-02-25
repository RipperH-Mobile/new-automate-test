import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';

class VerifyOtpLayout extends StatelessWidget {
  const VerifyOtpLayout({
    super.key,
    required this.appBarTitle,
    required this.description,
    required this.refNo,
    required this.errorMessage,
    required this.isResendButtonEnable,
    required this.otpFocusNode,
    required this.otpTextController,
    required this.verify,
    required this.requestOtp,
    required this.handleOTPChange,
    required this.errorController,
    required this.count,
  });

  final String appBarTitle;
  final String description;
  final RxString refNo;
  final RxnString errorMessage;
  final RxBool isResendButtonEnable;
  final FocusNode otpFocusNode;
  final TextEditingController otpTextController;
  final void Function() verify;
  final void Function() requestOtp;
  final void Function(String value) handleOTPChange;
  final StreamController<ErrorAnimationType> errorController;
  final RxInt count;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: appBarTitle,
        leadingButton: AppControlButton.back(
          context: context,
        ),
      ),
      body: GestureDetector(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: AppSpace.space8,
            right: AppSpace.space8,
            top: AppSpace.space6,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText.heading4(
                'Enter OTP code'.tr,
                context: context,
              ),
              const SizedBox(
                height: AppSpace.space2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpace.space2,
                ),
                child: AppText.body3(
                  description,
                  context: context,
                  color: context.theme.appColors.textLighter,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: AppSpace.space6,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpace.space4,
                  vertical: AppSpace.space1,
                ),
                decoration: BoxDecoration(
                  color: context.theme.appColors.backgroundNeutralLight,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppRadius.roundedFull),
                  ),
                ),
                child: Obx(
                  () => AppText.caption1Bold(
                    'Ref: @refCode'.trParams(
                      {
                        'refCode': refNo.value,
                      },
                    ),
                    context: context,
                    color: context.theme.appColors.textLight,
                  ),
                ),
              ),
              const SizedBox(
                height: AppSpace.space6,
              ),
              _PinCode(
                otpFocusNode: otpFocusNode,
                otpTextController: otpTextController,
                verify: verify,
                handleOTPChange: handleOTPChange,
                errorController: errorController,
              ),
              Obx(
                () {
                  if (errorMessage.value != null) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: AppSpace.space6,
                      ),
                      child: AppText.body3(
                        errorMessage.value!,
                        context: context,
                        textAlign: TextAlign.center,
                        color: context.theme.appColors.textError,
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(
                height: AppSpace.space24,
              ),
              AppText.body3(
                'If you didn’t receive an OTP code'.tr,
                context: context,
                color: context.theme.appColors.textLight,
              ),
              const SizedBox(
                height: AppSpace.space2,
              ),
              Obx(
                () {
                  if (isResendButtonEnable.value) {
                    return _buildResendCodeButton(context);
                  }
                  return _timerCountdownShow(context);
                },
              ),
            ],
          ),
        ),
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
    );
  }

  Widget _timerCountdownShow(BuildContext context) {
    return Obx(
      () => Text.rich(
        TextSpan(
          text: 'You can request a new OTP code in '.tr,
          style: context.theme.appTexts.body3,
          children: [
            TextSpan(
              text: ' @second seconds'.trParams(
                {
                  'second': count.value.toString(),
                },
              ),
              style: context.theme.appTexts.body3Bold,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildResendCodeButton(BuildContext context) {
    return GestureDetector(
      onTap: requestOtp,
      child: AppText.body3Bold(
        'Request OTP code'.tr,
        context: context,
        color: context.theme.appColors.textPrimary,
      ),
    );
  }
}

class _PinCode extends StatelessWidget {
  const _PinCode({
    required this.otpFocusNode,
    required this.otpTextController,
    required this.verify,
    required this.handleOTPChange,
    required this.errorController,
  });

  final FocusNode otpFocusNode;
  final TextEditingController otpTextController;
  final void Function() verify;
  final void Function(String value) handleOTPChange;
  final StreamController<ErrorAnimationType> errorController;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      hintCharacter: '0',
      hintStyle: context.theme.appTexts.heading3.copyWith(
        color: context.theme.appColors.textDisable,
      ),
      textStyle: context.theme.appTexts.heading3,
      autoFocus: true,
      focusNode: otpFocusNode,
      length: 6,
      obscureText: false,
      cursorColor: context.theme.appColors.textDarkest,
      pinTheme: PinTheme(
        fieldHeight: AppSize.size16,
        fieldWidth: AppSize.size12,
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(AppRadius.roundedXl),
        borderWidth: 1,
        inactiveBorderWidth: 1,
        activeBorderWidth: 1,
        selectedBorderWidth: 1,
        disabledBorderWidth: 1,
        errorBorderWidth: 1,
        inactiveFillColor: context.theme.appColors.backgroundNeutralLightest,
        selectedFillColor: context.theme.appColors.backgroundNeutralLightest,
        activeFillColor: context.theme.appColors.backgroundNeutralLightest,
        inactiveColor: context.theme.appColors.borderDark,
        activeColor: context.theme.appColors.borderDark,
        selectedColor: context.theme.appColors.borderSelected,
        errorBorderColor: context.theme.appColors.borderError,
      ),
      keyboardType: TextInputType.number,
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      controller: otpTextController,
      animationType: AnimationType.fade,
      onCompleted: (v) => verify(),
      onChanged: handleOTPChange,
      autoDisposeControllers: false,
      errorAnimationController: errorController,
      errorAnimationDuration: 300,
      errorTextSpace: 0,
      beforeTextPaste: (text) {
        return true;
      },
    );
  }
}
