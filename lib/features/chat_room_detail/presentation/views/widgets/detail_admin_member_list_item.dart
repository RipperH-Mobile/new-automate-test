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

class DetailAdminMemberListItem extends StatelessWidget {
  final RoomMemberEntity member;
  final VoidCallback? onTapProfile;
  final String? highLightName;

  const DetailAdminMemberListItem({
    super.key,
    required this.member,
    this.onTapProfile,
    this.highLightName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapProfile,
      child: SizedBox(
        height: 72.spMin,
        child: Padding(
          padding: const EdgeInsets.only(
            right: AppSpace.space0,
            left: AppSpace.space6,
          ),
          child: Row(
            children: [
              AvatarWrapper<ContactInterface>(
                data: member.account,
                hasBorder: false,
                radius: 25.spMin,
                showOnlineStatus: false,
              ),
              SizedBox(
                width: 18.spMin,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border(
                      bottom: BorderSide(
                        color: context.theme.appColors.border,
                        width: 1,
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
                              if (member.account.originalStatusMessage != null)
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
    // Base name from the model.
    String baseName = member.account.name ?? 'UNKNOWN'.tr;

    TextStyle baseStyle = context.theme.appTexts.body3Bold.copyWith(
      color: context.theme.appColors.textDarkest,
    );

    // If nameHighlightStr is provided, highlight matching substrings.
    if (highLightName != null && highLightName!.isNotEmpty) {
      List<TextSpan> spans = [];
      final lowerName = baseName.toLowerCase();
      final lowerHighlight = highLightName!.toLowerCase();
      final matches = lowerHighlight.allMatches(lowerName);
      int lastEnd = 0;
      if (matches.isEmpty) {
        spans.add(TextSpan(text: baseName));
      } else {
        for (final match in matches) {
          if (match.start > lastEnd) {
            spans.add(TextSpan(text: baseName.substring(lastEnd, match.start)));
          }
          spans.add(TextSpan(
            text: baseName.substring(match.start, match.end),
            style: baseStyle.copyWith(color: context.theme.appColors.textPrimary),
          ));
          lastEnd = match.end;
        }
        if (lastEnd < baseName.length) {
          spans.add(TextSpan(text: baseName.substring(lastEnd)));
        }
      }
      return RichText(
        text: TextSpan(children: spans, style: baseStyle),
        overflow: TextOverflow.ellipsis,
      );
    } else {
      return Text(
        baseName,
        style: baseStyle,
        overflow: TextOverflow.ellipsis,
      );
    }
  }
}
