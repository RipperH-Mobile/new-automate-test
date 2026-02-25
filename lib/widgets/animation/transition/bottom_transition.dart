import 'package:flutter/material.dart';

SlideTransition fromBottomTransitionBuilder(
  Widget child,
  Animation<double> animate, {
  bool? disableFade,
}) {
  const bOffset = Offset(0, 1);
  const eOffset = Offset(0, 0);
  final curve = CurvedAnimation(
    parent: animate,
    curve: Curves.decelerate,
  );
  return SlideTransition(
    position: Tween<Offset>(begin: bOffset, end: eOffset).animate(curve),
    child: disableFade == true
        ? child
        : FadeTransition(
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
