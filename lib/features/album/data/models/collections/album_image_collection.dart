import 'package:isar_community/isar.dart';
import 'package:uchat/features/album/domain/entities/album_image_entity.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/utils/datetime.dart';
import 'package:uchat/utils/fast_hash.dart';
import 'package:uuid/uuid.dart';

part 'album_image_collection.g.dart';

@Collection(accessor: 'albumImages')
@Name('AlbumImage')
class AlbumImageCollection {
  @Index()
  String? imageId;

  /// Server doesn't sent albumId to app when calling fetchImagesInAlbum.
  @Index()
  String? albumId;

  Id get isarId => fastHash(imageId!);

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

  AlbumImageCollection({
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

  @ignore
  String? get imageUrl {
    if (imageId != null) {
      return '${AppEnv.apiUrl}album/$albumId/image/$imageId';
    }
    return null;
  }

  factory AlbumImageCollection.fromJson(Map<String, dynamic> data, {String? albumId}) {
    return AlbumImageCollection(
      imageId: data['imageId'],
      albumId: data['albumId'] ?? albumId,
      imageName: data['imageName'],
      imageType: data['imageType'],
      mimeType: data['mimeType'],
      blurHash: data['blurhash'],
      width: data['width'],
      height: data['height'],
      ownerId: data['ownerId'],
      createAt: data['createAt'] != null ? strToDateTime(data['createAt']) : null,
      taskId: data['taskId'],
    );
  }

  factory AlbumImageCollection.fromEntity(AlbumImageEntity entity) {
    return AlbumImageCollection(
      imageId: entity.imageId,
      albumId: entity.albumId,
      imageName: entity.imageName,
      imageType: entity.imageType,
      mimeType: entity.mimeType,
      blurHash: entity.blurHash,
      width: entity.width,
      height: entity.height,
      ownerId: entity.ownerId,
      createAt: entity.createAt,
      taskId: entity.taskId,
    );
  }

  AlbumImageEntity toEntity() {
    return AlbumImageEntity(
      imageId: imageId,
      albumId: albumId,
      imageName: imageName,
      imageType: imageType,
      mimeType: mimeType,
      blurHash: blurHash,
      width: width,
      height: height,
      ownerId: ownerId,
      createAt: createAt,
      taskId: taskId,
    );
  }

  @ignore
  String get hero {
    return 'ALBUM-${imageId ?? const Uuid().v4()}';
  }

  @override
  bool operator ==(Object other) {
    return other is AlbumImageCollection && other.imageId == imageId;
  }

  @override
  int get hashCode => imageId.hashCode;
}
