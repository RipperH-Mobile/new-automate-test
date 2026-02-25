import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:scrollview_observer/scrollview_observer.dart';
import 'package:swipeable_tile/swipeable_tile.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/domain/entities/room_capability_entity.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_list_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_animation_widget.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_container_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_list/date_message_header.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_list/unread_message_bar.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_image_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/pin/latest_pin_message.dart';
import 'package:uchat/features/chat_room/presentation/widgets/typing_message.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/vibrate.dart';
import 'package:uchat/widgets/app_text.dart';

class MainMessageList extends GetView<MessageListController> {
  final String controllerTag;
  final bool enableTabItem;
  final bool enableScroll;
  final double parentWidth;
  final EdgeInsets? padding;
  final VoidCallback? onScrollToBottom;
  final MessageSelectionCallback? onSelectionTap;
  final List<MessageCollection>? selectedMessages;
  final SelectType? selectionType;
  final OnImageItemSelected? onImageItemSelected;
  final Function(MessageCollection? messageCollection)? onSwipeReply;
  final Function(String accountId)? onTapToMention;
  final double keyboardHeight;
  final bool isReplying;
  final bool isEditing;
  final RoomCapabilityEntity roomCapability;

  /// Enable hold and scroll
  ///
  /// - Default value is `false`.
  ///
  /// If `true`, the message list will be hold and scroll.
  final bool enableHoldAndScroll;

  @override
  String? get tag => controllerTag;

  const MainMessageList({
    super.key,
    required this.selectedMessages,
    required this.controllerTag,
    required this.parentWidth,
    required this.roomCapability,
    this.keyboardHeight = 0.0,
    this.enableTabItem = false,
    this.enableScroll = true,
    this.padding,
    this.onScrollToBottom,
    this.onSelectionTap,
    this.selectionType,
    this.onImageItemSelected,
    this.enableHoldAndScroll = false,
    this.onSwipeReply,
    this.onTapToMention,
    this.isReplying = false,
    this.isEditing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingMessage.value) {
        return Container(
          color: context.theme.appColors.elevationSurfaceChat,
          height: double.infinity,
        );
      }
      if (controller.messages.isEmpty) {
        return Container(
          color: context.theme.appColors.elevationSurfaceChat,
          height: double.infinity,
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              // margin: EdgeInsets.only(bottom: bottomPadding),
              padding: const EdgeInsets.all(AppSpace.space6),
              decoration: BoxDecoration(
                color: context.theme.appColors.backgroundStartingChat,
                borderRadius: BorderRadius.circular(AppRadius.rounded3xl),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Assets.vectors.messageEmpty.svg(),
                  AppText.body3('Start your conversation'.tr, context: context),
                ],
              ),
            ),
          ),
        );
      }

      /// Add 1 to the length for typing widget if there is any typing member in the room
      /// if there is no typing member, still add 1 to the length for empty space
      return FadeIn(
        duration: const Duration(milliseconds: 100),
        child: Container(
          decoration: BoxDecoration(
            color: context.theme.appColors.elevationSurfaceChat,
          ),
          child: CupertinoScrollbar(
            controller: controller.scrollController,
            thumbVisibility: true,
            thickness: 4,
            child: _buildMessageListView(),
          ),
        ),
      );
    });
  }

  Widget _buildMessageListView() {
    return NotificationListener<ScrollMetricsNotification>(
      onNotification: controller.positionListener,
      child: ListViewObserver(
        controller: controller.listObserverController,
        sliverListContexts: () {
          return [if (controller.sliverListCtx != null) controller.sliverListCtx!];
        },
        onObserve: (observeModel) {
          controller.listControllerListenerV2(observeModel);
        },
        child: CustomScrollView(
          physics: ChatObserverClampingScrollPhysics(observer: controller.chatObserver),
          controller: controller.scrollController,
          reverse: true,
          cacheExtent: 0,
          slivers: [
            SliverPadding(
              padding: enableHoldAndScroll
                  ? EdgeInsets.only(
                      bottom: AppSpace.space3,
                      top: controller.pinMessages.isNotEmpty ? LatestPinMessage.height : 0,
                    )
                  : EdgeInsets.only(
                      bottom: keyboardHeight == 0 ? 0 : 10,
                      top: controller.pinMessages.isNotEmpty ? LatestPinMessage.height : 0,
                    ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    controller.sliverListCtx = context;
                    // If index is 0, return typing message widget if there is any typing member
                    // otherwise return SizedBox.shrink()
                    if (index == 0) {
                      return Obx(
                        () {
                          if (controller.typingMemberMap.value.isNotEmpty) {
                            return TypingMessage(typingMembers: controller.typingMemberList);
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      );
                    }

                    return Obx(() {
                      // Subtract 1 from index to get the correct message index
                      final messageIndex = index - 1;
                      final message = controller.messages.elementAtOrNull(messageIndex);
                      if (message == null) {
                        return const SizedBox.shrink();
                      }

                      // In case of message delete or unsend, the message files will be null
                      final noMedia = (message.isMediaMessage && message.files?.isNotEmpty != true);
                      if (noMedia || message.isUnsentMessage || message.isRemoveMessage) {
                        return const SizedBox.shrink();
                      }

                      // Get the previous message
                      // This is used to check if the current message is the same day as the previous message
                      // and to check if the current message is within 1 minute of the previous message
                      MessageCollection? previousMessage;
                      if (messageIndex + 1 < controller.messages.length) {
                        previousMessage = controller.messages[messageIndex + 1];
                      }
                      final hideAvatar =
                          controller.shouldShowAvatar(message: message, previousMessage: previousMessage) != true;
                      final showDateHeader =
                          controller.showDateHeader(message: message, previousMessage: previousMessage);
                      final (isRead, readIds) = controller.isRead(message: message);

                      final messageContainer = MessageContainerV2(
                        onResendTap: () {
                          controller.onResendFailedMessageWithDialog(message);
                        },
                        previousMessage: previousMessage,
                        hideAvatar: hideAvatar,
                        isGroup: controller.room?.isGroup == true,
                        message: message,
                        isMyMessage: message.mine,
                        onSelectionTap: onSelectionTap,
                        selectedMsg: selectedMessages,
                        selectionType: selectionType,
                        onImageItemSelected: onImageItemSelected,
                        isRead: isRead,
                        userName: controller.getContactName(message),
                        onTapToMention: onTapToMention,
                        readIds: readIds,
                        roomType: controller.chatRoomCtl.roomType,
                        onReplyTap: () {
                          controller.onReplyTap(message);
                        },
                        onTapAvatar: () {
                          if (message.account == null) return;
                          controller.handleProfile(message.account!);
                        },
                      );

                      final messageWidget = SwipeableTile.swipeToTrigger(
                        behavior: HitTestBehavior.translucent,
                        isElevated: false,
                        color: material.Colors.transparent,
                        swipeThreshold: 0.085,
                        direction:
                            message.canReply && selectedMessages == null && !roomCapability.disableSwipeToReplyMessage
                                ? SwipeDirection.endToStart
                                : SwipeDirection.none,
                        onSwiped: (_) {
                          onSwipeReply?.call(message);
                        },
                        backgroundBuilder: (
                          BuildContext context,
                          SwipeDirection swipeDirection,
                          AnimationController animationController,
                        ) =>
                            swipeReplyBackgroundBuilder(
                          context,
                          swipeDirection,
                          animationController,
                        ),
                        key: ValueKey('msg-${message.ref ?? message.id}-swipeable'),
                        child: IgnorePointer(
                          // Ignore pointer if enable hold and scroll is true
                          ignoring: enableHoldAndScroll,
                          child: Column(
                            children: [
                              // Show unread message bar if the message is the last read message, otherwise show nothing
                              if (message.ref == controller.lastReadMessageRef.value) const UnreadMessageBar(),
                              // For new message animation
                              // Check only message ref to avoid animation playing on wrong message
                              // when new messages are inserted quickly
                              if (message.ref != null &&
                                  message.ref == controller.animateMessageRef.value &&
                                  controller.isAllowedAnimation.value)
                                MessageAnimationWidget(
                                  callBack: controller.onResetAnimation,
                                  child: messageContainer,
                                )
                              else
                                messageContainer,
                            ],
                          ),
                        ),
                      );

                      // If the current message is the same day as the previous message or the previous message is null return the message widget
                      // otherwise return the message widget with the date header
                      if (showDateHeader) {
                        return Column(
                          children: [
                            DateMessageHeader(
                              dateHeader: message.dateHeader,
                            ),
                            Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.only(top: hideAvatar ? AppSpace.space1 : AppSpace.space3),
                              child: messageWidget,
                            ),
                          ],
                        );
                      } else {
                        return Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.only(top: hideAvatar ? AppSpace.space1 : AppSpace.space3),
                          child: messageWidget,
                        );
                      }
                    });
                  },
                  childCount: controller.messages.length + 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget swipeReplyBackgroundBuilder(BuildContext context, SwipeDirection direction, AnimationController progress) {
    bool vibrated = false;
    return AnimatedBuilder(
      animation: progress,
      builder: (_, __) {
        final curve = CurvedAnimation(parent: progress, curve: const material.Interval(0.5, 1.0, curve: Curves.linear));
        if (progress.value > 0.9999 && !vibrated) {
          GetIt.I<VibrateUtil>().vibrateSuccess();
          vibrated = true;
        } else if (progress.value < 0.9999) {
          vibrated = false;
        }
        return Container(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: AppSpace.space4),
            child: Transform.scale(
              scale: Tween<double>(begin: 0.0, end: 1.2).animate(curve).value,
              child: Assets.vectors.iconReply.svg(),
            ),
          ),
        );
      },
    );
  }
}
