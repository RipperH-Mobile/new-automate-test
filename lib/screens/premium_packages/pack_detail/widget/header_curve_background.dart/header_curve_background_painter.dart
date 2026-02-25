import 'package:flutter/material.dart';

class HeaderCurveBackgroundPainter extends CustomPainter {
  Color backgroundColor;
  List<Color> gradientColors;

  HeaderCurveBackgroundPainter({required this.backgroundColor, required this.gradientColors});

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPainter = Paint()
      // ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final backgroundPath = Path();
    backgroundPath.moveTo(0, 0);
    backgroundPath.lineTo(0, size.height);
    backgroundPath.lineTo(size.width, size.height);
    backgroundPath.lineTo(size.width, 0);
    backgroundPath.close();

    canvas.drawPath(backgroundPath, backgroundPainter);

    final topPainter = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: gradientColors,
      ).createShader(Rect.fromLTWH(size.width / 6, size.height / 6, size.width, size.height))
      ..style = PaintingStyle.fill;

    final topPath = Path();
    topPath.moveTo(0, 0);
    topPath.lineTo(0, size.height);
    topPath.quadraticBezierTo(size.width * .5, size.height - 35, size.width, size.height);
    topPath.lineTo(size.width, 0);
    topPath.close();

    canvas.drawPath(topPath, topPainter);
  }

  @override
  bool shouldRepaint(HeaderCurveBackgroundPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(HeaderCurveBackgroundPainter oldDelegate) => false;
}
