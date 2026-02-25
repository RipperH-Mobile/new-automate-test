import 'package:flutter/material.dart';
import 'package:uchat/themes/themes.dart';

class SettingRowText extends StatelessWidget {
  final String title;

  const SettingRowText({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: UTheme.textTheme.settingItemTitle.copyWith(
                    color: UTheme.color.onSettingItem.withAlpha(170),
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
