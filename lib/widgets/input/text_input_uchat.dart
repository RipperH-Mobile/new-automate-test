import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uchat/themes/themes.dart';

class TextInputUChat extends StatelessWidget {
  final int? maxLength;
  final int? currentTextLength;
  final bool autofocus;
  final bool obscureText;
  final bool enableTextField;
  final bool loading;
  final bool requiredMark;
  final double? hasLabelPadding;
  final double? hasDescriptionPadding;
  final FocusNode? focusNode;
  final void Function(String value)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final String? label;
  final String? description;
  final String? errorText;
  final String? hintText;
  final TextEditingController? controller;
  final TextStyle? titleTextStyle;
  final TextStyle? descriptionTextStyle;
  final Widget? suffixIcon;
  final Widget? error;
  final InputDecoration? textFieldDecoration;

  const TextInputUChat({
    super.key,
    this.maxLength,
    this.currentTextLength,
    this.autofocus = false,
    this.obscureText = false,
    this.enableTextField = true,
    this.loading = false,
    this.requiredMark = false,
    this.hasLabelPadding,
    this.hasDescriptionPadding,
    this.focusNode,
    this.onChanged,
    this.inputFormatters,
    this.label,
    this.description,
    this.errorText,
    this.hintText,
    this.controller,
    this.titleTextStyle,
    this.descriptionTextStyle,
    this.suffixIcon,
    this.error,
    this.textFieldDecoration,
  });

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.r)),
      borderSide: const BorderSide(
        width: 1,
        color: Color(0xffcccccc),
      ),
    );
    bool isError = (errorText ?? '').isNotEmpty || error != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: EdgeInsets.only(bottom: hasLabelPadding ?? 13.spMin),
            child: Row(
              children: [
                Text(
                  label!,
                  style: titleTextStyle ??
                      TextStyle(
                        color: const Color(0xFF666666),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                if (requiredMark)
                  Text(
                    '*',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                if (currentTextLength != null && maxLength != null) ...[
                  const Spacer(),
                  Text(
                    maxLength.toString().isNotEmpty ? '$currentTextLength/$maxLength' : '',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffB2B2B2),
                    ),
                  ),
                ]
              ],
            ),
          ),
        TextField(
          enabled: enableTextField,
          controller: controller,
          obscureText: obscureText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          decoration: textFieldDecoration ??
              InputDecoration(
                hintText: hintText,
                filled: true,
                fillColor: enableTextField ? UTheme.color.scaffoldInput : const Color(0xFFE6E6E6),
                focusedBorder: border.copyWith(
                  borderSide: BorderSide(
                    width: 1,
                    color: UTheme.color.primary,
                  ),
                ),
                enabledBorder: border,
                focusedErrorBorder: border.copyWith(
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.red,
                  ),
                ),
                errorBorder: enableTextField
                    ? border.copyWith(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.red,
                        ),
                      )
                    : border.copyWith(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Color(
                            0xFFE6E6E6,
                          ),
                        ),
                      ),
                error: isError ? const SizedBox.shrink() : null,
                errorStyle: const TextStyle(height: 0),
                contentPadding: EdgeInsets.fromLTRB(
                  20.spMin,
                  24.spMin,
                  20.spMin,
                  16.spMin,
                ),
                suffixIcon: Padding(
                  padding: EdgeInsetsDirectional.only(end: 20.spMin),
                  child: loading
                      ? SizedBox(
                          width: 20.spMin,
                          height: 20.spMin,
                          child: CircularProgressIndicator(
                            color: UTheme.color.primary,
                            strokeWidth: 2,
                          ),
                        )
                      : suffixIcon,
                ),
                suffixIconConstraints: BoxConstraints(maxHeight: 20.spMin),
                counterText: '',
              ),
          maxLength: maxLength,
          focusNode: focusNode,
          onChanged: onChanged,
          inputFormatters: inputFormatters,
          autofocus: autofocus,
        ),
        if (isError)
          Padding(
            padding: EdgeInsets.only(top: 14.spMin),
            child: error ??
                Text(
                  errorText!,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
          ),
        if (description != null && !isError)
          Padding(
            padding: EdgeInsets.only(top: hasDescriptionPadding ?? 14.spMin),
            child: Text(
              description!,
              style: descriptionTextStyle ??
                  const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF989898),
                  ),
            ),
          ),
      ],
    );
  }
}
