import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';

class SnappingBottomSheet extends StatefulWidget {
  final Widget header;
  final Widget Function(BuildContext, DraggableScrollableController) contentBuilder;
  final List<double> snapPositions;
  final double initialSnap;
  final FocusNode? focusNode;
  final void Function(bool)? isFull;
  final Widget? floatButton;

  const SnappingBottomSheet({
    super.key,
    required this.header,
    required this.contentBuilder,
    this.snapPositions = const [0.25, 0.50, 0.95],
    this.initialSnap = 0.25,
    this.focusNode,
    this.isFull,
    this.floatButton,
  });

  @override
  State<SnappingBottomSheet> createState() => _SnappingBottomSheetState();
}

class _SnappingBottomSheetState extends State<SnappingBottomSheet> {
  late DraggableScrollableController _draggableController;
  bool _isFull = false;
  Timer? _snapTimer;

  @override
  void initState() {
    _draggableController = DraggableScrollableController();
    widget.focusNode?.addListener(_handleFocusChange);
    _draggableController.addListener(_handleSizeChange);
    super.initState();
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(_handleFocusChange);
    _draggableController.removeListener(_handleSizeChange);
    _snapTimer?.cancel();
    super.dispose();
  }

  void _handleFocusChange() {
    if (widget.focusNode!.hasFocus) {
      // When a TextField gains focus, immediately animate to the largest snap.
      _animateTo(widget.snapPositions.last);
    }
  }

  void _handleSizeChange() {
    // Update full-screen status based on a chosen threshold.
    final bool newIsFull = _draggableController.size > 0.90;
    if (newIsFull != _isFull) {
      setState(() {
        _isFull = newIsFull;
      });
    }
    widget.isFull?.call(newIsFull);
  }

  Future<void> _animateTo(double snap) async {
    await _draggableController.animateTo(
      snap,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// Returns the snap value nearest to the current extent.
  double _getNearestSnap(double extent) {
    return widget.snapPositions.reduce((a, b) => (extent - a).abs() < (extent - b).abs() ? a : b);
  }

  @override
  Widget build(BuildContext context) {
    final sorted = [...widget.snapPositions]..sort();
    final minSnap = sorted.first;
    final maxSnap = sorted.last;
    final initialSnap = widget.initialSnap.clamp(minSnap, maxSnap);

    return NotificationListener<DraggableScrollableNotification>(
        onNotification: (notification) {
          // Cancel any pending snap timer.
          _snapTimer?.cancel();
          // Wait for 300ms after the last notification before snapping.
          _snapTimer = Timer(const Duration(milliseconds: 300), () {
            final double nearest = _getNearestSnap(notification.extent);
            _animateTo(nearest);
          });
          return false;
        },
        child: DraggableScrollableSheet(
          controller: _draggableController,
          // Disable built-in snapping.
          snap: false,
          minChildSize: minSnap,
          maxChildSize: maxSnap,
          initialChildSize: initialSnap,
          builder: (context, scrollController) {
            return Column(
              children: [
                if (widget.floatButton != null && !_isFull)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: AppSpace.space4,
                        bottom: AppSpace.space3,
                      ),
                      child: widget.floatButton!,
                    ),
                  ),
                Flexible(child: LayoutBuilder(builder: (context, constraints) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
                    clipBehavior: Clip.hardEdge,
                    decoration: ShapeDecoration(
                      color: context.theme.appColors.backgroundNeutralLightest,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.rounded3xl),
                      ),
                      shadows: [
                        BoxShadow(
                          color: const Color(0x1E000000),
                          blurRadius: 4.spMin,
                          offset: const Offset(0, 2),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: CustomScrollView(
                      controller: scrollController,
                      slivers: [
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: StickyHeader(
                            backgroundColor: Colors.transparent,
                            size: 120.spMin,
                            widget: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    top: AppSpace.space3,
                                    bottom: AppSpace.space2,
                                  ),
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 50.spMin,
                                    height: 5.spMin,
                                    decoration: BoxDecoration(
                                      color: context.theme.appColors.borderDisable,
                                      borderRadius: BorderRadius.circular(AppRadius.roundedSm),
                                    ),
                                  ),
                                ),
                                AppText.subtitle1(
                                  'Choose a place'.tr,
                                  context: context,
                                ),
                                widget.header,
                              ],
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(child: LayoutBuilder(builder: (_, __) {
                          final headerHeight = 120.spMin; // Or your header's height
                          final remainingHeight = constraints.maxHeight - headerHeight;
                          return SizedBox(
                              height: remainingHeight,
                              child: widget.contentBuilder.call(context, _draggableController));
                        })),
                      ],
                    ),
                  );
                })),
              ],
            );
          },
        ));
  }
}
