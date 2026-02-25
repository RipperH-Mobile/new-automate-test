import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:uchat/features/call/presentation/views/widgets/buttons/call_action_button_base.dart';
import 'package:uchat/gen/assets.gen.dart';

class DeclineButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DeclineButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CallActionButtonBase(
      label: 'End'.tr,
      svgPath: Assets.vectors.callEndCallButton.path,
      onPressed: onPressed,
    );
  }
}
