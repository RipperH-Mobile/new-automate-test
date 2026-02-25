import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/responses/get_message_from_server_response.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_message_request.dart';
import 'package:uchat/features/chat_room/domain/entities/get_message_from_server_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/send_message_response_entity.dart';

/// Extensions for mapping between data layer responses and domain entities
extension GetMessageFromServerResponseMapper on GetMessageFromServerResponse {
  /// Convert data layer response to domain entity
  GetMessageFromServerEntity toEntity() {
    return GetMessageFromServerEntity(
      messages: messages?.map((message) => message.toEntity()).toList(),
      // GetMessageFromServerResponse doesn't have hasMore field, so default to false
      hasMore: false,
    );
  }
}

/// Extensions for mapping ChatSendMessageResponse to domain entity
extension ChatSendMessageResponseMapper on SendMessageResponse {
  /// Convert data layer response to domain entity
  SendMessageResponseEntity toEntity() {
    return SendMessageResponseEntity(
      message: message?.toEntity(),
      success: message != null,
    );
  }
}
