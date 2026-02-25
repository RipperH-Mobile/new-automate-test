// Data types for different states
import 'dart:typed_data';

import 'package:super_clipboard/super_clipboard.dart';
import 'package:uchat/features/chat_room/domain/entities/paste_board_image_entity.dart';

abstract class ClipboardState {}

class ClipboardInitiated extends ClipboardState {
  final int totalImages;

  ClipboardInitiated(
    this.totalImages,
  );

  @override
  String toString() => 'ClipboardInitiated(totalFiles: $totalImages)';
}

class ClipboardLoading extends ClipboardState {
  final int fileIndex;
  final double percentage;
  final int loadedBytes;
  final int totalBytes;

  ClipboardLoading({
    required this.fileIndex,
    required this.percentage,
    required this.loadedBytes,
    required this.totalBytes,
  });

  @override
  String toString() =>
      'ClipboardLoading(index: $fileIndex, progress: ${percentage.toStringAsFixed(1)}%, $loadedBytes/$totalBytes bytes)';
}

class ClipboardLoaded extends ClipboardState {
  final int fileIndex;
  final Uint8List fileContent;
  final int fileSize;
  final FileFormat format;

  ClipboardLoaded({
    required this.fileIndex,
    required this.fileContent,
    required this.fileSize,
    required this.format,
  });

  @override
  String toString() => 'ClipboardLoaded(index: $fileIndex, size: $fileSize bytes)';
}

class ClipboardAllLoaded extends ClipboardState {
  final int totalImagesLoaded;
  final List<PasteBoardImageEntity> images;

  ClipboardAllLoaded({
    required this.totalImagesLoaded,
    required this.images,
  });

  @override
  String toString() => 'ClipboardAllLoaded(totalFiles: $totalImagesLoaded)';
}

class ClipboardError extends ClipboardState {
  final String message;
  final int? fileIndex;
  final bool? isTooLarge;

  ClipboardError({
    required this.message,
    this.fileIndex,
    this.isTooLarge,
  });

  @override
  String toString() => 'ClipboardError(message: $message, fileIndex: $fileIndex, isTooLarge: $isTooLarge)';
}
