import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uchat/themes/util.dart';

class UChatCheckBoxCircleWidgetChild extends StatelessWidget {
  final bool isSelected;

  const UChatCheckBoxCircleWidgetChild(
    this.isSelected, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.spMin,
      height: 20.spMin,
      decoration: BoxDecoration(
        color: isSelected ? UTheme.color.primary : Colors.grey, // border color
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(isSelected ? 6.spMin : 1.spMin), // border width
        child: Container(
          // or ClipRRect if you need to clip the content
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white, // inner circle color
          ),
          child: Container(), // inner content
        ),
      ),
    );
  }
}
