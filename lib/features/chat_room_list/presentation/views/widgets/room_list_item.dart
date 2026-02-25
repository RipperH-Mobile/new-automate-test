import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_text_parse_mention.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/extension/extension_number.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/utils/sanitize_thai_text.dart';
import 'package:uchat/widgets.dart';

class RoomListItem extends StatelessWidget {
  final RoomCollection room;
  final RoomSubscriptionCollection? roomSub;
  final bool showLastMessage;
  final bool showUnreadCount;
  final List<Widget>? actions;
  final String? customSubtitle;
  final String? nameHighlightStr;
  final bool? isTyping;
  final String? draftMessage;
  final bool showFailMessageBadge;
  final bool showJoinGroupCallBtn;
  final double? avatarHeight;
  final bool? isPinned;

  const RoomListItem({
    super.key,
    required this.room,
    this.roomSub,
    this.showLastMessage = true,
    this.showUnreadCount = true,
    this.actions,
    this.customSubtitle,
    this.nameHighlightStr,
    this.isTyping,
    this.draftMessage,
    this.showFailMessageBadge = true,
    this.showJoinGroupCallBtn = true,
    this.avatarHeight = 60,
    this.isPinned,
  });

  bool get isMobile => UChatScreenUtil.instance.isMobile;

  bool get hasDraftMessage {
    return (draftMessage ?? '') != '';
  }

  double get boxHeight {
    return isMobile ? 75.spMin : 65.spMin;
  }

  double get avatarHeightSelector {
    if (UChatScreenUtil.instance.isMobile) {
      return avatarHeight ?? 60.spMin;
    }

    return 50.spMin;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = UChatScreenUtil.instance.isMobilePlatform;
    final bookmarkAvatarSize = isMobile ? 53.spMin : 44.spMin;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 6.spMin,
      ),
      // height: boxHeight,
      // margin: EdgeInsets.only(bottom: 4.spMin),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          room.isBookmark
              ? Container(
                  margin: EdgeInsets.only(left: isMobile ? 1.4.spMin : 1.5.spMin),
                  child: Image.asset(
                    'assets/images/bookmark_avatar.png',
                    width: bookmarkAvatarSize,
                    height: bookmarkAvatarSize,
                    cacheWidth: bookmarkAvatarSize.cacheSize,
                  ),
                )
              : AvatarWrapper<RoomCollection>(
                  key: ValueKey(room.widgetKey),
                  data: room,
                  radius: avatarHeightSelector / 2.2,
                  borderColor: Colors.transparent,
                  onlineStatusSize: (avatarHeightSelector * 0.16).spMin,
                ),
          SizedBox(width: 13.spMin),
          Expanded(
            child: SizedBox(
              height: avatarHeightSelector,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Flexible(child: _buildName(context)),
                                    SizedBox(width: 6.spMin),
                                    Visibility(
                                      visible: isOfficialAccount,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          right: 6.spMin,
                                          bottom: 2.spMin,
                                        ),
                                        child: Image.asset(
                                          'assets/images/official_icon.png',
                                          width: 16.spMin,
                                          height: 16.spMin,
                                          cacheWidth: 16.spMin.cacheSize,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: roomSub?.isMuted == true,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 6.spMin),
                                        child: Image.asset(
                                          'assets/images/mute_icon_2.png',
                                          width: 14.spMin,
                                          height: 14.spMin,
                                          cacheWidth: 14.spMin.cacheSize,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: isPinned == true,
                                      child: Container(
                                        margin: EdgeInsets.only(right: 6.spMin),
                                        child: Image.asset(
                                          'assets/images/pin_icon.png',
                                          width: 14.spMin,
                                          height: 14.spMin,
                                          cacheWidth: 14.spMin.cacheSize,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: room.isSecretRoom,
                                      child: SecretRoomExpireDateWidget(
                                        expirationDate: room.expireAt,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              2.verticalSpace,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Visibility(
                                          visible: customSubtitle != null,
                                          child: Text(
                                            customSubtitle ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            style: UTheme.textTheme.messageStatus.copyWith(
                                              color: UTheme.color.onTextButtonSecondary,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Visibility(
                                              visible: hasDraftMessage && !(isTyping ?? false),
                                              child: Container(
                                                margin: EdgeInsets.only(right: 7.spMin),
                                                padding: EdgeInsets.symmetric(horizontal: 5.spMin),
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius: BorderRadius.circular(5.spMin),
                                                ),
                                                child: Text(
                                                  'Draft'.tr,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: (UTheme.textTheme.messageStatus).copyWith(
                                                    color: Colors.white,
                                                    fontFamily: 'BaiJamjuree',
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            _buildLastMessage(),
                                          ],
                                        ),
                                        Visibility(
                                          visible: roomSub?.isMentioned ?? false,
                                          child: Text(
                                            '${'You are mentioned'.tr} ',
                                            style: UTheme.textTheme.messageStatus.copyWith(
                                              color: UTheme.color.primary,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3.0.spMin, bottom: 5.0.spMin),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Visibility(
                          visible: showLastMessage &&
                              !room.isBookmark &&
                              (roomSub?.lastMessage != null && roomSub?.lastMessage?.isDecryptFailed != true),
                          child: Text(
                            roomSub?.lastMessageTime ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xff999999),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            Visibility(
                              visible: showFailMessageBadge && (room.hasFailedMessage ?? false),
                              child: Container(
                                height: 26.spMin,
                                width: 26.spMin,
                                margin: EdgeInsets.only(top: 6.7.spMin),
                                constraints: BoxConstraints(minWidth: 26.spMin),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF1552),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.spMin),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '!',
                                    style: UTheme.textTheme.messageUnreadCount.copyWith(
                                      color: UTheme.color.onPrimary,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: showUnreadCount && hasUnreadCount && !(room.hasFailedMessage ?? false),
                              child: Container(
                                height: 26.spMin,
                                constraints: BoxConstraints(minWidth: 26.spMin),
                                decoration: BoxDecoration(
                                  color: UTheme.color.primary,
                                  borderRadius: BorderRadius.all(Radius.circular(10.spMin)),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5.spMin),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        AnimatedFlipCounter(
                                          value: int.parse(unreadCount) > 999 ? 999 : int.parse(unreadCount),
                                          duration: const Duration(milliseconds: 400),
                                          curve: Curves.easeInOut,
                                          textStyle: UTheme.textTheme.messageUnreadCount.copyWith(
                                            color: UTheme.color.onPrimary,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 11,
                                          ),
                                        ),
                                        if (int.parse(unreadCount) > 999)
                                          Text(
                                            '+',
                                            style: UTheme.textTheme.messageUnreadCount.copyWith(
                                              color: UTheme.color.onPrimary,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 11,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (actions != null) ...actions!,
        ],
      ),
    );
  }

  Widget _buildName(BuildContext context) {
    if (nameHighlightStr != null) {
      List<TextSpan> textSpanList = [];
      final matches = nameHighlightStr!.toLowerCase().allMatches(room.title.toLowerCase());
      int lastMatchEnd = 0;
      for (int i = 0; i < matches.length; i++) {
        final match = matches.elementAt(i);
        if (match.start != lastMatchEnd) {
          textSpanList.add(
            TextSpan(
              text: room.title.substring(lastMatchEnd, match.start),
            ),
          );
        }
        textSpanList.add(
          TextSpan(
            text: room.title.substring(match.start, match.end),
            style: TextStyle(color: UTheme.color.blueCi),
          ),
        );
        if (i == matches.length - 1 && match.end != room.title.length) {
          textSpanList.add(
            TextSpan(
              text: room.title.substring(match.end, room.title.length),
            ),
          );
        }
        lastMatchEnd = match.end;
      }

      return ClipRect(
        child: RichText(
          text: TextSpan(
            children: textSpanList,
            style: DefaultTextStyle.of(context).style.merge(UTheme.textTheme.contactItemTitle).copyWith(
                  color: UTheme.color.contactItemTitle,
                ),
          ),
          overflow: TextOverflow.ellipsis,
        ),
      );
    } else {
      final textStyle = showUnreadCount && hasUnreadCount && !(room.hasFailedMessage ?? false)
          ? UTheme.textTheme.messageTitle.copyWith(
              color: UTheme.color.onTextButton,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              // fontFamily: 'newUiFont',
            )
          : UTheme.textTheme.messageTitle.copyWith(
              color: UTheme.color.onTextButton,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              // fontFamily: 'newUiFont',
            );

      if (!room.isDirect && !room.isSecretRoom && !room.isBookmark) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: ClipRect(
                child: Padding(
                  padding: EdgeInsets.only(top: 2.spMin, right: 2.spMin, bottom: 0.5.spMin),
                  child: Text(
                    room.isRoomEmpty ? 'UNKNOWN'.tr : sanitizeThaiText(room.title),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: textStyle,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 4.spMin,
            ),
            Text(
              '(${room.memberCount ?? 0})',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: textStyle,
            ),
          ],
        );
      }

      return ClipRect(
        child: Padding(
          padding: EdgeInsets.only(top: 2.spMin, right: 2.spMin, bottom: 0.5.spMin),
          child: Text(
            room.isRoomEmpty ? 'UNKNOWN'.tr : sanitizeThaiText(room.title),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: textStyle,
          ),
        ),
      );
    }
  }

  Widget _buildLastMessage() {
    String message = roomSub?.lastMessageText ?? '';
    if (hasDraftMessage) {
      message = draftMessage ?? '';
    } else if (room.isBookmark) {
      message = 'Saved bookmark'.tr;
    }
    if (isTyping == true) {
      if (isMobile) {
        if (room.isDirect) {
          message = 'typing'.tr;
        } else {
          message = 'Someone\'s typing'.tr;
        }
      } else {
        message = room.typingText(
          isDirectRoom: room.isDirect,
          typingMembers: room.typingMembers.toList(),
        );
      }
    }

    return Flexible(
      child: Visibility(
        visible: showLastMessage || hasDraftMessage,
        child: MentionTextParse(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          showTypingAnimation: isTyping ?? false,
          message: sanitizeThaiText(message),
          isOnTapEnable: false,
          style: isLastMsgIsCallMsgStartOrJoin
              ? UTheme.textTheme.messageStatus.copyWith(
                  color: const Color(0xff00AE74),
                  fontSize: 11,
                )
              : UTheme.textTheme.messageStatus.copyWith(
                  color: UTheme.color.onTextButtonSecondary,
                  fontSize: 11,
                  // fontFamily: 'newUiFont',
                ),
          styleMatch: UTheme.textTheme.messageStatus.copyWith(
            // color: UTheme.color.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  bool get hasUnreadCount {
    return roomSub?.unreadCount != null && roomSub!.unreadCount! > 0;
  }

  String get unreadCount {
    return (roomSub?.unreadCount ?? 0).toString();
  }

  bool get isOfficialAccount {
    final contactInRoom = room.firstOtherInRoom?.account;

    return (room.isDirect && contactInRoom?.isOfficial == true);
  }

  bool get isCallConnect {
    const typeChecker = [CallStatusType.startCall, CallStatusType.inProgress];
    return typeChecker.contains(room.callStatus);
  }

  bool get isLastMsgIsCallMsgStartOrJoin {
    const typeChecker = [MessageCallType.start, MessageCallType.join];
    final condition1 = roomSub?.lastMessage?.isCallMessage;
    final condition2 = typeChecker.contains(roomSub?.lastMessage?.callMessage?.type);
    return (condition1 ?? false) && condition2;
  }
}
