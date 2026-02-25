import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopoverMenuItem extends StatelessWidget {
  final Future<void> Function(BuildContext)? onPressed;
  final Future<void> Function(BuildContext, bool)? onHover;
  final String title;
  final TextStyle? customFontStyle;
  final Widget? child;
  final bool hasArrow;
  final bool hasTopDivider;
  final bool hasBottomDivider;
  final bool hasHoverEffect;
  final Widget? icon;

  const PopoverMenuItem({
    super.key,
    this.onPressed,
    this.onHover,
    this.title = 'Label',
    this.child,
    this.hasArrow = false,
    this.hasTopDivider = false,
    this.hasBottomDivider = false,
    this.customFontStyle,
    this.hasHoverEffect = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final content = Row(
      children: [
        Expanded(
          child: !hasHoverEffect
              ? InkWell(
                  onTap: () {
                    onPressed?.call(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(15.0.spMin),
                    child: child ??
                        (!hasArrow
                            ? Row(
                                children: [
                                  if (icon != null)
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: 10.spMin,
                                      ),
                                      width: 18.spMin,
                                      height: 18.spMin,
                                      child: icon,
                                    ),
                                  Text(title, style: customFontStyle ?? fontStyle)
                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(child: Text(title, style: customFontStyle ?? fontStyle)),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 15.spMin,
                                    color: const Color(0xffB3B3B3),
                                  ),
                                ],
                              )),
                  ),
                )
              : InkWell(
                  onHover: (isHovering) {
                    onHover?.call(context, isHovering);
                  },
                  onTap: () {
                    // onPressed?.call(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(15.0.spMin),
                    child: child ??
                        (!hasArrow
                            ? Row(
                                children: [
                                  if (icon != null)
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: 10.spMin,
                                      ),
                                      width: 18.spMin,
                                      height: 18.spMin,
                                      child: icon,
                                    ),
                                  Text(title, style: customFontStyle ?? fontStyle)
                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(child: Text(title, style: customFontStyle ?? fontStyle)),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 15.spMin,
                                    color: const Color(0xffB3B3B3),
                                  ),
                                ],
                              )),
                  ),
                ),
        ),
      ],
    );

    if (hasTopDivider || hasBottomDivider) {
      return Column(
        children: [
          if (hasTopDivider) divider,
          content,
          if (hasBottomDivider) divider,
        ],
      );
    } else {
      return content;
    }
  }

  static final fontStyle = TextStyle(
    color: const Color(0xff4D4D4D),
    fontWeight: FontWeight.w500,
    fontSize: 12.spMin,
  );

  static const divider = Divider(
    height: 0,
    thickness: 0.5,
  );
}
