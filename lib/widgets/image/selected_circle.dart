import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectedCircle extends StatelessWidget {
  const SelectedCircle({
    super.key,
    this.number,
  });

  final int? number;

  @override
  Widget build(BuildContext context) {
    Color color = number != null ? const Color(0xff0057ff) : Colors.black26;
    Color borderColor = number != null ? const Color(0xff0057ff) : Colors.white;
    return Container(
      width: 24.w,
      height: 24.w,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      ),
      child: number != null
          ? Center(
              child: Text(
                number.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
