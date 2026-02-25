import 'package:isar_community/isar.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/features/album/data/models/models/album_image_model.dart';
import 'package:uchat/features/album/domain/entities/album_entity.dart';
import 'package:uchat/utils/fast_hash.dart';

part 'album_collection.g.dart';

final _log = useLogger();

@Collection(accessor: 'albums')
@Name('Album')
class AlbumCollection {
  @Index(type: IndexType.value)
  String? id;

  Id get isarId => fastHash(id!);

  @Index(type: IndexType.value)
  String? accountId;

  @Index(type: IndexType.value)
  String? roomId;

  String? albumName;
  DateTime? createdAt;
  DateTime? updatedAt;

  ContactModel? createdBy;

  /// Server populate this value from upload task if there are any uploading task this will be false and will be true if
  /// all upload task is complete.
  bool? isSuccess;

  List<AlbumImageModel>? lastTenImageInAlbum;

  int? totalImagesV2;

  @ignore
  String get imageCoverPath {
    if (lastTenImageInAlbum != null && lastTenImageInAlbum?.isNotEmpty == true) {
      return lastTenImageInAlbum!.last.apiAlbumImageUrl(id!) ?? '';
    }

    return '';
  }

  AlbumCollection({
    required this.albumName,
    required this.id,
    required this.accountId,
    required this.roomId,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.isSuccess,
    this.lastTenImageInAlbum,
    this.totalImagesV2,
  });

  factory AlbumCollection.fromJson(Map<String, dynamic> json) {
    DateTime? createdAt;
    DateTime? updatedAt;
    if (json['createdAt'] != null) {
      createdAt = DateTime.parse(json['createdAt']);
    }
    if (json['updatedAt'] != null) {
      updatedAt = DateTime.parse(json['updatedAt']);
    }

    List<AlbumImageModel>? newImages;
    if (json['images'] != null) {
      newImages = [];
      for (final image in json['images']) {
        try {
          newImages.add(AlbumImageModel.fromJson(image));
        } catch (e, stackTrace) {
          _log.e('Error parse image. ($image)', e, stackTrace);
        }
      }
    }

    ContactModel? createdBy;
    if (json['createdBy'] != null) {
      if (json['createdBy'] is Map<String, dynamic>) {
        try {
          createdBy = ContactModel.fromMap(json['createdBy']);
        } catch (e, stackTrace) {
          _log.e(
            'Error parse created by. (${json['createdBy']})',
            e,
            stackTrace,
          );
        }
      }
    }

    List<AlbumImageModel>? lastFourImageInAlbum;
    if (json['lastFourImageInAlbum'] != null) {
      lastFourImageInAlbum = [];
      for (var item in json['lastFourImageInAlbum']) {
        // _log.i('there are lastFourImageInAlbum :: $item');
        lastFourImageInAlbum.add(AlbumImageModel.fromJson(item));
      }
    }

    List<AlbumImageModel>? lastTenImageInAlbum;

    /// When fetching data from [fetchRoomDetailMediaCount] endpoint, Server will send one image to be shown as a cover in room detail.
    /// This is to handle that case.
    if (json['firstImage'] != null) {
      lastTenImageInAlbum = [AlbumImageModel.fromJson(json['firstImage'])];
    }

    if (json['lastTenImageInAlbum'] != null) {
      lastTenImageInAlbum = [];
      for (var item in json['lastTenImageInAlbum']) {
        lastTenImageInAlbum.add(AlbumImageModel.fromJson(item));
      }
    }

    return AlbumCollection(
      albumName: json['albumName'],
      id: json['id'] ?? json['_id'],
      accountId: json['accountId'],
      roomId: json['roomId'],
      createdAt: createdAt,
      updatedAt: updatedAt,
      createdBy: createdBy,
      isSuccess: json['isSuccess'],
      lastTenImageInAlbum: lastTenImageInAlbum,

      /// json['totalImages'] is sent from server in all album endpoints.
      /// json['imageCount'] is send from server in fetchRoomDetailMediaCount endpoint.
      totalImagesV2: json['totalImages'] ?? json['imageCount'],
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>>? lastTenImages;
    if (lastTenImageInAlbum?.isNotEmpty == true) {
      lastTenImages = lastTenImageInAlbum!.map((e) => e.toJson()).toList();
    }

    return {
      'albumName': albumName,
      'id': id,
      'accountId': accountId,
      'roomId': roomId,
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
      'createdBy': createdBy,
      'lastTenImageInAlbum': lastTenImages,
      'totalImagesV2': totalImagesV2,
    };
  }

  // copyWith method
  AlbumCollection copyWith({
    String? albumName,
    String? id,
    String? accountId,
    String? roomId,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<AlbumImageModel>? lastTenImageInAlbum,
    ContactModel? createdBy,
    bool? isSuccess,
    int? totalImagesV2,
  }) {
    return AlbumCollection(
      albumName: albumName ?? this.albumName,
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      roomId: roomId ?? this.roomId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastTenImageInAlbum: lastTenImageInAlbum ?? this.lastTenImageInAlbum,
      createdBy: createdBy ?? this.createdBy,
      isSuccess: isSuccess ?? this.isSuccess,
      totalImagesV2: totalImagesV2 ?? this.totalImagesV2,
    );
  }

  /// Update this with data from [album].
  /// All null variable from [album] will be ignored.
  /// If [forceUpdateLastFourImage] is true lastFourImage from [album] will be used
  /// event if [album.lastFourImageInAlbum] is null. This is used to update when all images
  /// is deleted from this album.
  /// [forceUpdateTotalImage] is the same as [forceUpdateLastFourImage].
  void update(
    AlbumCollection album, {
    bool forceUpdateLastFourImage = false,
    bool forceUpdateTotalImage = false,
  }) {
    if (album.albumName != null) {
      albumName = album.albumName;
    }

    if (album.id != null) {
      id = album.id;
    }

    if (album.accountId != null) {
      accountId = album.accountId;
    }

    if (album.roomId != null) {
      roomId = album.roomId;
    }

    if (album.createdAt != null) {
      createdAt = album.createdAt;
    }

    if (album.updatedAt != null) {
      updatedAt = album.updatedAt;
    }

    if (album.lastTenImageInAlbum != null) {
      lastTenImageInAlbum = album.lastTenImageInAlbum;
    }

    if (album.createdBy != null) {
      createdBy = album.createdBy;
    }

    if (album.isSuccess != null) {
      isSuccess = album.isSuccess;
    }

    if (album.totalImagesV2 != null) {
      totalImagesV2 = album.totalImagesV2;
    }
  }

  // toEntity method
  AlbumEntity toEntity() {
    return AlbumEntity(
      albumName: albumName,
      id: id,
      accountId: accountId,
      roomId: roomId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      createdBy: createdBy?.toEntity(),
      isSuccess: isSuccess,
      lastTenImageInAlbum: lastTenImageInAlbum?.map((e) => e.toEntity(id ?? '')).toList(),
      totalImages: totalImagesV2,
    );
  }

  // fromEntity method
  static AlbumCollection fromEntity(AlbumEntity entity) {
    return AlbumCollection(
      albumName: entity.albumName,
      id: entity.id,
      accountId: entity.accountId,
      roomId: entity.roomId,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      createdBy: entity.createdBy != null ? ContactModel.fromEntity(entity.createdBy!) : null,
      isSuccess: entity.isSuccess,
      lastTenImageInAlbum: entity.lastTenImageInAlbum?.map((e) => AlbumImageModel.fromEntity(e)).toList(),
      totalImagesV2: entity.totalImages,
    );
  }
}
