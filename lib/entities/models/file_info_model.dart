import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart';
import 'package:mime/mime.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/features/media_gallery/media_gallery.dart';
import 'package:uchat/widgets/camera/handler/video_aspect_ratio_handler.dart';
import 'package:uuid/uuid.dart';

enum FileFrom { file, mediaGallery, messageFile }

class FileInfoModel {
  /// File type, image or video
  final MessageFileType? type;

  /// Order of the file
  final int order;

  /// Width of the file
  final double width;

  /// Height of the file
  final double height;

  /// Check if the file is live photo
  final bool isLivePhoto;

  /// Duration of the video and audio file
  final double duration;

  final FileFrom from;

  final String? assetId;

  final MediaAsset? mediaAsset;

  final MessageFileModel? messageFile;

  final File? initFile;

  File? _computedFile;

  Uint8List? _cachedBytes;

  String? _cachedPath;

  int _cachedSize = -1;

  String? _cachedMime;

  String? _cachedName;

  String? _cachedFileExtension;

  Uint8List? _cachedThumbnail;

  String? _cachedThumbnailFileName;

  bool isFileEncrypted = false;

  bool _isFailedToGenerateThumbnail = false;

  FileInfoModel({
    this.type,
    this.width = 0,
    this.height = 0,
    this.order = 0,
    this.isLivePhoto = false,
    this.duration = 0,
    this.from = FileFrom.file,
    this.assetId,
    this.mediaAsset,
    this.messageFile,
    this.initFile,
  });

  Future<File?> get file async {
    if (_computedFile != null) {
      return _computedFile;
    }

    switch (from) {
      case FileFrom.file:
        _computedFile = initFile;
      case FileFrom.mediaGallery:
        _computedFile = await mediaAsset?.file;
      case FileFrom.messageFile:
        final filePath = await path;
        if (filePath != null) {
          _computedFile = File(filePath);
        }
    }

    // in case computedFile is still null, try to get from assetId
    if (_computedFile == null && assetId != null) {
      final AssetEntity? asset = await AssetEntity.fromId(assetId!);
      _computedFile = await asset?.originFile;
    }
    return _computedFile;
  }

  Future<Uint8List?> get bytes async {
    if (_cachedBytes != null) {
      return _cachedBytes;
    }

    if (_computedFile != null) {
      _cachedBytes = await _computedFile?.readAsBytes();
      return _cachedBytes;
    }

    final file = await this.file;
    if (file == null) {
      return null;
    }

    final byte = await file.readAsBytes();
    _cachedBytes = byte;
    return _cachedBytes;
  }

  Future<String?> get path async {
    if (_cachedPath != null) {
      return _cachedPath;
    }

    if (_computedFile != null) {
      _cachedPath = _computedFile?.path;
      return _cachedPath;
    }

    switch (from) {
      case FileFrom.file:
        _cachedPath = initFile?.path;
        break;
      case FileFrom.mediaGallery:
        _cachedPath = await mediaAsset?.path;
        break;
      case FileFrom.messageFile:
        _cachedPath = messageFile?.url;
        break;
    }

    return _cachedPath;
  }

  Future<int> get size async {
    if (_cachedSize != -1) {
      return _cachedSize;
    }

    if (_computedFile != null) {
      _cachedSize = (await _computedFile?.length()) ?? 0;
      return _cachedSize;
    }

    switch (from) {
      case FileFrom.file:
        _cachedSize = (await initFile?.length()) ?? 0;
        break;
      case FileFrom.mediaGallery:
        _cachedSize = (await mediaAsset?.size) ?? 0;
        break;
      case FileFrom.messageFile:
        _cachedSize = messageFile?.size ?? 0;
        break;
    }

    return _cachedSize;
  }

  Future<String> get mime async {
    if (_cachedMime != null) {
      return _cachedMime ?? '';
    }

    switch (from) {
      case FileFrom.file:
        _cachedMime = lookupMimeType(initFile?.path ?? '');
        return _cachedMime ?? '';
      case FileFrom.mediaGallery:
        _cachedMime = await mediaAsset?.mimeType;
        return _cachedMime ?? '';
      case FileFrom.messageFile:
        _cachedMime = messageFile?.mime;
        return _cachedMime ?? '';
    }
  }

  Future<String> get name async {
    if (_cachedName != null) {
      return _cachedName ?? '';
    }

    if (_computedFile != null) {
      _cachedName = _computedFile?.path.split('/').last ?? '';
      return _cachedName ?? '';
    }

    switch (from) {
      case FileFrom.file:
        _cachedName = initFile?.path.split('/').last ?? '';
        break;
      case FileFrom.mediaGallery:
        _cachedName = (await mediaAsset?.name) ?? '';
        break;
      case FileFrom.messageFile:
        _cachedName = messageFile?.name ?? '';
        break;
    }

    return _cachedName ?? '';
  }

  Future<String?> get fileExtension async {
    if (_cachedFileExtension != null) {
      return _cachedFileExtension;
    }

    if (_computedFile != null) {
      _cachedFileExtension = FileService.getFileExtension(_computedFile?.path ?? '');
      return _cachedFileExtension;
    }

    final fileName = await name;
    if (fileName.isEmpty) {
      return null;
    }

    _cachedFileExtension = FileService.getFileExtension(fileName);
    return _cachedFileExtension;
  }

  Future<Uint8List?> get thumbnail async {
    if (![MessageFileType.video, MessageFileType.file].contains(type)) {
      return null;
    }

    if (type == MessageFileType.video) {
      if (_cachedThumbnail != null) {
        return _cachedThumbnail;
      }

      switch (from) {
        case FileFrom.file:
          final filePath = await path;
          if (filePath == null) {
            return null;
          }
          _cachedThumbnail = await FileService.instance.generateThumbnailVideo(filePath);
          break;
        case FileFrom.mediaGallery:
          _cachedThumbnail = await mediaAsset?.asset.thumbnailDataWithOption(
            ThumbnailOption(
              size: ThumbnailSize(mediaAsset?.width ?? 1, mediaAsset?.height ?? 1),
              format: ThumbnailFormat.jpeg,
              quality: 50,
            ),
          );
          break;
        case FileFrom.messageFile:
          final filePath = await path;
          if (filePath == null) {
            return null;
          }
          _cachedThumbnail = await FileService.instance.generateThumbnailVideo(filePath);
          break;
      }

      return _cachedThumbnail;
    }

    if (type == MessageFileType.file) {
      final fileExt = await fileExtension;
      final filePath = await path;

      if (fileExt == null || filePath == null) {
        return null;
      }

      if (fileExt.toLowerCase() == 'pdf') {
        if (_isFailedToGenerateThumbnail) {
          // Return null if previously failed to generate thumbnail
          return null;
        }

        if (isFileEncrypted) {
          // Return null thumbnail for encrypted pdf
          return null;
        }

        if (_cachedThumbnail != null) {
          return _cachedThumbnail;
        }

        final (pdfThumbnail, isEncrypted, isFailed) = await FileService.instance.generatePdfThumbnail(filePath);
        _isFailedToGenerateThumbnail = isFailed;
        isFileEncrypted = isEncrypted;

        if (isEncrypted) {
          // Return null thumbnail for encrypted pdf
          return null;
        }

        _cachedThumbnail = pdfThumbnail;
        return _cachedThumbnail;
      }
    }

    return null;
  }

  Future<String> get thumbnailFileName async {
    if (_cachedThumbnailFileName != null) {
      return _cachedThumbnailFileName!;
    }

    final fileName = await name;
    if (fileName.isEmpty) {
      if (from == FileFrom.mediaGallery) {
        _cachedThumbnailFileName = 'thumbnail_${mediaAsset?.assetId ?? 'media-asset'}_${const Uuid().v4()}.jpeg';
        return _cachedThumbnailFileName!;
      }

      if (from == FileFrom.messageFile) {
        _cachedThumbnailFileName = 'thumbnail_${messageFile?.refFile ?? 'message-file'}_${const Uuid().v4()}.jpeg';
        return _cachedThumbnailFileName!;
      }

      _cachedThumbnailFileName = 'thumbnail_${const Uuid().v4()}.jpeg';
      return _cachedThumbnailFileName!;
    }

    _cachedThumbnailFileName = 'thumbnail_${fileName.split('.').first}.jpeg';
    return _cachedThumbnailFileName!;
  }

  static FileInfoModel fromMediaGallery(MediaAsset media, int order, {bool forceTypeFile = false}) {
    if (media.type == MediaType.video && !forceTypeFile) {
      final (videoWidth, videoHeight) = VideoAspectRatioHandler.computeDimensions(
        width: media.width.toDouble(),
        height: media.height.toDouble(),
        rotationCorrection: media.asset.orientation,
      );
      return FileInfoModel(
        assetId: media.assetId,
        mediaAsset: media,
        type: MessageFileType.video,
        width: videoWidth,
        height: videoHeight,
        order: order,
        isLivePhoto: media.isLivePhoto,
        from: FileFrom.mediaGallery,
        duration: media.duration.toDouble(),
      );
    }

    return FileInfoModel(
      assetId: media.assetId,
      mediaAsset: media,
      type: forceTypeFile ? MessageFileType.file : MessageFileType.fromMediaGallery(media.type),
      width: media.width.toDouble(),
      height: media.height.toDouble(),
      order: order,
      isLivePhoto: media.isLivePhoto,
      from: FileFrom.mediaGallery,
    );
  }

  static FileInfoModel fromMessageFile(MessageFileModel messageFile) {
    final fileType = messageFile.type;
    return FileInfoModel(
      type: fileType!,
      assetId: messageFile.assetId,
      width: messageFile.width ?? 0,
      height: messageFile.height ?? 0,
      order: messageFile.order,
      isLivePhoto: messageFile.isLivePhoto,
      duration: messageFile.duration ?? 0,
      from: FileFrom.messageFile,
      messageFile: messageFile,
    );
  }

  static Future<FileInfoModel> fromFile(File file, int order) async {
    final filePath = file.path;
    final fileMime = lookupMimeType(filePath) ?? '';
    final fileType = MessageFileType.fromFileMime(fileMime);

    if (fileType == MessageFileType.video) {
      final videoInfo = await FileService.instance.getVideoInfo(file);
      final (videoWidth, videoHeight) = VideoAspectRatioHandler.computeDimensions(
        width: (videoInfo?.width ?? 0).toDouble(),
        height: (videoInfo?.height ?? 0).toDouble(),
        rotationCorrection: videoInfo?.orientation ?? 0,
      );

      return FileInfoModel(
        type: fileType,
        order: order,
        width: videoWidth,
        height: videoHeight,
        duration: videoInfo?.duration ?? 0,
        from: FileFrom.file,
        initFile: file,
      );
    } else if ([
      MessageFileType.fileThumbnail,
      MessageFileType.image,
      MessageFileType.groupAvatar,
      MessageFileType.videoThumbnail
    ].contains(fileType)) {
      final decodedImage = await decodeImageFile(filePath);
      return FileInfoModel(
        type: fileType,
        order: order,
        width: decodedImage?.width.toDouble() ?? 0,
        height: decodedImage?.height.toDouble() ?? 0,
        from: FileFrom.file,
        initFile: file,
      );
    } else if (fileType == MessageFileType.audio) {
      final duration = await FileService.instance.getAudioDuration(file);

      return FileInfoModel(
        type: fileType,
        order: order,
        from: FileFrom.file,
        initFile: file,
        duration: duration ?? 0,
      );
    }

    return FileInfoModel(
      type: fileType,
      order: order,
      from: FileFrom.file,
      initFile: file,
    );
  }

  @override
  String toString() {
    return 'FileInfoModel(type: $type, order: $order, width: $width, height: $height, isLivePhoto: $isLivePhoto, duration: $duration, from: $from, assetId: $assetId, mediaAsset: $mediaAsset, messageFile: $messageFile, initFile: $initFile)';
  }
}
