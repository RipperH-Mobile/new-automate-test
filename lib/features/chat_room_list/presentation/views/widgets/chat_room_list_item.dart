import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_text_parse_mention.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/extension/extension_number.dart';
import 'package:uchat/utils/get_name.dart' show getNameHelper;
import 'package:uchat/utils/sanitize_thai_text.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';

class ChatRoomListItem extends StatelessWidget {
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
  final double? itemHeight;
  final bool? isPinned;
  final String? whoTypingText;
  final EdgeInsets? customIndent;
  final bool? isSearch;
  final Color? customBackgroundColor;

  const ChatRoomListItem({
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
    this.itemHeight,
    this.isPinned,
    this.isSearch,
    this.whoTypingText,
    this.customIndent,
    this.customBackgroundColor,
  });

  bool get hasDraftMessage {
    return (draftMessage ?? '') != '';
  }

  double get avatarHeightSelector {
    return avatarHeight ?? AppSpace.space16;
  }

  Set get callTypeMissedCall {
    return {
      MessageCallType.unknown,
      MessageCallType.decline,
      MessageCallType.timeout,
      MessageCallType.unreachable,
    };
  }

  Set get callTypeGroup {
    return {
      MessageCallType.join,
      MessageCallType.start,
      MessageCallType.end,
      MessageCallType.leave,
    };
  }

  EdgeInsets get customIndentSelector {
    if (customIndent != null) {
      return customIndent!;
    }

    return const EdgeInsets.only(
      top: AppSpace.space015,
      bottom: AppSpace.space015,
      left: AppSpace.space4,
    );
  }

  bool get isGroupCallMissed {
    final isGroup = room.isGroup;
    final isGroupCallEnd = MessageCallType.end == roomSub?.lastMessage?.callMessage?.type;
    return isGroup && isGroupCallEnd && roomSub?.lastMessage?.callMessage?.payload?.isJoined != true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: customBackgroundColor ?? context.theme.appColors.backgroundNeutralLighter,
      padding: customIndentSelector,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: avatarHeightSelector,
            height: avatarHeightSelector,
            child: AvatarWrapper<RoomCollection>(
              key: ValueKey(room.widgetKey),
              data: room,
              radius: avatarHeightSelector / 2,
              borderColor: Colors.transparent,
              onlineStatusSize: (avatarHeightSelector / AppSpace.space2),
            ),
          ),
          const SizedBox(width: AppSpace.space4),
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                minHeight: itemHeight ?? 60.spMin,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              _buildFirstRow(context),
                              const SizedBox(
                                height: AppSpace.space1,
                              ),
                              _buildSecondRow(context),
                            ],
                          ),
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

  Widget _buildFirstRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Row(
            children: [
              Visibility(
                visible: isOfficialAccount,
                child: Container(
                  margin: EdgeInsets.only(
                    right: 6.spMin,
                  ),
                  child: Image.asset(
                    'assets/images/official_icon.png',
                    width: 16.spMin,
                    height: 16.spMin,
                    cacheWidth: 16.spMin.cacheSize,
                  ),
                ),
              ),
              Flexible(
                child: _buildName(context),
              ),
              const SizedBox(width: AppSpace.space1),
              Visibility(
                visible: roomSub?.isMuted == true,
                child: Padding(
                  padding: const EdgeInsets.only(right: AppSpace.space1),
                  child: Assets.vectors.iconMutedGrey.svg(),
                ),
              ),
              Visibility(
                visible: isPinned == true,
                child: Container(
                  padding: const EdgeInsets.only(right: AppSpace.space1),
                  child: Assets.vectors.iconPinned.svg(),
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
        Visibility(
          visible: showLastMessage &&
              !room.isBookmark &&
              (roomSub?.lastMessage != null && roomSub?.lastMessage?.isDecryptFailed != true),
          child: Padding(
            padding: const EdgeInsets.only(right: AppSpace.space4, bottom: AppSpace.space05),
            child: AppText.caption1(
              textOverflow: TextOverflow.ellipsis,
              roomSub?.lastMessageTime ?? '',
              context: context,
              color: context.theme.appColors.textLighter,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSecondRow(BuildContext context) {
    return Row(
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
                      padding: EdgeInsets.symmetric(horizontal: 6.spMin, vertical: 2.spMin),
                      decoration: BoxDecoration(
                        color: const Color(0xffEFEFEF),
                        borderRadius: BorderRadius.circular(10.spMin),
                      ),
                      child: Text(
                        'Draft'.tr,
                        overflow: TextOverflow.ellipsis,
                        style: (UTheme.textTheme.messageStatus).copyWith(
                          color: const Color(0xff7C7C7C),
                          fontFamily: 'BaiJamjuree',
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !hasDraftMessage &&
                        callTypeGroup.contains(roomSub?.lastMessage?.callMessage?.type) &&
                        isTyping != true &&
                        isSearch != true,
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.0.spMin),
                      child: Assets.vectors.iconCall.svg(
                        colorFilter: isGroupCallMissed
                            ? ColorFilter.mode(
                                context.theme.appColors.iconError,
                                BlendMode.srcIn,
                              )
                            : null,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !hasDraftMessage &&
                        callTypeMissedCall.contains(roomSub?.lastMessage?.callMessage?.type) &&
                        isTyping != true,
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.0.spMin),
                      child: roomSub?.lastMessageText == 'No answer'.tr
                          ? Assets.vectors.iconOtherMissedCall.svg()
                          : Assets.vectors.iconMissedCall.svg(),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: AppSpace.space1),
                      child: _buildLastMessage(context),
                    ),
                  ),
                  _buildSecondRowRight(context)
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSecondRowRight(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 3.0.spMin, bottom: 0.0.spMin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(
            alignment: Alignment.centerRight,
            children: [
              if (isCallConnect && showJoinGroupCallBtn && room.isGroup)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpace.space4,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpace.space3,
                      vertical: AppSpace.space1,
                    ),
                    decoration: BoxDecoration(
                      color: context.theme.appColors.iconSuccess,
                      borderRadius: BorderRadius.circular(AppRadius.roundedFull),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          room.callType == CallType.video.value
                              ? Assets.vectors.videoCallIcon.path
                              : Assets.vectors.voiceCallIcon.path,
                          width: AppSize.size3,
                          height: AppSize.size3,
                          colorFilter: ColorFilter.mode(
                            context.theme.appColors.iconPrimaryInverse,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(
                          width: AppSpace.space1,
                        ),
                        AppText.subtitle1(
                          'Join'.tr,
                          context: context,
                          color: context.theme.appColors.textPrimaryInverse,
                        ),
                      ],
                    ),
                  ),
                )
              else ...[
                Visibility(
                  visible: showFailMessageBadge && (room.hasFailedMessage ?? false),
                  child: Container(
                      margin: const EdgeInsets.only(
                        right: AppSpace.space4,
                      ),
                      child: Assets.vectors.iconReload.svg()),
                ),
                Visibility(
                  visible: showUnreadCount && hasUnreadCount && !(room.hasFailedMessage ?? false),
                  child: Container(
                    margin: const EdgeInsets.only(
                      right: AppSpace.space4,
                    ),
                    height: AppSpace.space6,
                    constraints: const BoxConstraints(minWidth: AppSpace.space6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.roundedFull),
                      color: UTheme.color.primary,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedFlipCounter(
                          value: int.parse(unreadCount) > 999 ? 999 : int.parse(unreadCount),
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                          textStyle: context.theme.appTexts.caption1Bold
                              .copyWith(color: context.theme.appColors.textPrimaryInverse, height: 1),
                        ),
                        if (int.parse(unreadCount) > 999)
                          Text(
                            '+',
                            style: context.theme.appTexts.caption1Bold
                                .copyWith(color: context.theme.appColors.textPrimaryInverse, height: 1),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
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
                  color: context.theme.appColors.textDarkest,
                ),
          ),
          overflow: TextOverflow.ellipsis,
        ),
      );
    } else {
      final textStyle = UTheme.textTheme.messageTitle.copyWith(
        color: context.theme.appColors.textDarkest,
        fontWeight: FontWeight.w600,
        fontSize: 15,
      );

      if (!room.isDirect && !room.isSecretRoom && !room.isBookmark && !room.isSystem) {
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
            const SizedBox(
              width: AppSpace.space05,
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

  Widget _buildLastMessage(BuildContext context) {
    String message = roomSub?.lastMessageText ?? '';
    final isDirectMissedCall = callTypeMissedCall.contains(roomSub?.lastMessage?.callMessage?.type);

    if (isGroupCallMissed) {
      final payload = roomSub?.lastMessage?.callMessage?.payload;
      final displayName = getNameHelper(
        id: payload?.accountId,
        fallback: payload?.displayName,
      );
      message = 'Missed call from @displayName'.trParams({
        'displayName': displayName,
      });
    }
    if (hasDraftMessage) {
      message = draftMessage ?? '';
    } else if (room.isBookmark) {
      message = 'Saved bookmark'.tr;
    }

    if (hasUnreadCount && (roomSub?.isMentioned == true)) {
      message = 'You were mentioned'.tr;
    }

    if (isTyping == true) {
      if (room.isDirect) {
        message = 'Typing...'.tr;
      } else {
        message = '@who Typing...'.trParams(
          {
            'who': whoTypingText != null ? '$whoTypingText:' : 'Someone\'s'.tr,
          },
        );
      }
    } else if (hasDraftMessage && (isDirectMissedCall || isGroupCallMissed)) {
      final style = context.theme.appTexts.body4.copyWith(
        color: context.theme.appColors.textLight,
        fontWeight: FontWeight.w500,
      );
      return MentionTextParse(
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        message: sanitizeThaiText(draftMessage ?? ''),
        isOnTapEnable: false,
        style: style,
        styleMatch: style,
      );
    }

    return Visibility(
      visible: showLastMessage || hasDraftMessage,
      child: MentionTextParse(
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        message: sanitizeThaiText(message),
        isOnTapEnable: false,
        style: _lastMessageTextStyle(),
        styleMatch: _lastMessageTextStyle(),
      ),
    );
  }

  TextStyle _lastMessageTextStyle() {
    if (isTyping == true) {
      return UTheme.textTheme.messageStatus.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 13,
      );
    }

    if (callTypeMissedCall.contains(roomSub?.lastMessage?.callMessage?.type) || isGroupCallMissed) {
      if (roomSub?.lastMessageText == 'No answer'.tr) {
        return UTheme.textTheme.messageStatus.copyWith(
          color: UTheme.color.onTextButtonSecondary,
          fontSize: 13,
        );
      }
      return UTheme.textTheme.messageStatus.copyWith(
        color: const Color(0xffFF1552),
        fontWeight: FontWeight.w600,
        fontSize: 13,
      );
    }

    if ((showUnreadCount && hasUnreadCount && !(room.hasFailedMessage ?? false))) {
      return UTheme.textTheme.messageStatus.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 13,
      );
    }

    return UTheme.textTheme.messageStatus.copyWith(
      color: UTheme.color.onTextButtonSecondary,
      fontSize: 13,
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

    return ((room.isDirect || room.isSystem) && contactInRoom?.isOfficial == true);
  }

  bool get isCallConnect {
    const typeChecker = [CallStatusType.created, CallStatusType.inProgress];
    return typeChecker.contains(room.callStatus);
  }

  bool get isLastMsgIsCallMsgStartOrJoin {
    const typeChecker = [MessageCallType.start, MessageCallType.join];
    final condition1 = roomSub?.lastMessage?.isCallMessage;
    final condition2 = typeChecker.contains(roomSub?.lastMessage?.callMessage?.type);
    return (condition1 ?? false) && condition2;
  }
}
