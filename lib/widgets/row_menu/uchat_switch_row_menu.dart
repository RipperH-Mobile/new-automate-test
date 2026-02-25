import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/themes/util.dart';

class UChatSwitchRowMenu extends StatelessWidget {
  /// [child] is a widget that will be displayed
  /// instead of the default row elements
  final Widget? child;

  /// [padding] is the padding of the row
  /// default is `EdgeInsets.symmetric(horizontal: 20, vertical: 15)`
  final EdgeInsetsGeometry? padding;

  /// [height] is the height of the row
  /// default is `60.hr`
  final double? height;

  /// [onTap] is a callback that will be called when the row is tapped
  /// default is `null`
  final void Function(bool?)? onTap;

  /// [hasBorder] is a bool that will show or hide the border
  /// default is `true`
  final bool hasBorder;

  /// [hasTopBorder] is a bool that will show or hide the top border
  /// default is `true`
  ///
  /// this will only work if [hasBorder] is true
  final bool hasTopBorder;

  /// [hasBottomBorder] is a bool that will show or hide the bottom border
  /// default is `true`
  ///
  /// this will only work if [hasBorder] is true
  final bool hasBottomBorder;

  /// [borderWidth] is the width of the border of the row, top and bottom
  /// default is `1`
  ///
  /// this will only work if [hasBorder] is true
  final double borderWidth;

  /// [prefixWidget] is a widget that will be displayed at the start of the row
  /// default is`null`
  ///
  /// it can be any widget, but it is recommended to use a widget with a size of 26.hr
  final Widget? prefixWidget;
  final Widget? suffixWidget;

  /// [title] is the title of the row
  /// default is `''`
  final String title;

  /// [titleTextStyle] is the style of the title
  /// default is
  /// ```
  /// TextStyle(
  ///  fontSize: 16,
  ///  fontWeight: FontWeight.w400,
  ///  color: Color(0xFF333333),
  /// )
  /// ```
  final TextStyle? titleTextStyle;

  /// [subTitle] is the subtitle of the row
  /// default is `null`
  /// if it is null, it will not be displayed
  /// if it is not null, it will be displayed under the title with vertical spacing of 8.hr
  final String? subTitle;

  /// [subTitleTextStyle] is the style of the subtitle
  /// default is
  /// ```
  /// TextStyle(
  ///  fontSize: 14,
  ///  fontWeight: FontWeight.w400,
  ///  color: Color(0xFF808080),
  /// )
  /// ```
  final TextStyle? subTitleTextStyle;

  /// [backgroundColor] is the background color of the row
  /// default is `Colors.white`
  final Color backgroundColor;

  /// [overlayColor] is the overlay color of the row when it is tapped
  /// default is `Color(0xFFE5E5E5)`
  /// it is recommended to use a color with opacity
  ///
  /// ```
  /// example:
  /// Color(0xFFE5E5E5).withValues(alpha: .5)
  /// ```
  final Color overlayColor;

  /// [bottomContent] is a widget that will be displayed at the bottom of the row
  /// default is `null`
  ///
  /// it can be any widget
  final Widget? bottomContent;

  final bool value;
  final bool? borderRadiusTop;
  final bool? borderRadiusBottom;
  final double? borderRadius;
  final bool hasLeftBorder;
  final bool hasRightBorder;
  final Color? borderColor;
  final bool hasHorizontalBorder;
  final bool hasVerticalBorder;
  final Color? thumbColor;
  final Color? trackColor;
  final bool isDesktop;

  const UChatSwitchRowMenu({
    super.key,
    this.padding,
    this.child,
    this.height,
    required this.onTap,
    this.borderWidth = 1,
    this.prefixWidget,
    this.title = '',
    this.titleTextStyle,
    this.subTitle,
    this.subTitleTextStyle,
    this.hasBorder = true,
    this.hasBottomBorder = false,
    this.hasTopBorder = false,
    this.hasLeftBorder = false,
    this.hasRightBorder = false,
    this.hasHorizontalBorder = false,
    this.hasVerticalBorder = false,
    this.backgroundColor = Colors.white,
    this.overlayColor = const Color(0xFFE5E5E5),
    this.bottomContent,
    this.value = false,
    this.suffixWidget,
    this.borderRadiusTop,
    this.borderRadiusBottom,
    this.borderRadius,
    this.borderColor,
    this.thumbColor,
    this.trackColor,
    this.isDesktop = false,
  });

  BorderSide get _borderSide => BorderSide(
        color: borderColor ?? const Color(0xffE6E6E6),
        width: borderWidth,
      );

  Border? get _border {
    bool isSeparateInput =
        hasLeftBorder || hasRightBorder || hasHorizontalBorder || hasVerticalBorder || hasTopBorder || hasBottomBorder;
    if (hasBorder && !(isSeparateInput)) {
      return Border(
        top: _borderSide,
        bottom: _borderSide,
        left: _borderSide,
        right: _borderSide,
      );
    }

    if (isSeparateInput) {
      return Border(
        top: hasVerticalBorder
            ? _borderSide
            : hasTopBorder
                ? _borderSide
                : BorderSide.none,
        bottom: hasVerticalBorder
            ? _borderSide
            : hasBottomBorder
                ? _borderSide
                : BorderSide.none,
        left: hasHorizontalBorder
            ? _borderSide
            : hasLeftBorder
                ? _borderSide
                : BorderSide.none,
        right: hasHorizontalBorder
            ? _borderSide
            : hasRightBorder
                ? _borderSide
                : BorderSide.none,
      );
    }

    return null;
  }

  BorderRadius get _borderRadius {
    if (borderRadiusTop == true) {
      return BorderRadius.only(topLeft: Radius.circular(10.spMin), topRight: Radius.circular(10.spMin));
    } else if (borderRadiusBottom == true) {
      return BorderRadius.only(bottomLeft: Radius.circular(10.spMin), bottomRight: Radius.circular(10.spMin));
    } else {
      return BorderRadius.circular(borderRadius ?? 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
        color: backgroundColor,
        border: _border,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                borderRadius: borderRadiusTop == true
                    ? BorderRadius.only(topLeft: Radius.circular(10.spMin), topRight: Radius.circular(10.spMin))
                    : borderRadiusBottom == true
                        ? BorderRadius.only(
                            bottomLeft: Radius.circular(10.spMin), bottomRight: Radius.circular(10.spMin))
                        : BorderRadius.circular(borderRadius ?? 0),
              )),
              padding: WidgetStateProperty.all(
                padding ?? EdgeInsets.symmetric(horizontal: 20.spMin, vertical: 10.spMin),
              ),
              // fixedSize: WidgetStateProperty.all(
              //   Size.fromHeight(
              //     height ?? 60.spMin,
              //   ),
              // ),
              elevation: WidgetStateProperty.all(0),
              backgroundColor: WidgetStateProperty.all(backgroundColor),
              overlayColor: WidgetStateProperty.all(Colors.transparent),
            ),
            onPressed: null,
            child: Padding(
              padding: isDesktop ? EdgeInsets.symmetric(vertical: 20.spMin) : EdgeInsets.zero,
              child: child ??
                  Row(
                    crossAxisAlignment: bottomContent == null && subTitle == null
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: [
                      if (prefixWidget != null) ...[
                        SizedBox(
                          height: 26.spMin,
                          width: 26.spMin,
                          child: prefixWidget!,
                        ),
                        SizedBox(width: 15.spMin),
                      ],
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: titleTextStyle ??
                                        const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF333333),
                                        ),
                                  ),
                                ),
                                SizedBox(
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
                                if (suffixWidget != null) suffixWidget!,
                              ],
                            ),
                            if (subTitle != null && subTitle!.isNotEmpty) ...[
                              SizedBox(height: 8.spMin),
                              Padding(
                                padding: const EdgeInsets.only(right: AppSpace.space12),
                                child: Text(
                                  subTitle ?? '',
                                  style: subTitleTextStyle ??
                                      const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF808080),
                                      ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
            ),
          ),
          if (bottomContent != null) bottomContent!,
        ],
      ),
    );
  }
}
