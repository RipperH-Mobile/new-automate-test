import 'package:photo_manager/photo_manager.dart';

class GalleryPickerAlbumDetailModel {
  final String id;
  final String name;
  final int assetCount;
  final AssetEntity? firstAsset;
  final AssetPathEntity album;

  GalleryPickerAlbumDetailModel({
    required this.id,
    required this.name,
    this.assetCount = 0,
    this.firstAsset,
    required this.album,
  });

  factory GalleryPickerAlbumDetailModel.fromAlbumPathEntity(
    AssetPathEntity album, {
    int assetCount = 0,
    AssetEntity? firstAsset,
  }) {
    return GalleryPickerAlbumDetailModel(
      id: album.id,
      name: album.name,
      album: album,
      assetCount: assetCount,
      firstAsset: firstAsset,
    );
  }

  GalleryPickerAlbumDetailModel copyWith({
    String? id,
    String? name,
    int? assetCount,
    AssetEntity? firstAsset,
    AssetPathEntity? album,
  }) {
    return GalleryPickerAlbumDetailModel(
      id: id ?? this.id,
      name: name ?? this.name,
      assetCount: assetCount ?? this.assetCount,
      firstAsset: firstAsset ?? this.firstAsset,
      album: album ?? this.album,
    );
  }

  @override
  String toString() {
    return 'GalleryPickerAlbumDetailModel(id: $id, name: $name, assetCount: $assetCount, firstAsset: $firstAsset, album: $album)';
  }

  @override
  bool operator ==(covariant GalleryPickerAlbumDetailModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.assetCount == assetCount &&
        other.firstAsset == firstAsset &&
        other.album == album;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ assetCount.hashCode ^ firstAsset.hashCode ^ album.hashCode;
  }
}
