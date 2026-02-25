///
/// Created by NieBin on 2019/1/4
/// Github: https://github.com/nb312
/// Email: niebin312@gmail.com
///
library;

import 'package:flutter/material.dart';
// ignore_for_file: constant_identifier_names

import 'dart:math';
import 'dart:ui';

import 'circle.dart';
import 'line.dart';

const GREEN_NORMAL = Color(0xff6bde54);
const BLUE_DARK2 = Color(0xff01579b);
const BLUE_DARK1 = Color(0xff29b6f6);
const RED_DARK1 = Color(0xfff26388);
const YELLOW_NORMAL = Color(0xfffcce89);

class PolygonUtil {
  static List<Point> convertToPoints(Point center, double r, int length, {double startRadian = 0.0}) {
    List<Point<num>> list = [];
    double perRadian = 2.0 * pi / length;
    for (int i = 0; i < length; i++) {
      double radian = i * perRadian + startRadian;
      var p = LineCircle.radianPoint(center, r, radian);
      list.add(p);
    }
    return list;
  }

  static Path drawRoundPolygon(List<Point> listPoints, Canvas canvas, Paint paint,
      {double distance = 4.0, double radius = 0.0}) {
    if (radius < 0.01) {
      radius = 6 * distance;
    }
    var path = Path();
    listPoints.add(listPoints[0]);
    listPoints.add(listPoints[1]);
    if (paint.style == PaintingStyle.stroke) {
      listPoints.add(listPoints[2]);
    }
    var p0 = LineInterCircle.intersectionPoint(listPoints[1], listPoints[0], distance);
    path.moveTo(p0.x.toDouble(), p0.y.toDouble());
    for (int i = 0; i < listPoints.length - 2; i++) {
      var p1 = listPoints[i];
      var p2 = listPoints[i + 1];
      var p3 = listPoints[i + 2];
      var interP1 = LineInterCircle.intersectionPoint(p1, p2, distance);
      var interP2 = LineInterCircle.intersectionPoint(p3, p2, distance);
      path.lineTo(interP1.x.toDouble(), interP1.y.toDouble());
      path.arcToPoint(
        Offset(interP2.x.toDouble(), interP2.y.toDouble()),
        radius: Radius.circular(radius),
      );
    }
    return path;
  }
}
