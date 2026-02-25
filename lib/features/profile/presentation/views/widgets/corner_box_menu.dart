import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';

class CornerBoxMenu extends StatelessWidget {
  final List<Widget> children;

  const CornerBoxMenu({super.key, required this.children});

  factory CornerBoxMenu.singleItem({
    required Widget child,
    VoidCallback? onTap,
  }) {
    return CornerBoxMenu(
      children: [
        CornerBoxMenuItem(
          onTap: onTap,
          child: child,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: context.theme.appColors.backgroundNeutralLightest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppRadius.rounded2xl,
          ),
        ),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: children.length,
        itemBuilder: (context, index) {
          return children[index];
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 1,
            thickness: 1,
            indent: AppSpace.space4,
            color: context.theme.appColors.border,
          );
        },
      ),
    );
  }
}

class CornerBoxMenuItem extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry padding;

  const CornerBoxMenuItem({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.padding = const EdgeInsets.symmetric(
      vertical: AppSpace.space3,
      horizontal: AppSpace.space4,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}

class CornerBoxMenuItemListTitle extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry? contentPadding;

  const CornerBoxMenuItemListTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.contentPadding,
  });
  factory CornerBoxMenuItemListTitle.arrow({
    required Widget title,
    required VoidCallback onTap,
    Widget? subtitle,
    VoidCallback? onLongPress,
  }) {
    return CornerBoxMenuItemListTitle(
      title: title,
      subtitle: subtitle,
      onTap: onTap,
      onLongPress: onLongPress,
      trailing: Assets.vectors.iconArrowBackIos.svg(),
    );
  }

  factory CornerBoxMenuItemListTitle.toggle({
    required Widget title,
    required bool value,
    required ValueChanged<bool> onChanged,
    required BuildContext context,
    Widget? subtitle,
    Widget? trailing,
  }) {
    return CornerBoxMenuItemListTitle(
      title: title,
      subtitle: subtitle,
      contentPadding: const EdgeInsets.only(
        left: AppSpace.space4,
        right: AppSpace.space3,
        top: AppSpace.space3,
        bottom: AppSpace.space3,
      ),
      trailing: SizedBox(
        width: AppSize.size12,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: context.theme.appColors.backgroundPrimary,
            thumbColor: context.theme.appColors.backgroundNeutralLightest,
            inactiveTrackColor: context.theme.appColors.iconDisable,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: contentPadding ??
          const EdgeInsets.symmetric(
            vertical: AppSpace.space3,
            horizontal: AppSpace.space4,
          ),
      minVerticalPadding: 0,
      minTileHeight: 0,
      dense: true,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
