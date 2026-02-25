import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uchat/themes/util.dart';

class UChatCheckBoxRowMenu<T> extends StatelessWidget {
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
  final void Function(T?) onTap;

  /// [value] is the value of the row
  /// default is `null`,
  /// it can be any type
  final T? value;

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

  final bool selected;

  final Color? selectedTitleColor;

  /// [customSelectedWidget]
  /// to custom your selected / unselected icon
  /// see the [uchat_check_box_row_menu_custom_circle_icon.dart] file
  /// and call you widget via the property like this:
  /// customSelectedWidget: (bool _) => UChatCheckBoxCircleWidgetChild(_),
  final Widget Function(bool)? customSelectedWidget;

  /// [isShowDisableIcon] is True, show the opposite of [selected] icon. False, show nothing.
  final bool isShowDisableIcon;
  final double? heightPrefixWidget;
  final double? widthPrefixWidget;

  const UChatCheckBoxRowMenu({
    super.key,
    this.padding,
    this.child,
    this.height,
    required this.onTap,
    this.value,
    this.borderWidth = 1,
    this.prefixWidget,
    this.title = '',
    this.titleTextStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xFF333333),
    ),
    this.subTitle,
    this.subTitleTextStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xFF808080),
    ),
    this.hasBorder = true,
    this.hasBottomBorder = true,
    this.hasTopBorder = true,
    this.backgroundColor = Colors.white,
    this.overlayColor = const Color(0xFFE5E5E5),
    this.bottomContent,
    this.selected = false,
    this.isShowDisableIcon = false,
    this.customSelectedWidget,
    this.selectedTitleColor,
    this.heightPrefixWidget,
    this.widthPrefixWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: hasBorder
            ? Border(
                top: hasTopBorder
                    ? BorderSide(
                        color: const Color(0xFFF2F2F2),
                        width: borderWidth,
                      )
                    : BorderSide.none,
                bottom: hasBottomBorder
                    ? BorderSide(
                        color: const Color(0xFFF2F2F2),
                        width: borderWidth,
                      )
                    : BorderSide.none,
              )
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            style: ButtonStyle(
              padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(
                  horizontal: 20.spMin,
                  vertical: 10.spMin,
                ),
              ),
              fixedSize: bottomContent == null && subTitle == null
                  ? WidgetStateProperty.all(
                      Size.fromHeight(
                        height ?? 60.spMin,
                      ),
                    )
                  : null,
              elevation: WidgetStateProperty.all(0),
              backgroundColor: WidgetStateProperty.all(backgroundColor),
              overlayColor: WidgetStateProperty.all(
                overlayColor.withValues(alpha: .5),
              ),
            ),
            onPressed: () {
              onTap(value);
            },
            child: child ??
                Row(
                  crossAxisAlignment:
                      bottomContent == null && subTitle == null ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: [
                    if (prefixWidget != null) ...[
                      SizedBox(
                        height: heightPrefixWidget ?? 26.spMin,
                        width: widthPrefixWidget ?? 26.spMin,
                        child: prefixWidget!,
                      ),
                      SizedBox(
                        width: 15.spMin,
                      ),
                    ],
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: titleTextStyle?.copyWith(
                                color: selected ? (selectedTitleColor ?? titleTextStyle?.color) : titleTextStyle?.color,
                                fontSize: titleTextStyle?.fontSize),
                          ),
                          if (subTitle != null && subTitle!.isNotEmpty) ...[
                            SizedBox(
                              height: 8.spMin,
                            ),
                            Text(
                              subTitle ?? '',
                              style: subTitleTextStyle?.copyWith(fontSize: subTitleTextStyle?.fontSize),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        if (isShowDisableIcon && !selected)
                          // Custom
                          buildCheckBoxCustom(false) ??
                              // Default
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.spMin),
                                child: Icon(
                                  Icons.check_box_outline_blank,
                                  size: 18.spMin,
                                  color: UTheme.color.primary,
                                ),
                              ),
                        if (selected)
                          // Custom
                          buildCheckBoxCustom(true) ??
                              // Default
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.spMin),
                                child: Icon(
                                  Icons.check,
                                  size: 18.spMin,
                                  color: UTheme.color.primary,
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
          ),
          if (bottomContent != null) bottomContent!,
        ],
      ),
    );
  }

  Widget? buildCheckBoxCustom(bool isEnable) {
    if (customSelectedWidget == null) return null;
    return customSelectedWidget!(isEnable);
  }
}
