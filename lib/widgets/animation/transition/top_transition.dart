import 'package:flutter/material.dart';

SlideTransition fromTopTransitionBuilder(
  Widget child,
  Animation<double> animate, {
  Curve? curve,
  Curve? reverseCurve,
}) {
  const bOffset = Offset(0, -1);
  const eOffset = Offset(0, 0);
  final tempCurve = CurvedAnimation(
    parent: animate,
    curve: Curves.decelerate,
  );
  return SlideTransition(
    position: Tween<Offset>(begin: bOffset, end: eOffset).animate(tempCurve),
    child: FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animate,
          curve: curve ?? const Interval(0.5, 1.0),
          reverseCurve: reverseCurve ?? const Interval(0.0, 0.5),
        ),
      ),
      child: child,
    ),
  );
}
