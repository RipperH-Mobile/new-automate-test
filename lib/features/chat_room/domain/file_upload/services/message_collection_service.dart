import 'package:dio/dio.dart';
import 'package:uchat/api/services/message_service.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/models/file_info_model.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_file_message_params.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uuid/uuid.dart';

/// Service responsible for creating message collections
/// Separates message collection creation logic from the main use case
class MessageCollectionService {
  final LoggerService _logger;

  MessageCollectionService(this._logger);

  /// Creates a message collection from file information
  Future<MessageEntity> createMessageCollection({
    required List<FileInfoModel> fileInfoList,
    required SendFileMessageParams params,
  }) async {
    late MessageEntity message;

    // Generate message reference
    String messageRef;
    if (params.isResend) {
      messageRef = params.messageRef ?? MessageService.instance.generateMsgUid();
    } else {
      messageRef = MessageService.instance.generateMsgUid();
    }

    try {
      // Generate message file model list
      final List<MessageFileModel> msgFileModel = [];

      for (var i = 0; i < fileInfoList.length; i++) {
        final refFile = MessageService.instance.generateRefFile(params.chatRoomId);
        final fileInfo = fileInfoList[i];
        final mime = await fileInfo.mime;
        final name = await fileInfo.name;
        final thumbnail = await fileInfo.thumbnail;
        final isEncrypted = fileInfo.isFileEncrypted;

        msgFileModel.add(MessageFileModel(
          name: name,
          roomId: params.chatRoomId,
          thumbnailBytes: thumbnail,
          assetId: fileInfo.mediaAsset?.asset.id,
          type: fileInfo.type,
          isLocalFile: true,
          order: fileInfo.order,
          mime: mime,
          refFile: fileInfo.messageFile?.refFile ?? refFile,
          cancelToken: CancelToken(),
          width: fileInfo.width,
          height: fileInfo.height,
          isLivePhoto: fileInfo.isLivePhoto,
          downloadProgress: 0.0,
          progressState: FileProgressState.idle,
          url: fileInfo.initFile?.path,
          thumbnailHeight: fileInfo.height,
          thumbnailWidth: fileInfo.width,
          duration: fileInfo.duration,
          isPasswordProtected: isEncrypted,
        ));
      }

      // Sort the message file by order
      msgFileModel.sort((a, b) => a.order.compareTo(b.order));

      // Generate message collection
      const uuid = Uuid();
      final msgCollection = MessageCollection.generateFileMessageCollection(
        ref: messageRef,
        roomId: params.chatRoomId,
        files: msgFileModel,
        messageText: params.messageText,
        isLocked: params.isLocked,
        lockMessageSalt: uuid.v4(),
        lockMessageIv: uuid.v4(),
        isMyNote: params.isMyNote,
      );

      message = msgCollection.toEntity();

      _logger.d('Message collection created successfully: $messageRef');
    } catch (e, stackTrace) {
      _logger.e('Error creating message collection', e, stackTrace);
      message = MessageEntity(
        ref: messageRef,
        roomId: params.chatRoomId,
        isSending: false,
        isSendFailed: true,
      );
      rethrow;
    }

    return message;
  }
}
