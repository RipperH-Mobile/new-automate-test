import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';

class OptionList extends StatelessWidget {
  const OptionList({
    super.key,
    required this.data,
    required this.onTap,
    required this.suggestionListHeight,
    this.suggestionBuilder,
    this.suggestionListDecoration,
  });

  final Widget Function(Map<String, dynamic>)? suggestionBuilder;

  final List<Map<String, dynamic>> data;

  final Function(Map<String, dynamic>) onTap;

  final double suggestionListHeight;

  final BoxDecoration? suggestionListDecoration;

  @override
  Widget build(BuildContext context) {
    final isMobile = UChatScreenUtil.instance.isMobile;

    Widget child = const SizedBox.shrink();

    if (data.isNotEmpty) {
      child = Container(
        margin: const EdgeInsets.only(
          left: 14,
          right: 14,
          bottom: 20,
        ),
        decoration: suggestionListDecoration ??
            BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF5C94FF).withValues(alpha: 0.12),
                  blurRadius: 10,
                  spreadRadius: -5,
                  offset: const Offset(3, 3),
                ),
              ],
            ),
        constraints: BoxConstraints(
          maxHeight: suggestionListHeight,
          minHeight: 0,
          maxWidth: isMobile ? double.infinity : 400.spMin,
          minWidth: isMobile ? double.infinity : 300.spMin,
        ),
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          itemCount: data.length,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            Widget child = Container(
              color: Colors.blue,
              child: Text(
                data[index]['display'],
                style: const TextStyle(fontSize: 12),
              ),
            );

            if (suggestionBuilder != null) {
              child = suggestionBuilder!(data[index]);
            }

            return GestureDetector(
              onTap: () {
                onTap(data[index]);
              },
              child: child,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              thickness: 0.5,
              color: Color(0xFFE6E6E6),
            );
          },
        ),
      );
    }

    if (isMobile) {
      return child;
    } else {
      return Align(
        alignment: Alignment.bottomLeft,
        widthFactor: 1.35.spMin,
        child: child,
      );
    }
  }
}
