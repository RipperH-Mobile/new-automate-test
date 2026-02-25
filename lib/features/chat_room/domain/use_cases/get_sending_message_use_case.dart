import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/domain/params/chat_room_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

typedef SetSendingMessageList = (List<MessageCollection>, List<MessageCollection>);

/// Get all sending messages in the chat room.
///
/// Return a tuple of two lists:
/// - The first list contains all sending messages.
/// - The second list contains all messages that failed to send.
///
/// Each message is represented by a [MessageCollection] object.
///
/// Example Result: (sending, sentFail)
///
/// If an error occurs, return an empty list.
class GetSendingMessageUseCase extends SimpleUseCase<SetSendingMessageList, ChatRoomParams> {
  @override
  Future<SetSendingMessageList> call(ChatRoomParams params) async {
    try {
      final messageEntities = await GetIt.I<MessageLocalRepository>().getAllSendingMessage(params.roomId);
      final sending = <MessageCollection>[];
      final sentFail = <MessageCollection>[];

      for (final entity in messageEntities) {
        // Convert entity to collection for compatibility with existing code
        final message = entity.toCollection();
        if (message.isSendFailed == true) {
          sentFail.add(message);
        } else {
          sending.add(message);
        }
      }

      return (sending, sentFail);
    } catch (e) {
      return (<MessageCollection>[], <MessageCollection>[]);
    }
  }
}
