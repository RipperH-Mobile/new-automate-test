import 'package:photo_manager/photo_manager.dart';
import 'package:uchat/features/media_gallery/domain/model/media_asset.dart';

class MediaGalleryResult {
  final List<MediaAsset> images;
  final List<MediaAsset> videos;

  MediaGalleryResult({
    required this.images,
    required this.videos,
  });

  factory MediaGalleryResult.fromList(List<MediaAsset> assets) {
    final images = <MediaAsset>[];
    final videos = <MediaAsset>[];

    return MediaGalleryResult(
      images: images,
      videos: videos,
    );
  }

  factory MediaGalleryResult.fromAssets(List<AssetEntity> assets) {
    final images = <MediaAsset>[];
    final videos = <MediaAsset>[];

    for (final asset in assets) {
      if (asset.type == AssetType.image) {
        images.add(MediaAsset(assetId: asset.id, asset: asset));
      } else if (asset.type == AssetType.video) {
        videos.add(MediaAsset(assetId: asset.id, asset: asset));
      }
    }

    return MediaGalleryResult(
      images: images,
      videos: videos,
    );
  }

  /// Total media count in the gallery
  int get mediaCount => images.length + videos.length;

  bool get isEmpty => mediaCount == 0;

  /// Total image count in the gallery
  int get imageCount => images.length;

  /// Total video count in the gallery
  int get videoCount => videos.length;

  /// Asset ids of the images in the gallery (AssetEntity of PhotoManager)
  List<String> get imageIds => images.map((e) => e.assetId).toList();

  /// Asset ids of the videos in the gallery (AssetEntity of PhotoManager)
  List<String> get videoIds => videos.map((e) => e.assetId).toList();

  /// File paths of the images in the gallery
  ///
  /// Note: This will fetch the file paths asynchronously.
  /// So, it may take some time to complete. you should await the result.
  ///
  /// **Fetch the file path only one at a time to prevent out of memory error.**
  Future<List<String>> get imagePaths async {
    final paths = <String>[];
    for (final image in images) {
      final path = await image.path;
      if (path != null) {
        paths.add(path);
      }
    }
    return paths;
  }

  /// File paths of the videos in the gallery
  ///
  /// Note: This will fetch the file paths asynchronously.
  /// So, it may take some time to complete. you should await the result.
  ///
  /// **Fetch the file path only one at a time to prevent out of memory error.**
  Future<List<String>> get videoPaths async {
    final paths = <String>[];

    for (final video in videos) {
      final path = await video.path;
      if (path != null) {
        paths.add(path);
      }
    }
    return paths;
  }
}
