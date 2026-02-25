import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_duration.dart';
import 'package:uchat/widgets/popup_menu/message_popup/controller/message_popup_controller.dart';

class MessagePopup extends GetView<MessagePopupController> {
  final Widget message;
  final Widget? topPopup;
  final Widget? bottomPopup;
  final AxisDirection direction;
  final void Function()? onTabBackground;
  final String roomIdTag;

  @override
  String? get tag => roomIdTag;

  const MessagePopup({
    super.key,
    required this.message,
    required this.direction,
    required this.roomIdTag,
    this.topPopup,
    this.bottomPopup,
    this.onTabBackground,
  }) : assert(direction == AxisDirection.left || direction == AxisDirection.right);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildTabAreaBackground(),
        if (GetPlatform.isMobile) _buildBlurBackground(),
        _buildMessage(),
        _buildTopPopup(),
        if (bottomPopup != null) _buildBottomPopup(),
      ],
    );
  }

  Widget _buildBottomPopup() {
    return Obx(
      () => AnimatedPositioned(
        duration: UChatDuration.emojiPopupDuration,
        curve: Curves.easeOut,
        right: direction == AxisDirection.right ? controller.bottomPopupOffset.value.dx : null,
        left: direction == AxisDirection.right ? null : controller.bottomPopupOffset.value.dx,
        top: controller.bottomPopupOffset.value.dy,
        child: AnimatedBuilder(
          animation: controller.animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: controller.curvedAnimation.value,
              alignment: direction == AxisDirection.right ? Alignment.centerRight : Alignment.centerLeft,
              child: bottomPopup ?? const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTopPopup() {
    return Obx(
      () {
        return AnimatedPositioned(
          duration: UChatDuration.emojiPopupDuration,
          curve: Curves.easeOut,
          right: direction == AxisDirection.right ? controller.topPopupOffset.value.dx : null,
          left: direction == AxisDirection.right ? null : controller.topPopupOffset.value.dx,
          top: controller.topPopupOffset.value.dy,
          child: AnimatedBuilder(
            animation: controller.animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: controller.curvedAnimation.value,
                alignment: direction == AxisDirection.right ? Alignment.centerRight : Alignment.centerLeft,
                child: topPopup ?? const SizedBox.shrink(),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildMessage() {
    return Obx(
      () {
        if (!controller.isShowPopupMenu.value && !GetPlatform.isMobile) {
          return const SizedBox.shrink();
        }
        return Positioned(
          right: direction == AxisDirection.right ? controller.messageOffset.value.dx : null,
          left: direction == AxisDirection.right ? null : controller.messageOffset.value.dx,
          top: controller.messageOffset.value.dy,
          child: IgnorePointer(
            child: message,
          ),
        );
      },
    );
  }

  Widget _buildTabAreaBackground() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onTabBackground?.call();
      },
      onLongPress: () {
        onTabBackground?.call();
      },
      onSecondaryTap: () {
        onTabBackground?.call();
      },
      onPanStart: (details) {
        onTabBackground?.call();
      },
      onHorizontalDragStart: (details) {
        onTabBackground?.call();
      },
    );
  }

  IgnorePointer _buildBlurBackground() {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: controller.animationController,
        builder: (context, child) {
          return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: controller.curvedAnimation.value * 10,
              sigmaY: controller.curvedAnimation.value * 10,
            ),
            child: Container(
              width: Get.width,
              height: Get.height,
              color: Colors.black.withValues(
                alpha: controller.curvedAnimation.value * 0.8,
              ),
            ),
          );
        },
      ),
    );
  }
}
