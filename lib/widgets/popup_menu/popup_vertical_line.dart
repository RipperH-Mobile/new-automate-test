import 'package:flutter/material.dart';
import 'package:uchat/themes/themes.dart';

class PopupVerticalLine extends StatelessWidget {
  const PopupVerticalLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Container(
        width: 1,
        color: UTheme.color.onChatMessagePopupMenu.withValues(alpha: 0.1),
      ),
    );
  }
}
