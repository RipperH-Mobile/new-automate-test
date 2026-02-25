import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/themes/themes.dart';

class SettingRowValue extends StatelessWidget {
  final AssetImage? assetIcon;
  final IconData? iconLeft;
  final IconData? iconRight;
  final String title;
  final String? value;
  final bool showNone;
  final bool valueIsEmpty;
  final bool disableIconRight;
  final void Function()? onPressed;

  const SettingRowValue({
    super.key,
    required this.title,
    this.value,
    this.onPressed,
    this.assetIcon,
    this.iconLeft,
    this.iconRight,
    this.valueIsEmpty = false,
    this.showNone = true,
    this.disableIconRight = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateColor.resolveWith((states) {
          const Set<WidgetState> interactiveStates = <WidgetState>{
            WidgetState.pressed,
            WidgetState.hovered,
            WidgetState.focused,
          };
          if (states.any(interactiveStates.contains)) {
            return UTheme.color.settingItem.withValues(alpha: 0.4);
          }

          return UTheme.color.settingItem;
        }),
        overlayColor: WidgetStateColor.resolveWith(
          (states) => UTheme.color.settingItemOverlay,
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (assetIcon != null)
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ImageIcon(
                  assetIcon,
                  color: UTheme.color.onSettingItem,
                ),
              ),
            if (iconLeft != null)
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(iconLeft, color: UTheme.color.onSettingItem),
              ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(left: (assetIcon != null || iconLeft != null) ? 20 : 12),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          title,
                          style: UTheme.textTheme.settingItemTitle.copyWith(
                            color: UTheme.color.onSettingItem.withAlpha(200),
                          ),
                        ),
                      ),
                      if (showNone)
                        Text(
                          value ?? '- NONE -'.tr,
                          style: UTheme.textTheme.settingItemValue.copyWith(
                            color: value == null || valueIsEmpty
                                ? UTheme.color.onSettingItem.withAlpha(100)
                                : UTheme.color.onSettingItem,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            if (onPressed != null && !disableIconRight)
              Icon(
                iconRight ?? Icons.keyboard_arrow_right,
                color: UTheme.color.settingItemSecondary,
              ),
          ],
        ),
      ),
    );
  }
}
