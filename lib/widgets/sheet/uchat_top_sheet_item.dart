import 'package:flutter/material.dart';
import 'package:uchat/themes/themes.dart';

class UChatTopSheetItem extends StatelessWidget {
  final String label;
  final String? iconImage;
  final IconData? icon;
  final Color? color;
  final void Function()? onPressed;

  const UChatTopSheetItem({
    super.key,
    required this.label,
    this.iconImage,
    this.icon,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: UTheme.color.topSheetMenu,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Column(
          children: [
            if (iconImage != null)
              Image(
                image: ResizeImage(
                  AssetImage(iconImage!),
                  width: 80,
                ),
                width: 25,
                height: 25,
              ),
            if (icon != null)
              Icon(
                icon,
                color: color ?? UTheme.color.onTopSheetMenu,
              ),
            Container(height: 10),
            Text(
              label,
              style: UTheme.textTheme.topSheetMenu.copyWith(
                color: color ?? UTheme.color.onTopSheetMenu,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
