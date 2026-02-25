import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  final bool enable;
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;

  const ShimmerLoading({
    super.key,
    required this.enable,
    required this.child,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: enable,
      baseColor: baseColor ?? Colors.grey.shade200,
      highlightColor: highlightColor ?? Colors.grey.shade300,
      child: child,
    );
  }
}
