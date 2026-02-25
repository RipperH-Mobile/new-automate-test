import 'package:flutter/material.dart';

SlideTransition fromRightTransitionBuilder(
  Widget child,
  Animation<double> animate,
) {
  const bOffset = Offset(1, 0);
  const eOffset = Offset(0, 0);
  final curve = CurvedAnimation(
    parent: animate,
    curve: Curves.decelerate,
  );
  return SlideTransition(
    position: Tween<Offset>(begin: bOffset, end: eOffset).animate(curve),
    child: child,
  );
}
