import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/domain/entities/share_target_entity.dart';
import 'package:uchat/core/domain/params/app_share_bottom_sheet_share_param.dart';
import 'package:uchat/core/domain/params/share_image_from_album_param.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/entities/models/file_info_model.dart';
import 'package:uchat/features/album/domain/album_domain.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/open_direct_chat_request.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_file_message_params.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_message_to_server_params.dart';
import 'package:uchat/features/chat_room/domain/chat_room_domain.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/extension/extension_list.dart';

/// Handle what to do after pressing share in [AppShareBottomSheet]
/// This will sent all data from [AppShareBottomSheetShareParam] to server.
class AppShareBottomSheetShareUseCase extends SimpleUseCase<Set<String>?, AppShareBottomSheetShareParam> {
  AppShareBottomSheetShareUseCase();

  final Set<String> _errorRoomName = {};

  final int _delayBetweenBatch = 100; // in milliseconds

  @override
  Future<Set<String>?> call(AppShareBottomSheetShareParam params) async {
    final currentUserId = _getCurrentUserId();
    if (currentUserId == null) return {};

    await _initializeRoomIds(params);

    if (params.data.messageList != null) {
      await _handleMessageList(params, currentUserId);
    }

    if (params.data.albumImageList != null) {
      await _shareAlbumImages(params);
    }

    if (params.data.newMessage != null) {
      await _handleNewMessage(params, currentUserId);
    }

    if (params.data.newFile != null) {
      await _handleNewFile(params, currentUserId);
    }

    if (params.data.fileList?.isNotEmpty == true) {
      await _handleFileList(params, currentUserId);
    }

    if (params.captionText != null) {
      for (final target in params.selectedTargetList) {
        // If share to that room failed, Skip sending caption message to that room.
        if (!_errorRoomName.contains(target.name)) {
          await sendCaptionMessage(params: params, target: target, currentUserId: currentUserId);
        }
      }
    }

    if (_errorRoomName.isNotEmpty) return _errorRoomName;

    return null;
  }

  String? _getCurrentUserId() {
    return UserController.instance.currentUser()?.id;
  }

  Future<void> _initializeRoomIds(AppShareBottomSheetShareParam params) async {
    for (final target in params.selectedTargetList) {
      if (target.roomId.isEmpty && target.contactId != null) {
        final newRoom = await GetIt.I<OpenDirectChatAndSaveToDbUseCase>().call(
          OpenDirectChatRequest(friendAccountId: target.contactId!),
        );
        target.roomId = newRoom!.id;
      }
    }
  }

  Future<void> _handleMessageList(AppShareBottomSheetShareParam params, String currentUserId) async {
    for (final target in params.selectedTargetList) {
      for (final selection in params.data.messageList!) {
        if (_isFileMessage(selection)) {
          await _shareFile(selection, target);
        } else {
          await sendShareMessage(message: selection.message, target: target, currentUserId: currentUserId);
        }
      }
    }
  }

  bool _isFileMessage(dynamic selection) {
    return [
          MessageType.image,
          MessageType.video,
          MessageType.file,
          MessageType.audio,
        ].contains(selection.message.type) &&
        selection.fileIdList != null;
  }

  Future<void> _shareFile(dynamic selection, ShareTargetEntity target) async {
    // TODO: Calling another use case, isn't good practice to use case inside use case?.
    // TODO: Consider refactor this to use repository directly.
    try {
      await GetIt.I<ShareFileUseCase>().call(ShareFileParam(
        originRoomId: selection.message.roomId!,
        destinationRoomId: target.roomId,
        messageId: selection.message.id!,
        fileIdList: selection.fileIdList!,
      ));
    } catch (e, stackTrace) {
      useLogger().e('Share file failed', e, stackTrace);
      addErrorRoomName(target.name);
    }
  }

  Future<void> _shareAlbumImages(AppShareBottomSheetShareParam params) async {
    // TODO: Calling another use case, isn't good practice to use case inside use case?.
    // TODO: Consider refactor this to use repository directly.
    try {
      await GetIt.I<ShareImageFromAlbumUseCase>().call(ShareImageFromAlbumParam(
        albumId: params.data.albumImageList!.albumId,
        imageIds: params.data.albumImageList!.images.map((e) => e.imageId!).toList(),
        targetRoomIds: params.selectedTargetList.map((e) => e.roomId).toList(),
      ));
    } catch (e, stackTrace) {
      useLogger().e('Share album images failed', e, stackTrace);
      for (final target in params.selectedTargetList) {
        addErrorRoomName(target.name);
      }
    }
  }

  Future<void> _handleNewMessage(AppShareBottomSheetShareParam params, String currentUserId) async {
    for (final target in params.selectedTargetList) {
      await sendShareMessage(
        message: params.data.newMessage!,
        target: target,
        currentUserId: currentUserId,
        isShare: false,
      );
    }
  }

  Future<void> _handleNewFile(AppShareBottomSheetShareParam params, String currentUserId) async {
    for (final target in params.selectedTargetList) {
      // TODO: Calling another use case, isn't good practice to use case inside use case?.
      // TODO: Consider refactor this to use repository directly.
      await GetIt.I<SendFileMessageToServerUseCase>().call(
        SendFileMessageParams(
          chatRoomId: target.roomId,
          files: [params.data.newFile!],
          isSending: true,
          isLocked: false,
          isMyNote: false,
          enableUploadPro: UserController.instance.enableUploadPro,
          customOnSendFailed: () {
            addErrorRoomName(target.name);
          },
          customOnPermissionDenied: () {
            addErrorRoomName(target.name);
          },
        ),
      );
    }
  }

  Future<void> _handleFileList(AppShareBottomSheetShareParam params, String currentUserId) async {
    final fileList = params.data.fileList;
    if (fileList == null) return;
    if (fileList.isEmpty == true) return;

    List<FileInfoModel> tempFiles = <FileInfoModel>[];
    try {
      tempFiles = await compute(_getFileInfoList, {
        'files': fileList,
        'fileSizeLimit': UChatConstant.fileSizeLimit,
      });
    } catch (e, stackTrace) {
      useLogger().e('Error in _handleFileList.', e, stackTrace);
      for (final target in params.selectedTargetList) {
        addErrorRoomName(target.name);
      }
      return;
    }

    // Split files into batch to avoid sending too many files at once which can cause performance issue, and also to make sure that the UI is not blocked for too long.
    const batchSize = UChatConstant.sendFileBatchSize;
    final fileBatches = tempFiles.splitToGroup(batchSize);

    for (final target in params.selectedTargetList) {
      for (final fileBatch in fileBatches) {
        for (final file in fileBatch) {
          try {
            await GetIt.I<SendFileMessageToServerUseCase>().call(
              SendFileMessageParams(
                chatRoomId: target.roomId,
                files: [file],
                isSending: true,
                isLocked: false,
                isMyNote: false,
                enableUploadPro: UserController.instance.enableUploadPro,
                customOnSendFailed: () {
                  addErrorRoomName(target.name);
                },
                customOnPermissionDenied: () {
                  addErrorRoomName(target.name);
                },
              ),
            );
          } catch (e, stackTrace) {
            useLogger().e('Error sending file message.', e, stackTrace);
            addErrorRoomName(target.name);
          }

          // Delay between batches for garbage collection
          if (fileBatch != fileBatches.last) {
            await Future.delayed(Duration(milliseconds: _delayBetweenBatch));
          }
        }
      }
    }
  }

  /// This function is used to convert List<File> to List<FileInfoModel> in a separate isolate to avoid blocking the main thread.
  ///
  /// [compute] is a Flutter function that runs the provided function in a separate isolate and returns the result.
  /// This is useful for CPU-intensive tasks that would otherwise block the main thread and cause the UI to freeze.
  static Future<List<FileInfoModel>> _getFileInfoList(Map<String, dynamic> params) async {
    final files = params['files'] as List<File>;
    final fileSizeLimit = params['fileSizeLimit'] as int;

    final tempFiles = <FileInfoModel>[];

    for (final file in files) {
      if (!await file.exists()) {
        continue;
      }

      final fileSize = await file.length();
      if (fileSize > fileSizeLimit) {
        continue;
      }

      try {
        final fileInfo = await FileInfoModel.fromFile(file, 0);
        tempFiles.add(fileInfo);
      } catch (_) {
        continue;
      }
    }

    return tempFiles;
  }

  Future<void> sendShareMessage({
    required MessageCollection message,
    required ShareTargetEntity target,
    required String currentUserId,
    bool isShare = true,
  }) async {
    /// TODO: Update [SendMessageToServerParams] to use their own data, do not use [MessageCollection]
    final shareMessage = message.copy();
    shareMessage.sequence = null;
    // TODO: Calling another use case, isn't good practice to use case inside use case?.
    // TODO: Consider refactor this to use repository directly.
    await GetIt.I<SendMessageToServerUseCase>().call(SendMessageToServerParams(
      chatRoomId: target.roomId,

      /// If secret chat is implemented and message can be shared into secret chat, Add isSecretRoom data in
      /// [ShareTargetEntity] and use it here.
      isSecretRoom: false,
      message: shareMessage,
      accountId: currentUserId,
      isSending: true,
      isShare: isShare,
      roomCryptoKey: target.roomCryptoKey,
      customOnPermissionDenied: () {
        addErrorRoomName(target.name);
      },
      customOnSendFailed: () {
        addErrorRoomName(target.name);
      },
    ));
  }

  Future<void> sendCaptionMessage({
    required AppShareBottomSheetShareParam params,
    required ShareTargetEntity target,
    required String currentUserId,
  }) async {
    if (params.captionText?.isNotEmpty == true) {
      // TODO Update this to send message as type emoji if all text in caption text is emoji.
      final captionMessage = MessageCollection(
        message: params.captionText,
        type: MessageType.text,
      );
      // TODO: Calling another use case, isn't good practice to use case inside use case?.
      // TODO: Consider refactor this to use repository directly.
      await GetIt.I<SendMessageToServerUseCase>().call(SendMessageToServerParams(
        chatRoomId: target.roomId,

        /// If secret chat is implemented and message can be shared into secret chat, Add isSecretRoom data in
        /// [ShareTargetEntity] and use it here.
        isSecretRoom: false,
        message: captionMessage,
        accountId: currentUserId,
        isSending: true,
        roomCryptoKey: target.roomCryptoKey,
        customOnPermissionDenied: () {
          addErrorRoomName(target.name);
        },
        customOnSendFailed: () {
          addErrorRoomName(target.name);
        },
      ));
    }
  }

  void addErrorRoomName(String name) {
    _errorRoomName.add(name);
  }
}
