import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';

const double _appBarHeight = 56;

class AppBarMain<T> extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  const AppBarMain({
    super.key,
    this.leading,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    if (T == SliverAppBar) {
      return SliverToBoxAdapter(
        child: _buildAppBar(context),
      );
    }
    return _buildAppBar(context);
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBarMainDefault(
      centerTitle: false,
      title: title,
      leadingWidth: 40,
      leadingButton: leading,
      actionList: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(_appBarHeight);
}

class AppBarMainDefault extends StatelessWidget implements PreferredSizeWidget {
  const AppBarMainDefault({
    super.key,
    required this.title,
    this.leadingButton,
    this.actionButton,
    this.actionList,
    this.automaticallyImplyLeading = true,
    this.leadingWidth = AppSpace.space24,
    this.centerTitle = true,
    this.titleStyle,
  });

  final String title;
  final Widget? leadingButton;
  final Widget? actionButton;
  final List<Widget>? actionList;
  final bool automaticallyImplyLeading;
  final double leadingWidth;
  final bool centerTitle;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.theme.appColors.backgroundNeutralLighter,
      toolbarHeight: _appBarHeight,
      centerTitle: centerTitle,
      title: Text(
        title,
        style: context.theme.appTexts.title3.copyWith(
          color: context.theme.appColors.textDarkest,
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: leadingButton != null
          ? Padding(
              padding: const EdgeInsets.only(
                left: AppSpace.space4,
              ),
              child: leadingButton,
            )
          : null,
      leadingWidth: leadingWidth,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actionsPadding: const EdgeInsets.only(
        right: AppSpace.space4,
      ),
      actions: [
        if (actionButton != null)
          SizedBox(
            width: AppSpace.space24,
            child: actionButton,
          ),
        if (actionList != null) ...actionList!,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(_appBarHeight);
}
