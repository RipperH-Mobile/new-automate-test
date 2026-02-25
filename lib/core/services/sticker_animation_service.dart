import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_item_preview/sticker_item_preview.dart';

class StickerAnimationService extends GetxController with GetTickerProviderStateMixin {
  static StickerAnimationService get instance {
    if (!Get.isRegistered<StickerAnimationService>()) {
      Get.put(StickerAnimationService());
    }
    return Get.find<StickerAnimationService>();
  }

  OverlayEntry? _currentFlyingSticker;

  // Store tap positions for stickers
  final Map<String, Rect> _tapPositions = {};

  /// Store the tap position when user taps a sticker
  void storeTapPosition({
    required String packId,
    required String fileId,
    required Rect position,
  }) {
    final key = '$packId-$fileId';
    _tapPositions[key] = position;
  }

  /// Get stored tap position for a sticker
  Rect? getTapPosition({
    required String packId,
    required String fileId,
  }) {
    final key = '$packId-$fileId';
    return _tapPositions[key];
  }

  /// Animate a sticker from source position to target position
  Future<void> animateSticker({
    required String packId,
    required String fileId,
    required Rect sourceRect,
    required Rect targetRect,
    double stickerSize = 96.0,
    Duration duration = const Duration(milliseconds: 300),
    String? targetMessageId,
    GlobalKey? targetWidgetKey, // Track actual widget position
  }) async {
    // Don't remove existing flying sticker to allow multiple animations
    // Just let them run concurrently

    // Create a new animation controller for each animation
    late AnimationController controller;
    OverlayEntry? flyingSticker;

    try {
      controller = AnimationController(
        duration: duration,
        vsync: this,
      );

      // Create curved animation for more natural movement
      final CurvedAnimation curvedAnimation = CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutQuint,
      );

      // Position animation - dynamic if targetWidgetKey provided, static otherwise
      late Animation<Rect?> positionAnimation;

      if (targetWidgetKey != null) {
        // Use dynamic animation that tracks widget position
        positionAnimation = _DynamicRectAnimation(
          controller: controller,
          sourceRect: sourceRect,
          targetWidgetKey: targetWidgetKey,
          fallbackTargetRect: targetRect,
        );
      } else {
        // Use static animation
        positionAnimation = RectTween(
          begin: sourceRect,
          end: targetRect,
        ).animate(curvedAnimation);
      }

      // Scale animation - grow slightly then shrink to target size
      final Animation<double> scaleAnimation = TweenSequence<double>([
        TweenSequenceItem(
          tween: Tween<double>(begin: 0.6, end: 1.0),
          weight: 70,
        ),
      ]).animate(curvedAnimation);

      // Opacity animation - fade out at the end
      // final Animation<double> opacityAnimation = Tween<double>(
      //   begin: 1.0,
      //   end: 0.0,
      // ).animate(
      //   CurvedAnimation(
      //     parent: controller,
      //     curve: const Interval(0.8, 1.0, curve: Curves.easeOut),
      //   ),
      // );

      flyingSticker = OverlayEntry(
        builder: (context) => FlyingStickerWidget(
          packId: packId,
          fileId: fileId,
          positionAnimation: positionAnimation,
          scaleAnimation: scaleAnimation,
          stickerSize: stickerSize,
        ),
      );

      // Get overlay context and insert the flying sticker
      final overlayContext = Get.overlayContext;
      if (overlayContext != null) {
        Overlay.of(overlayContext, rootOverlay: true).insert(flyingSticker);

        // Start animation and wait for completion
        await controller.forward();
      }
    } catch (e) {
      // Handle any errors during animation
      debugPrint('Sticker animation error: $e');
    } finally {
      // Always clean up, even if there was an error
      try {
        controller.dispose();
      } catch (e) {
        // Ignore disposal errors
      }
      if (flyingSticker != null) {
        try {
          flyingSticker.remove();
          flyingSticker.dispose();
        } catch (e) {
          // Ignore overlay removal errors
        }
      }
    }
  }

  void _removeFlyingSticker() {
    if (_currentFlyingSticker != null) {
      try {
        _currentFlyingSticker!.remove();
        _currentFlyingSticker!.dispose();
      } catch (e) {
        // Overlay might already be removed
      }
      _currentFlyingSticker = null;
    }
  }

  @override
  void onClose() {
    _removeFlyingSticker();
    super.onClose();
  }
}

class FlyingStickerWidget extends StatelessWidget {
  const FlyingStickerWidget({
    super.key,
    required this.packId,
    required this.fileId,
    required this.positionAnimation,
    required this.scaleAnimation,
    this.opacityAnimation,
    required this.stickerSize,
  });

  final String packId;
  final String fileId;
  final Animation<Rect?> positionAnimation;
  final Animation<double> scaleAnimation;
  final Animation<double>? opacityAnimation;
  final double stickerSize;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        positionAnimation,
        scaleAnimation,
        opacityAnimation,
      ]),
      builder: (context, child) {
        final rect = positionAnimation.value;
        final scale = scaleAnimation.value;
        // final opacity = opacityAnimation.value;

        return Positioned.fromRect(
          rect: rect!,
          child: Transform.scale(
            scale: scale,
            child: Opacity(
              opacity: opacityAnimation != null ? opacityAnimation!.value : 1.0,
              child: StickerItemPreview(
                packId: packId,
                fileId: fileId,
                width: stickerSize,
                height: stickerSize,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Dynamic animation that tracks a widget's position during animation
class _DynamicRectAnimation extends Animation<Rect> with AnimationWithParentMixin<double> {
  _DynamicRectAnimation({
    required this.controller,
    required this.sourceRect,
    required this.targetWidgetKey,
    required this.fallbackTargetRect,
  });

  final AnimationController controller;
  final Rect sourceRect;
  final GlobalKey targetWidgetKey;
  final Rect fallbackTargetRect;

  @override
  Animation<double> get parent => controller;

  @override
  Rect get value {
    final progress = controller.value;

    // Get current position of target widget
    Rect currentTargetRect = fallbackTargetRect;
    try {
      final RenderBox? renderBox = targetWidgetKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final position = renderBox.localToGlobal(Offset.zero);
        currentTargetRect = Rect.fromLTWH(
          position.dx,
          position.dy,
          renderBox.size.width,
          renderBox.size.height,
        );
      }
    } catch (e) {
      // Use fallback if widget not ready
    }

    // Interpolate between source and current target position with a curve
    final double curveOffset = progress * (1 - progress) * 500; // Adjust 300 for curve intensity

    double lerpDouble(double a, double b, double t) {
      return a + (b - a) * t;
    }

    Rect lerpRect(Rect a, Rect b, double t) {
      return Rect.fromLTRB(
        lerpDouble(a.left, b.left, t),
        lerpDouble(a.top, b.top, t) + curveOffset, // Apply curve to vertical position
        lerpDouble(a.right, b.right, t),
        lerpDouble(a.bottom, b.bottom, t) + curveOffset, // Apply curve to vertical position
      );
    }

    return lerpRect(sourceRect, currentTargetRect, progress);
  }
}
