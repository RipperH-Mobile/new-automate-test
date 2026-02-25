import 'package:flutter/material.dart';
import 'package:uchat/themes/themes.dart';

class AppBarSliverBasic extends StatelessWidget {
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions; // TODO this actions is probably unused. Remove ?
  final double? expandedHeight;
  final double? collapsedHeight;
  final double? height;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final bool pinned;
  final bool floating;
  final bool snap;
  final double? titleRightPadding;
  final bool isHideSearchBar;
  final void Function()? onTap;
  final bool stretch;
  final double? leadingWidth;

  const AppBarSliverBasic({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.expandedHeight,
    this.collapsedHeight,
    this.height,
    this.centerTitle = false,
    this.automaticallyImplyLeading = false,
    this.pinned = true,
    this.floating = false,
    this.snap = false,
    this.isHideSearchBar = true,
    this.onTap,
    this.titleRightPadding,
    this.stretch = false,
    this.leadingWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      collapsedHeight: collapsedHeight,
      expandedHeight: expandedHeight,
      backgroundColor: UTheme.color.appBar,
      shadowColor: UTheme.color.appBarShadow,
      pinned: pinned,
      floating: floating,
      snap: snap,
      stretch: stretch,
      elevation: 1,
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      title: title,
      actions: actions,
      leading: leading,
      leadingWidth: leadingWidth,
    );
  }
}
