import 'package:flutter/material.dart';
import 'package:uchat/themes/themes.dart';

class MenuDialogItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final void Function()? onPressed;

  const MenuDialogItem({
    super.key,
    required this.label,
    required this.isActive,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: UTheme.textTheme.optionsDialogMenu.copyWith(
              color: isActive ? UTheme.color.optionsDialogMenuActive : UTheme.color.optionsDialogMenu,
            ),
          ),
        ),
      ),
    );
  }
}
