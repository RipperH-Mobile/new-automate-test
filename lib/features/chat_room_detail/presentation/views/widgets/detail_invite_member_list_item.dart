import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/interfaces.dart';
import 'package:uchat/features/chat_room_detail/data/models/models/room_waiting_list_model.dart';
import 'package:uchat/utils/get_name.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/avatar/avatar_wrapper.dart';

class DetailInviteMemberListItem extends StatelessWidget {
  final RoomDetailMemberAndPendingModel memberAndPending;
  final bool hasTailAction;
  final String? tailActionText;
  final TextStyle? tailActionTextStyle;
  final Color? tailActionTextColor;
  final Color? tailActionButtonColor;
  final VoidCallback? tailActionPressed;
  final VoidCallback? onTapProfile;
  final bool tailActionActive;
  final bool hasTailText;
  final String? tailText;
  final Color? tailTextColor;
  final String? highLightName;

  const DetailInviteMemberListItem({
    super.key,
    required this.memberAndPending,
    this.hasTailAction = false,
    this.tailActionActive = true,
    this.tailActionText = 'Action',
    this.tailActionTextColor,
    this.tailActionTextStyle,
    this.tailActionButtonColor,
    this.onTapProfile,
    this.tailActionPressed,
    this.hasTailText = false,
    this.tailText = '',
    this.tailTextColor,
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
            left: AppSpace.space4,
          ),
          child: Row(
            children: [
              memberAndPending.isPending == true
                  ? Opacity(
                      opacity: 0.5,
                      child: AvatarWrapper<ContactInterface>(
                        data: memberAndPending.toContactModel(),
                        hasBorder: false,
                        radius: 25.spMin,
                        showOnlineStatus: false,
                      ),
                    )
                  : AvatarWrapper<ContactInterface>(
                      data: memberAndPending.toContactModel(),
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
                              if (memberAndPending.accountStatusMessage?.isNotEmpty == true)
                                AppText.body3(
                                  memberAndPending.accountStatusMessage ?? '',
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
                          _getCustomNameRole(),
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

  String _getCustomNameRole() {
    final role = memberAndPending.role?.toLowerCase();
    final customTitle = memberAndPending.customTitle;

    if (role == 'owner') return 'Owner';
    if (role == 'admin') return (customTitle?.isEmpty ?? true) ? 'Admin' : customTitle!;

    return '';
  }

  Widget _buildNameSection(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: _buildName(context),
        ),
        if (UserController.instance.isCurrentUser(memberAndPending.accountId))
          AppText.body3Bold(
            ' (You)'.tr,
            context: context,
          ),
        if (memberAndPending.isPending == true)
          Padding(
            padding: const EdgeInsets.only(left: AppSpace.space2),
            child: AppText.body3Bold(
              '(Waiting)'.tr,
              context: context,
              color: context.theme.appColors.textLight,
            ),
          ),
      ],
    );
  }

  Widget _buildName(BuildContext context) {
    // Base name from the model.
    final String originalName = memberAndPending.accountDisplayName ?? 'UNKNOWN'.tr;
    final String baseName = getNameHelper(id: memberAndPending.accountId, fallback: originalName);

    TextStyle baseStyle = context.theme.appTexts.body3Bold.copyWith(
      color:
          memberAndPending.isPending == true ? context.theme.appColors.textLight : context.theme.appColors.textDarkest,
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
