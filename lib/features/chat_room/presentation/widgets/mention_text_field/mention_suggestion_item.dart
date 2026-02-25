import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/presentation/widgets/mention_text_field/mention_info_model.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/avatar/avatar.dart';

class MentionSuggestionItem extends StatelessWidget {
  final MentionInfoModel data;
  final void Function(MentionInfoModel data) onSelected;

  const MentionSuggestionItem({
    super.key,
    required this.data,
    required this.onSelected,
  });

  bool get isMentionAll => data.id == UChatConstant.mentionAllId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(data),
      child: Container(
        height: 56.spMin,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
          child: Row(
            children: [
              if (isMentionAll)
                Assets.vectors.mentionAll.svg()
              else if (data.photoUrl.isEmpty)
                Assets.vectors.iconNoAvatar.svg()
              else
                Avatar(
                  url: data.photoUrl,
                  radius: AppSize.size4,
                  borderWidth: 0,
                ),
              AppSpace.space2.horizontalSpace,
              Flexible(
                child: AppText.body3Bold(
                  data.display,
                  context: context,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
