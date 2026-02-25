import 'package:flutter/material.dart';

ScaleTransition scaleTransitionBuilder(
  Widget child,
  Animation<double> animate,
) {
  final curve = CurvedAnimation(
    parent: animate,
    curve: Curves.decelerate,
  );
  return ScaleTransition(
    scale: Tween<double>(begin: 0.0, end: 1.0).animate(curve),
    child: FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animate,
          curve: const Interval(0.5, 1.0),
          reverseCurve: const Interval(0.0, 0.5),
        ),
      ),
      child: child,
    ),
  );
}
