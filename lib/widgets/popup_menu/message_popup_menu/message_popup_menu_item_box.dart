import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uchat/widgets/popup_menu/message_popup_menu/message_popup_menu_item.dart';

class MessagePopupMenuItemBox extends StatelessWidget {
  final MessagePopupMenuItem item;
  final bool isSecondRow;
  final bool isLastItem;
  final bool isFirstItem;
  final bool isSymmetrical;
  final int itemLength;

  const MessagePopupMenuItemBox({
    super.key,
    required this.item,
    required this.itemLength,
    this.isSecondRow = false,
    this.isLastItem = false,
    this.isFirstItem = false,
    this.isSymmetrical = false,
  });

  BorderRadiusGeometry getBorderRadius(double radius) {
    final borderRadius = Radius.circular(radius.r);
    return BorderRadius.only(
      topLeft: isFirstItem && !isSecondRow ? borderRadius : Radius.zero,
      topRight: isLastItem && !isSecondRow ? borderRadius : Radius.zero,
      bottomLeft: itemLength >= 6
          ? isFirstItem && isSecondRow
              ? borderRadius
              : Radius.zero
          : isFirstItem
              ? borderRadius
              : Radius.zero,
      bottomRight: itemLength >= 6
          ? isSymmetrical
              ? (isLastItem && isSecondRow)
                  ? borderRadius
                  : Radius.zero
              : isLastItem
                  ? borderRadius
                  : Radius.zero
          : isLastItem
              ? borderRadius
              : Radius.zero,
    );
  }

  double get borderWidth => 1;

  @override
  Widget build(BuildContext context) {
    final borderSide = BorderSide(
      color: Colors.white.withValues(alpha: 0.2),
      width: borderWidth,
    );
    return Container(
      decoration: BoxDecoration(
        borderRadius: getBorderRadius(10 + borderWidth),
        border: Border(
          top: isSecondRow ? BorderSide.none : borderSide,
          left: isFirstItem ? borderSide : BorderSide.none,
          right: borderSide,
          bottom: borderSide,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.8),
          borderRadius: getBorderRadius(10),
        ),
        child: item,
      ),
    );
  }
}
