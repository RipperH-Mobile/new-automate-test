import 'package:flutter/material.dart';

/// Custom scroll physics that make the list stay still
///
/// This scroll physics is used to make the list stay at the current position when the item added to the first index.
/// This scroll physics is used in the [MainMessageList] widget.
///
/// Reference: https://github.com/flutter/flutter/issues/63946#issuecomment-1000442747
class AlwaysScrollableFixedPositionScrollPhysics extends ScrollPhysics {
  final double extendFirstItemHeight;

  /// Creates scroll physics that always lets the user scroll.
  const AlwaysScrollableFixedPositionScrollPhysics({super.parent, this.extendFirstItemHeight = 0.0});

  @override
  AlwaysScrollableFixedPositionScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return AlwaysScrollableFixedPositionScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double adjustPositionForNewDimensions({
    required ScrollMetrics oldPosition,
    required ScrollMetrics newPosition,
    required bool isScrolling,
    required double velocity,
  }) {
    if (!isScrolling && oldPosition.extentBefore > extendFirstItemHeight) {
      return newPosition.maxScrollExtent - oldPosition.extentAfter;
    }

    return super.adjustPositionForNewDimensions(
      oldPosition: oldPosition,
      newPosition: newPosition,
      isScrolling: isScrolling,
      velocity: velocity,
    );
  }

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) => true;
}
