import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:uchat/entities/enum/message_file_type.dart';
import 'package:uchat/features/chat_room/presentation/controllers/thumbnail_bytes_cache_manager.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';

class MessageLocalImageProvider extends ImageProvider<MessageLocalImageProvider> {
  final String refFile;
  final Uint8List? bytes;
  final String? assetId;
  final String? filePath;
  final MessageFileType fileType;

  MessageLocalImageProvider({
    required this.refFile,
    this.assetId,
    this.bytes,
    this.filePath,
    this.fileType = MessageFileType.image,
  });

  @override
  SynchronousFuture<MessageLocalImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<MessageLocalImageProvider>(this);
  }

  @override
  ImageStreamCompleter loadImage(MessageLocalImageProvider key, ImageDecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(decode),
      scale: 1.0,
      debugLabel: 'MessageLocalImageProvider-$refFile',
      informationCollector: () sync* {
        yield ErrorDescription('Error loading memory: $refFile');
      },
    );
  }

  Future<ui.Codec> _loadAsync(ImageDecoderCallback decode) async {
    final cachedThumbnail = GetIt.I<ThumbnailBytesCacheManager>().getThumbnail(refFile);
    if (cachedThumbnail != null) {
      return decode(await ui.ImmutableBuffer.fromUint8List(cachedThumbnail));
    }

    Uint8List? thumbnailFromCache;

    if (bytes != null) {
      thumbnailFromCache = bytes!;
    }

    if (filePath != null && fileType == MessageFileType.video) {
      final thumbnailFromFile = await FileService.instance.generateThumbnailVideo(filePath!);
      if (thumbnailFromFile != null) {
        thumbnailFromCache = thumbnailFromFile;
      }
    }

    if (assetId != null) {
      final assetEntity = await AssetEntity.fromId(assetId!);

      if (assetEntity != null) {
        final thumbnail = await assetEntity.thumbnailDataWithSize(ThumbnailSize(assetEntity.width, assetEntity.height));
        if (thumbnail != null) {
          thumbnailFromCache = thumbnail;
        }
      }
    }

    if (thumbnailFromCache != null) {
      GetIt.I<ThumbnailBytesCacheManager>().saveThumbnail(refFile, thumbnailFromCache);
      return decode(await ui.ImmutableBuffer.fromUint8List(thumbnailFromCache));
    }

    return Future.error('AssetId and bytes are null');
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is MessageLocalImageProvider &&
        other.refFile == refFile &&
        other.bytes == bytes &&
        other.assetId == assetId;
  }

  @override
  int get hashCode => Object.hash(
        runtimeType,
        refFile,
        bytes,
        assetId,
      );
}
