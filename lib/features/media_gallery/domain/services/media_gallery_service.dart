import 'package:photo_manager/photo_manager.dart';
import 'package:uchat/features/media_gallery/domain/model/album_asset_model.dart';
import 'package:uchat/features/media_gallery/presentation/views/screens/media_gallery.dart';

abstract class MediaGalleryService {
  AlbumAssetModel? get currentAlbum;

  bool get isGranted;

  List<AlbumAssetModel> get cachedAlbums;

  Map<String, List<AssetEntity>> get cachedAlbumAssets;

  PermissionState get permissionState;

  Future<bool> checkPermission();

  Future<bool> requestPermission();

  Future<List<AlbumAssetModel>> getAlbums({
    MediaGalleryFilterMediaType requestType = MediaGalleryFilterMediaType.imageAndVideo,
    bool refresh = false,
  });

  Future<List<AssetEntity>> getImagesFromAlbum({
    String? albumId,
    int limit = 40,
    bool refresh = false,
    MediaGalleryFilterMediaType requestType = MediaGalleryFilterMediaType.imageAndVideo,
    bool loadMore = false,
  });

  Future<void> preloadThumbnail(List<AssetEntity> assets);

  Future<void> initService();

  Future<void> disposeService();

  Future<void> clearCache();

  Future<void> releaseCache();

  Future<void> changeAlbum({required String albumId, int limit = 40});

  Future<void> refreshCurrentAlbum({int limit = 40});

  Future<AlbumAssetModel> getAdditionalAlbumInfo({String? albumId});
}
