import 'package:flutter/material.dart';
import 'package:flutter_animarker/helpers/extensions.dart';
import 'package:uchat/widgets/animation/circle_ripper/circle_painter.dart';
import 'package:uchat/widgets/animation/circle_ripper/curve_wave.dart';

typedef PlayWaveBuilder = Widget Function(AnimationController? animateCtl);

class RipplesAnimation extends StatefulWidget {
  const RipplesAnimation({
    super.key,
    this.size = 80.0,
    this.color = Colors.red,
    this.onPressed,
    this.isDisableSignalAnimation = false,
    this.waveLoop = false,
    this.waveNumber = 3,
    this.borderWeight = 3,
    this.waveDuration = const Duration(seconds: 2),
    required this.builder,
    this.screenWidth = 410,
  });
  final double size;
  final Color color;
  final VoidCallback? onPressed;
  final bool isDisableSignalAnimation;
  final bool waveLoop;
  final int waveNumber;
  final int borderWeight;
  final Duration waveDuration;
  final PlayWaveBuilder builder;
  final double screenWidth;

  @override
  RipplesAnimationState createState() => RipplesAnimationState();
}

class RipplesAnimationState extends State<RipplesAnimation> with TickerProviderStateMixin {
  AnimationController? _controller;
  bool hideAnimation = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.waveDuration,
      upperBound: 1.0,
      vsync: this,
    );
    _controller?.addStatusListener((AnimationStatus status) {
      if (status.isCompletedOrDismissed) {
        setState(() {
          hideAnimation = true;
        });
      } else {
        setState(() {
          hideAnimation = false;
        });
      }
    });
    _controller?.forward(from: 1.0);
    if (widget.waveLoop) {
      _controller!.repeat();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget _button() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.size),
        child: widget.isDisableSignalAnimation
            ? widget.builder(_controller)
            : DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: <Color>[
                      widget.color,
                      Color.lerp(
                        widget.color,
                        Colors.black,
                        .05,
                      )!
                    ],
                  ),
                ),
                child: ScaleTransition(
                  scale: Tween(begin: 0.95, end: 1.0).animate(
                    CurvedAnimation(
                      parent: _controller!,
                      curve: const CurveWave(),
                    ),
                  ),
                  child: widget.builder(_controller),
                  // child: SizedBox(),
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: hideAnimation ? 0 : 1,
            child: CustomPaint(
              painter: CirclePainter(
                _controller!,
                screenWidth: widget.screenWidth,
                color: widget.color,
                strokeWidth: widget.borderWeight,
                waveNumber: widget.waveNumber,
                isDisableSignalAnimation: widget.isDisableSignalAnimation,
              ),
              child: SizedBox(
                width: widget.size * 2,
                height: widget.size * 2,
              ),
            ),
          ),
          SizedBox(
            width: widget.size * 2,
            height: widget.size * 2,
            child: _button(),
          )
        ],
      ),
    );
  }
}
