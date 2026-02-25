import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/album/data/models/models/album_task_status.dart';
import 'package:uchat/features/album/domain/entities/download_album_image_result_entity.dart';
import 'package:uchat/features/album/domain/events/album_task_canceled_event.dart';
import 'package:uchat/features/album/domain/events/album_task_completed_event.dart';
import 'package:uchat/features/album/domain/events/album_task_failed_event.dart';
import 'package:uchat/features/album/domain/events/album_task_progress_updated_event.dart';
import 'package:uchat/features/album/domain/events/album_task_started_event.dart';
import 'package:uchat/features/album/domain/params/retry_download_image_to_album_param.dart';
import 'package:uchat/features/album/domain/repositories/album_local_repository.dart';
import 'package:uchat/features/album/domain/repositories/album_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

final _log = useLogger();

class RetryDownloadImageToAlbumUseCase
    extends SimpleUseCase<DownloadAlbumImageResultEntity, RetryDownloadImageToAlbumParam> {
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
  Future<DownloadAlbumImageResultEntity> call(RetryDownloadImageToAlbumParam params) async {
    /// If download image to album is called, Reset isCancelled to false. To prevent cancel of previous task to cancel
    /// the current and new task.
    isCanceled = false;

    /// For download restart from the first image.
    params.task.currentProgress = 0;
    params.task.status = AlbumTaskStatus.inProgress;
    params.task.updatedAt = DateTime.now();

    /// Send event to update ui.
    eventBus.fire(AlbumTaskStartedEvent(
      task: params.task,
    ));
    List<String> retryImagesUrl = List.from(params.task.inQueueImagesPath!);
    int successCount = 0;
    cancelToken = CancelToken();
    for (int i = 0; i < retryImagesUrl.length; i++) {
      if (isCanceled) {
        /// If task is canceled, Stop the function.
        isCanceled = false;
        eventBus.fire(AlbumTaskCanceledEvent(task: params.task));
        return DownloadAlbumImageResultEntity(
          totalImages: params.task.totalImages ?? 0,
          successCount: successCount,
          isCanceled: true,
        );
      }
      final downloadResult =
          await downloadImageWithRetry(retryImagesUrl[i], params.task.downloadFileName?[i] ?? 'image');
      if (downloadResult == true) {
        successCount++;
      }
      if (i == retryImagesUrl.length - 1) {
        if (successCount == 0) {
          /// Update failed status to local database.
          params.task.currentProgress = 0;
          params.task.status = AlbumTaskStatus.failed;
          params.task.updatedAt = DateTime.now();
          await albumLocalRepository.putAlbumTask(params.task);

          /// Send event to update ui.
          eventBus.fire(AlbumTaskFailedEvent(task: params.task));
        } else {
          /// Update completed status, current progress and uploaded image to local database.
          params.task.status = AlbumTaskStatus.completed;
          params.task.currentProgress = (params.task.currentProgress ?? 0) + 1;
          params.task.updatedAt = DateTime.now();
          await albumLocalRepository.putAlbumTask(params.task);

          /// Send event to update ui.
          eventBus.fire(AlbumTaskCompletedEvent(task: params.task));
        }
      } else {
        /// Update current progress and uploaded image to local database.
        params.task.currentProgress = (params.task.currentProgress ?? 0) + 1;
        params.task.updatedAt = DateTime.now();
        await albumLocalRepository.putAlbumTask(params.task);

        /// Send event to update ui.
        eventBus.fire(AlbumTaskProgressUpdatedEvent(task: params.task));
      }
    }
    return DownloadAlbumImageResultEntity(
      totalImages: params.task.totalImages ?? retryImagesUrl.length,
      successCount: successCount,
    );
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
