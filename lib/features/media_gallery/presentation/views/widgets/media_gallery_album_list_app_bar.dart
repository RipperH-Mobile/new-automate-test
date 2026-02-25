import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/app_text.dart';

class MediaGalleryAlbumListAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showDragHandle;

  const MediaGalleryAlbumListAppBar({super.key, this.showDragHandle = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Bar of the box
          if (showDragHandle)
            Positioned(
              top: AppSpace.space2,
              child: Container(
                width: 48.spMin,
                height: 5.spMin,
                decoration: BoxDecoration(
                  color: context.theme.appColors.borderDisable,
                  borderRadius: BorderRadius.circular(AppRadius.roundedFull),
                ),
              ),
            ),

          // Close button
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () async {
                Get.back();
              },
              child: AppText.body1(
                'Close'.tr,
                context: context,
                color: context.theme.appColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(72);
}
