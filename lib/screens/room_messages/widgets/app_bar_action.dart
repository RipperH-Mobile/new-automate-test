import 'package:flutter/material.dart';
import 'package:uchat/themes/themes.dart';

class AppBarAction extends StatelessWidget {
  final void Function()? onPressed;
  final Widget icon;
  final double? splashRadius;
  // final Color splashColor;

  const AppBarAction({
    super.key,
    this.onPressed,
    required this.icon,
    // required this.splashColor,
    this.splashRadius,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      color: UTheme.color.onAppBar,
      onPressed: onPressed,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashRadius: splashRadius,
    );
  }
}
