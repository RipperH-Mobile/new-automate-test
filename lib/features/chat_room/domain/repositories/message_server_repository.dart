import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_message_react_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/react_message_request.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_message_request.dart';
import 'package:uchat/features/chat_room/domain/entities/get_message_from_server_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/message_reaction_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/message_reaction_response_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/send_message_response_entity.dart';
import 'package:uchat/features/chat_room/domain/params/delete_message_params.dart';
import 'package:uchat/features/chat_room/domain/params/delete_other_message_params.dart';
import 'package:uchat/features/chat_room/domain/params/edit_message_params.dart';
import 'package:uchat/features/chat_room/domain/params/get_message_from_server_params.dart';
import 'package:uchat/features/chat_room/domain/params/unsent_message_params.dart';

abstract class MessageServerRepository {
  /// Gets messages from the server for a specific room
  Future<GetMessageFromServerEntity?> getMessageInRoom(GetMessageFromServerParams params);

  /// Sends a message to the server
  Future<SendMessageResponseEntity?> sendMessage(SendMessageRequest request);

  /// Removes (deletes) a message
  Future<void> removeMessage(DeleteMessageParams params);

  /// Remove an other's message from group
  Future<void> removeOtherMessage(DeleteOtherMessageParams params);

  /// Unsets a message (for the sender to remove their message)
  Future<void> unsentMessage(UnsentMessageParams params);

  /// Edits an existing message
  Future<MessageEntity?> editMessage(EditMessageParams params);

  Future<MessageReactionResponseEntity> reactMessage(ReactMessageRequest params);

  Future<PaginationPayload<MessageReactionEntity>> getMessageReact(GetMessageReactRequest params);
}
