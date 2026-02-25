import 'dart:async';

import 'package:background_downloader/background_downloader.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';

class FileDownloaderService {
  final _log = useLogger();

  static final FileDownloaderService instance = FileDownloaderService._internal();

  factory FileDownloaderService() => instance;

  FileDownloaderService._internal();

  final FileDownloader _fileDownloader = FileDownloader();

  FileService get fileService => FileService.instance;

  final _maximumConcurrentTasks = 2;

  StreamSubscription<TaskUpdate>? _statusUpdateSubscription;

  Future<void> initial() async {
    // set up task queue, concurrency
    final taskQueue = MemoryTaskQueue();
    taskQueue.maxConcurrent = _maximumConcurrentTasks;
    taskQueue.maxConcurrentByHost = _maximumConcurrentTasks;
    taskQueue.maxConcurrentByGroup = _maximumConcurrentTasks;
    _fileDownloader.addTaskQueue(taskQueue);

    // add listener
    _statusUpdateSubscription = _fileDownloader.updates.listen((event) {
      if (event is TaskStatusUpdate) {
        onStatusUpdate(event);
      }

      if (event is TaskProgressUpdate) {
        onProgressUpdate(event);
      }
    });

    // set track tasks, this will record all tasks in persistent storage
    await _fileDownloader.trackTasks();
  }

  Future<void> dispose() async {
    await _statusUpdateSubscription?.cancel();
    await resetDatabase();
    _fileDownloader.destroy();
  }

  Future<void> onStatusUpdate(TaskStatusUpdate status) async {
    bool openWhenCompleted = false;
    if (status.task.metaData.isNotEmpty) {
      final metaData = FileDownloaderMetaDataModel.fromJson(status.task.metaData);
      openWhenCompleted = metaData.openWhenCompleted;
    }

    if (status.status == TaskStatus.complete) {
      if (openWhenCompleted) {
        final filePath = await status.task.filePath();
        await fileService.openFile(filePath);
      }
    }

    eventBus.fire(FileDownloaderStatusEvent(
      downloadStatus: status,
    ));
  }

  Future<void> onProgressUpdate(TaskProgressUpdate progress) async {
    eventBus.fire(FileDownloaderProgressEvent(
      downloadProgress: progress,
    ));
  }

  Future<void> downloadFile({
    required String fileId,
    required String url,
    required String filePath,
    int? fileSize,
    Map<String, String>? headers,
    String group = 'default',
    String eventTo = '',
    bool openWhenCompleted = false,
    bool makeUniqueName = true,
  }) async {
    try {
      final setUpHeaders = {
        ...(headers ?? HttpCaller.instance.apiHeader),
        if (fileSize != null) 'Known-Content-Length': fileSize.toString(),
      };

      String path = filePath;
      if (makeUniqueName) {
        path = await fileService.uniqueFilename(filePath: filePath, returnFullPath: true);
      }
      final (baseDirectory, directory, filename) = await Task.split(filePath: path);
      final formattedMetaData = FileDownloaderMetaDataModel(
        eventTo: eventTo,
        openWhenCompleted: openWhenCompleted,
        fileSize: fileSize ?? 0,
      );

      final task = DownloadTask(
        taskId: fileId,
        url: url,
        headers: setUpHeaders,
        group: group,
        filename: filename,
        displayName: filename,
        directory: directory,
        baseDirectory: baseDirectory,
        updates: Updates.statusAndProgress,
        metaData: formattedMetaData.toJson(),
        retries: 2,
      );

      await _fileDownloader.enqueue(task);
    } catch (e, s) {
      _log.d('Error downloading file', e, s);
    }
  }

  Future<TaskRecord?> getTaskRecordByFileId(String fileId) async {
    try {
      final records = await _fileDownloader.database.recordForId(fileId);
      return records;
    } catch (e, s) {
      _log.e('Error fetching task record for fileId: $fileId', e, s);
      return null;
    }
  }

  Future<void> resetDatabase() async {
    await _fileDownloader.database.deleteAllRecords();
  }

  Future<void> deleteTask(String fileId) async {
    await _fileDownloader.database.deleteRecordWithId(fileId);
  }

  Future<void> cancelTask(String fileId) async {
    await _fileDownloader.cancelTaskWithId(fileId);
  }
}
