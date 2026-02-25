import 'package:flutter/material.dart';

enum SwipeDirection {
  right,
  left,
}

class SwipeToDismiss extends StatefulWidget {
  final Widget child;
  final VoidCallback onDismiss;
  final SwipeDirection direction;

  const SwipeToDismiss({
    super.key,
    required this.child,
    required this.onDismiss,
    this.direction = SwipeDirection.right,
  });

  @override
  State<SwipeToDismiss> createState() => _SwipeToDismissState();
}

class _SwipeToDismissState extends State<SwipeToDismiss> {
  bool _isDragging = false;
  final _dragAreaWidthFactor = 0.2;
  final _minFlingVelocity = 300;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (details) {
        final screenWidth = MediaQuery.of(context).size.width;
        if (widget.direction == SwipeDirection.right && 
            details.localPosition.dx < screenWidth * _dragAreaWidthFactor) {
          _isDragging = true;
        } else if (widget.direction == SwipeDirection.left && 
                  details.localPosition.dx > screenWidth * (1 - _dragAreaWidthFactor)) {
          _isDragging = true;
        }
      },
      onHorizontalDragUpdate: (details) {
        if (!_isDragging) return;
      },
      onHorizontalDragEnd: (details) {
        if (!_isDragging) return;
        
        if (details.primaryVelocity != null) {
          if ((widget.direction == SwipeDirection.right && details.primaryVelocity! > _minFlingVelocity) ||
              (widget.direction == SwipeDirection.left && details.primaryVelocity! < -_minFlingVelocity)) {
            widget.onDismiss();
          }
        }
        
        _isDragging = false;
      },
      behavior: HitTestBehavior.translucent,
      child: widget.child,
    );
  }
}
