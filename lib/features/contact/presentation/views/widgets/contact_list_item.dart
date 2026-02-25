import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/recent_search_type.dart';
import 'package:uchat/entities/interfaces.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/entities/models/room_data_model.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room_detail/data/models/models/room_invite_model.dart';
import 'package:uchat/features/chat_room_list/data/models/collection/recent_search_collection.dart';
import 'package:uchat/features/chat_room_list/data/models/contact_search_result_model.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/styles.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';

class ContactListItem<M> extends StatelessWidget {
  final M? data;
  final String? heroTag;
  final bool? showStatusMessage;
  final bool showOnlineStatus;
  final List<Widget>? actions;
  final bool showMemberCount;
  final bool useGravatar;
  final String? nameHighlightStr;
  final Color? customBackgroundColor;
  final Widget? customText;
  final bool? isPopUp;
  final double? avatarRadius;
  final double? spaceBetweenAvatarAndTitle;
  final Color? customNoHighlightTitleColor;

  const ContactListItem({
    super.key,
    required this.data,
    this.heroTag,
    this.showStatusMessage = true,
    this.showOnlineStatus = true,
    this.actions,
    this.showMemberCount = true,
    this.useGravatar = false,
    this.nameHighlightStr,
    this.customBackgroundColor,
    this.customText,
    this.isPopUp = false,
    this.avatarRadius = AppRadius.rounded3xl,
    this.spaceBetweenAvatarAndTitle,
    this.customNoHighlightTitleColor,
  });

  @override
  Widget build(BuildContext context) {
    bool isOfficialAccount = _isOfficialAccount;

    return Hero(
      tag: heroTag ?? '${data?.hashCode}',
      child: Container(
        height: 60.spMin,
        decoration: isPopUp == true
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.roundedXl),
                color: customBackgroundColor ?? Colors.transparent,
              )
            : BoxDecoration(
                color: customBackgroundColor ?? Colors.transparent,
              ),
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
        child: Row(
          children: <Widget>[
            _buildAvatar(context),
            SizedBox(
              width: spaceBetweenAvatarAndTitle ?? (isOfficialAccount ? AppSpace.space2 : AppSpace.space4),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (isOfficialAccount)
                    Container(
                      margin: const EdgeInsets.only(
                        left: AppSpace.space2,
                        right: AppSpace.space2,
                        bottom: AppSpace.space05,
                      ),
                      child: Assets.vectors.oaIconBlue.svg(
                        width: AppSpace.space4,
                        height: AppSpace.space4,
                      ),
                    ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        customText != null ? customText! : _buildName(context),
                        const SizedBox(
                          height: AppSpace.space05,
                        ),
                        _buildStatusMessage(context),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: AppSpace.space2,
                  ),
                ],
              ),
            ),
            if (actions != null) ...actions!,
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    if (data is ContactSearchResultModel) {
      final item = data as ContactSearchResultModel;

      // If there's a contact, pass that as ContactCollection
      if (item.contact != null) {
        return AvatarWrapper<ContactCollection>(
          borderColor: colorAvatarBorder,
          data: item.contact!,
          useGravatar: useGravatar,
          showOnlineStatus: showOnlineStatus,
          radius: avatarRadius,
        );
      }
      // Else if there's a room, pass that as RoomCollection
      else if (item.room != null) {
        return AvatarWrapper<RoomCollection>(
          borderColor: colorAvatarBorder,
          data: item.room!,
          useGravatar: useGravatar,
          showOnlineStatus: showOnlineStatus,
          radius: avatarRadius,
        );
      }
    }

    return AvatarWrapper<M>(
      borderColor: colorAvatarBorder,
      data: data,
      useGravatar: useGravatar,
      showOnlineStatus: showOnlineStatus,
      radius: avatarRadius,
    );
  }

  Widget _buildName(BuildContext context) {
    if (data is RecentSearchCollection) {
      final searchItem = data as RecentSearchCollection;
      if (searchItem.type == RecentSearchType.search) {
        return AppText.body3Bold(
          searchItem.keyword ?? '',
          context: context,
          textOverflow: TextOverflow.ellipsis,
          color: context.theme.appColors.textDark,
        );
      }

      return const SizedBox.shrink();
    }

    if (nameHighlightStr != null && nameHighlightStr!.isNotEmpty) {
      List<TextSpan> textSpanList = [];
      final matches = nameHighlightStr!.toLowerCase().allMatches(_name.toLowerCase());
      int lastMatchEnd = 0;
      if (matches.isEmpty) {
        textSpanList.add(TextSpan(text: _name));
      } else {
        for (int i = 0; i < matches.length; i++) {
          final match = matches.elementAt(i);
          if (match.start != lastMatchEnd) {
            textSpanList.add(
              TextSpan(
                text: _name.substring(lastMatchEnd, match.start),
              ),
            );
          }
          textSpanList.add(
            TextSpan(
              text: _name.substring(match.start, match.end),
              style: TextStyle(
                color: context.theme.appColors.textPrimary,
              ),
            ),
          );
          if (i == matches.length - 1 && match.end != _name.length) {
            textSpanList.add(
              TextSpan(
                text: _name.substring(match.end, _name.length),
              ),
            );
          }
          lastMatchEnd = match.end;
        }
      }

      return RichText(
        text: TextSpan(
          children: textSpanList,
          style: context.theme.appTexts.body3Bold.copyWith(
            color: customNoHighlightTitleColor ?? context.theme.appColors.textDark,
          ),
        ),
        overflow: TextOverflow.ellipsis,
      );
    } else {
      return AppText.body3Bold(
        _name,
        context: context,
        textOverflow: TextOverflow.ellipsis,
        color: context.theme.appColors.textDark,
      );
    }
  }

  Widget _buildStatusMessage(BuildContext context) {
    if (data is ContactSearchResultModel) {
      final item = data as ContactSearchResultModel;
      // If it's a friend
      if (item.contact != null) {
        if (showStatusMessage == false) {
          return const SizedBox.shrink();
        }
        // If no status message
        if (item.contact?.statusMessage.isEmpty ?? true) {
          return const SizedBox.shrink();
        }
        // Otherwise, show the status
        return AppText.body4(
          item.contact!.statusMessage,
          context: context,
          color: context.theme.appColors.textDark,
          textOverflow: TextOverflow.ellipsis,
        );
      }
      // If it's a room, we skip a status line
      return const SizedBox.shrink();
    }

    // 2) Otherwise, fallback to your existing logic:
    if (data is ContactInterface) {
      final contact = data as ContactInterface;
      if (contact.statusMessage == '') return const SizedBox.shrink();
      if (showStatusMessage == false) return const SizedBox.shrink();

      return AppText.body4(
        contact.statusMessage,
        context: context,
        color: context.theme.appColors.textDark,
        textOverflow: TextOverflow.ellipsis,
      );
    }
    return const SizedBox.shrink();
  }

  String get _name {
    // If this widget is used in contexts where M might be ContactSearchResultModel:
    if (data is ContactSearchResultModel) {
      final item = data as ContactSearchResultModel;

      // If it's a friend:
      if (item.contact != null) {
        return item.contact?.name ?? '';
      }
      // If it's a group:
      else if (item.room != null) {
        final roomName = item.room?.roomName ?? '';
        if (showMemberCount) {
          final count = item.room?.memberCount ?? 0;
          return '$roomName ($count)';
        }
        return roomName;
      }
      return 'Unknown'.tr;
    } else if (data is ContactInterface) {
      final contact = data as ContactInterface;
      return contact.name ?? '';
    } else if (data is RoomCollection) {
      final room = data as RoomCollection;
      if (showMemberCount) {
        final memberCount = room.memberCount ?? 0;

        if (memberCount == 0) return '${room.roomName}';

        return '${room.roomName} ($memberCount)';
      } else {
        return '${room.roomName}';
      }
    } else if (data is RoomDataModel) {
      final model = data as RoomDataModel;
      final roomName = model.room()?.roomName ?? '';
      if (showMemberCount) {
        final count = model.room()?.memberCount ?? 0;
        return '$roomName ($count)';
      }
      return roomName;
    } else if (data is RoomInviteModel) {
      final room = data as RoomInviteModel;
      return room.roomName ?? 'UNKNOWN'.tr;
    } else {
      return '';
    }
  }

  bool get _isOfficialAccount {
    // If data is a ContactSearchResultModel with a .contact
    if (data is ContactSearchResultModel) {
      final item = data as ContactSearchResultModel;
      return item.contact?.isOfficial ?? false;
    } else if (data is ContactModel) {
      return (data as ContactModel).isOfficial;
    } else if (data is ContactInterface) {
      return (data as ContactInterface).isOfficial;
    }
    return false;
  }
}
