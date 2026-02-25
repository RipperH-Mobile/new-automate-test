import 'package:flutter/foundation.dart';
import 'package:uchat/features/sticker/domain/enums/sticker_download_status.dart';

@immutable
class StickerPackDownloadStatusEvent {
  final String packId;
  final String fileId;
  final StickerDownloadStatus status;
  final double currentProgress;
  final double totalProgress;

  const StickerPackDownloadStatusEvent({
    required this.packId,
    required this.fileId,
    required this.status,
    this.currentProgress = 0.0,
    this.totalProgress = 0.0,
  });

  double get progress => totalProgress > 0 ? currentProgress / totalProgress : 0.0;
}
