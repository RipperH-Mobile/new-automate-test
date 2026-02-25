import 'package:flutter/material.dart';

class HeaderCurveBackground extends StatefulWidget {
  final Size size;
  final Color backgroundColor;
  final List<Color> gradientColors;
  final Widget child;

  const HeaderCurveBackground({
    super.key,
    required this.size,
    required this.backgroundColor,
    required this.gradientColors,
    required this.child,
  });

  @override
  State<HeaderCurveBackground> createState() => _HeaderCurveBackgroundState();
}

class _HeaderCurveBackgroundState extends State<HeaderCurveBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Define the animation value between 0.0 and 1.0
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Start the animation
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: widget.size,
      painter: RadialGradientPainter(
        progress: _animation.value,
        startColors: [
          Colors.black,
          Colors.black,
          Colors.black,
          Colors.black,
          Colors.black,
        ],
        endColors: widget.gradientColors,
        backgroundColor: widget.backgroundColor,
      ),
      child: widget.child,
    );
  }
}

class RadialGradientPainter extends CustomPainter {
  final double progress;
  final List<Color> startColors;
  final List<Color> endColors;
  final Color backgroundColor;

  RadialGradientPainter({
    required this.progress,
    required this.startColors,
    required this.endColors,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPainter = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

// Background path (just a rectangle as you have)
    final backgroundPath = Path();
    backgroundPath.moveTo(0, 0);
    backgroundPath.lineTo(0, size.height);
    backgroundPath.lineTo(size.width, size.height);
    backgroundPath.lineTo(size.width, 0);
    backgroundPath.close();

    canvas.drawPath(backgroundPath, backgroundPainter);

// Painter for the gradient on top
    final topPainter = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: endColors,
      ).createShader(Rect.fromLTWH(size.width / 6, size.height / 6, size.width, size.height))
      ..style = PaintingStyle.fill;

// Path with a curved top starting at (0, 35) and ending at (size.width, 35)
    final topPath = Path();
    topPath.moveTo(0, 15); // Start at the left side at y = 35
    topPath.quadraticBezierTo(size.width * 0.5, -15, size.width, 15); // Curve that dips upward
    topPath.lineTo(size.width, size.height); // Draw the right side straight down
    topPath.lineTo(0, size.height); // Draw the left side straight down
    topPath.close();

    canvas.drawPath(topPath, topPainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
