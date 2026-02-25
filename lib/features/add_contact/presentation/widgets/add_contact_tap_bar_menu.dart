import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';

class AddContactTapBarMenu extends StatelessWidget {
  final String title;
  final bool isShowRedDot;

  const AddContactTapBarMenu({
    super.key,
    required this.title,
    this.isShowRedDot = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.theme.appTexts.title3),
        AppSpace.space1.horizontalSpace,
        Container(
          height: 6.spMin,
          width: 6.spMin,
          decoration: BoxDecoration(
            color: isShowRedDot ? context.theme.appColors.backgroundError : null,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
