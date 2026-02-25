import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_file_message_request.dart';

/// Upload task interface
/// Task 6: Upload Task (API & Domain Call)
abstract class FileUploadTask {
  /// Uploads a file to the server
  Future<MessageCollection> uploadFile({
    required SendFileMessageRequest fileReq,
    Map<String, dynamic>? additionalData,
    Function(double progress)? onProgress,
  });

  /// Uploads multiple files using multipart upload
  Future<MessageCollection> uploadFilePro({
    required SendFileMessageRequest fileReq,
    String? mimeType,
    Function(double progress)? onProgress,
  });
}
