
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// this sliver class for custom `Height`
/// for pinned and floating header
/// SliverAppBar does not support custom height (maxExtent and minExtent) always min at ~55.0 pixels


enum SliverToBoxPersistentHeaderBehaviour {
  pinned,
  floating,
}

class SliverToBoxPersistentHeader extends SingleChildRenderObjectWidget {
  final SliverToBoxPersistentHeaderBehaviour scrollBehaviour;

  const SliverToBoxPersistentHeader({
    super.key,
    required super.child,
    this.scrollBehaviour = SliverToBoxPersistentHeaderBehaviour.floating,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    switch (scrollBehaviour) {
      case SliverToBoxPersistentHeaderBehaviour.pinned:
        return _RenderSliverPinnedPersistentHeader();
      case SliverToBoxPersistentHeaderBehaviour.floating:
        return _RenderSliverFloatingPersistentHeader(
          showOnScreenConfiguration:
          const PersistentHeaderShowOnScreenConfiguration(),
        );
    }
  }
}


class _RenderSliverPinnedPersistentHeader
    extends RenderSliverPinnedPersistentHeader {
  @override
  double get maxExtent =>
      child!.getMaxIntrinsicHeight(constraints.crossAxisExtent);

  @override
  double get minExtent => maxExtent;
}

class _RenderSliverFloatingPersistentHeader
    extends RenderSliverFloatingPersistentHeader {
  _RenderSliverFloatingPersistentHeader({
    required super.showOnScreenConfiguration,
  });

  @override
  double get maxExtent =>
      child!.getMaxIntrinsicHeight(constraints.crossAxisExtent);

  @override
  double get minExtent => maxExtent;
}
