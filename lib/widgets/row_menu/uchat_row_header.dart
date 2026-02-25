import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UChatRowHeader extends StatelessWidget {
  /// [child] is a widget that will be displayed
  /// instead of the default row elements
  final Widget? child;

  /// [padding] is the padding of the row
  /// default is `EdgeInsets.symmetric(horizontal: 20, vertical: 15)`
  final EdgeInsetsGeometry? padding;

  /// [height] is the height of the row
  /// default is `60.hr`
  final double? height;

  /// [showArrowCenterRight] force show arrow center right
  final bool centerRightContent;

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

  /// [suffixWidget] is a widget that will be displayed at the start of the row
  /// default is`null`
  ///
  /// it can be any widget, but it is recommended to use a widget with a size of 26.hr
  final Widget? suffixWidget;

  /// [suffixWidgetSize] is the size of the suffix widget
  /// default is `26.hr`
  /// this will only work if [suffixWidget] is not null
  final double? suffixWidgetSize;

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

  /// [suffixText] is the text that will be displayed beside the arrow
  /// with `a horizontal spacing of 8.wr`
  /// default is `null`
  final String? suffixText;

  /// [suffixTextStyle] is the style of the suffix text
  /// default is
  /// ```
  /// TextStyle(
  ///  fontSize: 16,
  ///  fontWeight: FontWeight.w400,
  ///  color: Color(0xFFB3B3B3),
  /// )
  /// ```
  final TextStyle? suffixTextStyle;

  final bool? borderRadiusTop;
  final bool? borderRadiusBottom;
  final double? borderRadius;
  final Color? borderColor;
  final bool hasLeftBorder;
  final bool hasRightBorder;
  final bool hasHorizontalBorder;
  final bool hasVerticalBorder;

  final Widget? titleTailing;

  const UChatRowHeader({
    super.key,
    this.padding,
    this.child,
    this.height,
    this.borderWidth = 1,
    this.prefixWidget,
    this.suffixWidget,
    this.suffixWidgetSize,
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
    this.suffixText,
    this.suffixTextStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xFFB3B3B3),
    ),
    this.borderRadiusTop,
    this.borderRadiusBottom,
    this.borderRadius,
    this.borderColor,
    this.centerRightContent = true,
    this.titleTailing,
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
      constraints: BoxConstraints(
        minHeight: height ?? 60.spMin,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20.spMin,
        vertical: 10.spMin,
      ),
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
        color: backgroundColor,
        border: _border,
      ),
      child: Row(
        crossAxisAlignment: centerRightContent ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          if (prefixWidget != null) ...[
            prefixWidget!,
            SizedBox(
              width: 15.spMin,
            ),
          ],
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: titleTextStyle ??
                          const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF333333),
                          ),
                    ),
                    if (titleTailing != null) titleTailing!,
                  ],
                ),
                if (subTitle != null && subTitle!.isNotEmpty) ...[
                  SizedBox(
                    height: 8.spMin,
                  ),
                  Text(
                    subTitle ?? '',
                    style: subTitleTextStyle ??
                        const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF808080),
                        ),
                  ),
                ],
              ],
            ),
          ),
          if (suffixWidget != null) ...[
            suffixWidget!,
          ],
        ],
      ),
    );
  }
}
