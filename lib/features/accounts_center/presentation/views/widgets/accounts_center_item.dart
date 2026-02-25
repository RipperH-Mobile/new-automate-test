import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/avatar/avatar.dart';

class AccountsCenterItem extends StatelessWidget {
  static const double avatarRadius = AppSize.size6;

  final String title;
  final String? avatarUrl;
  final Function? onTap;
  final bool isCurrentAccount;
  final Widget? customAvatar;
  final bool hideArrowIcon;
  final Color? customBackgroundColor;

  const AccountsCenterItem({
    super.key,
    required this.title,
    this.onTap,
    this.avatarUrl,
    this.isCurrentAccount = false,
    this.customAvatar,
    this.hideArrowIcon = false,
    this.customBackgroundColor,
  });

  factory AccountsCenterItem.addAccount(BuildContext context, Function onTap) {
    return AccountsCenterItem(
      title: 'Add UChat Account'.tr,
      customAvatar: Container(
        width: avatarRadius * 2,
        height: avatarRadius * 2,
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.theme.appColors.backgroundNeutralLighterPressed,
        ),
        child: Assets.vectors.add.svg(
          colorFilter: ColorFilter.mode(
            context.theme.appColors.iconLight,
            BlendMode.srcIn,
          ),
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null ? () => onTap!() : null,
      child: Container(
        color: customBackgroundColor ?? context.theme.appColors.backgroundNeutralLightest,
        padding: const EdgeInsets.only(
          left: AppSpace.space2,
          right: AppSpace.space6,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpace.space2),
              child: customAvatar ??
                  Avatar(
                    radius: avatarRadius,
                    url: avatarUrl,
                  ),
            ),
            const SizedBox(width: AppSpace.space4),
            Expanded(
              child: AppText.body3Bold(
                title,
                context: context,
                color: context.theme.appColors.textDarkest,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
            if (isCurrentAccount)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpace.space1),
                child: Assets.vectors.checkBoxSelected.svg(
                  width: AppSize.size6,
                  height: AppSize.size6,
                ),
              ),
            if (!hideArrowIcon)
              Padding(
                padding: const EdgeInsets.only(left: AppSpace.space2),
                child: Assets.vectors.iconArrowBackIos.svg(),
              ),
          ],
        ),
      ),
    );
  }
}
