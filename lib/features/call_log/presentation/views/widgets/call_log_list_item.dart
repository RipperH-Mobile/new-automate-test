import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/interfaces/contact_interface.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/call_log/data/models/enum/call_action_type.dart';
import 'package:uchat/features/call_log/domain/entities/call_log_with_contact_entity.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_mapper_extensions.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/utils/styles.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';

class CallLogListItem extends StatelessWidget {
  final CallLogWithContactEntity data;
  final bool showOnlineStatus;
  final List<Widget>? actions;
  final String? nameHighlightStr;
  final Color? customBackgroundColor;
  final Widget? customText;
  final bool? isChangeSize;
  final bool? isShowCheckBox;
  final bool isSelected;
  final void Function()? onTap;

  const CallLogListItem({
    super.key,
    required this.data,
    this.showOnlineStatus = false,
    this.actions,
    this.nameHighlightStr,
    this.customBackgroundColor,
    this.customText,
    this.isChangeSize = false,
    this.isShowCheckBox = false,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isChangeSize == true ? 60.spMin : AppSpace.space20,
      color: customBackgroundColor ?? Colors.transparent,
      child: Row(
        children: <Widget>[
          if (isShowCheckBox == true) _buildCheckBox(context),
          _buildAvatar(context),
          const SizedBox(width: AppSpace.space4),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: _buildName(context)),
                    _buildTime(context),
                  ],
                ),
                const SizedBox(height: AppSpace.space1),
                _buildDetails(context),
              ],
            ),
          ),
          if (actions != null) ...actions!,
        ],
      ),
    );
  }

  Widget _buildCheckBox(BuildContext context) {
    return Row(
      children: [
        RoundCheckBox(
          onTap: (value) {
            onTap?.call();
          },
          uncheckedWidget: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: AppSize.size05,
                color: context.theme.appColors.borderDisable,
              ),
            ),
          ),
          checkedColor: context.theme.appColors.iconPrimary,
          disabledColor: context.theme.appColors.textPrimary,
          checkedWidget: Assets.vectors.iconCheckCirclePrimary.svg(),
          isChecked: isSelected,
          size: AppSize.size6,
          borderColor: isSelected ? context.theme.appColors.borderPrimary : context.theme.appColors.borderDisable,
          border: Border.all(
            width: AppSize.size0,
            color: context.theme.appColors.borderDisable,
          ),
          animationDuration: const Duration(milliseconds: 200),
        ),
        const SizedBox(width: AppSpace.space4),
      ],
    );
  }

  Widget _buildAvatar(BuildContext context) {
    if (data.contact != null) {
      return AvatarWrapper<ContactInterface>(
        data: data.contact!,
        borderColor: colorAvatarBorder,
        showOnlineStatus: showOnlineStatus,
        radius: isChangeSize == true ? AppSize.size6 : AppSize.size8,
      );
    } else if (data.room != null) {
      return AvatarWrapper<RoomCollection>(
        data: data.room?.toCollection(),
        borderColor: colorAvatarBorder,
        showOnlineStatus: showOnlineStatus,
        radius: isChangeSize == true ? AppSize.size6 : AppSize.size8,
      );
    }
    return Assets.vectors.iconNoAvatar.svg(
      width: AppSize.size8 * 2,
      height: AppSize.size8 * 2,
    );
  }

  Widget _buildName(BuildContext context) {
    Widget nameBox = const SizedBox.shrink();

    // Base name from the entity.
    String baseName = data.contact?.displayName ?? data.room?.roomName ?? 'Unknown'.tr;
    TextStyle baseStyle = context.theme.appTexts.subtitle1.copyWith(
      color: data.callActionType == CallActionType.missed
          ? context.theme.appColors.textError
          : context.theme.appColors.textDarkest,
    );

    // If nameHighlightStr is provided, highlight matching substrings.
    if (nameHighlightStr != null && nameHighlightStr!.isNotEmpty) {
      List<TextSpan> spans = [];
      final lowerName = baseName.toLowerCase();
      final lowerHighlight = nameHighlightStr!.toLowerCase();
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
      nameBox = RichText(
        text: TextSpan(children: spans, style: baseStyle),
        overflow: TextOverflow.ellipsis,
      );
    } else {
      nameBox = Text(
        baseName,
        style: baseStyle,
        overflow: TextOverflow.ellipsis,
      );
    }

    return Row(
      children: [
        Flexible(child: nameBox),

        // Append grouped count if more than one event.
        if (data.callCount > 1)
          Text(
            ' (${data.callCount})',
            style: baseStyle,
            overflow: TextOverflow.ellipsis,
          ),

        const SizedBox(width: AppSpace.space2),
      ],
    );
  }

  Widget _buildDetails(BuildContext context) {
    final action = data.callActionType;
    final iconColor = ColorFilter.mode(
      context.theme.appColors.iconLighter,
      BlendMode.srcIn,
    );

    SvgPicture icon;
    String displayText;

    if (data.callType == CallType.voice) {
      if (action == CallActionType.incoming) {
        icon = Assets.vectors.iconIncomingCall.svg(
          width: AppSize.size4,
          height: AppSize.size4,
          colorFilter: iconColor,
        );
        displayText = 'Voice call'.tr;
      } else if (action == CallActionType.outgoing) {
        icon = Assets.vectors.iconOutgoingCall.svg(
          width: AppSize.size4,
          height: AppSize.size4,
          colorFilter: iconColor,
        );
        displayText = 'Voice call'.tr;
      } else if (action == CallActionType.missed) {
        icon = Assets.vectors.iconMissedCall.svg(
          width: AppSize.size4,
          height: AppSize.size4,
          colorFilter: iconColor,
        );
        displayText = 'Missed voice call'.tr;
      } else {
        icon = Assets.vectors.iconIncomingCall.svg(
          width: AppSize.size4,
          height: AppSize.size4,
          colorFilter: iconColor,
        );
        displayText = 'Voice call'.tr;
      }
    } else if (data.callType == CallType.video) {
      if (action == CallActionType.incoming) {
        icon = Assets.vectors.iconIncomingVideoCall.svg(
          width: AppSize.size4,
          height: AppSize.size4,
          colorFilter: iconColor,
        );
        displayText = 'Video call'.tr;
      } else if (action == CallActionType.outgoing) {
        icon = Assets.vectors.iconOutgoingVideoCall.svg(
          width: AppSize.size4,
          height: AppSize.size4,
          colorFilter: iconColor,
        );
        displayText = 'Video call'.tr;
      } else if (action == CallActionType.missed) {
        icon = Assets.vectors.iconMissedVideoCall.svg(
          width: AppSize.size4,
          height: AppSize.size4,
          colorFilter: iconColor,
        );
        displayText = 'Missed video call'.tr;
      } else {
        icon = Assets.vectors.iconIncomingVideoCall.svg(
          width: AppSize.size4,
          height: AppSize.size4,
          colorFilter: iconColor,
        );
        displayText = 'Video call'.tr;
      }
    } else {
      // Fallback values.
      icon = Assets.vectors.iconIncomingCall.svg(
        width: AppSize.size4,
        height: AppSize.size4,
        colorFilter: iconColor,
      );
      displayText = 'Call'.tr;
    }

    return Row(
      children: [
        icon,
        const SizedBox(
          width: AppSpace.space2,
        ),
        AppText.body4(
          displayText,
          context: context,
          color: context.theme.appColors.textLight,
        ),
      ],
    );
  }

  Widget _buildTime(BuildContext context) {
    String formatted = _formattedTime(data.lastStartedAt.toLocalTime);
    return AppText.caption1(
      formatted,
      context: context,
      color: context.theme.appColors.textLighter,
    );
  }

  String _formattedTime(DateTime date) {
    final DateTime now = DateTime.now().toLocal();
    final DateTime yesterday = now.subtract(const Duration(days: 1));

    if (date.isSameDay(now)) {
      return date.format('HH:mm');
    } else if (date.isSameDay(yesterday)) {
      return 'Yesterday'.tr;
    } else {
      return date.format('MMM d, y');
    }
  }
}
