import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:popover/popover.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_folder/domain/enums/chat_folder_type.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room_list/presentation/views/util/pop_menu_transition.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/room_list_item_touchable.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/uchat_slidable_item.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/popover_menu/uchat_popover.dart';
import 'package:uchat/widgets/popover_menu/widgets/pop_over_menu_item.dart';

final _closePanelEvent = CloseSlidablePanelEvent(
  forceClosePanel: true,
  duration: const Duration(milliseconds: 250),
);

class RoomListItemSlidable extends StatelessWidget {
  final RoomCollection room;
  final RoomSubscriptionCollection? roomSub;
  final Function(RoomSubscriptionCollection roomSub)? onPinRoom;
  final Function(RoomCollection room)? onSelectRoom;
  final Function(RoomSubscriptionCollection roomSub)? onMuteRoom;
  final Function(RoomCollection room)? onDeleteRoom;
  final Function(RoomSubscriptionCollection roomSub)? onHideChat;
  final void Function()? onLongPress;
  final bool? isOnline;
  final bool? isTyping;
  final String? draftMessage;
  final bool disableSlidable;
  final ChatFolderType? chatFolderType;
  final String? folderId;
  final bool showFailMessageBadge;

  /// Whether the item is selected or not. use only in `Desktop`
  final bool isSelected;
  final double? avatarHeight;
  final String? whoTypingText;
  final Function(RoomSubscriptionCollection roomSub)? onReadRoom;
  final Function(RoomCollection room)? onBlockUser;
  final Function(RoomCollection room)? onUnblockUser;
  final Function(RoomCollection room)? onLeaveGroup;

  final String? actionPaneId;
  final bool shouldStayOpenActionPane;
  final Function(String? itemId, bool isOpen)? onActionPaneOpenChanged;

  const RoomListItemSlidable({
    super.key,
    required this.room,
    this.roomSub,
    this.onPinRoom,
    this.onSelectRoom,
    this.onMuteRoom,
    this.onDeleteRoom,
    this.onHideChat,
    this.onLongPress,
    this.draftMessage,
    this.isOnline,
    this.isTyping,
    this.disableSlidable = false,
    this.isSelected = false,
    this.showFailMessageBadge = true,
    this.avatarHeight,
    this.chatFolderType,
    this.folderId,
    this.whoTypingText,
    this.onReadRoom,
    this.onBlockUser,
    this.onUnblockUser,
    this.onLeaveGroup,
    this.actionPaneId,
    this.shouldStayOpenActionPane = false,
    this.onActionPaneOpenChanged,
  });

  bool checkIsPinned() {
    switch (chatFolderType) {
      case ChatFolderType.all || ChatFolderType.unread:
        return roomSub?.isPinned == true;
      case ChatFolderType.normal:
        return roomSub?.chatFolders?.firstWhere((element) => element.folderId == folderId).isPinned ?? false;
      case ChatFolderType.direct || ChatFolderType.group || ChatFolderType.oa:
        return roomSub?.chatFolders?.firstWhereOrNull((element) => element.folderId == folderId)?.isPinned ?? false;
      default:
        return roomSub?.isPinned == true;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isPinned = checkIsPinned();

    return UChatSlidableItem(
      key: ValueKey(room.id),
      actionPaneId: actionPaneId,
      shouldStayOpenActionPane: shouldStayOpenActionPane,
      onActionPaneOpenChanged: onActionPaneOpenChanged,
      disableSlidable: disableSlidable,
      groupTag: 'RoomListItem',
      endActionPane: ActionPane(
        extentRatio: 0.4,
        motion: const DrawerMotion(),
        children: [
          if (onHideChat != null)
            CustomSlidableAction(
              padding: const EdgeInsets.all(AppSpace.space0),
              backgroundColor: context.theme.appColors.backgroundNeutralBolderPressed,
              autoClose: false,
              onPressed: (BuildContext customSlidableActionContext) {
                UChatPopover.open(
                  context: customSlidableActionContext,
                  contentDxOffset: -AppSpace.space28,
                  contentDyOffset: -AppSpace.space2,
                  width: 220.spMin,
                  transition: PopoverTransition.other,
                  popoverTransitionBuilder: (animation, child) => _popMenuTransition(
                    context: customSlidableActionContext,
                    animation: animation,
                    child: child,
                  ),
                  menu: [
                    PopoverMenuItem(
                      onPressed: (BuildContext context) async {
                        GetIt.I<TaxonomyService>().sendEvent(EventName.clickMoreSwipeaction,
                            eventProperties: EventProperty.clickMoreSwipeAction(
                                'mark as read', EventProperty.getChatTypeForEventParams(room)));
                        Navigator.pop(context);
                        eventBus.fire(_closePanelEvent);
                        onReadRoom?.call(roomSub!);
                      },
                      hasBottomDivider: true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText.body1(
                            'Mark as read'.tr,
                            context: context,
                          ),
                          Assets.vectors.iconRead.svg(),
                        ],
                      ),
                    ),
                    PopoverMenuItem(
                      onPressed: (BuildContext context) async {
                        Navigator.pop(context);
                        eventBus.fire(_closePanelEvent);
                        GetIt.I<TaxonomyService>().sendEvent(EventName.clickMoreSwipeaction,
                            eventProperties: EventProperty.clickMoreSwipeAction(
                                checkIsPinned() ? 'unpin' : 'pin', EventProperty.getChatTypeForEventParams(room)));
                        onPinRoom?.call(roomSub!);
                      },
                      hasBottomDivider: true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText.body1(
                            checkIsPinned() ? 'Unpin'.tr : 'Pin'.tr,
                            context: context,
                          ),
                          checkIsPinned() ? Assets.vectors.iconUnpin.svg() : Assets.vectors.iconPin.svg(),
                        ],
                      ),
                    ),
                    PopoverMenuItem(
                      onPressed: (BuildContext context) async {
                        Navigator.pop(context);
                        eventBus.fire(_closePanelEvent);
                        GetIt.I<TaxonomyService>().sendEvent(EventName.clickMoreSwipeaction,
                            eventProperties: EventProperty.clickMoreSwipeAction(
                                roomSub?.isMuted == true ? 'unmuted' : 'muted',
                                EventProperty.getChatTypeForEventParams(room)));
                        onMuteRoom?.call(roomSub!);
                      },
                      hasBottomDivider: true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText.body1(
                            roomSub?.isMuted == true ? 'Unmute'.tr : 'Mute'.tr,
                            context: context,
                          ),
                          roomSub?.isMuted == true ? Assets.vectors.iconUnmuted.svg() : Assets.vectors.iconMuted.svg(),
                        ],
                      ),
                    ),
                    PopoverMenuItem(
                      hasBottomDivider: true,
                      onPressed: (BuildContext context) async {
                        Navigator.pop(context);
                        eventBus.fire(_closePanelEvent);
                        GetIt.I<TaxonomyService>().sendEvent(EventName.clickMoreSwipeaction,
                            eventProperties: EventProperty.clickMoreSwipeAction(
                                'hide', EventProperty.getChatTypeForEventParams(room)));
                        onHideChat?.call(roomSub!);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText.body1(
                            'Hide'.tr,
                            context: context,
                          ),
                          Assets.vectors.iconHide.svg(),
                        ],
                      ),
                    ),
                    if (roomSub?.isGroup == false)
                      PopoverMenuItem(
                        onPressed: (BuildContext context) async {
                          Navigator.pop(context);
                          eventBus.fire(_closePanelEvent);

                          if (roomSub?.isDirectChatBlocked == true) {
                            onUnblockUser?.call(room);
                            GetIt.I<TaxonomyService>().sendEvent(EventName.clickMoreSwipeaction,
                                eventProperties: EventProperty.clickMoreSwipeAction(
                                    'unblock', EventProperty.getChatTypeForEventParams(room)));
                          } else {
                            GetIt.I<TaxonomyService>().sendEvent(EventName.clickMoreSwipeaction,
                                eventProperties: EventProperty.clickMoreSwipeAction(
                                    'block', EventProperty.getChatTypeForEventParams(room)));
                            onBlockUser?.call(room);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText.body1(
                              roomSub?.isDirectChatBlocked == true ? 'Unblock'.tr : 'Block'.tr,
                              context: context,
                              color: roomSub?.isDirectChatBlocked == true
                                  ? context.theme.appColors.textWarning
                                  : context.theme.appColors.textError,
                            ),
                            roomSub?.isDirectChatBlocked == true
                                ? Assets.vectors.iconUnblock.svg()
                                : Assets.vectors.iconBlock.svg(),
                          ],
                        ),
                      ),
                    if (roomSub?.isGroup == true)
                      PopoverMenuItem(
                        onPressed: (BuildContext context) async {
                          Navigator.pop(context);
                          eventBus.fire(_closePanelEvent);
                          GetIt.I<TaxonomyService>().sendEvent(EventName.clickMoreSwipeaction,
                              eventProperties: EventProperty.clickMoreSwipeAction(
                                  'leave group', EventProperty.getChatTypeForEventParams(room)));
                          onLeaveGroup?.call(room);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText.body1(
                              'Leave group'.tr,
                              context: context,
                              color: context.theme.appColors.textError,
                            ),
                            Assets.vectors.iconLeaveGroup.svg()
                          ],
                        ),
                      ),
                  ],
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.vectors.iconMore.svg(),
                  const SizedBox(
                    height: AppSpace.space2,
                  ),
                  AppText.body3Bold(
                    'More'.tr,
                    context: context,
                    color: context.theme.appColors.textPrimaryInverse,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          if (onDeleteRoom != null)
            CustomSlidableAction(
                padding: const EdgeInsets.all(AppSpace.space0),
                autoClose: false,
                backgroundColor: context.theme.appColors.backgroundError,
                onPressed: (BuildContext context) {
                  onDeleteRoom?.call(room);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.vectors.iconTrash.svg(),
                    const SizedBox(
                      height: AppSpace.space2,
                    ),
                    AppText.body3Bold(
                      'Delete'.tr,
                      context: context,
                      color: context.theme.appColors.textPrimaryInverse,
                      maxLines: 1,
                    ),
                  ],
                )),
        ],
      ),
      child: Container(
        color: isSelected ? const Color(0xFFF2F9FF) : null,
        child: RoomListItemTouchable(
          borderPadding: const EdgeInsets.all(AppSpace.space0),
          key: key,
          room: room,
          roomSub: roomSub,
          isTyping: isTyping,
          draftMessage: draftMessage,
          showFailMessageBadge: showFailMessageBadge,
          onLongPress: onLongPress,
          onPressed: () {
            onSelectRoom?.call(room);
          },
          avatarHeight: avatarHeight,
          isPinned: isPinned,
          whoTypingText: whoTypingText,
        ),
      ),
    );
  }

  Widget _popMenuTransition({
    BuildContext? context,
    required Animation<double> animation,
    required Widget child,
  }) {
    try {
      if (context == null) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
          child: child,
        );
      }

      return popMenuTransition(
        context: context,
        animation: animation,
        child: child,
      );
    } catch (exception) {
      return _popMenuTransition(
        context: Get.context,
        animation: animation,
        child: child,
      );
    }
  }
}
