import 'dart:ui';

import 'package:flutter/material.dart';

class BlurBox extends StatelessWidget {
  final Widget child;
  final BoxDecoration decoration;
  final double blurWeight;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry? containerPadding;

  const BlurBox({
    super.key,
    required this.child,
    this.decoration = const BoxDecoration(),
    this.blurWeight = 16.0,
    this.borderRadius = BorderRadius.zero,
    this.containerPadding,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurWeight,
          sigmaY: blurWeight,
        ),
        child: Container(
          padding: containerPadding,
          decoration: decoration.copyWith(
            borderRadius: borderRadius,
          ),
          child: child,
        ),
      ),
    );
  }
}
