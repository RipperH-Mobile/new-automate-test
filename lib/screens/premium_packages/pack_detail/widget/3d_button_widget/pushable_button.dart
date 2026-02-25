import 'package:flutter/material.dart';
import 'package:uchat/screens/premium_packages/pack_detail/widget/3d_button_widget/animated_controller_state.dart';

/// A widget to show a "3D" pushable button
class PushableButton extends StatefulWidget {
  const PushableButton({
    super.key,
    this.child,
    required this.hslColor,
    required this.height,
    this.elevation = 12.0,
    this.shadow,
    this.onPressed,
    this.border,
  }) : assert(height > 0);

  /// child widget (normally a Text or Icon)
  final Widget? child;

  /// Color of the top layer
  /// The color of the bottom layer is derived by decreasing the luminosity by 0.15
  final HSLColor hslColor;

  /// height of the top layer
  final double height;

  /// elevation or "gap" between the top and bottom layer
  final double elevation;

  /// An optional shadow to make the button look better
  /// This is added to the bottom layer only
  final BoxShadow? shadow;

  /// button pressed callback
  final VoidCallback? onPressed;

  final BorderRadiusGeometry? border;

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _PushableButtonState createState() => _PushableButtonState(const Duration(milliseconds: 100));
}

class _PushableButtonState extends AnimationControllerState<PushableButton> {
  _PushableButtonState(super.duration);

  bool _isDragInProgress = false;
  Offset _gestureLocation = Offset.zero;

  void _handleTapDown(TapDownDetails details) {
    _gestureLocation = details.localPosition;
    animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    animationController.reverse();
  }

  void _handleTap() async {
    animationController.forward();
    widget.onPressed?.call();
    await Future.delayed(const Duration(milliseconds: 200));
    animationController.reverse();
  }

  void _handleTapCancel() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!_isDragInProgress && mounted) {
        animationController.reverse();
      }
    });
  }

  void _handleDragStart(DragStartDetails details) {
    _gestureLocation = details.localPosition;
    _isDragInProgress = true;
    animationController.forward();
  }

  void _handleDragEnd(Size buttonSize) {
    //print('drag end (in progress: $_isDragInProgress)');
    if (_isDragInProgress) {
      _isDragInProgress = false;
      animationController.reverse();
    }
    if (_gestureLocation.dx >= 0 &&
        _gestureLocation.dy < buttonSize.width &&
        _gestureLocation.dy >= 0 &&
        _gestureLocation.dy < buttonSize.height) {
      widget.onPressed?.call();
    }
  }

  void _handleDragCancel() {
    if (_isDragInProgress) {
      _isDragInProgress = false;
      animationController.reverse();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _gestureLocation = details.localPosition;
  }

  @override
  Widget build(BuildContext context) {
    final totalHeight = widget.height + widget.elevation;
    return SizedBox(
      height: totalHeight,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final buttonSize = Size(constraints.maxWidth, constraints.maxHeight);
          return IgnorePointer(
            ignoring: widget.onPressed == null,
            child: GestureDetector(
              onTap: _handleTap,
              onTapDown: _handleTapDown,
              onTapUp: _handleTapUp,
              onTapCancel: _handleTapCancel,
              onHorizontalDragStart: _handleDragStart,
              onHorizontalDragEnd: (_) => _handleDragEnd(buttonSize),
              onHorizontalDragCancel: _handleDragCancel,
              onHorizontalDragUpdate: _handleDragUpdate,
              onVerticalDragStart: _handleDragStart,
              onVerticalDragEnd: (_) => _handleDragEnd(buttonSize),
              onVerticalDragCancel: _handleDragCancel,
              onVerticalDragUpdate: _handleDragUpdate,
              child: AnimatedBuilder(
                animation: animationController,
                builder: (context, child) {
                  final top = animationController.value * widget.elevation;
                  final hslColor = widget.hslColor;
                  final bottomHslColor = hslColor.withLightness(hslColor.lightness - 0.15);
                  return Stack(
                    children: [
                      // Draw bottom layer first
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: totalHeight - top,
                          decoration: BoxDecoration(
                            color: bottomHslColor.toColor(),
                            boxShadow: widget.shadow != null ? [widget.shadow!] : [],
                            borderRadius: widget.border,
                          ),
                        ),
                      ),
                      // Then top (pushable) layer
                      Positioned(
                        left: 0,
                        right: 0,
                        top: top,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          height: widget.height,
                          decoration: BoxDecoration(
                            color: hslColor.toColor(),
                            borderRadius: widget.border,
                          ),
                          child: Center(child: widget.child),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
