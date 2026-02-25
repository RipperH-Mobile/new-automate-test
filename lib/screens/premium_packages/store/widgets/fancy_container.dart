import 'package:flutter/material.dart';

class FancyContainer extends StatefulWidget {
  final Size size;
  final Duration cycle;
  final List<Color> colors;
  final Widget child;
  final AlignmentGeometry bgIconStart;
  final AlignmentGeometry bgIconEnd;
  final BorderRadiusGeometry borderRadius;
  const FancyContainer({
    super.key,
    required this.size,
    required this.cycle,
    required this.colors,
    required this.child,
    this.bgIconStart = Alignment.topCenter,
    this.bgIconEnd = Alignment.bottomCenter,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  State<FancyContainer> createState() => _FancyContainer();
}

class _FancyContainer extends State<FancyContainer> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: widget.cycle,
      vsync: this,
    )
      ..forward()
      ..addListener(() {
        if (controller.isCompleted) {
          controller.repeat();
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final aspectRatio = widget.size.height / widget.size.width;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Container(
          width: widget.size.width,
          height: widget.size.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            gradient: LinearGradient(
              tileMode: TileMode.mirror,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: SlideGradient(
                controller.value,
                widget.size.height * aspectRatio,
              ),
              colors: widget.colors,
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}

class SlideGradient implements GradientTransform {
  final double value;
  final double offset;

  const SlideGradient(this.value, this.offset);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final dist = value * (bounds.width + offset);
    return Matrix4.identity()..translate(-dist);
  }
}
