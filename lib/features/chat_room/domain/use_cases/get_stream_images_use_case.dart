// UseCase for clipboard operations with stream
import 'dart:async';
import 'dart:typed_data';

import 'package:super_clipboard/super_clipboard.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/constants/uchat_error_label_constant.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/domain/entities/get_image_from_clipboard_stream_state.dart';
import 'package:uchat/features/chat_room/domain/entities/paste_board_image_entity.dart';
import 'package:uchat/features/chat_room/presentation/controllers/utils/get_images_from_clipboard_util.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetStreamImagesUseCase extends SimpleUseCase<void, List<ClipboardDataReader>> {
  final StreamController<ClipboardState> _stateController = StreamController<ClipboardState>.broadcast();

  // Public stream getter
  Stream<ClipboardState> get stateStream => _stateController.stream;

  // List to store loaded files
  final List<PasteBoardImageEntity> _loadedImages = <PasteBoardImageEntity>[];

  // Total available items that can actual provided
  int _totalProvidedItems = 0;

  // Counting an amount of how much loading images in progress
  int _loadingImageLength = 0;

  // Counting an amount of empty image data (Cannot get data from stream)
  int _emptyImageDataCount = 0;

  // Counting an amount of too large file
  int _tooLargeFileCount = 0;

  @override
  Future<void> call(List<ClipboardDataReader> fileItems) {
    return readImagesFromClipboard(fileItems);
  }

  // Read images from clipboard
  Future<void> readImagesFromClipboard(List<ClipboardDataReader> fileItems) async {
    try {
      _loadedImages.clear();

      if (fileItems.isEmpty) {
        _stateController.add(ClipboardAllLoaded(
          totalImagesLoaded: 0,
          images: [],
        ));

        return;
      }

      _totalProvidedItems = fileItems.length;

      // Emit initiated state with total files count
      _stateController.add(ClipboardInitiated(_totalProvidedItems));

      for (int i = 0; i < fileItems.length; i++) {
        // Maximum of Copy-Paste capacity is 10 images
        // So return if it's full
        if (_loadingImageLength >= 10) return;

        // Process each file format
        _processFile(item: fileItems[i], totalItemLength: fileItems.length, index: i);
      }
    } catch (e) {
      _emitError(UChatErrorLabelConstant.failedToReadClipboard, e: e);
    }
  }

  // Process individual file with progress tracking
  Future<void> _processFile({
    required ClipboardDataReader item,
    required int totalItemLength,
    required int index,
  }) async {
    try {
      // Get available image types
      final format = getAvailableFormats(item);

      if (format == null) {
        return;
      }

      // Counting amount of images in loading process
      _loadingImageLength++;

      item.getFile(format, (file) async {
        final totalSize = file.fileSize ?? 0;

        // Get stream and process with progress
        final stream = file.getStream();
        _processFileStream(
          stream: stream,
          fileIndex: index,
          totalSize: totalSize,
          format: format,
        );
      });
    } catch (e) {
      _emitError(UChatErrorLabelConstant.failedToProcessFile, e: e, fileIndex: index);
    }
  }

  // Process file stream with progress updates
  Future<void> _processFileStream({
    required Stream<List<int>> stream,
    required int fileIndex,
    required int totalSize,
    required FileFormat format,
  }) async {
    try {
      int loadedBytes = 0;
      final chunks = <Uint8List>[];
      final isTooLarge = totalSize > UChatConstant.fileSizeLimit;

      stream.listen(
        (c) {
          // Return if file is too large
          if (isTooLarge) {
            _tooLargeFileCount++;
            _emitError(UChatErrorLabelConstant.fileIsTooLarge, fileIndex: fileIndex);

            /// If the last image is too large
            /// then set state to [ClipboardAllLoaded] to complete the process
            if (_totalProvidedItems - 1 == fileIndex) {
              _stateController.add(ClipboardAllLoaded(
                totalImagesLoaded: _loadedImages.length,
                images: List.from(_loadedImages),
              ));
            }

            return;
          }

          // Handle incoming data chunks
          loadedBytes += c.length;
          chunks.add(Uint8List.fromList(c));

          // Emit loading state
          double percentage = totalSize > 0 ? (loadedBytes / totalSize) : 0;

          _stateController.add(ClipboardLoading(
            fileIndex: fileIndex,
            percentage: percentage,
            loadedBytes: loadedBytes,
            totalBytes: totalSize,
          ));
        },
        onError: (error) {
          _emitError(UChatErrorLabelConstant.streamFileError, e: error, fileIndex: fileIndex);
        },
        onDone: () {
          // Stream completed
          final completeFileData = _combineChunks(chunks);

          // Create file data object
          final fileData = PasteBoardImageEntity(
            image: completeFileData,
            isSelected: true,
            index: fileIndex,
            percentage: 1.0,
            format: format,
          );

          // Add to loaded files list
          _loadedImages.add(fileData);

          // Return if it cannot get data from this stream
          if (completeFileData.isEmpty) {
            _emptyImageDataCount++;

            // In case that it cannot get any data from the clipboard
            if (_emptyImageDataCount == _totalProvidedItems) {
              _emitError(
                UChatErrorLabelConstant.cannotGetAnyImages,
                isTooLarge: _tooLargeFileCount > 0,
              );
            }

            return;
          }

          // Emit loaded state
          _stateController.add(ClipboardLoaded(
            fileIndex: fileIndex,
            fileContent: completeFileData,
            fileSize: completeFileData.length,
            format: format,
          ));

          // Emit all loaded state
          if (_loadedImages.length == _totalProvidedItems || _loadedImages.length == 10) {
            _stateController.add(ClipboardAllLoaded(
              totalImagesLoaded: _loadedImages.length,
              images: List.from(_loadedImages),
            ));
          }
        },
      );
    } catch (e) {
      _emitError(UChatErrorLabelConstant.failedToProcessFileStream, e: e, fileIndex: fileIndex);
    }
  }

  // Combine chunks into single Uint8List
  Uint8List _combineChunks(List<Uint8List> chunks) {
    final builder = BytesBuilder();

    for (final chunk in chunks) {
      builder.add(chunk);
    }

    return builder.toBytes();
  }

  // Emit error state
  void _emitError(String message, {Object? e, int? fileIndex, bool? isTooLarge}) {
    useLogger().e('$message: $e');

    _stateController.add(ClipboardError(
      message: message,
      fileIndex: fileIndex,
      isTooLarge: isTooLarge,
    ));
  }

  // Dispose resources
  void dispose() {
    _stateController.close();
    _loadedImages.clear();
  }
}
