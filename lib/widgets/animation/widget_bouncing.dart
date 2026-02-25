import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';

typedef BouncingGestureBuilder = Widget Function(
    void Function()?, void Function()?, AnimationController? animationCtl, double scale);

class BouncingGesture extends StatefulWidget {
  final Widget? child;
  final void Function()? onTap;
  final void Function()? onLongTap;
  final bool isActionWidgetUpdateEnable;
  final int bouncingDurationMilliseconds;
  final bool initialEnable;
  final BouncingGestureBuilder? builder;
  final double upperBound;
  final bool isConcurrency;

  const BouncingGesture({
    super.key,
    this.child,
    this.onTap,
    this.onLongTap,
    this.isActionWidgetUpdateEnable = false,
    this.bouncingDurationMilliseconds = 300,
    this.initialEnable = false,
    this.builder,
    this.upperBound = 0.1,
    this.isConcurrency = false,
  });

  @override
  BouncingGestureState createState() => BouncingGestureState();
}

class BouncingGestureState extends State<BouncingGesture> with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  AnimationController? _controller;

  @override
  void didUpdateWidget(covariant BouncingGesture oldWidget) {
    if (widget.isActionWidgetUpdateEnable) {
      EasyDebounce.debounce(
        'bouncing_animation',
        Duration(milliseconds: widget.bouncingDurationMilliseconds - 50),
        () {
          if (mounted) {
            _controller?.forward();
          }
        },
      );
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: widget.bouncingDurationMilliseconds,
      ),
      lowerBound: 0.0,
      upperBound: widget.upperBound,
    )..addListener(
        () {
          setState(() {
            _scale = 1.0 - _controller!.value;
          });
        },
      );
    _controller?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller?.reverse();
      }
    });

    if (widget.initialEnable) {
      Future.delayed(
        const Duration(milliseconds: 300),
        () {
          _controller?.forward();
        },
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onLongPress() async {
    if (widget.onLongTap == null) return null;
    widget.onLongTap?.call();
    await _controller?.forward();
  }

  void _onTap() async {
    if (widget.onTap == null) return null;
    widget.onTap?.call();
    if (!widget.isConcurrency) {
      await _controller?.forward();
      await Future.delayed(Duration(milliseconds: widget.bouncingDurationMilliseconds));
    } else {
      _controller?.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.builder != null) {
      return Transform.scale(
        scale: _scale,
        child: widget.builder!(_onTap, _onLongPress, _controller, _scale),
      );
    }
    return GestureDetector(
      onLongPress: _onLongPress,
      onTap: _onTap,
      child: Transform.scale(
        scale: _scale,
        child: widget.child ?? Container(),
      ),
    );
  }
}
