import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/input/app_text_field.dart';

class AppSearchBox extends StatefulWidget {
  final FocusNode? focusNode;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final void Function(String)? onSubmitted;
  final bool enabled;

  const AppSearchBox({
    super.key,
    this.focusNode,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.controller,
    this.scrollController,
    this.scrollPhysics,
    this.enabled = true,
  });

  static const double height = AppSize.size10;

  @override
  State<AppSearchBox> createState() => _AppSearchBoxState();
}

class _AppSearchBoxState extends State<AppSearchBox> {
  bool showSuffix = false;

  @override
  void initState() {
    super.initState();
    showSuffix = widget.controller?.text.isNotEmpty ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSearchBox.height,
      child: TextField(
        inputFormatters: [ThaiLengthLimitingTextInputFormatter(UChatConstant.maxSearchInputLength)],
        decoration: InputDecoration(
          filled: true,
          fillColor: context.theme.appColors.backgroundNeutralLight,
          contentPadding: const EdgeInsets.symmetric(vertical: AppSpace.space2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.roundedXl),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          hintText: 'Search'.tr,
          hintStyle: context.theme.appTexts.body1.copyWith(
            color: context.theme.appColors.textLight,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(
              left: AppSpace.space4,
              right: AppSpace.space2,
            ),
            child: Assets.vectors.iconSearch.svg(),
          ),
          suffixIcon: showSuffix
              ? GestureDetector(
                  onTap: () {
                    widget.controller?.clear();
                    setState(() {
                      showSuffix = false;
                    });
                    if (widget.onChanged != null) {
                      widget.onChanged!('');
                    }
                  },
                  child: Container(
                    width: AppSize.size6,
                    height: AppSize.size6,
                    padding: const EdgeInsets.only(
                      left: AppSpace.space2,
                      right: AppSpace.space3,
                    ),
                    child: Assets.vectors.iconClearSearchBox.svg(),
                  ),
                )
              : null,
        ),
        controller: widget.controller,
        scrollPhysics: widget.scrollPhysics,
        scrollController: widget.scrollController,
        enabled: widget.enabled,
        focusNode: widget.focusNode,
        style: context.theme.appTexts.body1,
        onChanged: (value) {
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
          setState(() {
            showSuffix = value.isNotEmpty;
          });
        },
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
        onSubmitted: widget.onSubmitted,
        onTapOutside: (_) {
          widget.focusNode?.unfocus();
        },
      ),
    );
  }
}
