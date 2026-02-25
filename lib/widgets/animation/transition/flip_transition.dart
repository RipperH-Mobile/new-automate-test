import 'dart:math';

import 'package:flutter/material.dart';

AnimatedBuilder flipTransitionBuilder(Widget widget, Animation<double> animation, bool flipXAxis) {
  final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
  return AnimatedBuilder(
    animation: rotateAnim,
    child: widget,
    builder: (context, widget) {
      final isUnder = (const ValueKey('showFrontSide') != widget?.key);
      var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
      tilt *= isUnder ? -1.0 : 1.0;
      final value = isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
      return Transform(
        transform: flipXAxis
            ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt)) // Horizontal
            : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)), // Vertical
        alignment: Alignment.center,
        child: widget,
      );
    },
  );
}
