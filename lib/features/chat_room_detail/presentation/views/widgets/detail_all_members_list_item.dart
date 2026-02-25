import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/room_member_role.dart';
import 'package:uchat/entities/interfaces.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/avatar/avatar_wrapper.dart';

class DetailAllMembersListItem extends StatelessWidget {
  final RoomMemberEntity member;
  final VoidCallback? onTapProfile;
  final bool isLastIndex;
  final int moreAmountMembers;

  const DetailAllMembersListItem({
    super.key,
    required this.member,
    this.onTapProfile,
    this.isLastIndex = false,
    required this.moreAmountMembers,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapProfile,
      child: SizedBox(
        height: AppSpace.space16,
        child: Padding(
          padding: const EdgeInsets.only(
            right: AppSpace.space0,
            left: AppSpace.space2,
          ),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  AvatarWrapper<ContactInterface>(
                    data: member.account,
                    hasBorder: false,
                    radius: 25.spMin,
                    showOnlineStatus: false,
                  ),
                  if (moreAmountMembers >= 2 && isLastIndex == true)
                    Container(
                      decoration: BoxDecoration(
                        color: context.theme.appColors.backgroundDarkNeutral.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                      width: 50.spMin,
                      height: 50.spMin,
                      alignment: Alignment.center,
                      child: AppText.title2(
                        '+$moreAmountMembers',
                        context: context,
                        color: context.theme.appColors.textPrimaryInverse,
                      ),
                    ),
                ],
              ),
              SizedBox(
                width: 18.spMin,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: isLastIndex == true
                        ? null
                        : Border(
                            bottom: BorderSide(
                              color: context.theme.appColors.borderDark,
                              width: 0.5,
                            ),
                          ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: AppSpace.space6),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildNameSection(context),
                              if (member.account.originalStatusMessage != null && isLastIndex == false)
                                AppText.body3(
                                  member.account.originalStatusMessage ?? '',
                                  maxLines: 1,
                                  context: context,
                                  color: context.theme.appColors.textLight,
                                ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: AppSpace.space4),
                        child: AppText.body4(
                          member.groupRole?.role == RoomMemberRole.admin
                              ? member.groupRole?.customAdminName ?? 'Admin'
                              : '',
                          context: context,
                          color: context.theme.appColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameSection(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Flexible(child: _buildName(context)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildName(BuildContext context) {
    String baseName;
    if (isLastIndex == true && moreAmountMembers >= 2) {
      baseName = 'See all member'.tr;
    } else {
      baseName = member.account.name ?? 'UNKNOWN'.tr;
    }

    TextStyle baseStyle = context.theme.appTexts.body3Bold.copyWith(
      color: context.theme.appColors.textDarkest,
    );

    return Text(
      baseName,
      style: baseStyle,
      overflow: TextOverflow.ellipsis,
    );
  }
}
