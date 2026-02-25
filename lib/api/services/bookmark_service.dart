import 'package:uchat/api/api.dart';
import 'package:uchat/api/mixins/service_mixin.dart';
import 'package:uchat/api/payloads/bookmark_tag/add_new_bookmark_tag_request.dart';
import 'package:uchat/api/payloads/bookmark_tag/get_bookmark_tag_added_item_request.dart';
import 'package:uchat/api/payloads/bookmark_tag/set_default_bookmark_tag_request.dart';
import 'package:uchat/api/payloads/bookmark_tag/update_bookmark_tag_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_emoji_package_items_request.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/models/bookmark_package_with_items_response_model.dart';
import 'package:uchat/entities/models/bookmark_tag_package_response_model.dart';
import 'package:uchat/entities/models/get_bookmark_tag_added_item_response.dart';
import 'package:uchat/entities/models/set_default_bookmark_tag_response.dart';
import 'package:uchat/features/chat_room/data/models/models/bookmark_tag_model.dart';

final _log = useLogger();

class BookmarkService with ServiceMixin {
  // Singleton pattern
  static final BookmarkService instance = BookmarkService._internal();

  /// Factory constructor for the class
  factory BookmarkService() => instance;

  /// Internal constructor
  BookmarkService._internal();

  /// Fetches bookmark files using either socket or HTTP depending on connectivity.
  Future<BookmarkFileResponse?> getBookmarkFiles(BookmarkFileRequest request) async {
    try {
      // Check if socket is connected, attempt to use socket call first
      if (socketCaller.isReadyForCall) {
        final socketResp = await socketCaller.emitCall(
          BackendPath.getBookmarkFiles.socket,
          request.toMap(),
          timeout: const Duration(seconds: 60),
        );
        if (socketResp.data != null) {
          return BookmarkFileResponse.fromMap(socketResp.data);
        }
      }
    } catch (e, stackTrace) {
      _log.w('getBookmarkFiles with socket error. fallback to http request...', e, stackTrace);
    }

    // Fallback to HTTP request if socket is not connected or fails
    final httpResp = await httpCaller.get(
      BackendPath.getBookmarkFiles.http,
      data: request.toMap(),
    );

    return BookmarkFileResponse.fromMap(httpResp.data);
  }

  /// Fetch bookmarked messages from the backend
  Future<BookmarkMessageResponse?> getBookmarkMessages(BookmarkMessageRequest request) async {
    try {
      if (socketCaller.isReadyForCall) {
        final socketResp = await socketCaller.emitCall(
          BackendPath.getBookmarkMessages.socket,
          request.toMap(),
          timeout: const Duration(seconds: 60),
        );

        if (socketResp.data != null) {
          return BookmarkMessageResponse.fromMap(socketResp.data);
        }
      }
    } catch (e, stackTrace) {
      _log.w('getBookmarkMessages with socket error. fallback to http request...', e, stackTrace);
    }

    // Fallback to HTTP request if WebSocket is not connected
    final httpResp = await httpCaller.get(
      BackendPath.getBookmarkMessages.http,
      queryParameters: request.toMap(),
    );

    return BookmarkMessageResponse.fromMap(httpResp.data);
  }

  /// Fetches bookmark tags using either socket or HTTP depending on connectivity.
  Future<GetBookmarkTagsResponse?> getBookmarkTags(GetBookmarkTagsRequest request) async {
    try {
      // Check if socket is connected, attempt to use socket call first
      if (socketCaller.isReadyForCall) {
        final socketResp = await socketCaller.emitCall(
          BackendPath.getBookmarkTags.socket,
          request.toMap(),
          timeout: const Duration(seconds: 60),
        );

        if (socketResp.data != null) {
          return GetBookmarkTagsResponse.fromMap(socketResp.data);
        }
      }
    } catch (e, stackTrace) {
      _log.w('getBookmarkTags with socket error. fallback to http request...', e, stackTrace);
    }

    // Fallback to HTTP request if socket is not connected or fails
    final httpResp = await httpCaller.get(
      BackendPath.getBookmarkTags.http,
      queryParameters: request.toMap(),
    );

    return GetBookmarkTagsResponse.fromMap(httpResp.data);
  }

  /// Deletes bookmark tags using either socket or HTTP depending on connectivity.
  Future<DeleteBookmarkTagsResponse?> deleteBookmarkTags(DeleteBookmarkTagsRequest request) async {
    try {
      // Check if socket is connected, attempt to use socket call first
      if (socketCaller.isReadyForCall) {
        final socketResp = await socketCaller.emitCall(
          BackendPath.deleteBookmarkTags.socket,
          request.toMap(),
          timeout: const Duration(seconds: 60),
        );
        if (socketResp.data != null) {
          return DeleteBookmarkTagsResponse.fromMap(socketResp.data);
        }
      }
    } catch (e, stackTrace) {
      _log.w('deleteBookmarkTags with socket error. fallback to http request...', e, stackTrace);
    }
    // Fallback to HTTP request if socket is not connected or fails
    final httpResp = await httpCaller.delete(
      BackendPath.deleteBookmarkTags.http,
      data: request.toMap(),
    );

    return DeleteBookmarkTagsResponse.fromMap(httpResp.data);
  }

  Future<GetBookmarkTagAddedItemResponse?>? getBookmarkAddedItemList(GetBookmarkTagAddedItemRequest request) async {
    try {
      if (socketCaller.isReadyForCall) {
        final socketResp = await socketCaller.emitCall(
          BackendPath.getBookmarkTags.socket,
          request.toMap(),
        );

        return socketResp.mapToResponse<GetBookmarkTagAddedItemResponse>(
          (data) => GetBookmarkTagAddedItemResponse.fromMap(data),
        );
      }
    } catch (e, stackTrace) {
      _log.w('getBookmarkAddedItemList with socket error. fallback to http request...', e, stackTrace);
    }

    final httpResp = await httpCaller.get(
      BackendPath.getBookmarkTags.http,
      queryParameters: request.toMap(),
    );

    return httpResp.mapToResponse<GetBookmarkTagAddedItemResponse>(
      (data) => GetBookmarkTagAddedItemResponse.fromMap(data),
    );
  }

  Future<SetDefaultBookmarkTagResponse?> setDefaultBookmarkTag(SetDefaultBookmarkTagRequest request) async {
    try {
      if (socketCaller.isReadyForCall) {
        final socketResp = await socketCaller.emitCall(
          BackendPath.setDefaultBookmarkTag.socket,
          request.toMap(),
        );

        return socketResp.mapToResponse<SetDefaultBookmarkTagResponse>(
          (result) {
            return SetDefaultBookmarkTagResponse.fromMap(result);
          },
        );
      }
    } catch (e, stackTrace) {
      _log.w('setDefaultBookmarkTag with socket error. fallback to http request...', e, stackTrace);
    }

    final httpResp = await httpCaller.put(
      BackendPath.setDefaultBookmarkTag.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponse<SetDefaultBookmarkTagResponse>(
      (result) => SetDefaultBookmarkTagResponse.fromMap(result),
    );
  }

  Future<AddTagToMessageResponse?> addTagToMessage(AddTagToMessageRequest request) async {
    try {
      if (socketCaller.isReadyForCall) {
        final socketResp = await socketCaller.emitCall(
          BackendPath.addTagToMessage.socket,
          request.toMap(),
        );

        return socketResp.mapToResponse<AddTagToMessageResponse>(
          (result) => AddTagToMessageResponse.fromMap(result),
        );
      }
    } catch (e, stackTrace) {
      _log.w('addTagToMessage with socket error. fallback to http request...', e, stackTrace);
    }

    final res = await httpCaller.post(
      BackendPath.addTagToMessage.http.replaceAll(':messageId', request.msgId),
      data: request.toMap(),
    );

    return res.mapToResponse<AddTagToMessageResponse>(
      (result) => AddTagToMessageResponse.fromMap(result),
    );
  }

  Future<BookmarkPackageWithItemsResponse?> getBookmarkPackagesItems(GetEmojiPackageItemsRequest request) async {
    try {
      if (socketCaller.isReadyForCall) {
        final res = await socketCaller.emitCall(
          BackendPath.getEmojiPackages.socket,
          request.toMap(),
        );

        return res.mapToResponse<BookmarkPackageWithItemsResponse>(
          (result) => BookmarkPackageWithItemsResponse.fromMap(result),
        );
      }
    } catch (e, stackTrace) {
      _log.w('getBookmarkPackagesItems socket error', e, stackTrace);
    }

    final res = await httpCaller.get(
      BackendPath.getEmojiPackages.http,
      queryParameters: request.toMap(),
    );

    return res.mapToResponse<BookmarkPackageWithItemsResponse>(
      (result) => BookmarkPackageWithItemsResponse.fromMap(result),
    );
  }

  Future<BookmarkTagPackageResponse?> getBookmarkEmojiPackages(
    GetBookmarkTagAddedItemRequest request,
  ) async {
    try {
      if (socketCaller.isReadyForCall) {
        final res = await socketCaller.emitCall(
          BackendPath.getEmojiPackages.socket,
          request.toMap(),
        );

        return res.mapToResponse<BookmarkTagPackageResponse>(
          (result) => BookmarkTagPackageResponse.fromMap(result),
        );
      }
    } catch (e, stackTrace) {
      _log.w('getBookmarkEmojiPackages socket error', e, stackTrace);
    }

    final res = await httpCaller.get(
      BackendPath.getEmojiPackages.http,
      queryParameters: request.toMap(),
    );

    return res.mapToResponse<BookmarkTagPackageResponse>(
      (result) => BookmarkTagPackageResponse.fromMap(result),
    );
  }

  Future<BookmarkTagModel?> addNewBookmarkTag(AddNewBookmarkTagRequest request) async {
    try {
      if (socketCaller.isReadyForCall) {
        final res = await socketCaller.emitCall(
          BackendPath.addNewBookmarkTag.socket,
          request.toMap(),
        );

        return res.mapToResponse<BookmarkTagModel>(
          (result) => BookmarkTagModel.fromMap(result),
        );
      }
    } catch (e, stackTrace) {
      _log.w('addNewBookmarkTag socket error', e, stackTrace);
    }

    final res = await httpCaller.post(
      BackendPath.addNewBookmarkTag.http,
      data: request.toMap(),
    );

    return res.mapToResponse<BookmarkTagModel>(
      (result) => BookmarkTagModel.fromMap(result),
    );
  }

  Future<BookmarkTagModel?> updateBookmarkTag(UpdateBookmarkTagRequest request) async {
    try {
      if (socketCaller.isReadyForCall) {
        final res = await socketCaller.emitCall(
          BackendPath.updateBookmarkTag.socket,
          request.toMap(),
        );

        return res.mapToResponse<BookmarkTagModel>(
          (result) => BookmarkTagModel.fromMap(result),
        );
      }
    } catch (e, stackTrace) {
      _log.w('updateBookmarkTag socket error', e, stackTrace);
    }

    final res = await httpCaller.put(
      BackendPath.updateBookmarkTag.http,
      data: request.toMap(),
    );

    return res.mapToResponse<BookmarkTagModel>(
      (result) => BookmarkTagModel.fromMap(result),
    );
  }
}
