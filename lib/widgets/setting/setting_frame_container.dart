import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';

class SettingFrameContainer extends StatelessWidget {
  final Widget? header;
  final Widget child;
  final double? customBorderRadius;

  const SettingFrameContainer({
    super.key,
    required this.child,
    this.header,
    this.customBorderRadius,
  });

  factory SettingFrameContainer.withChildren({
    required BuildContext context,
    required List<Widget> children,
    EdgeInsets dividerPadding = const EdgeInsets.only(left: AppSpace.space4),
    Widget? header,
    double? customBorderRadius,
  }) {
    final indexLastChild = children.length - 1;
    final childrenMapped = children.indexed.flatMap(
      (indexedChild) {
        final (index, child) = indexedChild;

        return [
          child,
          index != indexLastChild
              ? Padding(
                  padding: dividerPadding,
                  child: Divider(
                    color: context.theme.appColors.border,
                    height: AppSpace.spacePx,
                    thickness: AppSize.sizePx,
                  ),
                )
              : const SizedBox.shrink(),
        ];
      },
    ).toList();

    return SettingFrameContainer(
      header: header,
      customBorderRadius: customBorderRadius,
      child: Column(
        children: childrenMapped,
      ),
    );
  }

  static Widget withLongList({
    required int itemCount,
    required Widget Function(BuildContext context, int index) itemBuilder,
    EdgeInsets padding = const EdgeInsets.only(bottom: AppSpace.space4),
    EdgeInsets dividerPadding = const EdgeInsets.only(left: AppSpace.space14),
    double? customBorderRadius,
    bool useShrinkWrap = false,
    Color? customDividerColor,
    Color? customBackgroundColor,
  }) {
    final firstIndex = 0;
    final lastIndex = itemCount - 1;

    return ListView.separated(
      itemCount: itemCount,
      padding: padding,
      shrinkWrap: useShrinkWrap,
      separatorBuilder: (context, index) => ColoredBox(
        color: customBackgroundColor ?? context.theme.appColors.backgroundNeutralLightestPressed,
        child: Padding(
          padding: dividerPadding,
          child: Divider(
            color: customDividerColor ?? context.theme.appColors.border,
            height: AppSize.sizePx,
          ),
        ),
      ),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: index == firstIndex ? Radius.circular(customBorderRadius ?? AppRadius.rounded2xl) : Radius.zero,
            bottom: index == lastIndex ? Radius.circular(customBorderRadius ?? AppRadius.rounded2xl) : Radius.zero,
          ),
          child: ColoredBox(
            color: context.theme.appColors.backgroundNeutralLightestPressed,
            child: itemBuilder(context, index),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (header != null) {
      return _headerWithFrame(
        context: context,
        header: header!,
        child: child,
      );
    }

    return _frame(
      context: context,
      child: child,
    );
  }

  Widget _headerWithFrame({
    required BuildContext context,
    required Widget header,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpace.space2,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppSpace.space3,
          ),
          child: header,
        ),
        _frame(
          context: context,
          child: child,
        ),
      ],
    );
  }

  Widget _frame({
    required BuildContext context,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(customBorderRadius ?? AppSpace.space4),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(customBorderRadius ?? AppSpace.space4),
        child: child,
      ),
    );
  }
}
