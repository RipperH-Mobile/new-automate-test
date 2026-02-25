import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

part 'uchat_keyboard_action.dart';
part 'uchat_keyboard_controller.dart';

// ignore: must_be_immutable
class UChatKeyboardListener extends StatelessWidget {
  final String widgetTag;
  final Widget child;
  final void Function(KeyEvent)? onKeyEvent;
  final Set<UChatKeyboardAction>? actionOnKeyPressed;
  final TextEditingController? textEditingController;

  const UChatKeyboardListener({
    super.key,
    required this.widgetTag,
    required this.child,
    this.onKeyEvent,
    this.actionOnKeyPressed,
    this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UChatKeyboardController>(
      init: UChatKeyboardController(),
      tag: widgetTag,
      builder: (ctl) {
        return KeyboardListener(
          focusNode: FocusNode(),
          onKeyEvent: onKeyEvent ??
              (event) {
                if (actionOnKeyPressed?.isEmpty == true) return;
                ctl.onKeyEvent(event, actionOnKeyPressed!);
              },
          child: child,
        );
      },
    );
  }
}
