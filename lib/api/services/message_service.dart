import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/api/mixins/service_mixin.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/features/chat_room/chat_room_barrel.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/message_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_file_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_file_message_request.dart';
import 'package:uchat/features/chat_room/presentation/controllers/utils/append_or_update_many_message_to_state.dart';
import 'package:uchat/utils/encrypt_helper.dart';
// ignore: depend_on_referenced_packages
import 'package:uuid/uuid.dart';
import 'package:webcrypto/webcrypto.dart';

final _log = useLogger();

typedef AddToStateType = Future<void> Function(
  MessageCollection message,
  List<String>? assetEntityId,
)?;

class MessageService with ServiceMixin {
  // Singleton pattern
  static final MessageService instance = MessageService.internal();

  factory MessageService() => instance;

  MessageService.internal();

  final messageDb = GetIt.I<MessageDb>();
  final roomFileDb = GetIt.I<RoomFileDb>();
  final roomDb = GetIt.I<RoomDb>();
  final roomSubDb = GetIt.I<RoomSubscriptionDb>();

  final Map<String?, ChatSendFileRequest> sendingFileRequests = {};

  List<bool> isLivePhotoList = [];

  String getFileUrl(String fileId) {
    return 'chat-rooms/file/$fileId';
  }

  /// [Hybrid]
  /// ServiceMethod: get chat messages
  Future<ChatMessagesResponse?> getMessages(
    ChatMessagesRequest request, {
    Duration timeout = emitCallTimeout,
  }) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCallV3(
          BackendPath.getMessages.socket,
          request.toMap(),
          timeout: timeout,
        );
        return ChatMessagesResponse(
          messages: socketResp.listToResponseV3((data) => MessageCollection.fromMap(data))?.toList(),
        );
      } catch (e, stackTrace) {
        _log.w('getMessages with socket error. fallback to http request...', e, stackTrace);
      }
    }

    // Fallback to http caller
    final httpResp = await httpCaller.get(
      BackendPath.getMessages.http.replaceAll(':roomId', request.roomId),
      queryParameters: request.toMap(),
    );

    return ChatMessagesResponse(
      messages: httpResp.listToResponseV3((data) => MessageCollection.fromMap(data))?.toList(),
    );
  }

  void cancelSendFile(String? refFile) {
    if (refFile == null) return;
    sendingFileRequests[refFile]?.cancelToken?.cancel();
    sendingFileRequests[refFile]?.onSendFail?.call();
  }

  Future<MessageCollection> uploadFile({
    String? thumbnailId,
    required SendFileMessageRequest fileRequest,
    Function(double progress)? onProgress,
  }) async {
    final data = await fileRequest.toFormData(thumbnailId: thumbnailId);
    final resp = await httpCaller.post(
      BackendPath.uploadFile.http.replaceAll(':roomId', fileRequest.roomId),
      data: data,
      onSendProgress: (int sent, int total) {
        if (onProgress != null && total != 0) {
          final progress = sent / total;
          onProgress(progress);
        }
      },
      cancelToken: fileRequest.cancelToken,
      options: Options(sendTimeout: const Duration(minutes: 10)),
    );
    return MessageCollection.fromMap(resp.data['data']);
  }

  Future<MessageCollection> uploadFilesConfirm(UploadFilesConfirmRequest request) async {
    final resp = await httpCaller.post(
      BackendPath.uploadFileConfirm.http.replaceAll(':roomId', request.roomId),
      data: request.toMap(),
    );
    return MessageCollection.fromMap(resp.data);
  }

  @Deprecated('Hide message function is removed')
  Future<bool> hideMessage(String messageId) async {
    if (socketCaller.isReadyForCall) {
      try {
        await socketCaller.emitCall(
          BackendPath.hideMessage.socket,
          {
            'messageId': messageId,
          },
        );

        return true;
      } catch (e, stackTrace) {
        _log.w('hideMessage with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await httpCaller.post(
      BackendPath.hideMessage.http,
      data: {
        'messageId': messageId,
      },
    );

    return true;
  }

  @Deprecated('Hide message function is removed')
  Future<bool> unHideMessage(String messageId) async {
    if (socketCaller.isReadyForCall) {
      try {
        await socketCaller.emitCall(
          BackendPath.unhideMessage.socket,
          {
            'messageId': messageId,
          },
        );

        return true;
      } catch (e, stackTrace) {
        _log.w('unHideMessage with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await httpCaller.post(
      BackendPath.unhideMessage.http,
      data: {
        'messageId': messageId,
      },
    );

    return true;
  }

  /// [Hybrid]
  /// ServiceMethod: Save to bookmark
  Future<void> saveToBookmark(SaveBookmarkRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await socketCaller.emitCall(
          BackendPath.saveToBookmark.socket,
          request.toMap(),
        );

        return;
      } catch (e, stackTrace) {
        _log.w('saveToBookmark with socket error. fallback to http request...', e, stackTrace);
      }
    }

    // Fallback to http caller
    await httpCaller.post(
      BackendPath.saveToBookmark.http,
      data: request.toMap(),
    );
  }

  /// [Hybrid]
  /// ServiceMethod: Remove from bookmark
  Future<void> removeFromBookmark(RemoveBookmarkRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await socketCaller.emitCall(
          BackendPath.removeFromBookmark.socket,
          request.toMap(),
        );

        return;
      } catch (e, stackTrace) {
        _log.w('removeFromBookmark with socket error. fallback to http request...', e, stackTrace);
      }
    }

    // Fallback to http caller
    await httpCaller.delete(
      BackendPath.removeFromBookmark.http,
      data: request.toMap(),
    );
  }

  // ! New request changed, old service incompatible with new api.
  //
  // /// [Hybrid]
  // /// ServiceMethod: Unsent Message
  // Future<void> unsentMessage(UnsentMessageRequest request) async {
  //   if (socketCaller.isReadyForCall) {
  //     try {
  //       await socketCaller.emitCall(
  //         BackendPath.unsentMessage.socket,
  //         request.toMap(),
  //       );
  //
  //       return;
  //     } catch (e, stackTrace) {
  //       _log.w('unsentMessage with socket error. fallback to http request...', e, stackTrace);
  //     }
  //   }
  //
  //   // Fallback to http caller
  //   await httpCaller.delete(
  //     BackendPath.unsentMessage.http.replaceAll(':messageId', request.messageId),
  //     data: request.toMap(),
  //   );
  // }
  //
  // /// [Hybrid]
  // /// ServiceMethod: Delete Message
  // Future<void> removeMessage(UnsentMessageRequest request) async {
  //   if (socketCaller.isReadyForCall) {
  //     try {
  //       await socketCaller.emitCall(
  //         BackendPath.removeMessage.socket,
  //         request.toMap(),
  //       );
  //
  //       return;
  //     } catch (e, stackTrace) {
  //       _log.w('removeMessage with socket error. fallback to http request...', e, stackTrace);
  //     }
  //   }
  //
  //   // Fallback to http caller
  //   await httpCaller.delete(
  //     BackendPath.removeMessage.http.replaceAll(':messageId', request.messageId),
  //     data: request.toMap(),
  //   );
  // }

  /// [Hybrid]
  /// ServiceMethod: Edit Message
  Future<void> editMessage(EditMessageRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await socketCaller.emitCallV3(
          BackendPath.editMessage.socket,
          request.toMap(),
        );

        return;
      } catch (e, stackTrace) {
        _log.w('editMessage with socket error. fallback to http request...', e, stackTrace);
      }
    }

    // Fallback to http caller
    await httpCaller.put(
      BackendPath.editMessage.http.replaceAll(':messageId', request.messageId),
      data: request.toMap(),
    );
  }

  Future<String> uploadThumbnail({
    required Uint8List thumbnail,
    required SendFileMessageRequest req,
    required String fileName,
    required MessageFileType fileType,
    double? width = 720,
    double? height = 1280,
  }) async {
    if (![MessageFileType.video, MessageFileType.file].contains(fileType)) {
      throw Exception('uploadThumbnail only support video and file type.');
    }

    try {
      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(
          thumbnail,
          filename: fileName,
        ),
        'width': width,
        'height': height,
      });

      final url = fileType == MessageFileType.video
          ? BackendPath.uploadVideoThumbnail.http.replaceAll(':roomId', req.roomId)
          : BackendPath.uploadFileThumbnail.http.replaceAll(':roomId', req.roomId);
      final response = await httpCaller.post(url,
          options: Options(headers: {
            'content-type': 'multipart/form-data',
          }),
          data: formData,
          onSendProgress: req.onSendThumbnailProgress);

      _log.d('uploadThumbnail response: $response');
      final data = response.data['data'];
      final thumbnailId = data['thumbnailId'];

      return thumbnailId;
    } catch (e, stackTrace) {
      _log.e('uploadThumbnail error.', e, stackTrace);
      rethrow;
    }
  }

  ///
  /// Helper to fetch room message from server
  /// Using [timeout] for specific socket emit timeout.
  ///
  Future<ChatMessagesResponse?> fetchMessagesFromServer(
    String roomId, {
    bool onlyPrevious = false,
    bool onlyAfter = false,
    bool isMyNote = false,
    bool saveToDb = true,
    String? bookmarkTagId,
    Duration timeout = emitCallTimeout,
  }) async {
    // _log.d('Fetch message from roomId: $roomId');

    // New request param
    final req = ChatMessagesRequest(
      roomId: roomId,
      pageSize: UChatConstant.defaultPageSize,
      isMyNote: isMyNote,
      bookmarkTagId: bookmarkTagId,
    );

    // Get latest message
    if (onlyAfter) {
      try {
        final latestValue = await messageDb.getLastSequenceByRoom(roomId: roomId);

        if (latestValue != null) {
          req.afterSequence = latestValue.sequence;
          _log.d('Sync message afterSequence: ${req.afterSequence}');
        }
      } catch (e, stackTrace) {
        _log.i('Get last sequence by room error.', e, stackTrace);
      }
    }

    // Get old message
    if (onlyPrevious) {
      try {
        final oldValue = await messageDb.getFirstSequenceByRoom(roomId: roomId);
        // _log.d('oldValue: $oldValue');

        if (onlyPrevious && oldValue?.sequence == 1) {
          return null;
        }

        if (oldValue != null && oldValue.sequence! > 1) {
          req.beforeSequence = oldValue.sequence;
          // _log.d('Sync message beforeSeq: ${req.beforeSeq}');
        }
      } catch (e, stackTrace) {
        _log.d('Get first sequence by room error.', e, stackTrace);
      }
    }

    if (req.beforeSequence != null && req.afterSequence != null) {
      if (req.beforeSequence! <= req.afterSequence!) {
        req.seqCondition = 'OR';
      } else {
        req.seqCondition = 'AND';
      }
    }

    // _log.d('[Fetch Message Request]:\n$req');

    // Request message
    try {
      final res = await getMessages(req, timeout: timeout);
      // _log.d('Getting message...');
      // _log.d(res);

      if (res == null) {
        return null;
      }

      if (res.messages?.isNotEmpty == true) {
        // _log.d('Found new messages: ${res.messages!.length}');
        AesGcmSecretKey? roomCryptoKey;
        RoomCollection? room = await roomDb.getRoom(roomId);

        if (room?.isSecretRoom == true) {
          // Create room crypto key for secret chat.
          if (room?.roomCryptoKey == null) {
            final roomWithCryptoKey = await EncryptHelper.instance.createSecretRoomCryptoKey(room);
            if (roomWithCryptoKey != null) {
              room = roomWithCryptoKey;
            }
          }
        } else {
          // Create room crypto key. This code block will do nothing if this room
          // doesn't use encryption and the server doesn't have public key.
          final roomWithCryptoKey = await EncryptHelper.instance.createRoomCryptoKey(room);
          if (roomWithCryptoKey != null) {
            room = roomWithCryptoKey;
          }
        }

        roomCryptoKey = await room?.getRoomCryptoKeyObj();
        if (roomCryptoKey != null) {
          for (MessageCollection message in res.messages!) {
            // Decrypt a message if it is encrypted.
            try {
              message = (await EncryptHelper.instance.decryptMessageCollection(
                room: room,
                message: message,
                cryptoKey: roomCryptoKey,
              ))!;
            } catch (e, stackTrace) {
              _log.e('decrypt message error.', e, stackTrace);
            }
          }
        }

        // Save to db
        if (saveToDb) {
          await messageDb.putAllMessages(res.messages!);
        }
      }

      return res;
    } catch (e, stackTrace) {
      _log.e('Get messages from server error.', e, stackTrace);
    }

    return null;
  }

  Future<List<SearchMessagesResultModel>?> searchMessages(
    SearchMessagesRequest request,
  ) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.searchUniversal.socket,
          request.toMap(),
          timeout: const Duration(seconds: 15),
        );

        // Wait for the asynchronous function to get results from the local database
        final response = await SearchMessagesResponse.fromList(socketResp.data);

        // Return the result list from the response
        return response.resultList;
      } catch (e, stackTrace) {
        _log.w('searchUniversal with socket error. fallback to http request...', e, stackTrace);
      }
    }

    try {
      // Fetch the response from the API
      final httpResp = await httpCaller
          .get(
            BackendPath.searchUniversal.http,
            queryParameters: request.toMap(),
          )
          .timeout(const Duration(seconds: 15));

      // Wait for the asynchronous function to get results from the local database
      final response = await SearchMessagesResponse.fromList(httpResp.data);

      // Return the result list from the response
      return response.resultList;
    } on TimeoutException catch (e) {
      _log.w('Request timed out', e);
    } catch (e, stackTrace) {
      _log.w('Search universal error.', e, stackTrace);
    }
    return null;
  }

  Future<void> putMessageToDbAndState({required MessageCollection message, AddToStateType addToStateFunction}) async {
    await messageDb.putMessage(message);
    if (addToStateFunction != null) {
      await addToStateFunction(message, []);
    }
  }

  Future<void> onCompressingVideoFileCallback({
    required double progress,
    required MessageCollection message,
    required int fileIndex,
  }) async {
    try {
      /// Update message file progress
      /// [progress] is the percentage of the video file compression
      if (message.files == null || message.files!.isEmpty) return;

      /// If the file progress state is not compressing,
      /// we need to update the message file progress state to compressing
      if (message.files?[fileIndex].progressState != FileProgressState.compressing) {
        message.files?[fileIndex].progressState = FileProgressState.compressing;
        await messageDb.putMessage(message);
      }

      /// Update message file compressing progress through event bus
      eventBus.fire(
        VideoFileCompressingProgressEvent(
          fileRef: message.files![fileIndex].refFile!,
          compressProgress: progress,
        ),
      );
    } catch (e, stackTrace) {
      _log.e('onCompressingVideoFileCallback error', e, stackTrace);
    }
  }

  Future<void> onSendProgressCallback({
    required int sent,
    required int total,
    required MessageCollection message,
    required int fileIndex,
  }) async {
    try {
      if (message.files == null || message.files!.isEmpty) {
        return;
      }

      /// Update message file uploading progress through event bus
      eventBus.fire(
        FileUploadProgressEvent(
          fileRef: message.files![fileIndex].refFile!,
          uploadProgress: sent.toDouble(),
          totalProgress: total.toDouble(),
        ),
      );

      /// Update message file progress state to uploading
      if (message.files?[fileIndex].progressState != FileProgressState.uploading) {
        final messageFile = message.files![fileIndex].copyWith(
          progressState: FileProgressState.uploading,
          isSendFailed: true,
        );
        message.files?[fileIndex] = messageFile;
        await messageDb.putMessage(message);
      }
    } catch (e, stackTrace) {
      _log.e('onSendProgressCallback error', e, stackTrace);
    }
  }

  /// Send file fail callback
  Future<void> onSendFailCallback({
    required MessageCollection message,
    required int fileIndex,
    required String sendToRoomId,
    required String targetFilePath,
  }) async {
    try {
      if (sendToRoomId == message.roomId) {
        /// Update message file progress state to upload failed
        final room = roomDb.getRoomSync(sendToRoomId);

        ChatRoomController chatRoomDirectController = getx.Get.isRegistered<ChatRoomController>(tag: message.roomId)
            ? getx.Get.find<ChatRoomController>(
                tag: message.roomId,
              )
            : getx.Get.put(
                ChatRoomController(
                  tag: '${room!.id}',
                  messageLocalRepository: GetIt.I<MessageLocalRepository>(),
                ),
              );

        final roomsController = getx.Get.find<ChatListController>();
        await roomsController.toggleHasFailedMessage(
          chatRoomDirectController.roomId,
          true,
        );

        // Handle send fail when there is one file in this message.
        if (message.files?.length == 1) {
          message.isSending = false;
          message.isSendFailed = true;
          final messageFile = message.files![0].copyWith(
            progressState: FileProgressState.uploadFailed,
            isSendFailed: true,
          );
          message.files?[0] = messageFile;
          await messageDb.putMessage(message);
          final messages = appendOrUpdateMessageToState(
            message,
            chatRoomDirectController.messageListCtl.messages,
            chatRoomDirectController.messageListCtl.failedMessages.length,
          );
          chatRoomDirectController.messageListCtl.messages.value = messages;
          chatRoomDirectController.messageListCtl.messages.refresh();
          eventBus.fire(
            FileStateChangeEvent(
              fileRef: message.files![0].refFile!,
              state: FileProgressState.uploadFailed,
            ),
          );
        } else {
          // handle send fail when there is more than 1 file in this message.

          int index =
              message.files?.indexWhere((element) => element.url != null && element.url == targetFilePath) ?? -1;
          // Remove failed file from original message.
          final failedFile = message.files?.removeAt(index);
          failedFile?.progressState = FileProgressState.uploadFailed;
          failedFile?.isSendFailed = true;
          // Create new message with failed file for resend.
          String newFailedMessageRef = generateMsgUid();
          MessageCollection newFailedMessage = MessageCollection()
            ..id = newFailedMessageRef
            ..ref = newFailedMessageRef
            ..roomId = message.roomId
            ..isSending = false
            ..isSendFailed = true
            ..account = message.account
            ..accountId = message.accountId
            ..type = message.type
            ..files = [failedFile!]
            ..createdAt = DateTime.now()
            ..message = message.message;

          // Update original message to local db and update state in ChatRoomController.
          await messageDb.putMessage(message);

          final messages = appendOrUpdateMessageToState(
            message,
            chatRoomDirectController.messageListCtl.messages,
            chatRoomDirectController.messageListCtl.failedMessages.length,
          );
          chatRoomDirectController.messageListCtl.messages.value = messages;
          chatRoomDirectController.messageListCtl.messages.refresh();

          // Add new failed message to local db and update state in ChatRoomController.
          // This should show up in chat room just like when sending 1 image and failed.
          await messageDb.putMessage(newFailedMessage);

          final tempFewFailedMessage = appendOrUpdateMessageToState(
            newFailedMessage,
            chatRoomDirectController.messageListCtl.messages,
            chatRoomDirectController.messageListCtl.failedMessages.length,
          );
          chatRoomDirectController.messageListCtl.messages.value = tempFewFailedMessage;
          chatRoomDirectController.messageListCtl.messages.refresh();
          eventBus.fire(
            FileStateChangeEvent(
              fileRef: failedFile.refFile!,
              state: FileProgressState.uploadFailed,
            ),
          );
        }
      }
    } catch (e, stackTrace) {
      _log.e('onSendFailCallback error', e, stackTrace);
    }
  }

  Future<Response> uploadPro({
    required String name,
    required String roomId,
    String? ref,
    String? replyId,
    int? size,
    String? type,
  }) async {
    return await httpCaller.post(
      BackendPath.uploadPro.http,
      data: {
        'name': name,
        'roomId': roomId,
        'ref': ref,
        'replyId': replyId,
        'size': size,
        'type': type,
      },
    );
  }

  // NOTE: #uploadProFeature
  Future<Response> putUpload({
    required String signedUrl,
    required Uint8List dataForPut,
  }) async {
    // Create mutable headers map (not const) and use appropriate Content-Type for binary data
    final headers = <String, dynamic>{
      'Content-Type': 'application/octet-stream',
      'Accept': 'application/json',
    };
    return httpCaller.put(
      signedUrl,
      data: dataForPut,
      options: Options(
        headers: headers,
      ),
      isExternalApi: true,
      useDefaultHeader: false,
    );
  }

  // NOTE: #uploadProFeature
  Future<Response> uploadProFinal({
    required String fileId,
    required String fileKey,
    required List<Map<String, dynamic>> parts,
  }) async {
    return await httpCaller.post(
      BackendPath.uploadProFinal.http,
      data: {
        'fileId': fileId,
        'fileKey': fileKey,
        'parts': parts,
      },
    );
  }

  String generateMsgUid() {
    return '${UserController.instance.currentUser()!.id}-${const Uuid().v4()}';
  }

  String generateRefFile(String roomId) {
    return '$roomId-${const Uuid().v4()}';
  }

  Future<void> onShareFileService(
    ShareMessagePayload shareMessagePayload,
  ) async {
    try {
      await httpCaller.post(
        BackendPath.shareFile.http,
        data: shareMessagePayload.toJson(),
      );
    } catch (e) {
      _log.e('Send share files to server error', e);
      rethrow;
    }
  }

  List<Uint8List> getChunkParts(Uint8List data, int numberOfChunk) {
    // Define the chunk size
    // TODO: Aware to check maximum chunk size with server configuration
    final chunkSize = data.length ~/ numberOfChunk;

    return List<Uint8List>.generate(numberOfChunk, (index) {
      final startByte = index * chunkSize;
      final endByte = min((index + 1) * chunkSize, data.length);
      return data.sublist(startByte, endByte);
    });
  }

  /// Reads a specific chunk from a file using stream-based I/O to avoid
  /// loading the entire file into memory at once.
  ///
  /// [file] – the file to read from.
  /// [fileSize] – total size in bytes (pre-computed to avoid repeated stat calls).
  /// [numberOfChunks] – how many chunks the file is split into.
  /// [chunkIndex] – zero-based index of the chunk to read.
  ///
  /// Returns the chunk bytes as [Uint8List].
  Future<Uint8List> getChunkFromFile(
    File file,
    int fileSize,
    int numberOfChunks,
    int chunkIndex,
  ) async {
    final chunkSize = fileSize ~/ numberOfChunks;
    final startByte = chunkIndex * chunkSize;
    final endByte = min((chunkIndex + 1) * chunkSize, fileSize);
    final length = endByte - startByte;

    final completer = Completer<Uint8List>();
    final builder = BytesBuilder(copy: false);

    file.openRead(startByte, endByte).listen(
          builder.add,
          onDone: () => completer.complete(builder.takeBytes()),
          onError: completer.completeError,
          cancelOnError: true,
        );

    final bytes = await completer.future;
    assert(bytes.length == length, 'Expected $length bytes but got ${bytes.length}');
    return bytes;
  }

  /// [Hybrid]
  Future<MessageReactionResponse?> reactMessage(String messageId, String emojiId) async {
    if (socketCaller.isReadyForCall) {
      try {
        final res = await socketCaller.emitCall(
          BackendPath.reactMessage.socket,
          {'messageId': messageId, 'emojiId': emojiId},
        );

        return res.mapToResponse<MessageReactionResponse>(
          (result) => MessageReactionResponse.fromMap(result),
        );
      } catch (e, stackTrace) {
        _log.w('ReactMessage socket emit error, fallback to http request.', e, stackTrace);
      }
    }

    // Fallback to http caller
    final res = await httpCaller.post(
      BackendPath.reactMessage.http.replaceAll(':messageId', messageId),
      data: {'messageId': messageId, 'emojiId': emojiId},
    );

    return res.mapToResponse<MessageReactionResponse>(
      (result) => MessageReactionResponse.fromMap(result),
    );
  }

  /// [Hybrid]
  Future<Map<String, dynamic>> getMessageReact(String messageId, int page, int pageSize) async {
    if (socketCaller.isReadyForCall) {
      try {
        final result = await socketCaller.emitCall(
          BackendPath.getMessageReact.socket,
          {'messageId': messageId, 'page': page, 'pageSize': pageSize},
        );

        return result.data;
      } catch (e, stackTrace) {
        _log.w('Get message react socket emit error, fallback to http request.', e, stackTrace);
      }
    }

    try {
      // Fallback to http caller
      final result = await httpCaller.get(
        BackendPath.getMessageReact.http.replaceAll(':messageId', messageId),
        data: {'messageId': messageId, 'page': page, 'pageSize': pageSize},
      );

      return result.data;
    } catch (e, stackTrace) {
      _log.e('Get message react api error.', e, stackTrace);
      rethrow;
    }
  }
}
