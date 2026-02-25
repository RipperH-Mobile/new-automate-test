import 'package:flutter/material.dart';
import 'package:uchat/themes/themes.dart';

class AppBarActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color? color;
  final Color? disabledColor;
  final bool disabled;

  const AppBarActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
    this.disabledColor,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: TextButton(
        onPressed: disabled ? null : onPressed,
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            const Set<WidgetState> interactiveStates = <WidgetState>{
              WidgetState.pressed,
              WidgetState.hovered,
              WidgetState.focused,
            };
            if (!disabled && states.any(interactiveStates.contains)) {
              return (color ?? UTheme.color.primary).withValues(alpha: 0.4);
            }

            return disabled ? disabledColor ?? UTheme.color.scaffoldActionDisabled : color ?? UTheme.color.primary;
          }),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
        ),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            label,
            style: UTheme.textTheme.appBarAction,
          ),
        ),
      ),
    );
  }
}
