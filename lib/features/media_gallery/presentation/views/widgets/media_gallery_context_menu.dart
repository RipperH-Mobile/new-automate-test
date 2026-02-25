import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/app_text.dart';

class MediaGalleryContextMenu extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Widget tailing;
  final bool isWarningMenu;
  final BuildContext parentContext;

  const MediaGalleryContextMenu({
    super.key,
    required this.text,
    required this.tailing,
    this.onTap,
    this.isWarningMenu = false,
    required this.parentContext,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap?.call();
        } else {
          Get.back();
        }
      },
      child: Container(
        color: parentContext.theme.appColors.backgroundNeutralLightest,
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText.body3(
              text,
              color:
                  !isWarningMenu ? parentContext.theme.appColors.textDarkest : parentContext.theme.appColors.textError,
              context: context,
              textAlign: TextAlign.start,
            ),
            AppSpace.space3.horizontalSpace,
            tailing,
          ],
        ),
      ),
    );
  }
}
