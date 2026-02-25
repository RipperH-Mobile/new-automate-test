import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:uchat/features/call/presentation/views/widgets/buttons/call_action_button_base.dart';
import 'package:uchat/gen/assets.gen.dart';

class CallActionMicButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isActive;
  final bool isEnable;

  const CallActionMicButton({
    super.key,
    required this.onPressed,
    required this.isActive,
    this.isEnable = true,
  });

  @override
  Widget build(BuildContext context) {
    return CallActionButtonBase(
      label: 'Mute'.tr,
      svgPath: isActive ? Assets.vectors.callMuteMicButton.path : Assets.vectors.callMuteMicOnButton.path,
      isEnable: isEnable,
      onPressed: onPressed,
    );
  }
}
