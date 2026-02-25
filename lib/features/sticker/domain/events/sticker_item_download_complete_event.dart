import 'dart:io';

import 'package:flutter/foundation.dart';

@immutable
class StickerItemDownloadCompleteEvent {
  final String packId;
  final String fileId;
  final File stickerFile;

  const StickerItemDownloadCompleteEvent({
    required this.packId,
    required this.fileId,
    required this.stickerFile,
  });
}
