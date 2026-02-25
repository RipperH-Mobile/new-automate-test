import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class SpeakerActionButton extends StatelessWidget {
  final String svgPath;
  final VoidCallback onPressed;
  final bool isEnable;

  const SpeakerActionButton({
    super.key,
    required this.svgPath,
    required this.onPressed,
    this.isEnable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnable ? 1 : 0.5,
      child: GestureDetector(
        onTap: isEnable ? onPressed : null,
        behavior: HitTestBehavior.translucent,
        child: SvgPicture.asset(
          svgPath,
          width: 36,
        ),
      ),
    );
  }
}
