import 'package:photo_manager/photo_manager.dart';

class AlbumAssetModel {
  String albumId;

  /// Album information
  AssetPathEntity albumInfo;

  /// The album contains all the assets
  bool isAll;

  /// First asset of the album
  ///
  /// This is the first asset of the album that will be displayed in the UI
  AssetEntity? firstAsset;

  /// Name of the album
  ///
  /// This is the name of the album that will be displayed in the UI
  String albumName;

  /// total number of assets in the album
  int totalAssets;

  bool isFetchedAdditional;

  AlbumAssetModel({
    required this.albumId,
    required this.albumName,
    required this.albumInfo,
    this.firstAsset,
    this.isAll = false,
    this.totalAssets = 0,
    this.isFetchedAdditional = false,
  });

  AlbumAssetModel copyWith({
    String? albumId,
    AssetPathEntity? albumInfo,
    bool? isAll,
    AssetEntity? firstAsset,
    String? albumName,
    int? totalAssets,
    bool? isFetchedAdditional,
  }) {
    return AlbumAssetModel(
      albumId: albumId ?? this.albumId,
      albumInfo: albumInfo ?? this.albumInfo,
      isAll: isAll ?? this.isAll,
      firstAsset: firstAsset ?? this.firstAsset,
      albumName: albumName ?? this.albumName,
      totalAssets: totalAssets ?? this.totalAssets,
      isFetchedAdditional: isFetchedAdditional ?? this.isFetchedAdditional,
    );
  }

  @override
  bool operator ==(covariant AlbumAssetModel other) {
    if (identical(this, other)) return true;

    return other.albumId == albumId &&
        other.isAll == isAll &&
        other.albumName == albumName &&
        other.totalAssets == totalAssets;
  }

  @override
  int get hashCode {
    return albumId.hashCode ^ isAll.hashCode ^ albumName.hashCode ^ totalAssets.hashCode;
  }
}
