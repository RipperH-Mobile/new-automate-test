import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/profile/presentation/controllers/profile_controller.dart';
import 'package:uchat/widgets/effect/blur_box.dart';

class ProfileGlassContainer extends GetView<ProfileControllerV2> {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback? onTap;
  
  const ProfileGlassContainer({
    super.key,
    this.padding,
    this.borderRadius,
    this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: BlurBox(
        containerPadding: padding,
        borderRadius: borderRadius ?? BorderRadius.zero,
        decoration: BoxDecoration(
          color: Colors.black.withValues(
            alpha: 0.5,
          ),
        ),
        blurWeight: 16,
        child: child,
      ),
    );
  }
}
