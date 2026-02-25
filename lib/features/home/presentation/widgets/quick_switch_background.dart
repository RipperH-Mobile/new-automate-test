import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';

class QuickSwitchBackground extends StatefulWidget {
  const QuickSwitchBackground({super.key, required this.animationController});

  final AnimationController animationController;

  @override
  State<QuickSwitchBackground> createState() => _QuickSwitchBackgroundState();
}

class _QuickSwitchBackgroundState extends State<QuickSwitchBackground> {
  late Animation<double> _blurAnim;

  @override
  void initState() {
    super.initState();

    _blurAnim = Tween<double>(
      begin: 0.0,
      end: 20.0,
    ).animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Curves.easeOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _blurAnim,
      builder: (_, __) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: _blurAnim.value != 0 ? context.theme.appColors.backgroundDarkNeutral.withValues(alpha: 0.2) : null,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: _blurAnim.value,
              sigmaY: _blurAnim.value,
            ),
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        );
      },
    );
  }
}
