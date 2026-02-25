import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class ChatRoomDetailAlbumAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final Function? onLeadingPressed;

  const ChatRoomDetailAlbumAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
    this.onLeadingPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(AppSpace.space16);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: AppSize.size20,
      leading: GestureDetector(
        onTap: () {
          if (onLeadingPressed != null) {
            onLeadingPressed!();
          } else {
            Get.back();
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: AppSpace.space4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Assets.vectors.chevronBackIos.svg(
                colorFilter: ColorFilter.mode(
                  context.theme.appColors.iconPrimary,
                  BlendMode.srcIn,
                ),
              ),
              AppText.button1(
                'Back'.tr,
                color: context.theme.appColors.textPrimary,
                context: context,
              ),
            ],
          ),
        ),
      ),
      title: Column(
        children: [
          AppText.title3(
            title,
            context: context,
          ),
          if (subtitle != null)
            AppText.body3(
              subtitle!,
              color: context.theme.appColors.textLight,
              context: context,
            ),
        ],
      ),
      actions: actions,
    );
  }
}
