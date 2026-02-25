import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionSheetItem extends StatelessWidget {
  const ActionSheetItem({
    super.key,
    required this.title,
    this.style,
    this.onTap,
  });

  final String title;
  final TextStyle? style;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: EdgeInsets.all(
          18.spMin,
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: style ??
              TextStyle(
                fontSize: 14.spMin,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}

class ActionSheetItemBox extends StatelessWidget {
  const ActionSheetItemBox({
    super.key,
    required this.items,
  });

  final List<ActionSheetItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0), // Adjusted to a fixed value
        border: Border.all(
          color: const Color(0xFFE6E6E6),
        ),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 0,
          thickness: 1,
          color: Color(0xFFF2F2F2),
        ),
        itemBuilder: (BuildContext context, int index) {
          return items[index];
        },
      ),
    );
  }
}
