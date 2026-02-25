import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/input/chat_room_gif_input_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/input/chat_room_input_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/input/chat_room_sticker_input_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_list_controller.dart';

class ChatRoomDirectBinding implements Bindings {
  @override
  void dependencies() {
    final tag = Get.parameters['id'] ?? 'NEW_ROOM';

    Get.put<ChatRoomController>(
      ChatRoomController(
        tag: tag,
        messageLocalRepository: GetIt.I<MessageLocalRepository>(),
      ),
      tag: tag,
    );
    Get.put<ChatRoomInputController>(
      ChatRoomInputController(tag: 'chat-room-$tag', roomId: tag),
      tag: 'chat-room-$tag',
    );
    Get.put<ChatRoomStickerInputController>(
      ChatRoomStickerInputController(tag: 'chat-room-$tag'),
      tag: 'chat-room-$tag',
    );
    Get.put<ChatRoomGifInputController>(
      ChatRoomGifInputController(tag: 'chat-room-$tag'),
      tag: 'chat-room-$tag',
    );
    Get.put<MessageListController>(
      MessageListController(tag: 'chat-room-$tag'),
      tag: 'chat-room-$tag',
    );
  }

  /// Manual binding controller
  ///
  /// - [roomId] is the room ID.
  ///
  /// This method is used to put controller for the chat room hold and scroll dialog.
  void putManualBinding(String roomId, {bool enableReadMessage = true}) {
    Get.put<ChatRoomController>(
      ChatRoomController(
        tag: roomId,
        messageLocalRepository: GetIt.I<MessageLocalRepository>(),
      ),
      tag: roomId,
    );
    Get.put<ChatRoomInputController>(
      ChatRoomInputController(tag: 'chat-room-$roomId', roomId: roomId),
      tag: 'chat-room-$roomId',
    );
    Get.put<ChatRoomStickerInputController>(
      ChatRoomStickerInputController(tag: 'chat-room-$roomId'),
      tag: 'chat-room-$roomId',
    );
    Get.put<ChatRoomGifInputController>(
      ChatRoomGifInputController(tag: 'chat-room-$roomId'),
      tag: 'chat-room-$roomId',
    );
    Get.put<MessageListController>(
      MessageListController(tag: 'chat-room-$roomId', enableReadMessage: enableReadMessage),
      tag: 'chat-room-$roomId',
    );
  }

  /// Close controller for the chat room hold and scroll dialog.
  ///
  /// - [roomId] is the room ID.
  ///
  /// This method is used to close controller for the chat room hold and scroll dialog.
  void closeManualBinding(String roomId) {
    Get.delete<ChatRoomController>(tag: roomId);
    Get.delete<ChatRoomInputController>(tag: 'chat-room-$roomId');
    Get.delete<ChatRoomStickerInputController>(tag: 'chat-room-$roomId');
    Get.delete<ChatRoomGifInputController>(tag: 'chat-room-$roomId');
    Get.delete<MessageListController>(tag: 'chat-room-$roomId');
  }
}
