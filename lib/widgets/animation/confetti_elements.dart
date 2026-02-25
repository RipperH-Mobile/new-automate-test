import 'dart:math';
import 'package:flutter/material.dart';

/// A custom Path to paint stars.
Path drawStar(Size size) {
  // Method to convert degree to radians
  double degToRad(double deg) => deg * (pi / 180.0);

  const numberOfPoints = 5;
  final halfWidth = size.width / 2;
  final externalRadius = halfWidth;
  final internalRadius = halfWidth / 2.5;
  final degreesPerStep = degToRad(360 / numberOfPoints);
  final halfDegreesPerStep = degreesPerStep / 2;
  final path = Path();
  final fullAngle = degToRad(360);
  path.moveTo(size.width, halfWidth);

  for (double step = 0; step < fullAngle; step += degreesPerStep) {
    path.lineTo(halfWidth + externalRadius * cos(step), halfWidth + externalRadius * sin(step));
    path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
        halfWidth + internalRadius * sin(step + halfDegreesPerStep));
  }
  path.close();
  return path;
}

Path drawCoin(Size size) {
  final path = Path();
  final center = Offset(size.width, size.height);
  final radius = min(size.width, size.height);

  // Draw the outer circle
  path.addOval(Rect.fromCircle(center: center, radius: radius));

  // Define the positions and thickness of the lines and the curve
  double lineThickness = radius * 0.0015; // Set line thickness
  double lineLength = radius * 0.8; // Set length of lines
  double line2Length = radius; // Set length of lines

  double widthSize = radius * 0.3 / 1.1;
  double heightSize = radius * 0.15 / 1.1;
  // Create paths for horizontal and vertical lines
  final horizontalLine = Path();
  final horizontal2lLine = Path();
  final verticalLine = Path();
  final vertical2Line = Path();

  // Horizontal Line
  horizontalLine.moveTo(center.dx - line2Length / 2, (center.dy - lineThickness / 2) - heightSize);
  horizontalLine.lineTo(center.dx + line2Length / 2, (center.dy - lineThickness / 2) - heightSize);
  horizontalLine.close();

  horizontal2lLine.moveTo(center.dx - line2Length / 2, (center.dy - lineThickness / 2) + heightSize);
  horizontal2lLine.lineTo(center.dx + line2Length / 2, (center.dy - lineThickness / 2) + heightSize);
  horizontal2lLine.close();

  // Vertical Line
  verticalLine.moveTo((center.dx - lineThickness / 2) - widthSize, center.dy - lineLength / 2);
  verticalLine.lineTo((center.dx - lineThickness / 2) - widthSize, center.dy + lineLength / 2);
  verticalLine.close();

  vertical2Line.moveTo((center.dx - lineThickness / 2) + widthSize, center.dy - lineLength / 2);
  vertical2Line.lineTo((center.dx - lineThickness / 2) + widthSize, center.dy + lineLength / 2);
  vertical2Line.close();
  // Create path for the curve (smile)
  final curvePath = Path();
  curvePath.moveTo((center.dx - lineThickness / 2) - widthSize, center.dy + lineLength / 2);
  curvePath.quadraticBezierTo(
    center.dx,
    (center.dy + lineLength / 1.0),
    (center.dx - lineThickness / 2) + widthSize,
    center.dy + lineLength / 2,
  );
  curvePath.close();

  // Add paths to main path
  path.addPath(horizontalLine, Offset.zero);
  path.addPath(horizontal2lLine, Offset.zero);
  path.addPath(verticalLine, Offset.zero);
  path.addPath(vertical2Line, Offset.zero);
  path.addPath(curvePath, Offset.zero);

  return path;
}
