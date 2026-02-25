import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/widgets/app_text.dart';

class StickerDownloadProgressBar extends StatelessWidget {
  final double value;
  final double horizontalPadding;
  final double? textSize;

  const StickerDownloadProgressBar({
    super.key,
    required this.value,
    this.horizontalPadding = 32,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 550),
      curve: Curves.easeInOut,
      tween: Tween<double>(
        begin: 0,
        end: value,
      ),
      builder: (context, value, _) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: LinearProgressIndicator(
              value: value,
              color: context.theme.appColors.iconPrimary,
              backgroundColor: context.theme.appColors.backgroundGrayLight.withValues(alpha: 0.3),
            ),
          ),
          const SizedBox(height: 8),
          AppText.body2(
            '${(value * 100).toInt()}%',
            context: context,
          )
        ],
      ),
    );
  }
}
