import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uchat/screens/premium_packages/premium_icon/round_polygon_painter.dart';

class PremiumIconCustomPaintExample extends StatefulWidget {
  final AlignmentGeometry bgIconStart;
  final AlignmentGeometry bgIconEnd;
  final List<Color> iconBgColors;

  const PremiumIconCustomPaintExample({
    super.key,
    this.bgIconStart = Alignment.topCenter,
    this.bgIconEnd = Alignment.bottomCenter,
    required this.iconBgColors,
  });

  @override
  State<PremiumIconCustomPaintExample> createState() => _PremiumIconCustomPaintExampleState();
}

class _PremiumIconCustomPaintExampleState extends State<PremiumIconCustomPaintExample> {
  bool _showFrontSide = false;
  bool _flipXAxis = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: widget.bgIconStart,
            end: widget.bgIconEnd,
            colors: widget.iconBgColors,
          ),
          borderRadius: BorderRadius.circular(20.spMin),
        ),
        width: 120,
        height: 120,
        child: _buildFlipAnimation(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _showFrontSide = true;
    _flipXAxis = true;
  }

  void _switchCard() {
    setState(() {
      _showFrontSide = !_showFrontSide;
    });
  }

  Widget _buildFlipAnimation() {
    return GestureDetector(
      onTap: _switchCard,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
        child: _showFrontSide ? _buildFront() : _buildRear(),
      ),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget?.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value = isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: _flipXAxis
              ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
              : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }

  Widget _buildFront() {
    return SizedBox(
      width: 120,
      height: 120,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomPaint(
          painter: RoundPolygonPainter(),
        ),
      ),
    );
  }

  Widget _buildRear() {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(pi),
      child: SizedBox(
        width: 120,
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomPaint(
            painter: RoundPolygonPainter(),
          ),
        ),
      ),
    );
  }
}
