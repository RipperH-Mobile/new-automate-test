import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uchat/themes/themes.dart';

class StateCapital {
  String name;
  String capital;
  StateCapital({required this.name, required this.capital});
}

class GridViewWithSkeletonLoading extends StatefulWidget {
  final Widget widget;
  final int itemCount;
  final int crossAxisCount;
  final double childAspectRatio;
  final EdgeInsetsGeometry paddingGridViewSkeleton;
  final bool isLoading;
  const GridViewWithSkeletonLoading({
    super.key,
    required this.widget,
    required this.itemCount,
    required this.crossAxisCount,
    required this.childAspectRatio,
    this.paddingGridViewSkeleton = EdgeInsets.zero,
    this.isLoading = true,
  });

  @override
  GridViewWitSkeletonLoadingState createState() => GridViewWitSkeletonLoadingState();
}

class GridViewWitSkeletonLoadingState extends State<GridViewWithSkeletonLoading> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (widget.isLoading) {
      return Column(
        children: [
          Expanded(
            child: Shimmer.fromColors(
              baseColor: const Color(0xFFE0E0E0),
              highlightColor: UTheme.color.primary.withValues(alpha: 0.3),
              direction: ShimmerDirection.ltr,
              period: const Duration(seconds: 2),
              child: GridView.builder(
                padding: widget.paddingGridViewSkeleton,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, __) => Card(
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  color: Colors.transparent,
                  child: Container(
                    // width: Get.width / 3.2,
                    // height: Get.width / 3.2,
                    color: Colors.white,
                  ),
                ),
                itemCount: widget.itemCount,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.crossAxisCount,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  childAspectRatio: widget.childAspectRatio,
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return widget.widget;
    }
  }
}
