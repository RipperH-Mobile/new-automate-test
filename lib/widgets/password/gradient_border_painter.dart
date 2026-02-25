import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradientBorderPainter extends CustomPainter {
  final double strokeWidth;
  final Gradient gradient;
  final Radius? radius;

  GradientBorderPainter({
    this.strokeWidth = 1.0,
    required this.gradient,
    this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Create a rectangle to draw the border on
    Rect rect = Offset.zero & size;
    // Define the border's paint style
    Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..shader = gradient.createShader(rect);

    // Draw the rounded rectangle border with gradient
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, radius ?? Radius.circular(12.r)),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
