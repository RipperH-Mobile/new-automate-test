import 'package:get/get.dart';
import 'package:isar_community/isar.dart';
import 'package:uchat/features/album/data/models/models/album_task_status.dart';
import 'package:uchat/features/album/data/models/models/album_task_type.dart';
import 'package:uchat/features/album/domain/entities/album_task_entity.dart';
import 'package:uchat/utils/fast_hash.dart';

part 'album_task_collection.g.dart';

/// AlbumUploadTaskCollection represents the task of uploading images to an album or task of downloading image from an album.
/// Each time user select images to upload to album or press download images, a new AlbumTaskCollection will be created.
/// Currently this data is on the current device only and doesn't share across multiple devices.
@Collection(accessor: 'albumTasks')
@Name('AlbumTask')
class AlbumTaskCollection {
  @Index(unique: true, replace: true)
  String? taskId;

  Id get isarId => fastHash(taskId!);

  @Index()
  String? roomId;

  @Index()
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
  @Enumerated(EnumType.name)
  AlbumTaskStatus? status;

  /// Type of this task.
  @Enumerated(EnumType.name)
  AlbumTaskType? type;

  /// DateTime of when this task is created.
  DateTime? createdAt;

  /// DateTime of when this task is updated.
  DateTime? updatedAt;

  /// How many times this task can be retried.
  int remainingUploadRetryAttempt;

  AlbumTaskCollection({
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

  factory AlbumTaskCollection.fromEntity(AlbumTaskEntity entity) {
    return AlbumTaskCollection(
      taskId: entity.taskId,
      roomId: entity.roomId,
      albumId: entity.albumId,
      currentProgress: entity.currentProgress,
      totalImages: entity.totalImages,
      allImagesPath: entity.allImagesPath,
      inQueueImagesPath: entity.inQueueImagesPath,
      downloadFileName: entity.downloadFileName,
      status: entity.status,
      type: entity.type,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      remainingUploadRetryAttempt: entity.remainingUploadRetryAttempt,
    );
  }

  AlbumTaskEntity toEntity() {
    return AlbumTaskEntity(
      taskId: taskId,
      roomId: roomId,
      albumId: albumId,
      currentProgress: currentProgress,
      totalImages: totalImages,
      allImagesPath: allImagesPath,
      inQueueImagesPath: inQueueImagesPath,
      downloadFileName: downloadFileName,
      status: status,
      type: type,
      createdAt: createdAt,
      updatedAt: updatedAt,
      remainingUploadRetryAttempt: remainingUploadRetryAttempt,
    );
  }

  @ignore
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
