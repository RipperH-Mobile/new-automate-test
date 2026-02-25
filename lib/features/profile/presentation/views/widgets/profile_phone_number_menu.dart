import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/profile/presentation/controllers/profile_controller.dart';
import 'package:uchat/features/profile/presentation/views/widgets/corner_box_menu.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/dialog/hold_widget_with_menu.dart';
import 'package:uchat/widgets/menu_list/menu_list_item.dart';

class ProfilePhoneNumberMenu extends GetView<ProfileControllerV2> {
  const ProfilePhoneNumberMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        Widget child = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.body3(
              'Phone number'.tr,
              context: context,
            ),
            AppText.body1(
              controller.formattedPhoneNumber,
              context: context,
              color: context.theme.appColors.textPrimary,
            ),
          ],
        );
        return CornerBoxMenuItem(
          child: child,
          onLongPress: () {
            HoldWidgetWithMenu.show(
              CornerBoxMenu.singleItem(
                child: child,
              ),
              [
                MenuListItem(
                  text: 'UChat Voice Call'.tr,
                  suffixIcon: Assets.vectors.profileMenuCall.svg(
                    colorFilter: ColorFilter.mode(
                      context.theme.appColors.icon,
                      BlendMode.srcIn,
                    ),
                  ),
                  onTap: () {
                    Get.back();
                    controller.handleCall(CallType.voice);
                  },
                ),
                MenuListItem(
                  text: 'UChat Video Call'.tr,
                  suffixIcon: Assets.vectors.profileMenuVideo.svg(
                    colorFilter: ColorFilter.mode(
                      context.theme.appColors.icon,
                      BlendMode.srcIn,
                    ),
                  ),
                  onTap: () {
                    Get.back();
                    controller.handleCall(CallType.video);
                  },
                ),
                MenuListItem(
                  text: 'Phone Call'.tr,
                  suffixIcon: Assets.vectors.profileMenuPhoneCall.svg(
                    colorFilter: ColorFilter.mode(
                      context.theme.appColors.icon,
                      BlendMode.srcIn,
                    ),
                  ),
                  onTap: () {
                    Get.back();
                    controller.handlePhoneCall();
                  },
                ),
                MenuListItem(
                  text: 'Copy Number'.tr,
                  suffixIcon: Assets.vectors.copyIcon.svg(
                    colorFilter: ColorFilter.mode(
                      context.theme.appColors.icon,
                      BlendMode.srcIn,
                    ),
                  ),
                  onTap: () {
                    Get.back();
                    controller.copyPhoneNumberToClipboard();
                  },
                ),
              ],
              width: 260.spMin,
              barrierLabel: 'Phone Number Menu'.tr,
            );
          },
        );
      },
    );
  }
}
