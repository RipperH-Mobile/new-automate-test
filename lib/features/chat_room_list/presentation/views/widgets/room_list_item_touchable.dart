import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/chat_room_list_item.dart';
import 'package:uchat/widgets.dart';

class RoomListItemTouchable extends StatelessWidget {
  final void Function()? onPressed;
  final void Function()? onLongPress;
  final RoomCollection room;
  final RoomSubscriptionCollection? roomSub;
  final bool showLastMessage;
  final bool showUnreadCount;
  final String? customSubtitle;
  final Widget? customActionWidget;
  final String? nameHighlightStr;
  final String? draftMessage;
  final bool? isTyping;
  final bool? isSearch;
  final bool showFailMessageBadge;
  final double? avatarHeight;
  final double? itemHeight;

  final bool? isPinned;
  final String? whoTypingText;
  final EdgeInsets? customIndent;
  final EdgeInsets? borderPadding;
  final Color? customBackgroundColor;

  const RoomListItemTouchable({
    super.key,
    this.onPressed,
    this.onLongPress,
    required this.room,
    this.roomSub,
    this.showLastMessage = true,
    this.showUnreadCount = true,
    this.customSubtitle,
    this.customActionWidget,
    this.nameHighlightStr,
    this.draftMessage,
    this.isTyping,
    this.showFailMessageBadge = true,
    this.avatarHeight,
    this.isPinned,
    this.isSearch,
    this.whoTypingText,
    this.customIndent,
    this.borderPadding,
    this.itemHeight,
    this.customBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return BasicTextButton(
      padding: borderPadding,
      onPressed: () {
        Slidable.of(context)?.close();
        onPressed?.call();
      },
      onLongPress: onLongPress,
      child: ChatRoomListItem(
        key: key,
        room: room,
        roomSub: roomSub,
        showLastMessage: showLastMessage,
        showUnreadCount: showUnreadCount,
        customSubtitle: customSubtitle,
        actions: customActionWidget != null ? [customActionWidget!] : null,
        nameHighlightStr: nameHighlightStr,
        draftMessage: draftMessage,
        isTyping: isTyping,
        showFailMessageBadge: showFailMessageBadge,
        avatarHeight: avatarHeight,
        isPinned: isPinned,
        whoTypingText: whoTypingText,
        customIndent: customIndent,
        itemHeight: itemHeight,
        isSearch: isSearch,
        customBackgroundColor: customBackgroundColor,
      ),
    );
  }
}
