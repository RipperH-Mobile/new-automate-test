import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/camera/enum/camera_flash_mode.dart';

class FlashModeButton extends StatelessWidget {
  final CameraFlashMode flashMode;
  final VoidCallback onTap;
  final bool isEnabled;
  final Color? iconColor;

  const FlashModeButton({
    super.key,
    required this.flashMode,
    required this.onTap,
    this.isEnabled = true,
    this.iconColor,
  });

  IconData get iconData {
    if (flashMode == CameraFlashMode.off) {
      return Icons.flash_off_rounded;
    }

    if (flashMode == CameraFlashMode.auto) {
      return Icons.flash_auto_rounded;
    }

    if (flashMode == CameraFlashMode.always) {
      return Icons.flash_on_rounded;
    }

    if (flashMode == CameraFlashMode.torch) {
      return Icons.flashlight_on_rounded;
    }

    return Icons.flash_off_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.theme.appColors.icon,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpace.space4),
            child: Icon(
              iconData,
              size: AppSize.size8,
              color: iconColor ?? (isEnabled ? Colors.white : Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
