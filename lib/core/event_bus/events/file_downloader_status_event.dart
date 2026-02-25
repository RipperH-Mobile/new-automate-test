import 'package:background_downloader/background_downloader.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/models.dart';

class FileDownloaderStatusEvent {
  final TaskStatusUpdate downloadStatus;

  FileDownloaderStatusEvent({
    required this.downloadStatus,
  });

  String get fileId => downloadStatus.task.taskId;

  FileDownloadStatus get status => FileDownloadStatus.fromTaskStatus(downloadStatus.status);

  FileDownloaderMetaDataModel get metaData => FileDownloaderMetaDataModel.fromJson(downloadStatus.task.metaData);

  String get eventTo => metaData.eventTo;

  int get filesize => metaData.fileSize;

  @override
  String toString() => 'FileDownloaderStatusEvent(fileId: $fileId, status: $status)';
}
