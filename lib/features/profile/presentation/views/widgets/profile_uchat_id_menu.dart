import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/features/profile/presentation/controllers/profile_controller.dart';
import 'package:uchat/features/profile/presentation/views/widgets/corner_box_menu.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/dialog/hold_widget_with_menu.dart';
import 'package:uchat/widgets/menu_list/menu_list_item.dart';

class ProfileUchatIdMenu extends GetView<ProfileControllerV2> {
  const ProfileUchatIdMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final uchatId = controller.profile.value?.username;
    Widget child = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.body3(
              'Uchat ID'.tr,
              context: context,
            ),
            AppText.body1(
              uchatId ?? 'Not set up'.tr,
              context: context,
              color: uchatId != null && uchatId.isNotEmpty
                  ? context.theme.appColors.textPrimary
                  : context.theme.appColors.textLight,
            ),
          ],
        ),
        Assets.vectors.qrCode.svg(
          colorFilter: ColorFilter.mode(
            context.theme.appColors.iconPrimary,
            BlendMode.srcIn,
          ),
        ),
      ],
    );
    return CornerBoxMenuItem(
      child: child,
      onTap: () {
        controller.handleShowMyQR();
      },
      onLongPress: () {
        HoldWidgetWithMenu.show(
          CornerBoxMenu.singleItem(
            child: child,
          ),
          [
            MenuListItem(
              text: 'Copy UChat ID'.tr,
              suffixIcon: Assets.vectors.copyIcon.svg(
                colorFilter: ColorFilter.mode(
                  context.theme.appColors.icon,
                  BlendMode.srcIn,
                ),
              ),
              onTap: () {
                Get.back();
                controller.handleCopyUchatId();
              },
            ),
          ],
          width: 260.spMin,
          barrierLabel: 'UChat ID Menu'.tr,
        );
      },
    );
  }
}
