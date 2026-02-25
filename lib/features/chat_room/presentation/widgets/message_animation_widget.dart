import 'package:flutter/material.dart';

class MessageAnimationWidget extends StatefulWidget {
  final Widget child;
  final void Function() callBack;

  const MessageAnimationWidget({
    required this.child,
    required this.callBack,
    super.key,
  });

  @override
  State<MessageAnimationWidget> createState() => _MessageAnimationWidget();
}

class _MessageAnimationWidget extends State<MessageAnimationWidget> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    _addAnimationController();
  }

  void _addAnimationController({bool autoStart = true}) {
    final controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    final fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    ));

    this.controller = controller;
    this.fadeAnimation = fadeAnimation;

    if (autoStart) {
      controller.forward().whenComplete(widget.callBack);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: -1.0,
      sizeFactor: CurvedAnimation(parent: controller, curve: Curves.easeOut),
      child: FadeTransition(
        opacity: fadeAnimation,
        child: widget.child,
      ),
    );
  }
}
