import 'dart:async';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/null_response_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_emoji_packages_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_emoji_package_items_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/set_default_emoji_request.dart';
import 'package:uchat/features/chat_room/domain/entities/emoji_package_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/emoji_package_with_items_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/update_default_emoji_entity.dart';
import 'package:uchat/features/chat_room/data/data_sources/remote/emoji_api_service.dart';
import 'package:uchat/features/chat_room/data/data_sources/remote/emoji_socket_service.dart';
import 'package:uchat/features/chat_room/domain/repositories/emoji_server_repository.dart';

class EmojiServerRepositoryImpl implements EmojiServerRepository {
  final SocketCaller socketCaller;
  final EmojiApiService emojiApiService;
  final EmojiSocketService emojiSocketService;
  final LoggerService log;

  EmojiServerRepositoryImpl({
    required this.socketCaller,
    required this.emojiApiService,
    required this.emojiSocketService,
    required this.log,
  });

  @override
  Future<PaginationPayload<EmojiPackageWithItemsEntity>> getEmojiPackagesItems(
      GetEmojiPackageItemsRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketRes = await emojiSocketService.getEmojiPackagesItems(request);
        if (socketRes == null) {
          throw NullResponseException();
        }
        return socketRes;
      } on ApiException catch (e) {
        /// If the service is not found, fallback to http request.
        /// Otherwise, rethrow the error because when retrying with http request it's highly likely that server will
        /// throw the same error anyway.
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        log.w('getEmojiPackagesItems with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpRes = await emojiApiService.getEmojiPackagesItems(request);
    if (httpRes == null) {
      throw NullResponseException();
    }
    return httpRes;
  }

  @override
  Future<PaginationPayload<EmojiPackageEntity>> getEmojiPackages(GetEmojiPackagesRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketRes = await emojiSocketService.getEmojiPackages(request);
        if (socketRes == null) {
          throw NullResponseException();
        }
        return socketRes;
      } on ApiException catch (e) {
        /// If the service is not found, fallback to http request.
        /// Otherwise, rethrow the error because when retrying with http request it's highly likely that server will
        /// throw the same error anyway.
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        log.w('getEmojiPackages with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpRes = await emojiApiService.getEmojiPackages(request);
    if (httpRes == null) {
      throw NullResponseException();
    }
    return httpRes;
  }

  @override
  Future<UpdateDefaultEmojiEntity> updateDefaultEmoji(UpdateDefaultEmojiRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketRes = await emojiSocketService.setDefaultEmoji(request);
        if (socketRes == null) {
          throw NullResponseException();
        }
        return socketRes;
      } on ApiException catch (e) {
        /// If the service is not found, fallback to http request.
        /// Otherwise, rethrow the error because when retrying with http request it's highly likely that server will
        /// throw the same error anyway.
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        log.w('setDefaultEmoji with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpRes = await emojiApiService.setDefaultEmoji(request);
    if (httpRes == null) {
      throw NullResponseException();
    }
    return httpRes;
  }
}
