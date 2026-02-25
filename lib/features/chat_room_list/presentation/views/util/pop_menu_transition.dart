import 'package:flutter/material.dart';

Widget popMenuTransition({
  required BuildContext context,
  required Animation<double> animation,
  required Widget child,
}) {
  final renderBox = context.findRenderObject() as RenderBox?;
  final offsetX = renderBox?.localToGlobal(Offset.zero).dx ?? 0;
  final offsetY = renderBox?.localToGlobal(Offset.zero).dy ?? 0;
  final centerXOfItem = offsetX + (renderBox?.size.width ?? 0) / 2;
  final centerYOfItem = (offsetY + (renderBox?.size.height ?? 0) / 2);
  final targetOffsetX = centerXOfItem / MediaQuery.sizeOf(context).width;
  final targetOffsetY = centerYOfItem / MediaQuery.sizeOf(context).height;

  return AnimatedBuilder(
    animation: animation,
    builder: (context, child) {
      final scale = Tween<double>(
        begin: 0.0,
        end: 1.0,
      )
          .animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            ),
          )
          .value;

      return Transform(
        alignment: FractionalOffset(targetOffsetX, targetOffsetY),
        transform: Matrix4.identity()..scale(scale),
        child: child,
      );
    },
    child: child,
  );
}
