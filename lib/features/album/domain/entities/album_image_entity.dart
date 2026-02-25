import 'package:uchat/utils/app_env.dart';

class AlbumImageEntity {
  String? imageId;

  String? albumId;

  String? imageName;

  String? imageType;

  int? imageSize;

  String? mimeType;

  String? blurHash;

  int? width;

  int? height;

  String? ownerId;

  DateTime? createAt;

  String? taskId;

  AlbumImageEntity({
    this.imageId,
    this.albumId,
    this.imageName,
    this.imageType,
    this.mimeType,
    this.blurHash,
    this.width,
    this.height,
    this.ownerId,
    this.createAt,
    this.taskId,
  });

  String? get imageUrl {
    if (imageId != null) {
      return '${AppEnv.apiUrl}album/$albumId/image/$imageId';
    }
    return null;
  }

  String get hero {
    return 'IMAGE-${imageId}-${imageUrl}';
  }

  @override
  bool operator ==(Object other) {
    return other is AlbumImageEntity && imageId == other.imageId;
  }

  @override
  int get hashCode => imageId.hashCode;
}
