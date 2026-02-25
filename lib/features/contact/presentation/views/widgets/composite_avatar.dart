import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';

class CompositeAvatar<T> extends StatelessWidget {
  final List<T> items;
  final double size;
  final Widget Function(T item) itemBuilder;

  const CompositeAvatar({
    super.key,
    required this.items,
    this.size = AppSize.size12,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    // expect at least 4 items here.
    final double halfSize = size / 2;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.theme.appColors.backgroundGrayLight,
      ),
      child: ClipOval(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Top-left quadrant
            Positioned(
              left: 0,
              top: 0,
              width: halfSize,
              height: halfSize,
              child: itemBuilder(items[0]),
            ),
            // Top-right quadrant
            Positioned(
              right: 0,
              top: 0,
              width: halfSize,
              height: halfSize,
              child: itemBuilder(items[1]),
            ),
            // Bottom-left quadrant
            Positioned(
              left: 0,
              bottom: 0,
              width: halfSize,
              height: halfSize,
              child: itemBuilder(items[2]),
            ),
            // Bottom-right quadrant
            Positioned(
              right: 0,
              bottom: 0,
              width: halfSize,
              height: halfSize,
              child: itemBuilder(items[3]),
            ),
          ],
        ),
      ),
    );
  }
}
