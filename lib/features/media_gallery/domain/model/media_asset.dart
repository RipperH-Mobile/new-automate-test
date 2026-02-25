// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:photo_manager/photo_manager.dart';

import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

class MediaAsset {
  final String assetId;

  final AssetEntity asset;

  MediaAsset({required this.assetId, required this.asset});

  MediaType get type => MediaType.from(asset.type);

  /// duration of the media in milliseconds
  int get duration {
    if (type == MediaType.video) {
      return Duration(seconds: asset.duration).inMilliseconds;
    }

    return asset.duration;
  }

  int get height => asset.height;

  int get width => asset.width;

  bool get isFavorite => asset.isFavorite;

  bool get isLivePhoto => asset.isLivePhoto;

  File? _cachedFile;

  String? _cachedPath;

  String? _cachedMimeType;

  Future<String?> get mimeType async {
    if (_cachedMimeType != null) {
      return _cachedMimeType;
    }

    if (Platform.isIOS || Platform.isMacOS) {
      final mime = await asset.mimeTypeAsync;
      _cachedMimeType = mime;
      return _cachedMimeType;
    }

    _cachedMimeType = asset.mimeType;
    return _cachedMimeType;
  }

  Future<File?> get file async {
    if (_cachedFile != null) {
      return _cachedFile;
    }
    try {
      _cachedFile = await asset.file;
      return _cachedFile;
    } catch (e, stackTrace) {
      useLogger().e('MediaAsset', 'Error getting file for assetId $assetId: $e', stackTrace);
      return null;
    }
  }

  Future<String?> get path async {
    if (_cachedPath != null) {
      return _cachedPath;
    }

    final fileData = await file;
    final filePath = fileData?.path;
    _cachedPath = filePath;

    return filePath;
  }

  Future<int?> get size async {
    final fileData = await asset.file;
    return fileData?.length();
  }

  Future<String?> get name async {
    final filePath = await path;
    return filePath?.split('/').last;
  }

  Future<Uint8List?> get thumbnail async {
    final thumbnailData = await asset.thumbnailDataWithOption(
      const ThumbnailOption(
        size: ThumbnailSize(720, 1280),
        quality: 80,
      ),
    );
    return thumbnailData;
  }

  @override
  bool operator ==(covariant MediaAsset other) {
    if (identical(this, other)) return true;

    return other.assetId == assetId;
  }

  @override
  int get hashCode => assetId.hashCode;
}

enum MediaType {
  other,
  audio,
  image,
  video;

  static MediaType from(AssetType type) {
    switch (type) {
      case AssetType.image:
        return MediaType.image;
      case AssetType.video:
        return MediaType.video;
      case AssetType.audio:
        return MediaType.audio;
      default:
        return MediaType.other;
    }
  }
}
