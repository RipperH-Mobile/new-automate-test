import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uchat/themes/util.dart';

class MessagePopupMenuItem extends StatelessWidget {
  final String title;
  final double? titleFontSize;
  final String? iconPath;
  final Widget? icon;
  final VoidCallback onPressed;

  const MessagePopupMenuItem({
    super.key,
    required this.title,
    this.titleFontSize,
    this.iconPath,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            icon!
          else if (iconPath != null)
            Image.asset(
              iconPath!,
              width: 15.spMin,
              height: 15.spMin,
              color: Colors.white,
              cacheWidth: 90.spMin.toInt(),
            ),
          Padding(
            padding: EdgeInsets.only(top: 4.spMin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: UTheme.textTheme.chatPlatformPopupMenu.copyWith(
                    color: Colors.white,
                    fontSize: titleFontSize ?? 11,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
