import 'package:uchat/features/album/domain/entities/album_image_entity.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';

class AlbumEntity {
  final String? id;
  final String? accountId;
  final String? roomId;
  final String? albumName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<AlbumImageEntity>? lastTenImageInAlbum;
  final ContactEntity? createdBy;
  final bool? isSuccess;
  final int? totalImages;

  String get imageCoverPath {
    if (lastTenImageInAlbum != null && lastTenImageInAlbum?.isNotEmpty == true) {
      return lastTenImageInAlbum!.last.imageUrl ?? '';
    }

    return '';
  }

  AlbumEntity({
    required this.albumName,
    required this.id,
    required this.accountId,
    required this.roomId,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.isSuccess,
    this.lastTenImageInAlbum,
    this.totalImages,
  });

  // copyWith method
  AlbumEntity copyWith({
    String? albumName,
    String? id,
    String? accountId,
    String? roomId,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<AlbumImageEntity>? lastTenImageInAlbum,
    ContactEntity? createdBy,
    bool? isSuccess,
    int? totalImages,
  }) {
    return AlbumEntity(
      albumName: albumName ?? this.albumName,
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      roomId: roomId ?? this.roomId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSuccess: isSuccess ?? this.isSuccess,
      createdBy: createdBy ?? this.createdBy,
      lastTenImageInAlbum: lastTenImageInAlbum ?? this.lastTenImageInAlbum,
      totalImages: totalImages ?? this.totalImages,
    );
  }

  AlbumEntity copyWithEntity(AlbumEntity album) {
    return copyWith(
      albumName: album.albumName ?? albumName,
      id: album.id ?? id,
      accountId: album.accountId ?? accountId,
      roomId: album.roomId ?? roomId,
      createdAt: album.createdAt ?? createdAt,
      updatedAt: album.updatedAt ?? updatedAt,
      createdBy: album.createdBy ?? createdBy,
      isSuccess: album.isSuccess ?? isSuccess,
      lastTenImageInAlbum: album.lastTenImageInAlbum ?? lastTenImageInAlbum,
      totalImages: album.totalImages ?? totalImages,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AlbumEntity && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
