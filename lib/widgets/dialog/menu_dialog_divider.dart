import 'package:flutter/material.dart';
import 'package:uchat/themes/themes.dart';

class MenuDialogDivider extends StatelessWidget {
  const MenuDialogDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Divider(
        color: UTheme.color.bottomSheetDivider,
        height: 1,
        thickness: 1,
      ),
    );
  }
}
