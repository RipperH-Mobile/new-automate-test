import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/contact/presentation/views/widgets/composite_avatar.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/features/contact/presentation/views/widgets/basic_text_button.dart'; // For .tr if needed

class AllListItem<T> extends StatelessWidget {
  final List<T> items; // Full list of items (all groups, friends, etc.)
  final VoidCallback? onPressed;
  final Widget Function(T item) avatarItemBuilder; // For composite avatar.
  final String Function(T item) nameExtractor; // To get the display name.
  final int Function(T item)? memberCountExtractor; // To get amount of member.

  const AllListItem({
    super.key,
    required this.items,
    required this.avatarItemBuilder,
    required this.nameExtractor,
    this.memberCountExtractor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Get the first 4 items for the composite avatar.
    final avatarItems = items.length > 4 ? items.sublist(0, 4) : items;
    return BasicTextButton(
      onPressed: onPressed,
      child: SizedBox(
        height: 60.spMin,
        child: Row(
          children: [
            // Use the generic composite avatar.
            CompositeAvatar<T>(
              items: avatarItems,
              size: AppSize.size12,
              itemBuilder: avatarItemBuilder,
            ),
            const SizedBox(width: AppSize.size4),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.body3Bold(
                    context: context,
                    'All'.tr,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpace.space05),
                  AppText.body4(
                    context: context,
                    _buildSubtitle(),
                    color: context.theme.appColors.textLight,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: AppSize.size6,
              height: AppSize.size6,
              child: Assets.vectors.chevronRightSvg.svg(),
            ),
          ],
        ),
      ),
    );
  }

  String _buildSubtitle() {
    // Concatenate all the names separated by commas.
    final names = items.map((item) => nameExtractor(item)).toList();
    return names.join(', ');
  }
}
