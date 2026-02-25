import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets/row_menu/uchat_row_menu.dart';

bool get isMobile => UChatScreenUtil.instance.isMobile;

Widget recommendFolderWidget({
  void Function()? onPressed,
  String? title,
  String? subTitle,
  String? type,
  bool? showAddButton,
}) {
  return UChatRowMenu(
    height: isMobile ? 69.spMin : 60.spMin,
    enableHero: true,
    key: ValueKey<String>('recommendFolderWidget-$type'),
    title: title ?? '',
    titleTextStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color(0xFF333333),
    ),
    subTitle: subTitle,
    subTitleTopSpace: 3.spMin,
    subTitleTextStyle: const TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: Color(0xFF808080),
    ),
    showArrow: false,
    centerRightContent: true,
    suffixWidget: showAddButton == true
        ? ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color(0xFFE6EFFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.spMin),
              ),
            ),
            child: Text(
              'Add'.tr,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: UTheme.color.primary,
              ),
            ),
          )
        : null,
    hasBottomBorder: true,
  );
}
