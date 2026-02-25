import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/extension/extension_number.dart';
import 'package:uchat/widgets/input/app_text_field.dart';

class SearchBox extends StatelessWidget {
  final TextEditingController searchController;
  final void Function()? onSuffixPressed;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onBtnPress;
  final Color? color;
  final String? label;
  final FocusNode? focusNode;
  final bool showSearchBtn;
  final bool autofocus;
  final BorderRadius? borderRadius;
  final double? height;
  final bool hasSuffix;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsets? padding;
  final List<TextInputFormatter>? inputFormatters;
  final bool isShowPrefix;
  final TextInputType? keyboardType;

  const SearchBox({
    super.key,
    required this.searchController,
    this.onSuffixPressed,
    this.onChanged,
    this.onSubmitted,
    this.label,
    this.focusNode,
    this.color,
    this.autofocus = false,
    this.showSearchBtn = false,
    this.onBtnPress,
    this.borderRadius,
    this.height,
    this.hasSuffix = false,
    this.style,
    this.hintStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    this.inputFormatters,
    this.isShowPrefix = true,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: 0.0,
            vertical: AppSpace.space1,
          ),
      decoration: BoxDecoration(
        color: color ?? UTheme.color.input,
        border: Border.all(
          color: UTheme.color.appBarShadow.withValues(alpha: 0.5),
        ),
        borderRadius: borderRadius ??
            BorderRadius.circular(
              AppRadius.roundedXl,
            ),
      ),
      height: height ?? AppSize.size12,
      alignment: Alignment.centerLeft,
      child: ClipRect(
        child: TextField(
          onTapOutside: (event) => {
            if (focusNode != null)
              {
                focusNode?.unfocus(),
              }
          },
          autofocus: autofocus,
          focusNode: focusNode,
          keyboardType: keyboardType,
          controller: searchController,
          style: style ??
              TextStyle(
                color: UTheme.color.onInput,
                fontSize: AppSize.size4,
              ),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            isDense: true,
            hintStyle: hintStyle ??
                TextStyle(
                  color: UTheme.color.onInput.withValues(alpha: 0.5),
                  fontSize: AppSize.size4,
                ),
            hintText: label ?? 'Search'.tr,
            prefixIconConstraints: const BoxConstraints(
              minWidth: AppSpace.space4,
              minHeight: AppSpace.space4,
            ),
            prefixIcon: isShowPrefix
                ? prefixIcon ??
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpace.space4,
                        AppSpace.space2,
                        AppSpace.space2,
                        AppSpace.space2,
                      ),
                      child: Image.asset(
                        'assets/images/v2/search_icon.png',
                        cacheWidth: AppSize.size6.cacheSize,
                        cacheHeight: AppSize.size6.cacheSize,
                      ),
                    )
                : null,
            suffixIconConstraints: const BoxConstraints(
              maxWidth: AppSize.size10,
              maxHeight: AppSize.size10,
            ),
            suffixIcon: searchController.text.isNotEmpty || hasSuffix
                ? GestureDetector(
                    onTap: onSuffixPressed,
                    child: suffixIcon ??
                        Container(
                          margin: const EdgeInsets.only(
                            right: AppSpace.space3,
                          ),
                          child: Assets.vectors.iconClearSearchBox.svg(),
                        ),
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(
              bottom: AppSpace.space0,
              right: AppSpace.space2,
            ),
          ),
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          inputFormatters:
              inputFormatters ?? [ThaiLengthLimitingTextInputFormatter(UChatConstant.maxSearchInputLength)],
        ),
      ),
    );
  }
}
