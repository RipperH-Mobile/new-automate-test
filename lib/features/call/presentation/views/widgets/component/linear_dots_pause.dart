import 'dart:math';
import 'package:flutter/material.dart';

const double kDefaultDotNumber = 4.0;
const double kDefaultDotSize = 3.0;
const double kDefaultDotSpacing = 13;

// No lib support this animation
// Create a linear dots animation with a pause in the middle
// Following design https://www.figma.com/design/p405Zjn9z8p0mBY8zPfb46/UChat-V.3-MVP-2?node-id=1465-3378&t=0nhlpcKHt09v85Zz-1
class LinearDotsWithPause extends StatefulWidget {
  final Color color;
  final double size;

  const LinearDotsWithPause({
    super.key,
    this.color = Colors.white,
    this.size = 40,
  });

  @override
  AnimatedLoaderState createState() => AnimatedLoaderState();
}

class AnimatedLoaderState extends State<LinearDotsWithPause> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500), // 1.5 seconds for animation + pause
    );

    _animation = Tween<double>(begin: 0, end: kDefaultDotNumber).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 1.0, curve: Curves.linear), // Animation happens in first 75% of the cycle
      ),
    );

    _startAnimation();
  }

  void _startAnimation() async {
    while (mounted) {
      await _controller.forward();
      await Future.delayed(const Duration(milliseconds: 500)); // 0.5 second pause
      if (mounted) _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size + 5,
      height: widget.size,
      child: CustomPaint(
        painter: _LoaderPainter(
          color: widget.color,
          animation: _animation,
        ),
      ),
    );
  }
}

class _LoaderPainter extends CustomPainter {
  final Color color;
  final Animation<double> animation;

  _LoaderPainter({required this.color, required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final dotRadius = kDefaultDotSize;
    final dotSpacing = kDefaultDotSpacing;

    for (int i = 0; i < kDefaultDotNumber; i++) {
      final x = i * dotSpacing;
      double y;
      if (animation.value >= i && animation.value < i + 1) {
        final t = animation.value - i;
        y = size.height / 2 - sin(t * pi) * (dotRadius * 2.5); // Reduced bounce height
      } else {
        y = size.height / 2;
      }

      canvas.drawCircle(Offset(x, y), dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
