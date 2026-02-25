import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/presentation/widgets/mention_text_field/mention_info_model.dart';
import 'package:uchat/features/chat_room/presentation/widgets/mention_text_field/mention_suggestion_item.dart';

class MentionSuggestionWidget extends StatelessWidget {
  final List<MentionInfoModel> items;
  final void Function(MentionInfoModel data) onSelected;
  final double? height;

  const MentionSuggestionWidget({
    super.key,
    required this.items,
    required this.onSelected,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
      constraints: BoxConstraints(
        maxHeight: height ?? 220.spMin,
      ),
      decoration: BoxDecoration(
        color: context.theme.appColors.backgroundNeutralLightest,
        borderRadius: BorderRadius.circular(AppRadius.roundedXl),
        border: Border.all(color: context.theme.appColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: context.theme.shadowColor.withValues(alpha: .08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.roundedXl),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: items.length,
          separatorBuilder: (context, index) {
            return Divider(height: .5, color: context.theme.appColors.border);
          },
          itemBuilder: (context, index) {
            return MentionSuggestionItem(
              data: items[index],
              onSelected: onSelected,
            );
          },
        ),
      ),
    );
  }
}
