import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/models/typing_model.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/no_chat_found_widget.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/room_list_item_slidable.dart';

import '../../domain/entities/chat_folder_entity.dart';
import '../../domain/enums/chat_folder_type.dart';
import '../controllers/chat_folder_controller.dart';

class ChatFolderList extends GetView<ChatFolderController> {
  final ChatFolderEntity folder;
  final int index;

  const ChatFolderList({
    super.key,
    required this.folder,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final roomDataList = controller.chatListController.getRoomList(chatFolderType: folder.type, folderId: folder.id);
      if (roomDataList.isEmpty) {
        return const NoChatFoundWidget();
      }

      return SlidableAutoCloseBehavior(
        child: ListView.builder(
          controller: controller.scrollControllers[index],
          padding: const EdgeInsets.only(
            top: AppSpace.space2,
            bottom: AppSpace.space2,
          ),
          itemCount: roomDataList.length,
          itemBuilder: (context, index) {
            return Obx(() {
              final roomSub = roomDataList.elementAtOrNull(index)?.roomSub();
              if (roomSub == null) return const SizedBox.shrink();

              final roomId = roomSub.roomId;
              if (roomId == null) return const SizedBox.shrink();

              final room = controller.chatListController.getRoom(roomId);
              if (room == null) return const SizedBox.shrink();

              final isTyping = controller.chatListController.isRoomsTyping.value[roomId] ?? false;
              final List<TypingModel> whoTypingModelList = controller.chatListController.typingModelList;
              String? whoTypingText;

              if (whoTypingModelList.isNotEmpty) {
                whoTypingText = whoTypingModelList.length == 1
                    ? whoTypingModelList.first.name
                    : '${whoTypingModelList.first.name} ${'and'.tr} ${whoTypingModelList.length - 1} ${whoTypingModelList.length - 1 == 1 ? 'other'.tr : 'others'.tr}';
              } else {
                whoTypingText = null;
              }

              final key = room.widgetKey;

              return Column(
                children: [
                  RoomListItemSlidable(
                    key: ValueKey('CONTAINER-$key'),
                    whoTypingText: whoTypingText,
                    room: room,
                    roomSub: roomSub,
                    folderId: folder.id,
                    chatFolderType: folder.type,
                    onSelectRoom: controller.chatListController.handleSelectRoom,
                    onLongPress: UserController.instance.enableHoldChat
                        ? () => controller.chatListController.onLongPressChatListItem(room)
                        : null,
                    draftMessage: room.draftMessage ?? '',
                    isTyping: isTyping,
                    disableSlidable: controller.chatListController.isEditChat.value,
                    avatarHeight: AppSpace.space16,
                    onReadRoom: controller.chatListController.handleReadRoom,
                    onPinRoom: (roomSub) {
                      if (folder.type == ChatFolderType.all || folder.type == ChatFolderType.unread) {
                        controller.chatListController.handlePinRoom(roomSub);
                      } else {
                        controller.pinChatRoomInFolder(
                          isPinned: roomSub.chatFolders
                              ?.firstWhereOrNull(
                                (element) => element.folderId == folder.id,
                              )
                              ?.isPinned,
                          roomSubs: [roomSub],
                          chatFolderId: folder.id,
                          roomDataList: roomDataList,
                          index: index,
                          folderId: folder.id,
                        );
                      }
                    },
                    onMuteRoom: room.isBookmark ? null : controller.chatListController.handleMuteRoom,
                    onHideChat: room.isBookmark ? null : controller.chatListController.showDialogHideChat,
                    onBlockUser: controller.chatListController.showDialogBlockUser,
                    onUnblockUser: controller.chatListController.handleUnBlock,
                    onLeaveGroup: controller.chatListController.showDialogLeaveGroup,
                    onDeleteRoom: controller.chatListController.showDialogDeleteChat,
                    actionPaneId: key,
                    shouldStayOpenActionPane: controller.chatListController.openActionPaneId.value == key,
                    onActionPaneOpenChanged: controller.chatListController.onActionPaneOpenChanged,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppSpace.space24,
                    ),
                    child: Divider(
                      height: AppSpace.spacePx,
                      color: context.theme.appColors.borderDark,
                      thickness: 0.3,
                    ),
                  ),
                ],
              );
            });
          },
        ),
      );
    });
  }
}
