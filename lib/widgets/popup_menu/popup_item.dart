import 'package:flutter/material.dart';
import 'package:uchat/themes/themes.dart';

class PopupItem extends StatelessWidget {
  final String title;
  final IconData? iconData;
  final Function()? onPressed;

  const PopupItem({
    super.key,
    required this.title,
    this.iconData,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: UTheme.color.buttonOverlay,
        padding: EdgeInsets.zero,
      ),
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 15,
          top: 10,
          left: 15,
          right: 15,
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (iconData != null)
              Icon(
                iconData,
                size: 20,
                color: UTheme.color.onChatMessagePopupMenu,
              ),
            if (iconData != null)
              const SizedBox(
                height: 4,
              ),
            Container(
              margin: const EdgeInsets.only(top: 2),
              child: Text(
                title,
                style: UTheme.textTheme.chatMessagePopupMenu.copyWith(
                  color: UTheme.color.onChatMessagePopupMenu,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
