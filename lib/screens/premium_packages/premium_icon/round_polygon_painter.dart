import 'package:flutter/material.dart';
import 'dart:math';
import 'package:uchat/screens/premium_packages/premium_icon/round_polygon_util.dart';


class RoundPolygonPainter extends CustomPainter {
  final Color color;
  final bool hasShadow;

  RoundPolygonPainter({this.color = Colors.white, this.hasShadow = true});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    double w = size.width;
    double h = size.height;

    List<Point> theStar = [
      Point(w * 0.5, h * 0.0),
      Point(w * 0.7, h * 0.35),
      Point(w * 1.0, h * 0.5),
      Point(w * 0.7, h * 0.65),
      Point(w * 0.5, h * 1.0),
      Point(w * 0.3, h * 0.65),
      Point(w * 0.0, h * 0.5),
      Point(w * 0.3, h * 0.35),
    ];
    paint.color = color;
    _drawWithPoint(canvas, paint, theStar);
    if (hasShadow) {
      List<Point> shadow1 = [
        Point(w * 0.0, h * 0.5),
        Point(w * 0.3, h * 0.35),
        Point(w * 0.5, h * 0.0),
        Point(w/2.5, h/2.5),
      ];
      paint.color = color;
      _drawWithPoint(canvas, paint, shadow1, hasShadow: hasShadow);

      List<Point> shadow2 = [
        Point(w * 1.0, h * 0.5),
        Point(w * 0.7, h * 0.65),
        Point(w * 0.5, h * 1.0),
        Point(w/1.7, h/1.7),

      ];
      paint.color = color;
      _drawWithPoint(canvas, paint, shadow2, hasShadow: hasShadow);
    }


    canvas.save();
    canvas.restore();
  }

  void _drawWithPoint(canvas, paint, list, {hasShadow = false}) {
    // list = _resizePoint(list);
    var path = PolygonUtil.drawRoundPolygon(list, canvas, paint, distance: 2.0, radius: 10);
    if (hasShadow) {
      canvas.drawShadow(path, color, 10.0, true);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
