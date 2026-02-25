import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/group_request_type.dart';
import 'package:uchat/entities/interfaces.dart';
import 'package:uchat/features/add_contact/domain/entities/add_contact_group_requested_entity.dart';
import 'package:uchat/utils/get_name.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/avatar/avatar_wrapper.dart';

class DetailRoomRequestedListItem extends StatelessWidget {
  final AddContactGroupRequestedEntity item;
  final VoidCallback? onTapProfile;
  final VoidCallback? onApprove;
  final String? highLightName;

  const DetailRoomRequestedListItem({
    super.key,
    required this.item,
    this.onTapProfile,
    this.onApprove,
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
              AvatarWrapper<ContactInterface>(
                data: item.toContactModel(),
                hasBorder: false,
                radius: 25.spMin,
                showOnlineStatus: false,
              ),
              SizedBox(width: 18.spMin),
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
                              _buildName(context),
                              SizedBox(height: 6.spMin),
                              if (item.statusMessage != null)
                                AppText.body3(
                                  item.statusMessage!,
                                  maxLines: 1,
                                  context: context,
                                  color: context.theme.appColors.textLight,
                                ),
                            ],
                          ),
                        ),
                      ),
                      _buildButton(context),
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

  Widget _buildName(BuildContext context) {
    // Base name from the model.
    // String baseName = item.displayName ?? 'UNKNOWN'.tr;
    String baseName = getNameHelper(
        id: item.accountId,
        fallback: item.displayName ?? 'UNKNOWN'.tr
      );

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

  Widget _buildButton(BuildContext context) {
    final isAccepted = item.type != GroupRequestType.newRequest;

    return Container(
      constraints: const BoxConstraints(maxHeight: 34),
      margin: const EdgeInsets.only(right: AppSpace.space4),
      child: TextButton(
        onPressed: onApprove,
        style: TextButton.styleFrom(
          backgroundColor: isAccepted ? context.theme.appColors.buttonDisable : context.theme.appColors.buttonPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.roundedFull),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.size1),
          child: AppText.body4Bold(
            buttonTitle(),
            color: isAccepted ? context.theme.appColors.textDisable : context.theme.appColors.textPrimaryInverse,
            context: context,
            maxLines: 1,
            textOverflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  String buttonTitle() {
    switch (item.type) {
      case GroupRequestType.newRequest:
        return 'Approve'.tr;
      case GroupRequestType.cancelRequest:
        return 'Approve'.tr;
      default:
        return '';
    }
  }
}
