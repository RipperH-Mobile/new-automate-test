import 'package:get/get.dart';
import 'package:uchat/features/album/data/models/models/album_task_status.dart';
import 'package:uchat/features/album/data/models/models/album_task_type.dart';

class AlbumTaskEntity {
  String? taskId;

  String? roomId;

  String? albumId;

  /// How many images has completed upload or download.
  int? currentProgress;

  /// How many images is chosen in this task.
  int? totalImages;

  /// List of all images path that user selected to upload or download.
  List<String>? allImagesPath;

  /// List of images path that are waiting to be uploaded or downloaded.
  List<String>? inQueueImagesPath;

  /// List of file name that are waiting to be downloaded.
  /// Will be null if this task is not download task.
  /// Used for retry download task only.
  List<String>? downloadFileName;

  /// Status of this task.
  AlbumTaskStatus? status;

  /// Type of this task.
  AlbumTaskType? type;

  /// DateTime of when this task is created.
  DateTime? createdAt;

  /// DateTime of when this task is updated.
  DateTime? updatedAt;

  /// How many times this task can be retried.
  int remainingUploadRetryAttempt;

  AlbumTaskEntity({
    this.taskId,
    this.roomId,
    this.albumId,
    this.currentProgress,
    this.totalImages,
    this.allImagesPath,
    this.inQueueImagesPath,
    this.downloadFileName,
    this.status,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.remainingUploadRetryAttempt = 1,
  });

  String get uiString {
    switch (type) {
      case AlbumTaskType.download:
      case AlbumTaskType.downloadAll:
        if (status == AlbumTaskStatus.failed) {
          return 'Download failed'.tr;
        } else if (status == AlbumTaskStatus.completed) {
          return 'Download success'.tr;
        } else {
          return 'Downloading...'.tr;
        }
      case AlbumTaskType.upload:
        if (status == AlbumTaskStatus.failed) {
          return 'Upload failed'.tr;
        } else if (status == AlbumTaskStatus.completed) {
          return 'Upload successful'.tr;
        } else {
          return 'Uploading...'.tr;
        }
      case null:
        return '';
    }
  }
}
