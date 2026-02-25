import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/dimensions.dart';

@Deprecated('use UChatSwitchRowMenu instead')
class SettingRowSwitch extends StatelessWidget {
  final AssetImage? assetIcon;
  final IconData? iconData;
  final String title;
  final String? subTitle;
  final void Function()? onPressed;
  final void Function(bool value)? onChange;
  final bool isOn;
  final bool isEnable;
  final Color? backgroundColor;
  final bool secretVersion;

  const SettingRowSwitch({
    super.key,
    required this.title,
    required this.isOn,
    this.assetIcon,
    this.iconData,
    this.onPressed,
    this.onChange,
    this.isEnable = true,
    this.backgroundColor,
    this.secretVersion = false,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        backgroundColor: MaterialStateColor.resolveWith((states) {
          const Set<MaterialState> interactiveStates = <MaterialState>{
            MaterialState.pressed,
            MaterialState.hovered,
            MaterialState.focused,
          };
          if (states.any(interactiveStates.contains)) {
            return secretVersion
                ? UTheme.color.secretRoomSettingBlueAccent.withValues(alpha: 0.4)
                : UTheme.color.settingItem.withValues(alpha: 0.4);
          }

          return secretVersion ? UTheme.color.secretRoomSettingBlueAccent : UTheme.color.settingItem;
        }),
        overlayColor: MaterialStateColor.resolveWith(
          (states) => secretVersion ? UTheme.color.secretRoomStickerPackBackground : UTheme.color.settingItemOverlay,
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                if (iconData != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Icon(iconData, color: UTheme.color.onSettingItem),
                  ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: (assetIcon != null || iconData != null) ? 20 : 12,
                      right: subTitle != null ? 50.wr : 0,
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            title,
                            style: UTheme.textTheme.settingItemTitle.copyWith(
                              color: secretVersion ? UTheme.color.secretRoomText : UTheme.color.onSettingItem,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (subTitle != null)
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 8.hr),
                            child: Text(
                              subTitle ?? '',
                              style: UTheme.textTheme.settingItemTitle.copyWith(
                                color: secretVersion ? UTheme.color.secretRoomText : UTheme.color.passcodeNumpadOverlay,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                CupertinoSwitch(
                  trackColor: secretVersion ? UTheme.color.secretRoomButtonBlackColor : const Color(0xffCCCCCC),
                  thumbColor: !isOn
                      ? secretVersion
                          ? UTheme.color.secretRoomButtonThumbColor
                          : UTheme.color.background
                      : UTheme.color.background,
                  activeColor: UTheme.color.primary,
                  value: isOn,
                  onChanged: isEnable
                      ? (bool value) {
                          if (onChange != null) {
                            onChange?.call(value);
                          } else {
                            onPressed?.call();
                          }
                        }
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
