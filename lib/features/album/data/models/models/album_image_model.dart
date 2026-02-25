import 'package:isar_community/isar.dart';
import 'package:uchat/features/album/domain/entities/album_image_entity.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uuid/uuid.dart';

part 'album_image_model.g.dart';

@embedded
class AlbumImageModel {
  String? imageId;
  String? ownerId;
  String? taskId;
  String? imageName;
  String? imageType;
  int? imageSize;
  String? mimeType;
  String? blurhash;
  int? width;
  int? height;
  DateTime? createAt;
  int? size;

  AlbumImageModel({
    this.imageId,
    this.imageName,
    this.imageType,
    this.imageSize,
    this.mimeType,
    this.blurhash,
    this.width,
    this.height,
    this.ownerId,
    this.createAt,
    this.taskId,
    this.size,
  });

  String get hero {
    return 'ALBUM-${imageId ?? const Uuid().v4()}';
  }

  String? apiAlbumImageUrl(String albumId) {
    if (imageId != null) {
      return '${AppEnv.apiUrl}album/$albumId/image/$imageId';
    }
    return null;
  }

  factory AlbumImageModel.fromJson(Map<String, dynamic> json) {
    DateTime? createAt;
    if (json['createAt'] != null) {
      createAt = DateTime.parse(json['createAt']);
    }

    return AlbumImageModel(
      imageId: json['imageId'],
      imageName: json['imageName'],
      imageType: json['imageType'],
      imageSize: json['imageSize'],
      mimeType: json['mimeType'],
      blurhash: json['blurhash'],
      width: json['width'],
      height: json['height'],
      ownerId: json['ownerId'],
      createAt: createAt,
      taskId: json['taskId'],
      size: json['size'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageId': imageId,
      'imageName': imageName,
      'imageType': imageType,
      'imageSize': imageSize,
      'mimeType': mimeType,
      'blurhash': blurhash,
      'width': width,
      'height': height,
      'ownerId': ownerId,
      'createAt': createAt.toString(),
      'taskId': taskId,
      'size': size,
    };
  }

  // toEntity method
  AlbumImageEntity toEntity(String albumId) {
    return AlbumImageEntity(
      imageId: imageId,
      albumId: albumId,
      imageName: imageName,
      imageType: imageType,
      mimeType: mimeType,
      blurHash: blurhash,
      width: width,
      height: height,
      ownerId: ownerId,
      createAt: createAt,
      taskId: taskId,
    );
  }

  // fromEntity method
  static AlbumImageModel fromEntity(AlbumImageEntity entity) {
    return AlbumImageModel(
      imageId: entity.imageId,
      imageName: entity.imageName,
      imageType: entity.imageType,
      imageSize: entity.imageSize,
      mimeType: entity.mimeType,
      blurhash: entity.blurHash,
      width: entity.width,
      height: entity.height,
      ownerId: entity.ownerId,
      createAt: entity.createAt,
      taskId: entity.taskId,
    );
  }
}
