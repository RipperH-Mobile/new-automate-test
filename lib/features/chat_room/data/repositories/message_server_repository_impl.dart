import 'package:uchat/api/payloads/message/edit_message.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/exceptions/exceptions.dart';
import 'package:uchat/core/infrastructure/analytics/implementation/sending_msg_performance_service_impl.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/data_sources/remote/chat_room_api_service.dart';
import 'package:uchat/features/chat_room/data/data_sources/remote/chat_room_socket_service.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_response_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/requests/delete_message_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/delete_other_message_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_message_from_server_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_message_react_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/react_message_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/unsent_message_request.dart';
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
import 'package:uchat/features/chat_room/domain/repositories/message_server_repository.dart';

class MessageServerRepositoryImpl implements MessageServerRepository {
  MessageServerRepositoryImpl({
    required this.socketCaller,
    required this.chatRoomApiService,
    required this.chatRoomSocketService,
  });

  final SocketCaller socketCaller;
  final ChatRoomApiService chatRoomApiService;
  final ChatRoomSocketService chatRoomSocketService;

  final _log = useLogger();

  @override
  Future<MessageEntity?> editMessage(EditMessageParams params) async {
    final request = EditMessageRequest(
      messageId: params.messageId,
      newMessage: params.newContent,
      isEncrypted: false, // Default to false, can be enhanced later if needed
    );

    if (socketCaller.isReadyForCall) {
      try {
        return await chatRoomSocketService.editMessage(request);
      } catch (e, stackTrace) {
        _log.w('editMessage', e, stackTrace);
      }
    }

    try {
      return await chatRoomApiService.editMessage(request);
    } catch (e, stackTrace) {
      _log.e('editMessage', e, stackTrace);
      throw ExceptionHandler.handle(e);
    }
  }

  @override
  Future<GetMessageFromServerEntity?> getMessageInRoom(GetMessageFromServerParams params) async {
    final timeout =
        params.timeout != null ? Duration(milliseconds: params.timeout!) : const Duration(milliseconds: 30000);

    final request = GetMessageFromServerRequest(
      roomId: params.roomId,
      pageSize: params.pageSize,
      isMyNote: params.isMyNote,
      bookmarkTagId: params.bookmarkTagId,
      timeout: timeout,
    );

    if (params.afterSequence != null) {
      request.afterSequence = params.afterSequence;
    }

    if (params.beforeSequence != null) {
      request.beforeSequence = params.beforeSequence;
    }

    if (socketCaller.isReadyForCall) {
      try {
        final response = await chatRoomSocketService.getMessages(request, timeout: request.timeout);
        return response?.toEntity();
      } catch (e, stackTrace) {
        _log.w('getMessageInRoom', e, stackTrace);
      }
    }

    try {
      final response = await chatRoomApiService.getMessages(request, timeout: request.timeout);
      return response?.toEntity();
    } catch (e, stackTrace) {
      _log.e('getMessageInRoom', e, stackTrace);
      throw ExceptionHandler.handle(e);
    }
  }

  @override
  Future<void> removeMessage(DeleteMessageParams params) async {
    final messageList = <DeleteMessageModelHelper>[];

    // Add message IDs to the request
    for (final msg in params.messages) {
      final helper = DeleteMessageModelHelper(
        messageId: msg.id ?? '',
        groupFileIds: (msg.files ?? []).map((e) => e.id ?? '').toList(),
      );
      messageList.add(helper);
    }

    final request = DeleteMessageRequest(messageList: messageList);

    if (socketCaller.isReadyForCall) {
      try {
        await chatRoomSocketService.removeMessage(request);
        return;
      } catch (e, stackTrace) {
        _log.w('removeMessage', e, stackTrace);
      }
    }

    try {
      await chatRoomApiService.removeMessage(request);
      return;
    } catch (e, stackTrace) {
      _log.e('removeMessage', e, stackTrace);
      throw ExceptionHandler.handle(e);
    }
  }

  @override
  Future<void> removeOtherMessage(DeleteOtherMessageParams params) async {
    final messageList = <DeleteOtherMessageModelHelper>[];

    // Add message IDs to the request
    for (final msg in params.messages) {
      final helper = DeleteOtherMessageModelHelper(
        messageId: msg.id ?? '',
        groupFileIds: (msg.files ?? []).map((e) => e.id ?? '').toList(),
      );
      messageList.add(helper);
    }

    final request = DeleteOtherMessageRequest(roomId: params.roomId, messageList: messageList);

    if (socketCaller.isReadyForCall) {
      try {
        await chatRoomSocketService.removeOtherMessage(request);
        return;
      } catch (e, stackTrace) {
        _log.w('removeOtherMessage', e, stackTrace);
      }
    }

    try {
      await chatRoomApiService.removeOtherMessage(request);
      return;
    } catch (e, stackTrace) {
      _log.e('removeOtherMessage', e, stackTrace);
      throw ExceptionHandler.handle(e);
    }
  }

  @override
  Future<SendMessageResponseEntity?> sendMessage(SendMessageRequest request) async {
    SendingMsgPerformanceServiceImpl.sendMessageToServerNetWorkTrace.start();
    final message = request.message;
    SendingMsgPerformanceServiceImpl.sendMessageToServerNetWorkTrace.putTraceAttributes(
      messageRef: message.ref!,
      messageType: message.type?.value ?? 'unknown',
      isEmoji: message.meta?.isEmoji ?? false,
    );
    if (socketCaller.isReadyForCall) {
      try {
        final response = await chatRoomSocketService.sendMessage(request);
        SendingMsgPerformanceServiceImpl.sendMessageToServerNetWorkTrace.putAttribute(
          SendingMsgAttributeName.networkType.value,
          'socket',
        );
        SendingMsgPerformanceServiceImpl.sendMessageToServerNetWorkTrace.stop();
        return response?.toEntity();
      } catch (e, stackTrace) {
        // Add taxonomy log for socket failure, how many times it falls back to http
        _log.w('sendMessage', e, stackTrace);
      }
    }

    final response = await chatRoomApiService.sendMessage(request);
    SendingMsgPerformanceServiceImpl.sendMessageToServerNetWorkTrace.putAttribute(
      SendingMsgAttributeName.networkType.value,
      'http',
    );
    SendingMsgPerformanceServiceImpl.sendMessageToServerNetWorkTrace.stop();
    return response?.toEntity();
  }

  @override
  Future<void> unsentMessage(UnsentMessageParams params) async {
    final messageList = <UnsendMessageModelHelper>[];

    for (final msg in params.messages) {
      final helper = UnsendMessageModelHelper(
        messageId: msg.id ?? '',
        groupFileIds: (msg.files ?? []).map((e) => e.id ?? '').toList(),
      );
      messageList.add(helper);
    }

    final request = UnsentMessageRequest(messageList: messageList);

    if (socketCaller.isReadyForCall) {
      try {
        await chatRoomSocketService.unsentMessage(request);
        return;
      } catch (e, stackTrace) {
        _log.w('unsentMessage', e, stackTrace);
      }
    }

    try {
      await chatRoomApiService.unsentMessage(request);
      return;
    } catch (e, stackTrace) {
      _log.e('unsentMessage', e, stackTrace);
      throw ExceptionHandler.handle(e);
    }
  }

  @override
  Future<MessageReactionResponseEntity> reactMessage(ReactMessageRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketRes = await chatRoomSocketService.reactMessage(request);
        if (socketRes == null) {
          throw NullResponseException();
        }
        return socketRes.toEntity();
      } on ApiException catch (e) {
        /// If the service is not found, fallback to http request.
        /// Otherwise, rethrow the error because when retrying with http request it's highly likely that server will
        /// throw the same error anyway.
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('reactMessage', e, stackTrace);
      }
    }

    final httpRes = await chatRoomApiService.reactMessage(request);
    if (httpRes == null) {
      throw NullResponseException();
    }
    return httpRes.toEntity();
  }

  @override
  Future<PaginationPayload<MessageReactionEntity>> getMessageReact(GetMessageReactRequest params) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketRes = await chatRoomSocketService.getMessageReact(params);
        if (socketRes == null) {
          throw NullResponseException();
        }
        return socketRes.toEntity((data) => data.map((e) => e.toEntity()));
      } on ApiException catch (e) {
        /// If the service is not found, fallback to http request.
        /// Otherwise, rethrow the error because when retrying with http request it's highly likely that server will
        /// throw the same error anyway.
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('getMessageReact', e, stackTrace);
      }
    }
    final httpRes = await chatRoomApiService.getMessageReact(params);
    if (httpRes == null) {
      throw NullResponseException();
    }
    return httpRes.toEntity((data) => data.map((e) => e.toEntity()));
  }
}
