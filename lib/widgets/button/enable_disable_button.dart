import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/themes/themes.dart';

class EnableDisableButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? buttonText;
  final Color? buttonColor;
  final TextStyle? textStyle;
  final Color? textColor;
  final bool isContinueButton;
  final bool isEnable;

  const EnableDisableButton({
    this.onPressed,
    this.buttonText,
    this.buttonColor,
    this.textStyle,
    this.textColor,
    this.isContinueButton = true,
    this.isEnable = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.spMin,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 20.spMin),
      child: TextButton(
        onPressed: isEnable ? onPressed : null,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12.spMin),
          backgroundColor: isEnable
              ? isContinueButton
                  ? UTheme.color.primary
                  : UTheme.color.redAccentButton
              : const Color(0xFFE6E6E6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.spMin),
          ),
        ),
        child: Text(
          buttonText ?? 'Continue'.tr,
          style: UTheme.textTheme.buttonLabel.copyWith(
            color: UTheme.color.onPrimary,
            // fontFamily: 'newUiFont',
          ),
        ),
      ),
    );
  }
}
