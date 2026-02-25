import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/utils/dimensions.dart';
import 'package:uchat/utils/extension/extension_number.dart';

class CalendarDatePickerWidget extends StatelessWidget {
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final bool autofocus;
  final bool isValid;
  final String txtLabel;
  final String invalidText;
  final bool? enableTextField;
  final bool? isHasCounter;
  final bool? requiredMark;
  final TextStyle? titleTextStyle;
  final TextStyle? requiredMarkStyle;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final EdgeInsets? padding;
  final EdgeInsets? titlePadding;
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

  CalendarDatePickerWidget({
    super.key,
    this.hintStyle,
    this.textStyle,
    this.autofocus = false,
    this.isValid = true,
    this.txtLabel = '',
    this.invalidText = '',
    this.enableTextField,
    this.isHasCounter,
    this.requiredMark,
    this.titleTextStyle,
    this.requiredMarkStyle,
    this.validator,
    this.suffixIcon,
    this.hintText,
    this.padding,
    this.titlePadding,
  });

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final text = hintText ?? '';

    return Padding(
      padding: padding ??
          EdgeInsets.only(
            top: 20.spMin,
            left: 15.spMin,
            right: 15.spMin,
          ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.hr),
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
                          style: titleTextStyle ??
                              const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      Visibility(
                        visible: requiredMark ?? false,
                        child: Text(
                          '*',
                          style: requiredMarkStyle ??
                              const TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 55.hr,
            width: Get.width,
            padding: EdgeInsets.only(left: 13.spMin, right: 8.spMin),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              border: Border.all(
                width: 1.hr,
                color: const Color(0xffe6e6e6),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: text != 'DD/MM/YYYY' ? Colors.black : UTheme.color.pageSubtitle,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Image.asset(
                  'assets/images/calendar.png',
                  color: Colors.grey.shade300,
                  height: 35.spMin,
                  width: 35.spMin,
                  cacheWidth: 60.cacheSize,
                ),
              ],
            ),
          ),
          if (!isValid)
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                invalidText,
                style: const TextStyle(
                  color: Color(0xffFF1552),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
