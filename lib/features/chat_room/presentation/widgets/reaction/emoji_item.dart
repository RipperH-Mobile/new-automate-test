import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:uchat/constants/uchat_dimensions.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/features/media/media_viewer/domain/services/file_service.dart';
import 'package:uchat/utils/uchat_image.dart';
import 'package:uchat/widgets/shimmer_loading/shimmer_loading.dart';

class EmojiItem extends StatelessWidget {
  final String? fileId;
  final bool active;
  final bool selected;
  final void Function()? onTap;
  final double size;
  final Color? shimmerBaseColor;
  final Color? shimmerHighlightColor;
  final Decoration? decoration;
  final EdgeInsetsGeometry? paddingSelected;
  final EdgeInsetsGeometry padding;
  final bool showShimmer;

  const EmojiItem({
    super.key,
    required this.fileId,
    this.active = true,
    this.selected = false,
    this.showShimmer = false,
    this.onTap,
    required this.size,
    this.shimmerBaseColor,
    this.shimmerHighlightColor,
    this.decoration,
    this.paddingSelected,
    required this.padding,
  });

  factory EmojiItem.mobile({
    required BuildContext context,
    String? fileId,
    void Function()? onTap,
    bool active = true,
    bool selected = false,
    required double size,
  }) {
    return EmojiItem(
      fileId: fileId,
      active: active,
      selected: selected,
      onTap: onTap,
      size: size,
      decoration: BoxDecoration(
        color: context.theme.appColors.backgroundNeutralLightPressed,
        borderRadius: BorderRadius.circular(AppRadius.roundedMd),
      ),
      shimmerBaseColor: const Color(0xFF4D4D4D),
      shimmerHighlightColor: const Color(0xFF666666),
      paddingSelected: EdgeInsets.all(UChatDimensions.emojiMenuItemInnerPadding),
      padding: EdgeInsets.all(UChatDimensions.emojiMenuItemInnerPadding),
    );
  }

  factory EmojiItem.mobileCustomize({
    String? fileId,
    void Function()? onTap,
    bool active = true,
    bool selected = false,
    required double size,
    bool showShimmer = false,
  }) {
    return EmojiItem(
      fileId: fileId,
      active: active,
      selected: selected,
      onTap: onTap,
      size: size,
      decoration: BoxDecoration(
        color: const Color(0xFFE6E6E6),
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFF2F2F2),
          width: 1,
        ),
      ),
      shimmerBaseColor: const Color(0xFFE6E6E6),
      shimmerHighlightColor: const Color(0xFFF2F2F2),
      paddingSelected: EdgeInsets.all(10.spMin),
      padding: EdgeInsets.all(5.spMin),
      showShimmer: showShimmer,
    );
  }

  factory EmojiItem.desktop({
    String? fileId,
    void Function()? onTap,
    bool active = true,
    bool selected = false,
    required double size,
    bool showShimmer = false,
  }) {
    return EmojiItem(
      fileId: fileId,
      active: active,
      selected: selected,
      onTap: onTap,
      size: size,
      shimmerBaseColor: const Color(0xFF4D4D4D),
      shimmerHighlightColor: const Color(0xFF666666),
      decoration: const BoxDecoration(
        color: Color(0xFF666666),
        shape: BoxShape.circle,
      ),
      paddingSelected: EdgeInsets.all(4.spMin),
      padding: EdgeInsets.all(2.spMin),
      showShimmer: showShimmer,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (showShimmer) {
      return _Shimmer(
        shimmerBaseColor: shimmerBaseColor,
        shimmerHighlightColor: shimmerHighlightColor,
        size: size,
        decoration: decoration,
      );
    }

    if (fileId == null) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () {
        if (active) {
          onTap?.call();
        }
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        width: size,
        height: size,
        padding: selected ? (paddingSelected ?? padding) : padding,
        decoration: selected ? decoration : null,
        child: active
            ? UChatImage.network(
                key: ValueKey('emoji_item_$fileId'),
                FileService.instance.getEmojiUrl(
                  fileId!,
                ),
                customLoadingWidget: (p0) => _Shimmer(
                  shimmerBaseColor: shimmerBaseColor,
                  shimmerHighlightColor: shimmerHighlightColor,
                  size: size,
                  decoration: decoration,
                ),
              )
            : UChatImage.network(
                key: ValueKey('emoji_item_${fileId}_inactive'),
                FileService.instance.getEmojiUrl(
                  fileId!,
                ),
                opacity: const AlwaysStoppedAnimation(0.2),
                customLoadingWidget: (p0) => _Shimmer(
                  shimmerBaseColor: shimmerBaseColor,
                  shimmerHighlightColor: shimmerHighlightColor,
                  size: size,
                  decoration: decoration,
                ),
              ),
      ),
    );
  }
}

class _Shimmer extends StatelessWidget {
  const _Shimmer({
    required this.shimmerBaseColor,
    required this.shimmerHighlightColor,
    required this.size,
    required this.decoration,
  });

  final Color? shimmerBaseColor;
  final Color? shimmerHighlightColor;
  final double size;
  final Decoration? decoration;

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      enable: true,
      baseColor: shimmerBaseColor,
      highlightColor: shimmerHighlightColor,
      child: Container(
        width: size,
        height: size,
        decoration: decoration,
      ),
    );
  }
}
