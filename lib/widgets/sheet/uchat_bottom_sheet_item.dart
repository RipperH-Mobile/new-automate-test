import 'package:flutter/material.dart';
import 'package:uchat/themes/themes.dart';

class UChatBottomSheetItem extends StatelessWidget {
  final String label;
  final String? iconImage;
  final IconData? icon;
  final Color? color;
  final void Function()? onPressed;

  const UChatBottomSheetItem({
    super.key,
    required this.label,
    this.iconImage,
    this.icon,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: UTheme.color.bottomSheetMenu,
      ),
      child: Row(
        children: [
          if (iconImage != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Image(
                image: AssetImage(iconImage!),
                width: 20,
                height: 20,
              ),
            ),
          if (icon != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Icon(
                icon,
                color: color ?? UTheme.color.bottomSheetOnMenu,
              ),
            ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(
                (icon == null && iconImage == null) ? 16 : 0,
              ),
              child: SizedBox(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: UTheme.textTheme.bottomSheetMenu.copyWith(
                    color: color ?? UTheme.color.bottomSheetOnMenu,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
