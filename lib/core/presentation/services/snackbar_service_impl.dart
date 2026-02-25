import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart' as html;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/domain/services/snackbar_service.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/utils/timeago/timeago.dart';
import 'package:uchat/widgets/avatar/avatar.dart';

import '../../infrastructure/notification/common/notification_entity.dart';

class SnackbarServiceImpl implements SnackbarService {
  @override
  SnackbarController showNotification({
    required NotificationEntity notification,
    OnTap? onTap,
    void Function()? onShow,
  }) {
    final timestampFormated = formatInAppNotificationTimestamp(
      timestamp: notification.notifiedAt.timestamp,
      locale: Get.locale?.languageCode ?? 'en',
    );

    if (onShow != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onShow();
      });
    }

    return Get.snackbar(
      '',
      '',
      titleText: Row(
        children: [
          Expanded(
            child: Text(
              notification.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            timestampFormated,
            style: UTheme.textTheme.chatMessagePopupMenu.copyWith(
              color: UTheme.color.textLighter,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      messageText: html.Html(
        data: notification.body,
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
      icon: notification.avatarUrl != null
          ? Padding(
              padding: EdgeInsets.only(left: 2.spMin),
              child: Avatar(
                url: notification.avatarUrl,
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
}
