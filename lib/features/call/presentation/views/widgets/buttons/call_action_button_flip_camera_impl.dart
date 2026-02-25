import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:uchat/features/call/presentation/views/widgets/buttons/call_action_button_base.dart';
import 'package:uchat/gen/assets.gen.dart';

class CallActionFlipCameraButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isEnable;

  const CallActionFlipCameraButton({
    super.key,
    required this.onPressed,
    this.isEnable = true,
  });

  @override
  Widget build(BuildContext context) {
    return CallActionButtonBase(
      label: 'Flip camera'.tr,
      svgPath: Assets.vectors.callFlipCameraButton.path,
      isEnable: isEnable,
      onPressed: onPressed,
    );
  }
}
