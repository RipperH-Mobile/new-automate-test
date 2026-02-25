import 'package:uchat/api/api.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/data_sources/remote/chat_room_api_service.dart';
import 'package:uchat/features/chat_room/data/data_sources/remote/chat_room_socket_service.dart';
import 'package:uchat/features/chat_room/data/models/mapper/pin_message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/domain/entities/pin_message_entity.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_pin_messages_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/pin_message_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/unpin_all_messages_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/unpin_message_request.dart';
import 'package:uchat/features/chat_room/domain/repositories/pin_message_server_repository.dart';

class PinMessageServerRepositoryImpl implements PinMessageServerRepository {
  PinMessageServerRepositoryImpl({
    required this.socketCaller,
    required this.chatRoomApiService,
    required this.chatRoomSocketService,
  });

  final SocketCaller socketCaller;
  final ChatRoomApiService chatRoomApiService;
  final ChatRoomSocketService chatRoomSocketService;

  final _log = useLogger();

  @override
  Future<PinMessageEntity> pinMessage(PinMessageRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResponse = await chatRoomSocketService.pinMessage(request);
        if (socketResponse == null) {
          throw NullResponseException();
        }
        return socketResponse.toEntity();
      } on ApiException catch (e) {
        /// If the service is not found, fallback to http request.
        /// Otherwise, rethrow the error because when retrying with http request it's highly likely that server will
        /// throw the same error anyway.
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('pinMessage via socket', e, stackTrace);
      }
    }

    try {
      final apiResponse = await chatRoomApiService.pinMessage(request);
      if (apiResponse == null) {
        throw NullResponseException();
      }
      return apiResponse.toEntity();
    } catch (e, stackTrace) {
      _log.e('pinMessage via API', e, stackTrace);
      throw ExceptionHandler.handle(e);
    }
  }

  @override
  Future<void> unpinMessage(UnpinMessageRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await chatRoomSocketService.unpinMessage(request);
        return;
      } on ApiException catch (e) {
        /// If the service is not found, fallback to http request.
        /// Otherwise, rethrow the error because when retrying with http request it's highly likely that server will
        /// throw the same error anyway.
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('unpinMessage via socket', e, stackTrace);
      }
    }

    try {
      await chatRoomApiService.unpinMessage(request);
      return;
    } catch (e, stackTrace) {
      _log.e('unpinMessage via API', e, stackTrace);
      throw ExceptionHandler.handle(e);
    }
  }

  @override
  Future<void> unpinAllMessages(UnpinAllMessagesRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await chatRoomSocketService.unpinAllMessages(request);
        return;
      } on ApiException catch (e) {
        /// If the service is not found, fallback to http request.
        /// Otherwise, rethrow the error because when retrying with http request it's highly likely that server will
        /// throw the same error anyway.
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('unpinAllMessages via socket', e, stackTrace);
      }
    }

    try {
      await chatRoomApiService.unpinAllMessages(request);
      return;
    } catch (e, stackTrace) {
      _log.e('unpinAllMessages via API', e, stackTrace);
      throw ExceptionHandler.handle(e);
    }
  }

  @override
  Future<PaginationPayload<PinMessageEntity>> getPinMessages(GetPinMessagesRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResponse = await chatRoomSocketService.getPinMessages(request);
        if (socketResponse == null) {
          throw NullResponseException();
        }
        return socketResponse.toEntity<PinMessageEntity>((data) => data.toEntities());
      } on ApiException catch (e) {
        /// If the service is not found, fallback to http request.
        /// Otherwise, rethrow the error because when retrying with http request it's highly likely that server will
        /// throw the same error anyway.
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('getPinMessages via socket', e, stackTrace);
      }
    }

    try {
      final apiResponse = await chatRoomApiService.getPinMessages(request);
      if (apiResponse == null) {
        throw NullResponseException();
      }
      return apiResponse.toEntity<PinMessageEntity>((data) => data.toEntities());
    } catch (e, stackTrace) {
      _log.e('getPinMessages via API', e, stackTrace);
      throw ExceptionHandler.handle(e);
    }
  }
}
