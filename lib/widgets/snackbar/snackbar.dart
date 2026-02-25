import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart' as html;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_text_parse_mention.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/widgets.dart';

void showGeneralSnackBar(String message, {String? title, Icon? icon}) {
  Get.snackbar(
    title ?? 'UChat',
    '',
    messageText: MentionTextParse(message: message),
    icon: icon,
    shouldIconPulse: true,
    isDismissible: true,
    colorText: UTheme.color.onPrimary,
    backgroundColor: UTheme.color.primary,
    duration: const Duration(seconds: 5),
  );
}

void showNotificationSnackBar({
  required String message,
  required String timestampMessage,
  String? title,
  String? avatarUrl,
  OnTap? onTap,
}) {
  String notificationTitle = title ?? 'UChat';
  Get.snackbar(
    '',
    '',
    titleText: Row(
      children: [
        Expanded(
          child: Text(
            notificationTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          timestampMessage,
          style: UTheme.textTheme.chatMessagePopupMenu.copyWith(
            color: UTheme.color.textLighter,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
    messageText: html.Html(
      data: message,
      style: {
        'body': html.Style(
          margin: html.Margins.zero,
          padding: html.HtmlPaddings.zero,
          maxLines: 2,
          textOverflow: TextOverflow.ellipsis,
          fontSize: html.FontSize(13),
          fontWeight: FontWeight.w400,
          color: UTheme.color.textDarkest,
        ),
      },
    ),
    padding: EdgeInsets.only(left: 25.spMin, right: 25.spMin, top: 15.spMin, bottom: 15.spMin),
    icon: avatarUrl != null
        ? Padding(
            padding: EdgeInsets.only(left: 2.spMin),
            child: Avatar(
              url: avatarUrl,
              radius: 20,
            ),
          )
        : Padding(
            padding: EdgeInsets.only(left: 2.spMin),
            child: Avatar(
              image: const AssetImage('assets/images/uchat_noti_icon.png'),
              radius: 20,
            ),
          ),
    shouldIconPulse: true,
    isDismissible: true,
    colorText: UTheme.color.textNotification,
    backgroundColor: UTheme.color.bgNotification,
    borderColor: UTheme.color.borderNotification,
    borderWidth: 1,
    boxShadows: const [
      BoxShadow(
        color: Color.fromRGBO(17, 17, 26, 0.1),
        blurRadius: 0,
        spreadRadius: 0,
        offset: Offset(0, 1),
      ),
      BoxShadow(
        color: Color.fromRGBO(17, 17, 26, 0.1),
        blurRadius: 24,
        spreadRadius: 0,
        offset: Offset(0, 8),
      ),
      BoxShadow(
        color: Color.fromRGBO(17, 17, 26, 0.1),
        blurRadius: 48,
        spreadRadius: 0,
        offset: Offset(0, 16),
      ),
    ],
    duration: const Duration(seconds: 5),
    animationDuration: const Duration(milliseconds: 500),
    barBlur: 5,
    onTap: onTap,
    margin: EdgeInsets.only(top: 10.spMin, left: 10.spMin, right: 10.spMin),
  );
}

void showGradientBorderSnackbar({
  required String title,
  Color? bgColor,
  Color? gradientStartColor,
  Color? gradientEndColor,
  Alignment? alignmentBegin,
  Alignment? alignmentEnd,
  Widget? prefixIcon,
  TextStyle? textStyle,
  Duration? duration,
  SnackPosition? snackPosition,
  EdgeInsets? margin,
  EdgeInsets? padding,
  double? height,
  double? width,
}) {
  Get.showSnackbar(GetSnackBar(
    backgroundColor: bgColor ?? Colors.white,
    messageText: CustomPaint(
      painter: GradientBorderPainter(
        gradient: LinearGradient(
          colors: [
            gradientStartColor ?? const Color(0xFF00FFA3), // Start color
            gradientEndColor ?? const Color(0xFF3EC300), // End color
          ],
          begin: alignmentBegin ?? Alignment.centerLeft,
          end: alignmentEnd ?? Alignment.centerRight,
        ),
      ),
      child: SizedBox(
        height: height ?? 74.spMin,
        width: width ?? 390.spMin,
        child: Center(
          child: Row(
            children: [
              SizedBox(width: 17.w),
              prefixIcon ??
                  Image.asset(
                    'assets/images/v2/setup_password_success.png',
                    width: 46.spMin,
                    height: 46.spMin,
                  ),
              SizedBox(width: 14.w),
              Text(
                title,
                style: textStyle ??
                    TextStyle(
                      color: const Color(0xFF333333),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ),
    ),
    duration: duration ?? const Duration(seconds: 3),
    snackPosition: snackPosition ?? SnackPosition.TOP,
    margin: margin ?? const EdgeInsets.all(10),
    padding: padding ?? const EdgeInsets.all(0),
  ));
}

void showUpdateBookmarkSnackbar({
  required String title,
  Color? bgColor,
  Color? gradientStartColor,
  Color? gradientEndColor,
  Alignment? alignmentBegin,
  Alignment? alignmentEnd,
  Widget? prefixIcon,
  TextStyle? textStyle,
  Duration? duration,
  SnackPosition? snackPosition,
  EdgeInsets? margin,
  EdgeInsets? padding,
  double? height,
  double? width,
  double? maxWidth,
  void Function()? onPressed,
}) {
  Get.showSnackbar(
    GetSnackBar(
      backgroundColor: Colors.transparent,
      duration: duration ?? const Duration(seconds: 3),
      margin: margin ?? EdgeInsets.only(top: 10.spMin, left: 10.spMin, right: 10.spMin, bottom: 75.spMin),
      padding: padding ?? EdgeInsets.zero,
      maxWidth: maxWidth,
      snackPosition: snackPosition ?? SnackPosition.BOTTOM,
      messageText: Container(
        height: height ?? 61.spMin,
        width: width ?? 395.spMin,
        padding: EdgeInsets.only(left: 17.spMin, right: 8.spMin),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.spMin),
          color: bgColor ?? Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  prefixIcon ??
                      Image.asset(
                        'assets/images/bookmark_icon.png',
                        width: 16.spMin,
                        height: 20.spMin,
                        color: UTheme.color.primary,
                      ),
                  SizedBox(width: 14.spMin),
                  Text(
                    title,
                    style: textStyle ??
                        TextStyle(
                          color: const Color(0xFF333333),
                          fontSize: 13.spMin,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  onPressed?.call();
                  Get.back();
                },
                child: Text(
                  'View'.tr,
                  style: TextStyle(
                    fontSize: 13.spMin,
                    fontWeight: FontWeight.w500,
                    color: UTheme.color.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
