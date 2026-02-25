import 'package:flutter/material.dart';
import 'package:uchat/utils/extension/extension_number.dart';

class ActionButton extends StatelessWidget {
  final void Function()? onPressed;
  final String imagePath;

  const ActionButton({
    super.key,
    this.onPressed,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35,
      height: 35,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Image.asset(
          imagePath,
          width: 20,
          height: 20,
          cacheWidth: 20.cacheSize,
        ),
      ),
    );
  }
}
