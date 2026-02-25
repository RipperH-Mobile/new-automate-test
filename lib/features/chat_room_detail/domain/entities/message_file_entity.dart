import 'dart:io';

import 'package:isar_community/isar.dart';
import 'package:uchat/entities/enums.dart';

class MessageFileEntity {
  final String? id;
  final String? roomId;
  final String? name;
  final int? size;
  final String? thumbnailFileId;
  final bool? isPasswordProtected;
  final String? apiFileUrl;
  final MessageFileType? type;
  final double? duration;
  final DateTime? createdAt;
  final String? accountId;
  final String? refFile;
  final File? decryptedFile;
  final double? height;
  final double? width;
  final String? url;
  final double? thumbnailHeight;
  final double? thumbnailWidth;
  final String? mime;
  final String? fileExtension;
  final String? fileExt;
  FileDownloadStatus? downloadStatus;
  final String? thumbnailPath;
  final String? blurhash;
  final String? roomFileId;

  MessageFileEntity({
    this.id,
    this.roomId,
    this.name,
    this.size,
    this.thumbnailFileId,
    this.isPasswordProtected,
    this.apiFileUrl,
    this.type,
    this.duration,
    this.createdAt,
    this.accountId,
    this.refFile,
    this.decryptedFile,
    this.height,
    this.width,
    this.url,
    this.thumbnailHeight,
    this.thumbnailWidth,
    this.mime,
    this.fileExtension,
    this.fileExt,
    this.downloadStatus,
    this.thumbnailPath,
    this.blurhash,
    this.roomFileId,
  });

  String? get heroTag {
    if (type == MessageFileType.image) {
      return 'IMAGE-${id ?? refFile}-$apiFileUrl';
    } else if (type == MessageFileType.video) {
      return 'VIDEO-${id ?? refFile}-$apiFileUrl';
    }
    return null;
  }

  @override
  bool operator ==(Object other) {
    return other is MessageFileEntity && id == other.id;
  }

  @ignore
  @override
  int get hashCode => id.hashCode;
}
