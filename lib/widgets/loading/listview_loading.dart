import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

final _log = useLogger();

class StateCapital {
  String name;
  String capital;
  StateCapital({required this.name, required this.capital});
}

class ListViewWithSkeletonLoading extends StatefulWidget {
  final Widget widget;
  final Widget widgetLoading;
  final int itemCount;
  final int crossAxisCount;
  final double childAspectRatio;
  final EdgeInsetsGeometry paddingGridViewSkeleton;
  final bool isLoading;
  const ListViewWithSkeletonLoading(
      {super.key,
      required this.widget,
      required this.widgetLoading,
      required this.itemCount,
      required this.crossAxisCount,
      required this.childAspectRatio,
      this.paddingGridViewSkeleton = EdgeInsets.zero,
      this.isLoading = true});

  @override
  ListViewWithSkeletonLoadingState createState() => ListViewWithSkeletonLoadingState();
}

class ListViewWithSkeletonLoadingState extends State<ListViewWithSkeletonLoading> {
  @override
  void initState() {
    _log.d('logging loading param ${widget.isLoading}');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (widget.isLoading) {
      return SizedBox(
        width: Get.width,
        height: Get.height,
        child: Shimmer.fromColors(
          baseColor: const Color(0xFFE0E0E0),
          highlightColor: UTheme.color.primary.withValues(alpha: 0.3),
          direction: ShimmerDirection.ltr,
          period: const Duration(seconds: 2),
          child: ListView.builder(
            shrinkWrap: true,
            padding: widget.paddingGridViewSkeleton,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, __) => widget.widgetLoading,
            itemCount: widget.itemCount,
          ),
        ),
      );
    } else {
      return widget.widget;
    }
  }
}
