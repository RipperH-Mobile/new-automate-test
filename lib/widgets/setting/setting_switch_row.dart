import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/extension/extension_number.dart';

class SettingSwitchRow extends StatelessWidget {
  final AssetImage? assetIcon;
  final IconData? iconLeft;
  final String title;
  final String? title2;
  final String? description;
  final Color? backgroundColor;
  final Color? textColor;
  final bool secretVersion;
  final bool value;
  final void Function(bool?)? onTap;
  final bool isSelected;
  final bool? borderRadiusTop;
  final bool? borderRadiusBottom;
  final double? borderRadius;
  final bool isSplashFactory;
  final bool isShowBorderSide;
  final double? paddingVertical;
  final Color? thumbColor;
  final Color? trackColor;

  const SettingSwitchRow({
    super.key,
    required this.title,
    required this.value,
    required this.onTap,
    this.assetIcon,
    this.iconLeft,
    this.title2,
    this.description,
    this.secretVersion = false,
    this.backgroundColor,
    this.textColor,
    this.isSelected = false,
    this.borderRadiusTop,
    this.borderRadiusBottom,
    this.borderRadius,
    this.isSplashFactory = true,
    this.isShowBorderSide = false,
    this.paddingVertical,
    this.thumbColor,
    this.trackColor,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = UTheme.textTheme.settingItemTitle.copyWith(
      color: isSelected
          ? const Color(0xffFFFFFF)
          : textColor ?? (secretVersion ? UTheme.color.secretRoomText : UTheme.color.onSettingItem),
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
    );

    return TextButton(
      style: ButtonStyle(
        splashFactory: isSplashFactory ? null : NoSplash.splashFactory,
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: borderRadiusTop == true
                ? const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                : borderRadiusBottom == true
                    ? const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
                    : BorderRadius.circular(borderRadius ?? 0),
            side: isShowBorderSide
                ? const BorderSide(
                    color: Color(0xffE6E6E6),
                    width: 0.0,
                  )
                : BorderSide.none,
          ),
        ),
        backgroundColor: WidgetStateColor.resolveWith((states) {
          if (isSelected) {
            return const Color(0xff0057FF);
          }
          const Set<WidgetState> interactiveStates = <WidgetState>{
            WidgetState.pressed,
            WidgetState.hovered,
            WidgetState.focused,
          };
          if (states.any(interactiveStates.contains)) {
            return secretVersion
                ? UTheme.color.secretRoomSettingBlueAccent.withValues(alpha: 0.4)
                : UTheme.color.settingItem.withValues(alpha: 0.4);
          }

          return secretVersion ? UTheme.color.secretRoomSettingBlueAccent : UTheme.color.settingItem;
        }),
        overlayColor: WidgetStateColor.resolveWith(
          (states) => isSelected
              ? const Color(0xff0057FF)
              : secretVersion
                  ? UTheme.color.secretRoomStickerPackBackground
                  : UTheme.color.settingItemOverlay,
        ),
      ),
      onPressed: () => onTap?.call(!value),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: paddingVertical ?? 10.spMin,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (assetIcon != null)
              Padding(
                padding: EdgeInsets.only(left: 10.spMin),
                child: ImageIcon(
                  ResizeImage(
                    assetIcon!,
                    width: 50.cacheSize,
                  ),
                  color: isSelected ? const Color(0xffFFFFFF) : UTheme.color.onSettingItem,
                ),
              ),
            if (iconLeft != null)
              Padding(
                padding: EdgeInsets.only(left: 10.spMin),
                child: Icon(iconLeft, color: isSelected ? const Color(0xffFFFFFF) : UTheme.color.onSettingItem),
              ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 12.spMin),
                child: Column(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: 24,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: customTextBolder(textStyle),
                          ),
                          if (title2 != null)
                            Padding(
                              padding: EdgeInsets.only(left: 4.spMin),
                              child: Text(
                                title2!,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (description != null)
                      Padding(
                        padding: EdgeInsets.only(
                          top: 4.spMin,
                        ),
                        child: Text(
                          description!,
                          style: const TextStyle(
                            color: Color(0xFF808080),
                            fontSize: 13,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 12.spMin),
              child: SizedBox(
                width: 48.spMin,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: CupertinoSwitch(
                    value: value,
                    activeTrackColor: UTheme.color.primary,
                    thumbColor: thumbColor ?? const Color(0xFFF2F2F2),
                    inactiveTrackColor: trackColor ?? const Color(0xFFCCCCCC),
                    onChanged: onTap,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customTextBolder(TextStyle textStyle) {
    return Stack(
      children: [
        Text.rich(
          customTextSpan(
            text: title,
            style: textStyle,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: textStyle,
        ),
        Text.rich(
          customTextSpan(
            text: title,
            style: textStyle,
          ),
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          maxLines: 1,
          style: textStyle.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.fill
              ..strokeWidth = 0.2
              ..color = isSelected
                  ? const Color(0xffFFFFFF)
                  : secretVersion
                      ? UTheme.color.secretRoomText
                      : UTheme.color.onSettingItem,
          ),
        ),
      ],
    );
  }

  TextSpan customTextSpan({
    required String text,
    required TextStyle style,
  }) {
    return TextSpan(
      text: text,
      style: style,
    );
  }
}