// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart' as rendering;
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image/image.dart' as img;
import 'package:isar_community/isar.dart';
import 'package:path/path.dart' as p;
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/infrastructure/analytics/implementation/sending_msg_performance_service_impl.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/models/file_info_model.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/message_file_entity.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/utils/datetime.dart';
import 'package:uchat/utils/storage/storage.dart'; // ignore: depend_on_referenced_packages
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

part 'message_file_model.g.dart';

// const _kMaxBlurHashSizeOnMainIsolate = 3 * 1024 * 1024; // 3 MB

final _log = useLogger();

@embedded
class MessageFileModel {
  String? id;
  String? messageId;
  String? roomId;
  String? name;
  @Enumerated(EnumType.name)
  MessageFileType? type;
  String? mime;

  /// Url is path for file in local, but is not original file path.
  ///
  /// This is the file path that finalize, and ready to send to server.
  String? url;
  int? size;
  DateTime? createdAt;
  String? blurhash;
  double? width;
  double? height;
  String? albumId;
  String? taskId;
  @ignore
  double downloadProgress;
  @ignore
  FileDownloadStatus? downloadStatus;

  bool? isSendFailed;

  /// Duration of video, audio in milliseconds.
  double? duration;

  /// Thumbnail file id from server. use [FileService.instance.getFileUrl] to get
  /// url to image from server.
  String? thumbnailFileId;

  /// Path to local thumbnail in device. Will be null if this video is received from another user.
  /// When sending video this variable will save path to generated thumbnail in local device.
  /// This variable is used initially to quickly display a thumbnail without the need to first
  /// download it from the server.
  /// When showing thumbnail this should be used first but then if this is null use [thumbnailFileId].
  String? thumbnailPath;
  double? thumbnailWidth;
  double? thumbnailHeight;
  String? thumbnailFileName;

  @ignore
  Uint8List? thumbnailBytes;

  /// Used to compare and update correct file model when sending image in message.dart.
  String? refFile;

  /// for cancel upload file to dio process
  @ignore
  CancelToken? cancelToken;

  @ignore
  final uploadCount = 0.obs;

  @ignore
  final uploadTotal = 0.obs;

  double compressProgress = 0;

  /// progress state of file compress and upload
  @Enumerated(EnumType.name)
  FileProgressState? progressState;

  String? accountId;

  bool? isPasswordProtected;

  bool isLocalFile;

  int order;

  bool isLivePhoto;

  /// new file that compressed and ready to upload
  ///
  /// this file is ready to send to server
  @ignore
  File? uploadFile;

  /// original file from asset or any source (local file)
  ///
  /// This is used to get the original file when the file is from asset or any source
  ///
  /// This can be null if the message file is from the server
  @ignore
  File? originalFile;

  /// original file path from asset or any source (local file path)
  ///
  /// This is used to get the original file path when the file is from asset or any source
  String? originalFilePath;

  /// A decrypted file. Used for lock message only.
  /// Will be null if this is not a file in lock message or this file isn't decrypted yet.
  @ignore
  File? decryptedFile;

  @ignore
  VideoData? videoInfo;

  String? assetId;

  bool? isLocked;
  String? originalMessageId;
  String? originalRoomId;
  String? sequence;
  List<String>? userDeleted;

  /// RoomFileId for each file
  ///
  /// This field is used to store the file `_id` of the file in the room from the server
  ///
  /// This used to query the file from the server
  String? roomFileId;

  MessageFileModel({
    this.id,
    this.roomFileId,
    this.messageId,
    this.name,
    this.type,
    this.mime,
    this.size,
    this.roomId,
    this.url,
    this.createdAt,
    this.blurhash,
    this.width,
    this.height,
    this.albumId,
    this.accountId,
    this.isSendFailed,
    this.compressProgress = 0,
    this.progressState,
    this.duration,
    this.cancelToken,
    this.refFile,
    this.taskId,
    this.isPasswordProtected,
    this.isLocalFile = false,
    this.order = 0,
    this.isLivePhoto = false,
    this.originalFile,
    this.originalFilePath,
    this.uploadFile,
    this.videoInfo,
    this.assetId,
    this.isLocked,
    this.originalMessageId,
    this.originalRoomId,
    this.sequence,
    this.userDeleted,
    this.thumbnailFileId,
    this.thumbnailPath,
    this.thumbnailWidth,
    this.thumbnailHeight,
    this.thumbnailBytes,
    this.thumbnailFileName,
    this.downloadStatus,
    this.downloadProgress = -1.0,
  });

  // Convert from map
  factory MessageFileModel.fromMap(Map<String, dynamic> data) {
    // _log.i('MessageFileModel.fromMap: $data');
    double? width;
    if (data['width'] is int) {
      width = (data['width'] as int).toDouble();
    } else if (data['width'] is String) {
      width = double.parse(data['width'] as String);
    } else if (data['width'] is double) {
      width = data['width'] as double;
    }

    double? height;
    if (data['height'] is int) {
      height = (data['height'] as int).toDouble();
    } else if (data['height'] is String) {
      height = double.parse(data['height'] as String);
    } else if (data['height'] is double) {
      height = data['height'] as double;
    }

    double? duration;
    if (data['duration'] is int) {
      duration = (data['duration'] as int).toDouble();
    } else if (data['duration'] is String) {
      duration = double.parse(data['duration'] as String);
    } else if (data['duration'] is double) {
      duration = data['duration'] as double;
    }
    List<String> userDeleted = [];
    if (data['userDeleted'] is List) {
      userDeleted = List<String>.from(data['userDeleted']);
    }

    MessageFileModel model = MessageFileModel(
      id: data['fileId'],
      roomFileId: data['_id'],
      name: data['fileName'],
      type: data['fileType'] != null ? MessageFileType.fromString(data['fileType']) : MessageFileType.unknown,
      size: data['fileSize'],
      mime: data['mimeType'],
      url: data['url'],
      blurhash: data['blurhash'],
      width: width,
      height: height,
      albumId: data['albumId'],
      createdAt: strToDateTime(data['createdAt'])?.toLocal(),
      messageId: data['messageId'],
      accountId: data['accountId'],
      isSendFailed: data['isSendFailed'],
      progressState:
          data['progressState'] != null ? FileProgressState.fromString(data['progressState']) : FileProgressState.idle,
      duration: duration,
      refFile: data['refFile'],
      roomId: data['roomId'],
      taskId: data['taskId'],
      isPasswordProtected: data['isPasswordProtected'],
      isLocalFile: data['isLocalFile'] ?? false,
      order: data['order'] ?? 0,
      isLocked: data['isLocked'] ?? false,
      originalMessageId: data['originalMessageId'],
      originalRoomId: data['originalRoomId'],
      sequence: data['sequence'],
      userDeleted: userDeleted,
    );

    if (data['thumbnail'] != null) {
      model.thumbnailFileId = data['thumbnail']['fileId'];
      model.thumbnailWidth = (data['thumbnail']['width'] as int).toDouble();
      model.thumbnailHeight = (data['thumbnail']['height'] as int).toDouble();
      model.thumbnailFileName = data['thumbnail']['fileName'];
    }

    return model;
  }

  String? get apiFileUrl {
    if (id != null) {
      return GetIt.I<FileService>().getFileUrl(id!);
    }

    return null;
  }

  /// This is a getter to get the url of album image.
  /// If this is used for other image this will produce wrong url.
  @ignore
  String? get albumImageUrl {
    if (id != null && albumId != null) {
      return '${AppEnv.apiUrl}album/$albumId/image/$id';
    }
    return null;
  }

  bool isAvailableOnLocal() {
    return isLocalFile && url != null;
  }

  @ignore
  bool get isAviFile => url?.endsWith('avi') ?? false;

  Map<String, dynamic> toMap() {
    return {
      'fileId': id,
      'fileName': name,
      'fileType': type?.value,
      'fileSize': size,
      'mimeType': mime,
      'url': url,
      'blurhash': blurhash,
      'width': width,
      'height': height,
      'albumId': albumId,
      'createAt': createdAt,
      'messageId': messageId,
      'accountId': accountId,
      'taskId': taskId,
      'isSendFailed': isSendFailed,
      'compressProgress': compressProgress,
      'progressState': progressState?.value,
      'duration': duration,
      'refFile': refFile,
      'roomId': roomId,
      'isPasswordProtected': isPasswordProtected,
      'order': order,
      'isLocked': isLocked,
      'originalMessageId': originalMessageId,
      'originalRoomId': originalRoomId,
      'sequence': sequence,
      'userDeleted': userDeleted,
      'roomFileId': roomFileId,
    };
  }

  void update(MessageFileModel file) {
    if (file.id != null) {
      id = file.id;
    }
    if (file.name != null) {
      name = file.name;
    }
    if (file.type != null) {
      type = file.type;
    }
    if (file.size != null) {
      size = file.size;
    }
    if (file.mime != null) {
      mime = file.mime;
    }
    if (file.url != null) {
      url = file.url;
    }
    if (file.blurhash != null) {
      blurhash = file.blurhash;
    }
    if (file.width != null) {
      width = file.width;
    }
    if (file.height != null) {
      height = file.height;
    }
    if (file.albumId != null) {
      albumId = file.albumId;
    }
    if (file.createdAt != null) {
      createdAt = file.createdAt;
    }
    if (file.messageId != null) {
      messageId = file.messageId;
    }
    if (file.accountId != null) {
      accountId = file.accountId;
    }
    if (file.taskId != null) {
      taskId = file.taskId;
    }
    if (file.isSendFailed != null) {
      isSendFailed = file.isSendFailed;
    }
    if (file.refFile != null) {
      refFile = file.refFile;
    }
    if (file.roomId != null) {
      roomId = file.roomId;
    }
    if (file.isPasswordProtected != null) {
      isPasswordProtected = file.isPasswordProtected;
    }

    isLocalFile = file.isLocalFile;
    order = file.order;
    isLivePhoto = file.isLivePhoto;

    if (file.originalFile != null) {
      originalFile = file.originalFile;
    }

    if (file.originalFilePath != null) {
      originalFilePath = file.originalFilePath;
    }

    if (file.uploadFile != null) {
      uploadFile = file.uploadFile;
    }

    if (file.videoInfo != null) {
      videoInfo = file.videoInfo;
    }

    if (file.assetId != null) {
      assetId = file.assetId;
    }
    if (file.roomFileId != null) {
      roomFileId = file.roomFileId;
    }
  }

  bool get hasThumbnailData {
    return (thumbnailPath != null && thumbnailWidth != null && thumbnailHeight != null);
  }

  ///
  /// Helper to generate video thumbnail and save file to cache storage.
  ///
  /// [localFilePath] is optional, If not null, This function will try to generate
  /// thumbnail from file in the device first. This will be used when user is sending
  /// video to show thumbnail as soon as possible instead of waiting for server to generate
  /// thumbnail. But this will not work for some file extension.
  /// [localMessageId] and [localRoomId] is used for thumbnail save path when generate thumbnail from
  /// file in the device because there is no data in the MessageFileModel yet
  ///
  Future<void> generateVideoThumbnail({
    String? localFilePath,
    String? localMessageId,
    String? localRoomId,
  }) async {
    try {
      // Only video can use this function.
      if (mime?.contains(RegExp(r'video/')) != true) return;

      // Break if `path`, `width` and `height` has value.
      if (hasThumbnailData) {
        // Double check path exist.
        final thumbnailFile = File(thumbnailPath!);
        if (await thumbnailFile.exists()) {
          return;
        }
      }

      _log.d(
        'hasThumbnailData: $hasThumbnailData\n'
        'thumbnailPath: $thumbnailPath\n'
        'thumbnailWidth: $thumbnailWidth\n'
        'thumbnailHeight: $thumbnailHeight',
      );

      //
      // Start generate file process.
      //

      // Generate thumbnail from video file in the device
      if (localFilePath != null) {
        try {
          // This will save thumbnail file in a folder with messageId instead of fileId
          // because fileId came from server but this thumbnail is being created in the app
          // not the server.
          final localBasePath = FileService().getBasePathFromFileIdWithOutRoomId(
            localMessageId!,
            localRoomId!,
          );
          final localRoomPath = await UChatStorage().getRoomDirectory(roomId: localRoomId);

          final file = File('${localRoomPath.path}/$localBasePath/thumbnail.jpg');
          if (await file.exists()) {
            await file.delete();
          }

          await file.create(recursive: true);
          await generateVideoThumbnailFromLocal(file, localFilePath);
          return;
        } catch (e) {
          _log.w('generate video thumbnail from local failed using thumbnail from server');
        }
      }

      // Break if `id` and `roomId` is null.
      if (roomId == null || id == null) return;

      final basePath = FileService().getBasePathFromFileIdWithOutRoomId(
        id!,
        roomId!,
      );
      final roomPath = await UChatStorage().getRoomDirectory(roomId: roomId!);

      final file = File('${roomPath.path}/$basePath/thumbnail.jpg');
      if (await file.exists()) {
        await file.delete();
      }

      await file.create(recursive: true);

      // Download thumbnail from server
      if (thumbnailFileId != null) {
        String thumbnailUrl = FileService().getFileUrl(thumbnailFileId!);
        final res = await HttpCaller().get(
          thumbnailUrl,
          options: Options(
            responseType: ResponseType.bytes,
            headers: HttpCaller().apiHeader,
          ),
          // set isExternalApi to true because in thumbnail url already has base api url
          isExternalApi: true,
        );

        await file.writeAsBytes(res.data);

        // Success to create thumbnail
        thumbnailPath = file.path;
      } else {
        // Fallback when there is no thumbnail url from server, generate thumbnail from client side instead.
        final signedUrl = await FileService().getSignedUrl(apiFileUrl!);
        final thumbData = await VideoThumbnail.thumbnailData(
          video: signedUrl,
          imageFormat: ImageFormat.JPEG,
          quality: 100,
          maxWidth: (Get.mediaQuery.size.width * 1).toInt(),
        );

        if (thumbData == null) return;

        await file.writeAsBytes(thumbData);

        // Success to create thumbnail
        thumbnailPath = file.path;

        // Process `width`, `height` information.
        final imageData = await img.decodeImageFile(thumbnailPath!);

        thumbnailWidth = imageData?.width.toDouble() ?? 0;
        thumbnailHeight = imageData?.height.toDouble() ?? 0;
      }
    } catch (e) {
      _log.e('generateVideoThumbnail error.', e);
    }
  }

  Future<void> generateVideoThumbnailFromLocal(File file, String path) async {
    final thumbData = await VideoThumbnail.thumbnailData(
      video: path,
      imageFormat: ImageFormat.JPEG,
      quality: 100,
      maxWidth: (Get.mediaQuery.size.width * 1).toInt(),
    );

    if (thumbData == null) return;

    await file.writeAsBytes(thumbData);

    // Success to create thumbnail
    thumbnailPath = file.path;

    // Process `width`, `height` information.
    final imageData = await img.decodeImageFile(thumbnailPath!);

    thumbnailWidth = imageData?.width.toDouble() ?? 0;
    thumbnailHeight = imageData?.height.toDouble() ?? 0;
  }

  Map<String, dynamic> toMapForAlbumImage() {
    return {
      'imageId': id,
      'imageName': name,
      'imageType': type,
      'imageSize': size,
      'mimeType': mime,
      'blurhash': blurhash,
      'width': width,
      'height': height,
      'createAt': createdAt,
      'taskId': taskId,
    };
  }

  String? get shortName {
    if (name == null) return null;

    if (name!.characters.length < 20) {
      return name;
    }

    final fileExt = p.extension(name!);
    if (fileExt == '') {
      return name;
    }

    final fileName = p.basenameWithoutExtension(name!);
    final characters = fileName.characters;

    return '${characters.take(4)}...${characters.takeLast(3)}$fileExt';
  }

  String? get longShortName {
    if (name == null) return null;

    if (name!.characters.length < 25) {
      return name;
    }

    final fileExt = p.extension(name!);
    if (fileExt == '') {
      return name;
    }

    final fileName = p.basenameWithoutExtension(name!);
    final characters = fileName.characters;

    return '${characters.take(15)}...${characters.takeLast(5)}$fileExt';
  }

  String? get fileExt {
    if (name == null) return null;

    final fileExt = FileService.getFileExtension(name!);

    if (fileExt == '') return name;

    return fileExt.toLowerCase();
  }

  @ignore
  String get hero {
    return 'FILE-${id ?? const Uuid().v4()}';
  }

  @ignore
  String? get heroTag {
    if (type == MessageFileType.image) {
      return 'IMAGE-${id ?? refFile}-$apiFileUrl';
    } else if (type == MessageFileType.video) {
      return 'VIDEO-${id ?? refFile}-$apiFileUrl';
    }
    return null;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '[MessageFileModel] ID: $id, NAME: $name, URL: $url, BLURHASH: $blurhash, WIDTH: $width, HEIGHT $height, SIZE: $size, TYPE: $type, MIME: $mime, CREATED_AT: $createdAt, ALBUM_ID: $albumId, ACCOUNT_ID: $accountId, IS_SEND_FAILED: $isSendFailed, DURATION: $duration, REF_FILE: $refFile, ROOM_ID: $roomId, TASK_ID: $taskId, IS_PASSWORD_PROTECTED: $isPasswordProtected, IS_LOCAL_FILE: $isLocalFile, ORDER: $order, IS_LIVE_PHOTO: $isLivePhoto, ORIGINAL_FILE: $originalFile, ORIGINAL_FILE_PATH: $originalFilePath, UPLOAD_FILE: $uploadFile, VIDEO_INFO: $videoInfo, ASSET_ID: $assetId, SEQUENCE: $sequence, THUMBNAIL_PATH: $thumbnailPath, THUMBNAIL_FILE_ID: $thumbnailFileId, ROOM_FILE_ID: $roomFileId';
  }

  @override
  bool operator ==(Object other) {
    return other is MessageFileModel && id == other.id;
  }

  @ignore
  @override
  int get hashCode => id.hashCode;

  @ignore
  double get downloadProgressPercentage => downloadProgress / 100.0;

  static Future<MessageFileModel?> generateMessageFile({
    required String refFile,
    required String refMsg,
    required FileInfoModel fileInfo,
    required String type,
    int compressImageQuality = 50,
    int index = 0,
    CompressFormat compressImageFormat = CompressFormat.jpeg,
    void Function(int sent, int total, int fileIndex, String refMsg, String type)? compressCallback,
  }) async {
    try {
      final file = await fileInfo.file;
      if (file == null) {
        _log.w('generateMessageFile: file is null for refFile=$refFile');
        return null;
      }

      // Check if file exists before reading to prevent exceptions
      // for non-existent files.
      // Reference: UCHAT3-27733
      final fileExists = await file.exists();
      if (!fileExists) {
        _log.w('generateMessageFile: file does not exist at path=${file.path}');
        return null;
      }

      Uint8List? fileByte;
      try {
        fileByte = await fileInfo.bytes;
      } on PathAccessException catch (e, stackTrace) {
        _log.e('generateMessageFile: Permission denied to access file at path=${file.path}', e, stackTrace);
        return null;
      } on FileSystemException catch (e, stackTrace) {
        _log.e('generateMessageFile: FileSystemException when reading file at path=${file.path}', e, stackTrace);
        return null;
      }

      if (fileByte == null) {
        _log.w('generateMessageFile: fileByte is null for refFile=$refFile');
        return null;
      }

      final filePath = file.path;
      final fileExtension = await fileInfo.fileExtension;
      final fileMime = await fileInfo.mime;
      final fileName = await fileInfo.name;
      final fileSize = await file.length();

      if (fileInfo.type == MessageFileType.image ||
          UChatConstant.supportImageExtensionList.contains(fileExtension) ||
          fileInfo.isLivePhoto) {
        // handle creation of MessageFileModel for image file
        try {
          SendingMsgPerformanceServiceImpl.compressingImageFileTrace.start();
          SendingMsgPerformanceServiceImpl.compressingImageFileTrace.putTraceAttributes(
            messageRef: refMsg,
            messageType: MessageFileType.image.value,
            messageSizeInBytes: fileSize,
          );
          SendingMsgPerformanceServiceImpl.compressingImageFileTrace.stop();

          return MessageFileModel(
            name: fileName,
            refFile: refFile,
            cancelToken: CancelToken(),
            isLocalFile: true,
            order: fileInfo.order,
            originalFile: file,
            originalFilePath: filePath,
            assetId: fileInfo.assetId,
            width: fileInfo.width,
            height: fileInfo.height,
            url: file.path,
            uploadFile: file,
            mime: fileMime,
            type: MessageFileType.image,
            isLivePhoto: fileInfo.isLivePhoto,
          );
        } catch (e, stackTrace) {
          _log.e('Cannot create MessageFileModel for image file in sendFileHelper.', e, stackTrace);
        }
      } else if (fileInfo.type == MessageFileType.video &&
          !UChatConstant.unsupportedVideoMimeList.any((element) => fileMime.contains(element))) {
        // handle creation of MessageFileModel for video file
        try {
          /// Get video info before compressing to get duration, width, height
          // SendingMsgPerformanceServiceImpl.getFileInfoTrace.start();
          // final videoInfo = await FileService.instance.getVideoInfo(file);
          // SendingMsgPerformanceServiceImpl.getFileInfoTrace.putTraceAttributes(
          //   messageRef: refMsg,
          //   fileRef: refFile,
          //   messageType: MessageFileType.video.value,
          // );
          // SendingMsgPerformanceServiceImpl.getFileInfoTrace.stop();
          //
          // double originWidth = videoInfo?.width?.toDouble() ?? 0;
          // double originHeight = videoInfo?.height?.toDouble() ?? 0;
          //
          // /// If video orientation is 90 degree, we need to swap width and height
          // if (videoInfo?.orientation == 90) {
          //   originWidth = videoInfo?.height?.toDouble() ?? 0;
          //   originHeight = videoInfo?.width?.toDouble() ?? 0;
          // }
          //
          Uint8List? thumbnail = await fileInfo.thumbnail;
          double? thumbnailWidth;
          double? thumbnailHeight;
          // BlurHash? blurHash;
          //
          // if (thumbnail == null) {
          //   final thumbData = await VideoThumbnail.thumbnailData(
          //     video: filePath,
          //     imageFormat: ImageFormat.JPEG,
          //     quality: 80,
          //     maxWidth: originWidth.toInt(),
          //   );
          //
          //   if (thumbData != null) {
          //     thumbnail = thumbData;
          //     blurHash = await compute(FileService.generateBlurHash, {
          //       'imageBytes': thumbnail,
          //     });
          //   }
          // }
          //
          // if (thumbnail != null) {
          //   img.Image? imageObj = img.decodeImage(thumbnail);
          //
          //   if (imageObj != null) {
          //     thumbnailWidth = imageObj.width.toDouble();
          //     thumbnailHeight = imageObj.height.toDouble();
          //   }
          // }

          return MessageFileModel(
            name: fileName,
            refFile: refFile,
            cancelToken: CancelToken(),
            isLocalFile: true,
            order: fileInfo.order,
            originalFile: file,
            originalFilePath: filePath,
            assetId: fileInfo.assetId,
            thumbnailBytes: thumbnail,
            thumbnailWidth: thumbnailWidth,
            thumbnailHeight: thumbnailHeight,
            thumbnailFileName: await fileInfo.thumbnailFileName,
            // blurhash: blurHash?.hash,
            // width: originWidth,
            // height: originHeight,
            size: fileSize,
            url: filePath,
            uploadFile: file,
            // duration: videoInfo?.duration,
            // videoInfo: videoInfo,
            mime: fileMime,
            type: MessageFileType.video,
          );
        } catch (e, stackTrace) {
          _log.e('Cannot create MessageFileModel for video file in sendFileHelper.', e, stackTrace);
        }
      } else if (fileInfo.type == MessageFileType.audio) {
        // handle creation of MessageFileModel for audio file
        try {
          SendingMsgPerformanceServiceImpl.getFileInfoTrace.start();
          final duration = await FileService.instance.getAudioDuration(file);
          SendingMsgPerformanceServiceImpl.getFileInfoTrace.putTraceAttributes(
            messageRef: refMsg,
            fileRef: refFile,
            messageType: MessageFileType.audio.value,
          );
          SendingMsgPerformanceServiceImpl.getFileInfoTrace.stop();
          return MessageFileModel(
            name: fileName,
            refFile: refFile,
            cancelToken: CancelToken(),
            isLocalFile: true,
            order: fileInfo.order,
            originalFile: file,
            originalFilePath: filePath,
            assetId: fileInfo.assetId,
            size: fileSize,
            url: filePath,
            uploadFile: file,
            duration: duration,
            mime: fileMime,
            type: MessageFileType.audio,
          );
        } catch (e, stackTrace) {
          _log.e('Cannot create MessageFileModel for audio file in sendFileHelper.', e, stackTrace);
        }
      } else {
        try {
          final thumbnail = await fileInfo.thumbnail;
          final isEncrypted = fileInfo.isFileEncrypted;

          return MessageFileModel(
            name: fileName,
            refFile: refFile,
            cancelToken: CancelToken(),
            isLocalFile: true,
            order: fileInfo.order,
            originalFile: file,
            originalFilePath: filePath,
            assetId: fileInfo.assetId,
            size: fileSize,
            url: filePath,
            uploadFile: file,
            mime: fileMime,
            type: MessageFileType.file,
            thumbnailBytes: thumbnail,
            isPasswordProtected: isEncrypted,
          );
        } catch (e, stackTrace) {
          _log.e('Cannot create MessageFileModel for file in sendFileHelper.', e, stackTrace);
        }
      }
    } catch (e, stackTrace) {
      _log.e('generateMessageFile error in MessageFileModel:', e, stackTrace);
    }

    return null;
  }

  static Future<Uint8List?> _convertFileWidgetToImageHelper(GlobalKey globalKey) async {
    rendering.RenderRepaintBoundary? boundary =
        globalKey.currentContext?.findRenderObject() as rendering.RenderRepaintBoundary?;
    ui.Image? image;
    try {
      image = await boundary?.toImage();
      if (image == null) return null;

      final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } finally {
      // Dispose native image resource to prevent memory leak
      // Reference: UCHAT3-27699
      image?.dispose();
    }
  }

  MessageFileModel copyWith({
    String? id,
    String? messageId,
    String? roomId,
    String? name,
    MessageFileType? type,
    String? mime,
    String? url,
    int? size,
    DateTime? createdAt,
    String? blurhash,
    double? width,
    double? height,
    String? albumId,
    String? taskId,
    double? downloadProgress,
    FileDownloadStatus? downloadStatus,
    bool? isSendFailed,
    double? duration,
    String? thumbnailFileId,
    String? thumbnailPath,
    double? thumbnailWidth,
    double? thumbnailHeight,
    String? thumbnailFileName,
    Uint8List? thumbnailBytes,
    String? refFile,
    CancelToken? cancelToken,
    double? compressProgress,
    FileProgressState? progressState,
    String? accountId,
    bool? isPasswordProtected,
    bool? isLocalFile,
    int? order,
    bool? isLivePhoto,
    File? uploadFile,
    File? originalFile,
    String? originalFilePath,
    VideoData? videoInfo,
    String? assetId,
    String? roomFileId,
  }) {
    return MessageFileModel(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      roomId: roomId ?? this.roomId,
      name: name ?? this.name,
      type: type ?? this.type,
      mime: mime ?? this.mime,
      url: url ?? this.url,
      size: size ?? this.size,
      createdAt: createdAt ?? this.createdAt,
      blurhash: blurhash ?? this.blurhash,
      width: width ?? this.width,
      height: height ?? this.height,
      albumId: albumId ?? this.albumId,
      taskId: taskId ?? this.taskId,
      downloadProgress: downloadProgress ?? this.downloadProgress,
      downloadStatus: downloadStatus ?? this.downloadStatus,
      isSendFailed: isSendFailed ?? this.isSendFailed,
      duration: duration ?? this.duration,
      thumbnailFileId: thumbnailFileId ?? this.thumbnailFileId,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      thumbnailWidth: thumbnailWidth ?? this.thumbnailWidth,
      thumbnailHeight: thumbnailHeight ?? this.thumbnailHeight,
      thumbnailBytes: thumbnailBytes ?? this.thumbnailBytes,
      thumbnailFileName: thumbnailFileName ?? this.thumbnailFileName,
      refFile: refFile ?? this.refFile,
      cancelToken: cancelToken ?? this.cancelToken,
      compressProgress: compressProgress ?? this.compressProgress,
      progressState: progressState ?? this.progressState,
      accountId: accountId ?? this.accountId,
      isPasswordProtected: isPasswordProtected ?? this.isPasswordProtected,
      isLocalFile: isLocalFile ?? this.isLocalFile,
      order: order ?? this.order,
      isLivePhoto: isLivePhoto ?? this.isLivePhoto,
      uploadFile: uploadFile ?? this.uploadFile,
      originalFile: originalFile ?? this.originalFile,
      originalFilePath: originalFilePath ?? this.originalFilePath,
      videoInfo: videoInfo ?? this.videoInfo,
      assetId: assetId ?? this.assetId,
      roomFileId: roomFileId ?? this.roomFileId,
    );
  }

  MessageFileEntity toEntity() {
    return MessageFileEntity(
      id: id ?? '',
      accountId: accountId ?? '',
      roomId: roomId ?? '',
      name: name ?? '',
      type: type,
      size: size ?? 0,
      apiFileUrl: apiFileUrl ?? '',
      downloadStatus: downloadStatus ?? FileDownloadStatus.unknown,
      duration: duration,
      isPasswordProtected: isPasswordProtected ?? false,
      thumbnailFileId: thumbnailFileId,
      createdAt: createdAt,
      thumbnailPath: thumbnailPath,
      blurhash: blurhash,
      mime: mime,
      width: width,
      height: height,
      thumbnailWidth: thumbnailWidth,
      thumbnailHeight: thumbnailHeight,
      roomFileId: roomFileId,
    );
  }

  static MessageFileModel fromEntity(MessageFileEntity entity) {
    return MessageFileModel(
      accountId: entity.accountId,
      blurhash: entity.blurhash,
      createdAt: entity.createdAt,
      downloadStatus: entity.downloadStatus,
      duration: entity.duration,
      height: entity.height,
      id: entity.id,
      isPasswordProtected: entity.isPasswordProtected,
      mime: entity.mime,
      name: entity.name,
      refFile: entity.refFile,
      roomFileId: entity.roomFileId,
      roomId: entity.roomId,
      size: entity.size,
      thumbnailFileId: entity.thumbnailFileId,
      thumbnailHeight: entity.thumbnailHeight,
      thumbnailPath: entity.thumbnailPath,
      thumbnailWidth: entity.thumbnailWidth,
      type: entity.type,
      url: entity.url,
      width: entity.width,
    );
  }
}
