import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room/data/models/requests/react_message_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/sync_message_reaction_request.dart';
import 'package:uchat/features/chat_room/domain/chat_room_domain.dart';
import 'package:uchat/use_cases/use_case.dart';

class ReactMessageParams {
  final MessageEntity message;
  final String emojiId;

  ReactMessageParams({
    required this.message,
    required this.emojiId,
  });
}

class ReactMessageUseCase extends SimpleUseCase<void, ReactMessageParams> {
  final MessageLocalRepository messageLocalRepository;
  final MessageServerRepository messageServerRepository;

  ReactMessageUseCase({
    required this.messageLocalRepository,
    required this.messageServerRepository,
  });

  @override
  Future<void> call(ReactMessageParams params) async {
    final roomId = params.message.roomId;
    final msgId = params.message.id;

    if (roomId == null || msgId == null) {
      return;
    }

    // Clone the state before any changes
    final selectedReactionList = List<String>.from(params.message.selectedReactionList ?? []);

    final index = selectedReactionList.indexWhere((e) => e == params.emojiId);
    final accountId = UserController.instance.currentUser()?.id ?? '';

    // Backend call to update reactions
    final res = await messageServerRepository.reactMessage(
      ReactMessageRequest(
        emojiId: params.emojiId,
        msgId: msgId,
      ),
    );

    final lastEmojis = res.lastEmojis;
    final emojiAmount = res.emojiAmount;

    if (lastEmojis == null || emojiAmount == null) {
      return;
    }

    if (index == -1) {
      // New reactions
      if (selectedReactionList.isEmpty) {
        // The list is still available
        selectedReactionList.add(params.emojiId);
        await messageLocalRepository.syncMessageReactionData(
          SyncMessageReactionRequest(
            msgId: msgId,
            roomId: roomId,
            lastEmojis: lastEmojis,
            emojiAmount: emojiAmount,
            newEmojiId: params.emojiId,
            accountId: accountId,
            selectedReactionList: selectedReactionList,
          ),
        );
        eventBus.fire(
          MessageReactionEvent(
            msgId: msgId,
            lastEmojis: lastEmojis,
            emojiAmount: emojiAmount,
            selectedReactionList: selectedReactionList,
            accountId: accountId,
          ),
        );
      } else {
        // The list was full
        final removeEmojiId = selectedReactionList.removeAt(0);
        selectedReactionList.add(params.emojiId);
        await messageLocalRepository.syncMessageReactionData(
          SyncMessageReactionRequest(
            msgId: msgId,
            roomId: roomId,
            newEmojiId: params.emojiId,
            lastEmojis: lastEmojis,
            emojiAmount: emojiAmount,
            removeEmojiId: removeEmojiId,
            accountId: accountId,
            selectedReactionList: selectedReactionList,
          ),
        );
        eventBus.fire(
          MessageReactionEvent(
            msgId: msgId,
            lastEmojis: lastEmojis,
            emojiAmount: emojiAmount,
            removeEmojiId: removeEmojiId,
            selectedReactionList: selectedReactionList,
            accountId: accountId,
          ),
        );
      }
    } else if (selectedReactionList.any((element) => element == params.emojiId)) {
      // Remove reactions
      final removeEmojiId = selectedReactionList.removeAt(index);
      await messageLocalRepository.syncMessageReactionData(
        SyncMessageReactionRequest(
          msgId: msgId,
          roomId: roomId,
          lastEmojis: lastEmojis,
          emojiAmount: emojiAmount,
          removeEmojiId: removeEmojiId,
          accountId: accountId,
          selectedReactionList: selectedReactionList,
        ),
      );

      eventBus.fire(
        MessageReactionEvent(
          msgId: msgId,
          lastEmojis: lastEmojis,
          emojiAmount: emojiAmount,
          removeEmojiId: removeEmojiId,
          selectedReactionList: selectedReactionList,
          accountId: accountId,
        ),
      );
    }
  }
}
