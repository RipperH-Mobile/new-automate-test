import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uchat/widgets/popup_menu/message_popup_menu/message_popup_menu_item.dart';
import 'package:uchat/widgets/popup_menu/message_popup_menu/message_popup_menu_item_box.dart';

class MessagePopupMenu extends StatelessWidget {
  static double popupMenuItemSize = 60.spMin;
  static double popupMenuMaxWidth = 400.spMin;
  static double borderWidth = 1;
  static int maxItemPerRow = 3;
  static double childAspectRatio = 1.09;

  final List<MessagePopupMenuItem> menuItems;

  const MessagePopupMenu({
    super.key,
    this.menuItems = const [],
  });

  int get length => menuItems.length >= 6 ? maxItemPerRow : menuItems.length;

  static int crossAxisCount(int itemLength) {
    if (itemLength > 6) {
      return 4;
    } else if (itemLength == 6) {
      return 3;
    } else {
      return itemLength;
    }
  }

  static double height(int itemLength) {
    return ((popupMenuItemSize * (itemLength / crossAxisCount(itemLength)).ceil()) + (borderWidth * 2)) /
        childAspectRatio;
  }

  @override
  Widget build(BuildContext context) {
    final itemLength = menuItems.length;
    final count = crossAxisCount(itemLength);
    return Container(
      padding: EdgeInsets.all(borderWidth),
      constraints: BoxConstraints(
        maxWidth: popupMenuMaxWidth,
      ),
      child: SizedBox(
        width: (popupMenuItemSize + borderWidth) * count,
        child: GridView.count(
          crossAxisCount: count,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: childAspectRatio,
          shrinkWrap: true,
          children: menuItems.asMap().entries.map(
            (entry) {
              return MessagePopupMenuItemBox(
                item: entry.value,
                itemLength: itemLength,
                isSecondRow: entry.key >= count,
                isLastItem: entry.key == itemLength - 1 || entry.key % count == count - 1,
                isFirstItem: entry.key == 0 || entry.key % count == 0,
                isSymmetrical: itemLength % count == 0,
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
