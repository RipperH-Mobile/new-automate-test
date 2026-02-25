import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';

// TODO Refactor this to match design system and move this to core/widgets
class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 64,
        height: 28,
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space05),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.roundedFull),
          color: onChanged != null
              ? value
                  ? context.theme.appColors.backgroundPrimary
                  : context.theme.appColors.backgroundGrayLighter
              : context.theme.appColors.backgroundDisable,
        ),
        child: AnimatedAlign(
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          duration: const Duration(milliseconds: 200),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 40,
            height: 24,
            decoration: BoxDecoration(
              color: context.theme.appColors.backgroundNeutralLightest,
              borderRadius: BorderRadius.circular(AppRadius.rounded3xl),
            ),
          ),
        ),
      ),
    );
  }
}
