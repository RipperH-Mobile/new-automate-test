import 'package:flutter/rendering.dart';

/// This is used to implement how grid item size is calculated.
/// If you want to reuse this elsewhere you have to refactor this class.
///
/// original code is in the example in this url
/// https://api.flutter.dev/flutter/rendering/SliverGridDelegate-class.html
class AlbumGridDelegate extends SliverGridDelegate {
  final double itemSize;
  final int itemCount;
  final double spacing;

  AlbumGridDelegate({
    required this.itemSize,
    required this.itemCount,
    this.spacing = 0,
  });

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    // Determine how many squares we can fit per row.
    int count = constraints.crossAxisExtent ~/ itemSize;
    if (count < 1) {
      count = 1; // Always fit at least one regardless.
    } else if (count > 2) {
      // This ui and calculation in this file only work for two rows.
      count = 2;
    }

    return AlbumGridLayout(
      crossAxisCount: count,
      dimension: itemSize,
      itemCount: itemCount,
      spacing: spacing,
    );
  }

  @override
  bool shouldRelayout(AlbumGridDelegate oldDelegate) {
    return itemSize != oldDelegate.itemSize;
  }
}

class AlbumGridLayout extends SliverGridLayout {
  final int crossAxisCount;
  final double dimension;
  final int itemCount;
  final double spacing;

  const AlbumGridLayout({
    required this.crossAxisCount,
    required this.dimension,
    required this.itemCount,
    required this.spacing,
  }) : assert(crossAxisCount > 0);

  @override
  double computeMaxScrollOffset(int childCount) {
    if (childCount == 0 || dimension == 0) {
      return 0;
    }
    return (childCount ~/ crossAxisCount) * dimension;
  }

  /// Why does spacing is used this way in this function is from pure trial and error and magic.
  @override
  SliverGridGeometry getGeometryForChildIndex(int index) {
    // This returns the position of the index'th tile.
    //
    // The SliverGridGeometry object returned from this method has four
    // properties. For a grid that scrolls down, as in this example, the four
    // properties are equivalent to x,y,width,height. However, since the
    // GridView is direction agnostic, the names used for SliverGridGeometry are
    // also direction-agnostic.
    if (itemCount == 1) {
      /// When grid have only one item * 2 to both width and height to make it use full width and height.
      return SliverGridGeometry(
        scrollOffset: 0, // "y"
        crossAxisOffset: 0, // "x"
        mainAxisExtent: dimension * 2, // "height"
        crossAxisExtent: dimension * 2 + spacing, // "width"
      );
    }
    if (itemCount == 2) {
      /// When grid have two item * 2 to height to make it use full height.
      double horizontalSpacing = 0;
      if (index > 0) {
        horizontalSpacing = spacing;
      }
      return SliverGridGeometry(
        scrollOffset: index * dimension + horizontalSpacing, // "y"
        crossAxisOffset: 0, // "x"
        mainAxisExtent: dimension - horizontalSpacing, // "height"
        crossAxisExtent: dimension * 2 + spacing, // "width"
      );
    }

    /// When grid have more than 2 items
    final int rowIndex = index ~/ crossAxisCount;
    final int columnIndex = index % crossAxisCount;
    double horizontalSpacing = 0;
    if (rowIndex > 0) {
      horizontalSpacing = spacing;
    }
    double verticalSpacing = 0;
    if (columnIndex > 0) {
      verticalSpacing = spacing;
    }

    /// If the number of item is odd, * 2 to make the last item use full height.
    if (itemCount % 2 == 1 && index == itemCount - 1) {
      return SliverGridGeometry(
        scrollOffset: rowIndex * dimension + horizontalSpacing, // "y"
        crossAxisOffset: columnIndex * dimension + verticalSpacing, // "x"
        mainAxisExtent: dimension - horizontalSpacing, // "height"
        crossAxisExtent: (dimension * 2) + spacing, // "width"
      );
    }

    /// Otherwise build the item normally using normal width and height
    return SliverGridGeometry(
      scrollOffset: rowIndex * dimension + horizontalSpacing, // "y"
      crossAxisOffset: columnIndex * dimension + verticalSpacing, // "x"
      mainAxisExtent: dimension - horizontalSpacing, // "height"
      crossAxisExtent: dimension, // "width"
    );
  }

  @override
  int getMaxChildIndexForScrollOffset(double scrollOffset) {
    // This returns the first index that is visible for a given scrollOffset.
    //
    // The GridView only asks for the geometry of children that are visible
    // between the scroll offset passed to getMinChildIndexForScrollOffset and
    // the scroll offset passed to getMaxChildIndexForScrollOffset.
    //
    // It is the responsibility of the SliverGridLayout to ensure that
    // getGeometryForChildIndex is consistent with getMinChildIndexForScrollOffset
    // and getMaxChildIndexForScrollOffset.
    //
    // Not every child between the minimum child index and the maximum child
    // index need be visible (some may have scroll offsets that are outside the
    // view; this happens commonly when the grid view places tiles out of
    // order). However, doing this means the grid view is less efficient, as it
    // will do work for children that are not visible. It is preferred that the
    // children are returned in the order that they are laid out.

    /// This calculation came from trying to change the code from the example in flutter doc
    /// to match our design. How does it work exactly ? probably magic.
    final int rows = scrollOffset ~/ (dimension + spacing);
    return rows * crossAxisCount;
  }

  @override
  int getMinChildIndexForScrollOffset(double scrollOffset) {
    /// This calculation came from trying to change the code from the example in flutter doc
    /// to match our design. How does it work exactly ? probably magic.
    final int rows = scrollOffset ~/ (dimension + spacing);
    return rows * crossAxisCount;
  }
}
