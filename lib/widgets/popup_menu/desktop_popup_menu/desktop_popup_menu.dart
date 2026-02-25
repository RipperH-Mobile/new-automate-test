import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popover/popover.dart';

class DesktopPopupMenu extends StatelessWidget {
  final Widget listItems;
  final Widget child;
  final PopoverDirection direction;
  final double contentDyOffset;
  final double contentDxOffset;
  final double? width;
  final double? height;

  const DesktopPopupMenu({
    super.key,
    required this.listItems,
    required this.child,
    this.direction = PopoverDirection.bottom,
    this.contentDyOffset = 0,
    this.contentDxOffset = 0,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showPopover(
          radius: 15.spMin,
          context: context,
          bodyBuilder: (context) => listItems,
          onPop: () {},
          direction: direction,
          backgroundColor: Colors.white,
          barrierColor: Colors.transparent,
          width: width ?? 150.spMin,
          arrowHeight: 0,
          arrowWidth: 0,
          contentDyOffset: contentDyOffset,
          contentDxOffset: contentDxOffset,
        );
      },
      child: Container(
        width: 50.spMin,
        height: 50.spMin,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          // borderRadius: BorderRadius.all(Radius.circular(15.spMin)),
          // boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
        ),
        child: child,
      ),
    );
  }
}
