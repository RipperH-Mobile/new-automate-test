import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:uchat/entities/enums.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';

class ChatFileUploadingModel {
  String fileRef;
  MessageFileType type;
  FileProgressState fileProgressState;

  // Current uploaded / downloaded progress in byte.
  double currentProgress;

  // Total byte needed to upload or download.
  double totalProgress;
  double loadProgressPercent;
  bool isLoading;

  double compressProgress = 0.0;

  VoidCallback? onProgressChange;

  StreamSubscription? _compressVideoProgressSubscription;
  StreamSubscription? uploadProgressSubscription;
  StreamSubscription? _fileStateChangeSubscription;

  ChatFileUploadingModel({
    required this.fileRef,
    required this.type,
    required this.totalProgress,
    this.currentProgress = 0.0,
    this.loadProgressPercent = 0.0,
    this.isLoading = false,
    this.fileProgressState = FileProgressState.idle,
    this.onProgressChange,
  }) {
    if (fileProgressState == FileProgressState.uploaded) {
      return;
    }

    _compressVideoProgressSubscription = eventBus.on<VideoFileCompressingProgressEvent>().listen(
      (event) async {
        if (event.fileRef != fileRef) {
          return;
        }

        _updateCompressProgress(
          progress: event.compressProgress,
        );
      },
    );

    uploadProgressSubscription = eventBus.on<FileUploadProgressEvent>().listen(
      (event) async {
        if (event.fileRef != fileRef) {
          return;
        }

        await _updateUploadProgress(
          progress: event.uploadProgress,
          total: event.totalProgress,
        );
      },
    );

    _fileStateChangeSubscription = eventBus.on<FileStateChangeEvent>().listen(
      (event) {
        if (event.fileRef != fileRef) {
          return;
        }

        if (event.state == FileProgressState.uploaded) {
          fileProgressState = FileProgressState.uploaded;
          dispose();
          onProgressChange?.call();
        }

        if (event.state == FileProgressState.uploadFailed) {
          fileProgressState = FileProgressState.uploadFailed;
          dispose();
          onProgressChange?.call();
        }
      },
    );
  }

  Future<void> dispose() async {
    await _compressVideoProgressSubscription?.cancel();
    await uploadProgressSubscription?.cancel();
    await _fileStateChangeSubscription?.cancel();
  }

  factory ChatFileUploadingModel.fromMessageFileModel(MessageFileModel fileModel, {VoidCallback? onProgressChange}) {
    return ChatFileUploadingModel(
      fileRef: fileModel.refFile!,
      type: fileModel.type!,
      loadProgressPercent: 0,
      currentProgress: 0,
      totalProgress: 100,
      isLoading: false,
      onProgressChange: onProgressChange,
    );
  }

  Future<void> _updateCompressProgress({
    required double progress,
  }) async {
    if (fileProgressState != FileProgressState.compressing) {
      fileProgressState = FileProgressState.compressing;
    }

    compressProgress = progress;

    if (progress >= 0.999) {
      fileProgressState = FileProgressState.compressed;
    }
  }

  Future<void> _updateUploadProgress({
    required double progress,
    required double total,
  }) async {
    if (fileProgressState == FileProgressState.uploaded) {
      return;
    }

    if (currentProgress > progress) {
      /// This prevents backward progress.
      return;
    }

    final percentage = progress / total * 100;

    if (percentage == loadProgressPercent || percentage > 100) {
      /// This prevents the progress from updating if the progress is the same.
      return;
    }

    currentProgress = progress;
    loadProgressPercent = percentage;
    isLoading = !(progress >= total);
    if (totalProgress != total) {
      totalProgress = total;
    }

    if (percentage < 100 && fileProgressState != FileProgressState.uploading) {
      fileProgressState = FileProgressState.uploading;
    }

    onProgressChange?.call();
  }

  @override
  String toString() {
    return 'ChatFileUploadingModel(fileRef: $fileRef, type: $type, fileProgressState: $fileProgressState, currentProgress: $currentProgress, totalProgress: $totalProgress, loadProgressPercent: $loadProgressPercent, isLoading: $isLoading, onProgressChange: $onProgressChange, _uploadProgressSubscription: $uploadProgressSubscription, _fileStateChangeSubscription: $_fileStateChangeSubscription)';
  }
}
