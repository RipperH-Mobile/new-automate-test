import 'package:flutter/material.dart';
import 'dart:math' as math show sqrt;

class CirclePainter extends CustomPainter {
  final Color color;
  final Animation<double> _animation;
  final int waveNumber;
  final bool isDisableSignalAnimation;
  final int strokeWidth;
  final double screenWidth;

  CirclePainter(
    this._animation, {
    required this.color,
    this.waveNumber = 3,
    this.strokeWidth = 3,
    this.isDisableSignalAnimation = false,
    this.screenWidth = 410,
  }) : super(repaint: _animation);

  void circleBorder(Canvas canvas, Rect rect, double value) {
    final double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    final double size = rect.width / 2;
    final double area = size * size;
    final double radius = math.sqrt(area * value / 4);
    Paint paintCircleBorder = Paint()
      ..color = color.withValues(alpha: opacity)
      ..strokeWidth = strokeWidth * opacity
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(rect.center, radius, paintCircleBorder);
  }

  void circle(Canvas canvas, Rect rect, double value) {
    double dx = (rect.center.dx - screenWidth * 0.5) - (rect.center.dx - (screenWidth * 0.5 * value));
    final Paint paintCircle = Paint()..color = const Color(0xff56F5B2);
    canvas.drawCircle(Offset(dx + 50, rect.center.dy), 5, paintCircle);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    //Line center
    if (!isDisableSignalAnimation) {
      Paint linePaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.5)
        ..strokeWidth = 2;
      canvas.drawLine(Offset(rect.center.dx - screenWidth * 0.5, rect.center.dy), rect.center, linePaint);
    }

    //Circle border wave ripper
    for (int wave = waveNumber; wave >= 0; wave--) {
      circleBorder(canvas, rect, wave + _animation.value);
    }

    //circle from left to right
    if (!isDisableSignalAnimation) {
      circle(canvas, rect, _animation.value);
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => true;
}
