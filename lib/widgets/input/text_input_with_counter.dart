import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/dimensions.dart';
import 'package:uchat/widgets/input/app_text_field.dart';

class TextInputWithCounter extends StatelessWidget {
  final int? currentTextLength;
  final int? maxLength;
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String value)? onChange;
  final List<TextInputFormatter>? inputFormatters;
  final bool showCounter;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? titlePadding;
  final Color? fillColor;
  final bool? filled;
  final Color? counterStyle;
  final OutlineInputBorder? border;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final bool autofocus;
  final bool isShowUChatIdValidInfo;
  final String txtLabel;
  final String invalidText;
  final bool? enableTextField;
  final bool? isHasCounter;
  final bool? requiredMark;
  final TextStyle? titleTextStyle;
  final TextStyle? requiredMarkStyle;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool isShowCounter;
  final double? fontSizeCounter;
  final bool isHaveSpace;
  final bool readOnly;
  final void Function()? onTap;
  final double? txtLabelSize;

  final Color? colorUChatValidInfo;
  final Color? borderColorUChatValidInfo;
  final OutlineInputBorder inValidBorderStyle = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xffFF1552),
      width: 2,
    ),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );

  final OutlineInputBorder inputBorderStyle = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(
      width: 0,
      style: BorderStyle.none,
    ),
  );

  TextInputWithCounter({
    super.key,
    this.currentTextLength,
    this.maxLength,
    this.hintText,
    this.controller,
    this.focusNode,
    this.onChange,
    this.inputFormatters,
    this.showCounter = true,
    this.padding,
    this.titlePadding,
    this.fillColor,
    this.filled,
    this.border,
    this.hintStyle,
    this.textStyle,
    this.autofocus = false,
    this.isShowUChatIdValidInfo = false,
    this.txtLabel = '',
    this.invalidText = '',
    this.counterStyle,
    this.enableTextField,
    this.isHasCounter,
    this.requiredMark,
    this.titleTextStyle,
    this.requiredMarkStyle,
    this.validator,
    this.suffixIcon,
    this.colorUChatValidInfo = const Color(0xffFF1552),
    this.borderColorUChatValidInfo = const Color(0xffFF1552),
    this.isShowCounter = true,
    this.fontSizeCounter,
    this.isHaveSpace = false,
    this.readOnly = false,
    this.onTap,
    this.txtLabelSize,
  });

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder? borderSelector;

    if (isShowUChatIdValidInfo) {
      borderSelector = inValidBorderStyle.copyWith(
        borderSide: BorderSide(
          color: borderColorUChatValidInfo ?? const Color(0xffFF1552),
          width: 2,
        ),
      );
    } else {
      borderSelector = border ?? inputBorderStyle;
    }

    return Padding(
      padding: padding ??
          const EdgeInsets.only(
            top: 20,
            left: 15,
            right: 15,
          ),
      child: Column(
        children: [
          if (isShowCounter)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: titlePadding ?? EdgeInsets.zero,
                          child: Text(
                            txtLabel.tr,
                            style: TextStyle(
                              fontSize: txtLabelSize ?? 16,
                              fontWeight: FontWeight.w600,
                              // fontFamily: 'newUiFont',
                            ),
                          ),
                        ),
                        Visibility(
                          visible: requiredMark ?? false,
                          child: Text(
                            '*',
                            style: requiredMarkStyle ??
                                TextStyle(
                                  color: Colors.red,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: isHasCounter ?? true,
                      child: Text(
                        maxLength.toString().isNotEmpty ? '$currentTextLength/$maxLength' : '',
                        style: TextStyle(
                          color: counterStyle ?? const Color(0xffB2B2B2),
                          fontSize: fontSizeCounter ?? 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Container(
            constraints: BoxConstraints(maxHeight: 65.hr),
            child: ClipRect(
              child: TextField(
                onTap: () {
                  if (onTap != null) {
                    onTap!();
                  }
                },
                readOnly: readOnly,
                enabled: enableTextField ?? true,
                buildCounter: (
                  context, {
                  required currentLength,
                  required isFocused,
                  maxLength,
                }) {
                  return Container(
                    transform: Matrix4.translationValues(0, -kToolbarHeight, 0),
                    child: const SizedBox(),
                  );
                },
                decoration: InputDecoration(
                  counterStyle: UTheme.textTheme.inputCounter.copyWith(
                    color: UTheme.color.inputCounter,
                  ),
                  enabledBorder: borderSelector,
                  focusedBorder: borderSelector,
                  fillColor: fillColor ?? Colors.white,
                  filled: filled ?? true,
                  hintText: hintText,
                  hintStyle: hintStyle,
                  suffixIcon: suffixIcon,
                  contentPadding: EdgeInsets.only(
                    // top: 20.hr,
                    left: 15.spMin,
                    right: 15.spMin,
                    // bottom: 15.wr,
                  ),
                ),
                maxLength: maxLength,
                controller: controller,
                focusNode: focusNode,
                onChanged: onChange,
                style: textStyle,
                autofocus: autofocus,
                inputFormatters: [
                  ThaiLengthLimitingTextInputFormatter(maxLength ?? 100),
                  ...?inputFormatters,
                ],
              ),
            ),
          ),
          if (isHaveSpace)
            SizedBox(
              height: 12.spMin,
            ),
          if (isShowUChatIdValidInfo)
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                invalidText,
                style: TextStyle(
                  color: colorUChatValidInfo,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
