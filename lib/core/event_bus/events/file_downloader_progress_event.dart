import 'package:background_downloader/background_downloader.dart';
import 'package:uchat/entities/models.dart';

class FileDownloaderProgressEvent {
  final TaskProgressUpdate downloadProgress;

  FileDownloaderProgressEvent({
    required this.downloadProgress,
  });

  String get fileId => downloadProgress.task.taskId;

  /// Download progress in 0.0 - 1.0
  double get progress => downloadProgress.progress;

  FileDownloaderMetaDataModel get metaData => FileDownloaderMetaDataModel.fromJson(downloadProgress.task.metaData);

  String get eventTo => metaData.eventTo;

  int get filesize => metaData.fileSize;

  @override
  String toString() => 'FileDownloaderProgressEvent(fileId: $fileId, progress: ${(progress * 100).toStringAsFixed(1)}%)';
}
