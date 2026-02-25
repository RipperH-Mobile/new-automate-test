import 'package:flutter/material.dart';
import 'package:uchat/themes/themes.dart';

final headerStyle = UTheme.textTheme.settingItemTitle.copyWith(
  color: const Color(0xFF666666),
  fontSize: 14,
  fontWeight: FontWeight.normal,
);

class SettingHeader extends StatelessWidget {
  final String title;

  const SettingHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
        child: Text(
          title,
          style: headerStyle,
        ),
      ),
    );
  }
}
