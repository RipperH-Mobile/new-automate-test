import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final double? lineHeight;
  final StrutStyle? strutStyle;
  final bool isAutoSizeText;

  const AppText._internal(
    this.text, {
    super.key,
    this.textStyle,
    this.color,
    this.textAlign,
    this.textOverflow,
    this.maxLines,
    this.lineHeight,
    this.strutStyle,
    this.isAutoSizeText = false,
  });

  factory AppText.heading1(
    String text, {
    required BuildContext context,
    Key? key,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
    double? lineHeight,
    StrutStyle? strutStyle,
    bool? isAutoSizeText,
  }) =>
      AppText._internal(
        text,
        key: key,
        textStyle: context.theme.appTexts.heading1,
        color: color,
        textAlign: textAlign ?? TextAlign.start,
        textOverflow: textOverflow,
        maxLines: maxLines,
        lineHeight: lineHeight,
        strutStyle: strutStyle,
        isAutoSizeText: isAutoSizeText ?? false,
      );

  factory AppText.heading2(
    String text, {
    required BuildContext context,
    Key? key,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
    double? lineHeight,
    StrutStyle? strutStyle,
    bool? isAutoSizeText,
  }) =>
      AppText._internal(
        text,
        key: key,
        textStyle: context.theme.appTexts.heading2,
        color: color,
        textAlign: textAlign ?? TextAlign.start,
        textOverflow: textOverflow,
        maxLines: maxLines,
        lineHeight: lineHeight,
        strutStyle: strutStyle,
        isAutoSizeText: isAutoSizeText ?? false,
      );

  factory AppText.heading3(
    String text, {
    required BuildContext context,
    Key? key,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
    double? lineHeight,
    StrutStyle? strutStyle,
    bool? isAutoSizeText,
  }) =>
      AppText._internal(
        text,
        key: key,
        textStyle: context.theme.appTexts.heading3,
        color: color,
        textAlign: textAlign ?? TextAlign.start,
        textOverflow: textOverflow,
        maxLines: maxLines,
        lineHeight: lineHeight,
        strutStyle: strutStyle,
        isAutoSizeText: isAutoSizeText ?? false,
      );

  factory AppText.heading4(
    String text, {
    required BuildContext context,
    Key? key,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
    double? lineHeight,
    StrutStyle? strutStyle,
    bool? isAutoSizeText,
  }) =>
      AppText._internal(
        text,
        key: key,
        textStyle: context.theme.appTexts.heading4,
        color: color,
        textAlign: textAlign ?? TextAlign.start,
        textOverflow: textOverflow,
        maxLines: maxLines,
        lineHeight: lineHeight,
        strutStyle: strutStyle,
        isAutoSizeText: isAutoSizeText ?? false,
      );

  factory AppText.title1(
    String text, {
    required BuildContext context,
    Key? key,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
    double? lineHeight,
    StrutStyle? strutStyle,
    bool? isAutoSizeText,
  }) =>
      AppText._internal(
        text,
        key: key,
        textStyle: context.theme.appTexts.title1,
        color: color,
        textAlign: textAlign ?? TextAlign.start,
        textOverflow: textOverflow,
        maxLines: maxLines,
        lineHeight: lineHeight,
        strutStyle: strutStyle,
        isAutoSizeText: isAutoSizeText ?? false,
      );

  factory AppText.title2(
    String text, {
    required BuildContext context,
    Key? key,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
    double? lineHeight,
    StrutStyle? strutStyle,
    bool? isAutoSizeText,
  }) =>
      AppText._internal(
        text,
        key: key,
        textStyle: context.theme.appTexts.title2,
        color: color,
        textAlign: textAlign ?? TextAlign.start,
        textOverflow: textOverflow,
        maxLines: maxLines,
        lineHeight: lineHeight,
        strutStyle: strutStyle,
        isAutoSizeText: isAutoSizeText ?? false,
      );

  factory AppText.title3(
    String text, {
    required BuildContext context,
    Key? key,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
    double? lineHeight,
    StrutStyle? strutStyle,
    bool? isAutoSizeText,
  }) =>
      AppText._internal(
        text,
        key: key,
        textStyle: context.theme.appTexts.title3,
        color: color,
        textAlign: textAlign ?? TextAlign.start,
        textOverflow: textOverflow,
        maxLines: maxLines,
        lineHeight: lineHeight,
        strutStyle: strutStyle,
        isAutoSizeText: isAutoSizeText ?? false,
      );

  factory AppText.subtitle1(
    String text, {
    required BuildContext context,
    Key? key,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
    double? lineHeight,
    StrutStyle? strutStyle,
    bool? isAutoSizeText,
  }) =>
      AppText._internal(
        text,
        key: key,
        textStyle: context.theme.appTexts.subtitle1,
        color: color,
        textAlign: textAlign ?? TextAlign.start,
        textOverflow: textOverflow,
        maxLines: maxLines,
        lineHeight: lineHeight,
        strutStyle: strutStyle,
        isAutoSizeText: isAutoSizeText ?? false,
      );

  factory AppText.body1(
    String text, {
    required BuildContext context,
    Key? key,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
    double? lineHeight,
    StrutStyle? strutStyle,
    bool? isAutoSizeText,
  }) =>
      AppText._internal(
        text,
        key: key,
        textStyle: context.theme.appTexts.body1,
        color: color,
        textAlign: textAlign ?? TextAlign.start,
        textOverflow: textOverflow,
        maxLines: maxLines,
        lineHeight: lineHeight,
        strutStyle: strutStyle,
        isAutoSizeText: isAutoSizeText ?? false,
      );

  factory AppText.body1Bold(
    String text, {
    required BuildContext context,
    Key? key,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
    double? lineHeight,
    StrutStyle? strutStyle,
    bool? isAutoSizeText,
  }) =>
      AppText._internal(
        text,
        key: key,
        textStyle: context.theme.appTexts.body1Bold,
        color: color,
        textAlign: textAlign ?? TextAlign.start,
        textOverflow: textOverflow,
        maxLines: maxLines,
        lineHeight: lineHeight,
        strutStyle: strutStyle,
        isAutoSizeText: isAutoSizeText ?? false,
      );

  factory AppText.body2(
    String text, {
    required BuildContext context,
    Key? key,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
    double? lineHeight,
    StrutStyle? strutStyle,
    bool? isAutoSizeText,
  }) =>
      AppText._internal(
        text,
        key: key,
        textStyle: context.theme.appTexts.body2,
        color: color,
        textAlign: textAlign ?? TextAlign.start,
        textOverflow: textOverflow,
        maxLines: maxLines,
        lineHeight: lineHeight,
        strutStyle: strutStyle,
        isAutoSizeText: isAutoSizeText ?? false,
      );

  factory AppText.body2Bold(
    String text, {
    required BuildContext context,
    Key? key,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
    double? lineHeight,
    StrutStyle? strutStyle,
    bool? isAutoSizeText,
  }) =>
      AppText._internal(
        text,
        key: key,
        textStyle: context.theme.appTexts.body2Bold,
        color: color,
        textAlign: textAlign ?? TextAlign.start,
        textOverflow: textOverflow,
        maxLines: maxLines,
        lineHeight: lineHeight,
        strutStyle: strutStyle,
        isAutoSizeText: isAutoSizeText ?? false,
      );

  factory AppText.body3(
    String text, {
    required BuildContext context,
    Key? key,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
    double? lineHeight,
    StrutStyle? strutStyle,
    bool? useAutoSizeText,
  }) =>
      AppText._internal(
        text,
        key: key,
        textStyle: context.theme.appTexts.body3,
        color: color,
        textAlign: textAlign ?? TextAlign.start,
        textOverflow: textOverflow,
        maxLines: maxLines,
        lineHeight: lineHeight,
        strutStyle: strutStyle,
        isAutoSizeText: useAutoSizeText ?? false,
      );

  factory AppText.body3Bold(
    String text, {
    required BuildContext context,
    Key? key,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
    double? lineHeight,
    StrutStyle? strutStyle,
    bool? isAutoSizeText,
  }) =>
      AppText._internal(
        text,
        key: key,
        textStyle: context.theme.appTexts.body3Bold,
        color: color,
        textAlign: textAlign ?? TextAlign.start,
        textOverflow: textOverflow,
        maxLines: maxLines,
        lineHeight: lineHeight,
        strutStyle: strutStyle,
        isAutoSizeText: isAutoSizeText ?? false,
      );

  factory AppText.body4(
    String text, {
    required BuildContext context,
    Key? key,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
    double? lineHeight,
    StrutStyle? strutStyle,
    bool? isAutoSizeText,
  }) =>
      AppText._internal(
        text,
        key: key,
        textStyle: context.theme.appTexts.body4,
        color: color,
        textAlign: textAlign ?? TextAlign.start,
        textOverflow: textOverflow,
        maxLines: maxLines,
        lineHeight: lineHeight,
        strutStyle: strutStyle,
        isAutoSizeText: isAutoSizeText ?? false,
      );

  factory AppText.body4Bold(
    String text, {
    required BuildContext context,
    Key? key,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
    double? lineHeight,
    StrutStyle? strutStyle,
    bool? isAutoSizeText,
  }) =>
      AppText._internal(
        text,
        key: key,
        textStyle: context.theme.appTexts.body4Bold,
        color: color,
        textAlign: textAlign ?? TextAlign.start,
        textOverflow: textOverflow,
        maxLines: maxLines,
        lineHeight: lineHeight,
        strutStyle: strutStyle,
        isAutoSizeText: isAutoSizeText ?? false,
      );

  factory AppText.caption1(
    String text, {
    required BuildContext context,
    Key? key,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
    double? lineHeight,
    StrutStyle? strutStyle,
    bool? isAutoSizeText,
  }) =>
      AppText._internal(
        text,
        key: key,
        textStyle: context.theme.appTexts.caption1,
        color: color,
        textAlign: textAlign ?? TextAlign.start,
        textOverflow: textOverflow,
        maxLines: maxLines,
        lineHeight: lineHeight,
        strutStyle: strutStyle,
        isAutoSizeText: isAutoSizeText ?? false,
      );

  factory AppText.caption1Bold(
    String text, {
    required BuildContext context,
    Key? key,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
    double? lineHeight,
    StrutStyle? strutStyle,
    bool? isAutoSizeText,
  }) =>
      AppText._internal(
        text,
        key: key,
        textStyle: context.theme.appTexts.caption1Bold,
        color: color,
        textAlign: textAlign ?? TextAlign.start,
        textOverflow: textOverflow,
        maxLines: maxLines,
        lineHeight: lineHeight,
        strutStyle: strutStyle,
        isAutoSizeText: isAutoSizeText ?? false,
      );

  factory AppText.caption2(
    String text, {
    required BuildContext context,
    Key? key,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
    double? lineHeight,
    StrutStyle? strutStyle,
    bool? isAutoSizeText,
  }) =>
      AppText._internal(
        text,
        key: key,
        textStyle: context.theme.appTexts.caption2,
        color: color,
        textAlign: textAlign ?? TextAlign.start,
        textOverflow: textOverflow,
        maxLines: maxLines,
        lineHeight: lineHeight,
        strutStyle: strutStyle,
        isAutoSizeText: isAutoSizeText ?? false,
      );

  factory AppText.caption2Bold(
    String text, {
    required BuildContext context,
    Key? key,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
    double? lineHeight,
    StrutStyle? strutStyle,
    bool? isAutoSizeText,
  }) =>
      AppText._internal(
        text,
        key: key,
        textStyle: context.theme.appTexts.caption2Bold,
        color: color,
        textAlign: textAlign ?? TextAlign.start,
        textOverflow: textOverflow,
        maxLines: maxLines,
        lineHeight: lineHeight,
        strutStyle: strutStyle,
        isAutoSizeText: isAutoSizeText ?? false,
      );

  factory AppText.button1(
    String text, {
    required BuildContext context,
    Key? key,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
    double? lineHeight,
    StrutStyle? strutStyle,
    bool? isAutoSizeText,
  }) =>
      AppText._internal(
        text,
        key: key,
        textStyle: context.theme.appTexts.button1,
        color: color,
        textAlign: textAlign ?? TextAlign.start,
        textOverflow: textOverflow,
        maxLines: maxLines,
        lineHeight: lineHeight,
        strutStyle: strutStyle,
        isAutoSizeText: isAutoSizeText ?? false,
      );

  factory AppText.button1Bold(
    String text, {
    required BuildContext context,
    Key? key,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
    double? lineHeight,
    StrutStyle? strutStyle,
    bool? isAutoSizeText,
  }) =>
      AppText._internal(
        text,
        key: key,
        textStyle: context.theme.appTexts.button1Bold,
        color: color,
        textAlign: textAlign ?? TextAlign.start,
        textOverflow: textOverflow,
        maxLines: maxLines,
        lineHeight: lineHeight,
        strutStyle: strutStyle,
        isAutoSizeText: isAutoSizeText ?? false,
      );

  factory AppText.button2(
    String text, {
    required BuildContext context,
    Key? key,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
    double? lineHeight,
    StrutStyle? strutStyle,
    bool? isAutoSizeText,
  }) =>
      AppText._internal(
        text,
        key: key,
        textStyle: context.theme.appTexts.button2,
        color: color,
        textAlign: textAlign ?? TextAlign.start,
        textOverflow: textOverflow,
        maxLines: maxLines,
        lineHeight: lineHeight,
        strutStyle: strutStyle,
        isAutoSizeText: isAutoSizeText ?? false,
      );

  factory AppText.button2Bold(
    String text, {
    required BuildContext context,
    Key? key,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
    double? lineHeight,
    StrutStyle? strutStyle,
    bool? isAutoSizeText,
  }) =>
      AppText._internal(
        text,
        key: key,
        textStyle: context.theme.appTexts.button2Bold,
        color: color,
        textAlign: textAlign ?? TextAlign.start,
        textOverflow: textOverflow,
        maxLines: maxLines,
        lineHeight: lineHeight,
        strutStyle: strutStyle,
        isAutoSizeText: isAutoSizeText ?? false,
      );

  @override
  Widget build(BuildContext context) {
    if (isAutoSizeText == true) {
      return AutoSizeText(
        text,
        textAlign: textAlign,
        overflow: textOverflow,
        style: textStyle?.copyWith(
          color: color ?? context.theme.appColors.textDarkest,
          height: lineHeight,
        ),
        maxLines: maxLines,
        strutStyle: strutStyle,
      );
    }

    return Text(
      text,
      textAlign: textAlign,
      overflow: textOverflow,
      style: textStyle?.copyWith(
        color: color ?? context.theme.appColors.textDarkest,
        height: lineHeight,
      ),
      maxLines: maxLines,
      strutStyle: strutStyle,
    );
  }
}
