import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class SelectionGroupMenu<T> extends StatelessWidget {
  final List<SelectionMenuChoice<T>> choices;
  final void Function(T value)? onChanged;
  final T? selectedValue;

  const SelectionGroupMenu({
    super.key,
    required this.choices,
    this.onChanged,
    this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.theme.appColors.backgroundNeutralLightestPressed,
        borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
      ),
      child: Column(
        children: [
          ...choices.asMap().entries.map((entry) {
            final index = entry.key;
            final choice = entry.value;
            final isTopMenu = index == 0;
            final isBottomMenu = index == choices.length - 1;
            final isSelected = choice.value == selectedValue;

            return Column(
              children: [
                _SelectionMenu<T>(
                  value: choice.value,
                  title: choice.title,
                  icon: choice.icon,
                  isSelected: isSelected,
                  onTap: (value) {
                    if (onChanged != null) {
                      onChanged!(value);
                    }
                  },
                  isTopMenu: isTopMenu,
                  isBottomMenu: isBottomMenu,
                ),
                if (!isBottomMenu)
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: context.theme.appColors.border,
                    indent: AppSpace.space4,
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class SelectionMenuChoice<T> {
  final T value;
  final String title;
  final Widget? icon;

  SelectionMenuChoice({
    required this.value,
    required this.title,
    this.icon,
  });
}

class _SelectionMenu<T> extends StatelessWidget {
  final T value;
  final String title;
  final Widget? icon;
  final void Function(T value) onTap;
  final bool isTopMenu;
  final bool isBottomMenu;
  final bool isSelected;

  const _SelectionMenu({
    super.key,
    required this.value,
    required this.title,
    this.icon,
    required this.onTap,
    this.isTopMenu = false,
    this.isBottomMenu = false,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(value);
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: isTopMenu ? const Radius.circular(AppRadius.rounded2xl) : Radius.zero,
            bottom: isBottomMenu ? const Radius.circular(AppRadius.rounded2xl) : Radius.zero,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space3),
          child: Row(
            children: [
              if (icon != null) ...[icon!, AppSpace.space2.horizontalSpace],
              Expanded(child: AppText.body1(title, context: context)),
              if (isSelected)
                Assets.vectors.check12.svg(
                  width: 24.spMin,
                  height: 24.spMin,
                  colorFilter: ColorFilter.mode(context.theme.appColors.iconPrimary, BlendMode.srcIn),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
