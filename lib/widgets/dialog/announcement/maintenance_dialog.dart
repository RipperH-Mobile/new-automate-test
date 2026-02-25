import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class MaintenanceDialog extends GetView<AnnouncementController> {
  final bool isAnnouncement;
  final String? maintenanceText;

  const MaintenanceDialog({
    super.key,
    required this.isAnnouncement,
    this.maintenanceText,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpace.space4),
                  child: SizedBox(
                    width: 100.spMin,
                    height: 100.spMin,
                    child: Assets.images.uchatLogoSplash.image(),
                  ),
                ),
                AppText.title3(
                  isAnnouncement ? 'Announcement for system maintenance'.tr : 'System under maintenance'.tr,
                  color: context.theme.appColors.textDarkest,
                  textAlign: TextAlign.center,
                  context: context,
                ),
                const SizedBox(height: AppSpace.space2),
                AppText.body3(
                  // Show text entered from Thanos if available, otherwise show default text
                  maintenanceText ?? 'We will temporarily close the system for maintenance. You can use the service after that time.'
                      .tr,
                  color: context.theme.appColors.textDark,
                  textAlign: TextAlign.center,
                  context: context,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpace.space6),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: context.theme.appColors.border,
                    width: AppSpace.spacePx,
                  ),
                ),
              ),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: AppSpace.space3),
              child: Center(
                child: AppText.button2Bold(
                  isAnnouncement == true ? 'Got it'.tr : 'Use offline mode'.tr,
                  color: context.theme.appColors.textPrimary,
                  context: context,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
