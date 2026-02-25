import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:uchat/api/services/message_service.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_file_message_request.dart';
import 'package:uchat/features/chat_room/domain/file_upload/interfaces/file_upload_task.dart';

/// File upload task implementation
/// Task 6: Upload Task (API & Domain Call)
class FileUploadTaskImpl implements FileUploadTask {
  final LoggerService _logger;

  FileUploadTaskImpl(this._logger);

  @override
  Future<MessageCollection> uploadFile({
    required SendFileMessageRequest fileReq,
    Map<String, dynamic>? additionalData,
    Function(double progress)? onProgress,
  }) async {
    final File file = fileReq.messageFile.uploadFile!;
    try {
      _logger.d('Starting file upload: ${file.path}');

      // Create send file request from parameters
      final sendFileRequest = fileReq;

      // Handle thumbnail upload if present
      String? thumbnailId;
      final Uint8List? thumbnailBytes = fileReq.messageFile.thumbnailBytes;
      if (thumbnailBytes != null) {
        final messageFile = fileReq.messageFile;
        String fileName = messageFile.thumbnailFileName ??
            messageFile.name ??
            'thumbnail_${file.path.split('/').last.split('.').first}.jpeg';
        if (messageFile.type != null) {
          thumbnailId = await MessageService.instance.uploadThumbnail(
            thumbnail: thumbnailBytes,
            req: sendFileRequest,
            fileType: messageFile.type!,
            fileName: fileName,
            width: messageFile.thumbnailWidth,
            height: messageFile.thumbnailHeight,
          );
        }
      }

      // Upload file using existing message service
      final MessageCollection response = await MessageService.instance.uploadFile(
        fileRequest: sendFileRequest,
        thumbnailId: thumbnailId,
        onProgress: onProgress,
      );

      _logger.d('File upload completed successfully: ${file.path}');
      return response;
    } catch (e, stackTrace) {
      _logger.e('Error uploading file: ${file.path}', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<MessageCollection> uploadFilePro({
    required SendFileMessageRequest fileReq,
    String? mimeType,
    Function(double progress)? onProgress,
  }) async {
    final File file = fileReq.files.first;
    RandomAccessFile? raf;

    try {
      _logger.d('Starting multipart file upload: ${file.path}');

      // Use existing uploadPro implementation from MessageService
      final res = await MessageService.instance.uploadPro(
        name: file.path.split('/').last,
        roomId: fileReq.roomId,
        ref: fileReq.ref,
        replyId: fileReq.replyId,
        size: await file.length(),
        type: mimeType,
      );

      // Debug: Log the initial response structure
      _logger.d('uploadPro response structure: ${res.data}');
      _logger.d('Looking for fileId: ${res.data['fileId']}, fileKey: ${res.data['fileKey']}');

      final eTagsPart = <Map<String, dynamic>>[];
      final parts = res.data['parts'];
      final int totalFileSize = await file.length();
      final int numberOfParts = parts.length;
      final int baseChunkSize = totalFileSize ~/ numberOfParts;

      // Validate required fields
      if (res.data['fileId'] == null || res.data['fileKey'] == null || parts == null || parts.isEmpty) {
        throw Exception(
            'Missing fileId or fileKey in uploadPro response or No upload parts received in uploadPro response: ${res.data}');
      }

      // Open the file for random access to read chunks efficiently
      raf = await file.open(mode: FileMode.read);

      // Track progress for multipart upload
      var uploadedParts = 0;
      int currentOffset = 0;

      for (final part in parts) {
        final partNumber = part['PartNumber'] as int;
        final signedUrl = part['signedUrl'] as String;

        int chunkSize = baseChunkSize;
        if (partNumber == numberOfParts) {
          // The last chunk takes the remainder of the file size
          chunkSize = totalFileSize - currentOffset;
        }

        // Read the chunk directly from the file without loading the entire file into memory
        final Uint8List chunkBytes = await raf.read(chunkSize);

        final resUpload = await MessageService.instance.putUpload(
          signedUrl: signedUrl,
          dataForPut: chunkBytes,
        );

        final etag = resUpload.headers.value('etag');
        if (etag != null) {
          eTagsPart.add({'PartNumber': partNumber, 'ETag': etag});

          // Update progress
          uploadedParts++;
          if (onProgress != null) {
            final progress = uploadedParts / numberOfParts;
            onProgress(progress);
          }
        } else {
          _logger.e('Error getting eTag for part $partNumber');
          throw Exception('Failed to get eTag for part $partNumber');
        }
        currentOffset += chunkSize; // Update offset for the next read
      }

      // Complete multipart upload
      final resp = await MessageService.instance.uploadProFinal(
        fileId: res.data['fileId'],
        fileKey: res.data['fileKey'],
        parts: eTagsPart,
      );

      _logger.d('Multipart file upload completed successfully: ${file.path}');
      _logger.d('uploadProFinal response structure: ${resp.data}');

      //! TODO: Check backend response structure
      _logger.w('Unexpected response structure, creating basic success message');
      _logger.w('Available response data: ${resp.data}');
      final messageData = {
        'id': res.data['messageId'] ?? fileReq.ref ?? DateTime.now().millisecondsSinceEpoch.toString(),
        'roomId': fileReq.roomId,
        'fileName': file.path.split('/').last,
        'fileSize': totalFileSize,
        'mimeType': mimeType,
        'uploadStatus': 'completed',
        'createdAt': DateTime.now().toIso8601String(),
      };

      return MessageCollection.fromMap(messageData);
    } catch (e, stackTrace) {
      _logger.e('Error in multipart file upload: ${file.path}', e, stackTrace);
      rethrow;
    } finally {
      // Ensure the file is always closed, even if an error occurs
      try {
        await raf?.close();
      } catch (e) {
        _logger.w('Error closing file: ${file.path}', e);
      }
    }
  }
}
