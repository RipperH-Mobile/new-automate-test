import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/services/security_service.dart';

class PrivacyProtectionOverlay extends StatelessWidget {
  const PrivacyProtectionOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SecurityService>(
      id: 'protection-screen',
      builder: (controller) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          child: controller.isShowProtectionScreen
              ? BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                  child: Container(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                )
              : AbsorbPointer(
                  absorbing: controller.isPreventTap,
                  child: const SizedBox.expand(),
                ),
        );
      },
    );
  }
}
