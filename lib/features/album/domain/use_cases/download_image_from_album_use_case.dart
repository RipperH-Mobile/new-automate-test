import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/album/data/models/models/album_task_status.dart';
import 'package:uchat/features/album/data/models/models/album_task_type.dart';
import 'package:uchat/features/album/domain/entities/album_task_entity.dart';
import 'package:uchat/features/album/domain/entities/download_album_image_result_entity.dart';
import 'package:uchat/features/album/domain/events/album_task_canceled_event.dart';
import 'package:uchat/features/album/domain/events/album_task_completed_event.dart';
import 'package:uchat/features/album/domain/events/album_task_failed_event.dart';
import 'package:uchat/features/album/domain/events/album_task_progress_updated_event.dart';
import 'package:uchat/features/album/domain/events/album_task_started_event.dart';
import 'package:uchat/features/album/domain/params/download_image_from_album_param.dart';
import 'package:uchat/features/album/domain/repositories/album_local_repository.dart';
import 'package:uchat/features/album/domain/repositories/album_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uuid/uuid.dart';

final _log = useLogger();

class DownloadImageFromAlbumUseCase extends SimpleUseCase<DownloadAlbumImageResultEntity, DownloadImageFromAlbumParam> {
  AlbumServerRepository get albumServerRepository {
    return GetIt.I<AlbumServerRepository>();
  }

  AlbumLocalRepository get albumLocalRepository {
    return GetIt.I<AlbumLocalRepository>();
  }

  HttpCaller get httpCaller {
    return GetIt.I<HttpCaller>();
  }

  static bool isCanceled = false;
  static CancelToken? cancelToken;

  @override
  Future<DownloadAlbumImageResultEntity> call(DownloadImageFromAlbumParam params) async {
    /// If download image to album is called, Reset isCancelled to false. To prevent cancel of previous task to cancel
    /// the current and new task.
    isCanceled = false;
    cancelToken = CancelToken();

    /// Generate id of this download.
    String taskId = const Uuid().v4();

    /// Save this upload task to local database.
    final now = DateTime.now();
    final downloadTask = AlbumTaskEntity(
      taskId: taskId,
      roomId: params.roomId,
      albumId: params.albumId,
      currentProgress: 0,
      totalImages: params.images.length,
      allImagesPath: params.images.map((e) => e.imageUrl!).toList(),
      inQueueImagesPath: params.images.map((e) => e.imageUrl!).toList(),
      downloadFileName: params.images.map((e) => e.imageName ?? e.imageId ?? 'image_name').toList(),
      status: AlbumTaskStatus.inProgress,
      type: AlbumTaskType.download,
      createdAt: now,
      updatedAt: now,
    );
    await albumLocalRepository.putAlbumTask(downloadTask);

    /// Send event to update ui.
    eventBus.fire(AlbumTaskStartedEvent(
      task: downloadTask,
    ));

    int i = -1;
    int successCount = 0;
    for (final image in params.images) {
      i++;
      if (isCanceled) {
        /// If task is canceled, Stop the function.
        isCanceled = false;
        eventBus.fire(AlbumTaskCanceledEvent(task: downloadTask));
        return DownloadAlbumImageResultEntity(
          totalImages: params.images.length,
          successCount: successCount,
          isCanceled: true,
        );
      }
      if (image.imageUrl == null) {
        continue;
      }
      final downloadResult = await downloadImageWithRetry(image.imageUrl!, image.imageName ?? 'image');
      if (downloadResult == true) {
        successCount++;
      }
      if (i == params.images.length - 1) {
        if (successCount == 0) {
          /// Update failed status to local database.
          downloadTask.currentProgress = 0;
          downloadTask.status = AlbumTaskStatus.failed;
          downloadTask.updatedAt = DateTime.now();
          await albumLocalRepository.putAlbumTask(downloadTask);

          /// Send event to update ui.
          eventBus.fire(AlbumTaskFailedEvent(task: downloadTask));
        } else {
          /// Update completed status, current progress and uploaded image to local database.
          downloadTask.status = AlbumTaskStatus.completed;
          downloadTask.currentProgress = (downloadTask.currentProgress ?? 0) + 1;
          downloadTask.updatedAt = DateTime.now();
          await albumLocalRepository.putAlbumTask(downloadTask);

          /// Send event to update ui.
          eventBus.fire(AlbumTaskCompletedEvent(task: downloadTask));
        }
      } else {
        if (downloadResult == true) {
          /// Update current progress and uploaded image to local database.
          downloadTask.currentProgress = (downloadTask.currentProgress ?? 0) + 1;
          downloadTask.updatedAt = DateTime.now();
          await albumLocalRepository.putAlbumTask(downloadTask);

          /// Send event to update ui.
          eventBus.fire(AlbumTaskProgressUpdatedEvent(task: downloadTask));
        }
      }
    }
    return DownloadAlbumImageResultEntity(totalImages: params.images.length, successCount: successCount);
  }

  Future<bool> downloadImageWithRetry(
    String imageUrl,
    String imageName, {
    int attempt = 1,
    int maxRetry = 3,
  }) async {
    try {
      final resp = await httpCaller.get(
        imageUrl,
        isExternalApi: true,
        options: Options(
          responseType: ResponseType.bytes,
          headers: httpCaller.apiHeader,
          receiveTimeout: const Duration(seconds: UChatConstant.albumImageDownloadTimeout),
        ),
        cancelToken: cancelToken,
        onReceiveProgress: (int count, int total) {},
      );

      if (resp.data != null) {
        final bytes = resp.data;
        await SaverGallery.saveImage(
          bytes,
          fileName: imageName,
          skipIfExists: false,
        );
        return true;
      }
      return false;
    } on DioException catch (e, stackTrace) {
      if (e.type == DioExceptionType.cancel) {
        return false;
      } else if (attempt <= maxRetry) {
        _log.w('download image $imageUrl error (attempt #$attempt), retrying...', e, stackTrace);
        return downloadImageWithRetry(imageUrl, imageName, attempt: attempt + 1);
      } else {
        _log.e('download image $imageUrl error', e, stackTrace);
        return false;
      }
    } catch (e, stackTrace) {
      if (attempt <= maxRetry) {
        _log.w('download image $imageUrl error (attempt #$attempt), retrying...', e, stackTrace);
        return downloadImageWithRetry(imageUrl, imageName, attempt: attempt + 1);
      } else {
        _log.e('download image $imageUrl error', e, stackTrace);
        return false;
      }
    }
  }

  static void cancelDownloadTask() {
    isCanceled = true;
    cancelToken?.cancel();
  }
}
