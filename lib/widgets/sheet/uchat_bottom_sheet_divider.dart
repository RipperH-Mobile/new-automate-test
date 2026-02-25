import 'package:flutter/material.dart';
import 'package:uchat/themes/themes.dart';

class UChatBottomSheetDivider extends StatelessWidget {
  const UChatBottomSheetDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: UTheme.color.bottomSheetDivider,
      height: 1,
      thickness: 1,
      indent: 52,
    );
  }
}
