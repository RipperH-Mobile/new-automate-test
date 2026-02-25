import 'package:background_downloader/background_downloader.dart';

enum FileDownloadStatus {
  completed,
  failed,
  loading,
  waitingToStart,
  waitingToRetry,
  canceled,
  paused,
  unknown;

  String get value {
    switch (this) {
      case FileDownloadStatus.completed:
        return 'COMPLETED';
      case FileDownloadStatus.failed:
        return 'FAILED';
      case FileDownloadStatus.loading:
        return 'LOADING';
      case FileDownloadStatus.paused:
        return 'PAUSED';
      case FileDownloadStatus.unknown:
        return 'UNKNOWN';
      case FileDownloadStatus.waitingToStart:
        return 'WAITING_TO_START';
      case FileDownloadStatus.waitingToRetry:
        return 'WAITING_TO_RETRY';
      case FileDownloadStatus.canceled:
        return 'CANCELED';
    }
  }

  static FileDownloadStatus from(String? val) {
    switch (val) {
      case 'COMPLETED':
        return FileDownloadStatus.completed;
      case 'FAILED':
        return FileDownloadStatus.failed;
      case 'LOADING':
        return FileDownloadStatus.loading;
      case 'PAUSED':
        return FileDownloadStatus.paused;
      case 'UNKNOWN':
        return FileDownloadStatus.unknown;
      case 'WAITING_TO_START':
        return FileDownloadStatus.waitingToStart;
      case 'WAITING_TO_RETRY':
        return FileDownloadStatus.waitingToRetry;
      case 'CANCELED':
        return FileDownloadStatus.canceled;
      default:
        return FileDownloadStatus.unknown;
    }
  }

  static FileDownloadStatus fromTaskStatus(TaskStatus? status) {
    switch (status) {
      case TaskStatus.complete:
        return FileDownloadStatus.completed;
      case TaskStatus.failed:
        return FileDownloadStatus.failed;
      case TaskStatus.notFound:
        return FileDownloadStatus.failed;
      case TaskStatus.running:
        return FileDownloadStatus.loading;
      case TaskStatus.paused:
        return FileDownloadStatus.paused;
      case TaskStatus.enqueued:
        return FileDownloadStatus.waitingToStart;
      case TaskStatus.waitingToRetry:
        return FileDownloadStatus.waitingToRetry;
      case TaskStatus.canceled:
        return FileDownloadStatus.canceled;
      default:
        return FileDownloadStatus.unknown;
    }
  }

  TaskStatus? get toTaskStatus {
    switch (this) {
      case FileDownloadStatus.completed:
        return TaskStatus.complete;
      case FileDownloadStatus.failed:
        return TaskStatus.failed;
      case FileDownloadStatus.loading:
        return TaskStatus.running;
      case FileDownloadStatus.paused:
        return TaskStatus.paused;
      case FileDownloadStatus.waitingToStart:
        return TaskStatus.enqueued;
      case FileDownloadStatus.waitingToRetry:
        return TaskStatus.waitingToRetry;
      case FileDownloadStatus.canceled:
        return TaskStatus.canceled;
      case FileDownloadStatus.unknown:
        return null;
    }
  }
}
