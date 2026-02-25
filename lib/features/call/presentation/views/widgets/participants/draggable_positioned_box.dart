import 'dart:async';

import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers/user_interface_controller.dart';
import 'package:uchat/entities/models/keyboard_update_model.dart';

class DraggablePositionedBox extends StatefulWidget {
  const DraggablePositionedBox({
    super.key,
    required this.snapTopPosition,
    required this.snapLeftPosition,
    required this.snapBottomPosition,
    required this.snapRightPosition,
    required this.child,
  });

  final double snapTopPosition;
  final double snapBottomPosition;
  final double snapLeftPosition;
  final double snapRightPosition;
  final Widget child;

  @override
  State<DraggablePositionedBox> createState() => _DraggablePositionedBoxState();
}

class _DraggablePositionedBoxState extends State<DraggablePositionedBox> {
  double x = 0;
  double y = 0;
  int animationSpeed = 0;
  StreamSubscription<KeyboardUpdateModel>? keyboardListener;

  @override
  void initState() {
    x = widget.snapRightPosition;
    y = widget.snapTopPosition;
    keyboardListener = UserInterfaceController.instance.keyboardData.listen((e) {
      if (e.type == KeyboardUpdateType.open) {
        EasyThrottle.throttle('call-floating-screen-open', const Duration(milliseconds: 500), () {
          setState(() {
            double newValue = y - e.height;
            if (newValue < 0) {
              newValue = 0;
            }
            y = newValue;
          });
        });
      }
    });
    super.initState();
  }

  @override
  dispose() {
    keyboardListener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(
        milliseconds: animationSpeed,
      ),
      curve: Curves.easeOut,
      left: x,
      top: y,
      child: Draggable<Object>(
        rootOverlay: true,
        feedback: const SizedBox(),
        onDragUpdate: (DragUpdateDetails details) {
          setState(() {
            animationSpeed = 0;
            x += details.delta.dx;
            y += details.delta.dy;
          });
        },
        onDragEnd: (DraggableDetails details) {
          setState(
            () {
              animationSpeed = 300;
              if (x > Get.width * 0.5) {
                x = widget.snapRightPosition;
              } else {
                x = widget.snapLeftPosition;
              }
              if (y < widget.snapTopPosition) {
                y = widget.snapTopPosition;
              }
              if (y > widget.snapBottomPosition) {
                y = widget.snapBottomPosition;
              }
            },
          );
        },
        child: widget.child,
      ),
    );
  }
}
