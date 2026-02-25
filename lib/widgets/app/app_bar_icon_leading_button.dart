import 'package:flutter/material.dart';
import 'package:uchat/themes/themes.dart';

class AppBarIconLeadingButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? color;
  final Color? disabledColor;
  final bool disabled;
  final Widget icon;

  const AppBarIconLeadingButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.color,
    this.disabledColor,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: disabled ? null : onPressed,
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          const Set<WidgetState> interactiveStates = <WidgetState>{
            WidgetState.pressed,
            WidgetState.hovered,
            WidgetState.focused,
          };
          if (!disabled && states.any(interactiveStates.contains)) {
            return (color ?? UTheme.color.onAppBar).withValues(alpha: 0.4);
          }

          return disabled ? disabledColor ?? UTheme.color.scaffoldActionDisabled : color ?? UTheme.color.onAppBar;
        }),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
      ),
      child: Container(
        alignment: Alignment.center,
        child: icon,
      ),
    );
  }
}
