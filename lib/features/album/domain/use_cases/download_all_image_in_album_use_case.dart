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
import 'package:uchat/features/album/domain/params/download_all_image_in_album_param.dart';
import 'package:uchat/features/album/domain/params/fetch_images_in_albums_param.dart';
import 'package:uchat/features/album/domain/repositories/album_local_repository.dart';
import 'package:uchat/features/album/domain/repositories/album_server_repository.dart';
import 'package:uchat/features/album/domain/use_cases/fetch_images_in_album_use_case.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uuid/uuid.dart';

final _log = useLogger();

class DownloadAllImageInAlbumUseCase
    extends SimpleUseCase<DownloadAlbumImageResultEntity?, DownloadAllImageInAlbumParam> {
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
  Future<DownloadAlbumImageResultEntity?> call(DownloadAllImageInAlbumParam params) async {
    /// If download image to album is called, Reset isCancelled to false. To prevent cancel of previous task to cancel
    /// the current and new task.
    isCanceled = false;

    // Variable for using in catch block.
    AlbumTaskEntity? currentTask;
    try {
      /// Fetch first page of album images.
      final firstFetchResult = await GetIt.I<FetchImagesInAlbumUseCase>().call(FetchImagesInAlbumParam(
        albumId: params.albumId,
      ));
      if (firstFetchResult != null) {
        /// Save this upload task to local database.
        final now = DateTime.now();
        int totalImageCount = params.imageCount ?? firstFetchResult.total;
        final downloadTask = AlbumTaskEntity(
          taskId: params.taskId ?? const Uuid().v4(),
          roomId: params.roomId,
          albumId: params.albumId,
          currentProgress: 0,
          totalImages: totalImageCount,
          allImagesPath: (firstFetchResult.data?.toList() ?? []).map((e) => e.imageUrl!).toList(),
          inQueueImagesPath: (firstFetchResult.data?.toList() ?? []).map((e) => e.imageUrl!).toList(),
          downloadFileName:
              (firstFetchResult.data?.toList() ?? []).map((e) => e.imageName ?? e.imageId ?? 'image_name').toList(),
          status: AlbumTaskStatus.inProgress,
          type: AlbumTaskType.downloadAll,
          createdAt: now,
          updatedAt: now,
        );
        // Save reference to download task in currentTask to use in catch block.
        currentTask = downloadTask;
        await albumLocalRepository.putAlbumTask(downloadTask);

        /// Send event to update ui.
        eventBus.fire(AlbumTaskStartedEvent(
          task: downloadTask,
        ));
        int successCount = 0;

        /// Start download image from the first page of pagination result.
        int firstDownloadResult = await downloadAllImageInPage(
          imagesUrl: (firstFetchResult.data?.toList() ?? []).map((e) => e.imageUrl!).toList(),
          imagesName: downloadTask.downloadFileName!,
          downloadTask: downloadTask,
        );

        /// If download is canceled, Stop the function.
        if (firstDownloadResult == -1) {
          /// Update canceled status to local database.
          downloadTask.currentProgress = 0;
          downloadTask.status = AlbumTaskStatus.canceled;
          downloadTask.updatedAt = DateTime.now();
          await albumLocalRepository.putAlbumTask(downloadTask);

          /// Send event to update ui.
          eventBus.fire(AlbumTaskCanceledEvent(task: downloadTask));
          return DownloadAlbumImageResultEntity(
            successCount: 0,
            totalImages: totalImageCount,
            isCanceled: true,
          );
        } else {
          successCount += firstDownloadResult;
        }

        /// If there are more than 1 page of images, download the rest of the images.
        for (int i = 1; i < firstFetchResult.totalPages; i++) {
          /// Fetch image from page 2 to last page.
          final fetchResult = await GetIt.I<FetchImagesInAlbumUseCase>().call(FetchImagesInAlbumParam(
            albumId: params.albumId,
            page: i + 1,
          ));
          if (fetchResult != null) {
            final dataList = fetchResult.data?.toList() ?? [];
            successCount += await downloadAllImageInPage(
              imagesUrl: (dataList).map((e) => e.imageUrl!).toList(),
              imagesName: (dataList).map((e) => e.imageName ?? e.imageId ?? 'image_name').toList(),
              downloadTask: downloadTask,
            );
          }
        }
        if (successCount == 0) {
          /// Update failed status to local database.
          downloadTask.currentProgress = 0;
          downloadTask.status = AlbumTaskStatus.failed;
          downloadTask.updatedAt = DateTime.now();
          await albumLocalRepository.putAlbumTask(downloadTask);

          /// Send event to update ui.
          eventBus.fire(AlbumTaskFailedEvent(task: downloadTask));
        } else {
          /// Update completed status to local database.
          downloadTask.status = AlbumTaskStatus.completed;
          downloadTask.updatedAt = DateTime.now();
          await albumLocalRepository.putAlbumTask(downloadTask);

          /// Send event to update ui.
          eventBus.fire(AlbumTaskCompletedEvent(task: downloadTask));
        }
        return DownloadAlbumImageResultEntity(
          successCount: successCount,
          totalImages: totalImageCount,
        );
      } else {
        return DownloadAlbumImageResultEntity(
          successCount: 0,
          totalImages: params.imageCount ?? 0,
          isCanceled: false,
        );
      }
    } catch (e, stackTrace) {
      _log.e('fetch images in album error.', e, stackTrace);
      if (currentTask != null) {
        /// Update failed status to local database.
        currentTask.currentProgress = 0;
        currentTask.status = AlbumTaskStatus.failed;
        currentTask.updatedAt = DateTime.now();
        await albumLocalRepository.putAlbumTask(currentTask);

        /// Send event to update ui.
        eventBus.fire(AlbumTaskFailedEvent(task: currentTask));
      }
      rethrow;
    }
  }

  /// Download all image from one page of pagination result.
  /// Return -1 if downloadImages is canceled, Otherwise return download success count.
  Future<int> downloadAllImageInPage({
    required List<String> imagesUrl,
    required List<String> imagesName,
    required AlbumTaskEntity downloadTask,
  }) async {
    int successCount = 0;
    for (int i = 0; i < imagesUrl.length; i++) {
      if (isCanceled) {
        isCanceled = false;
        eventBus.fire(AlbumTaskCanceledEvent(task: downloadTask));
        return -1;
      }
      final downloadResult = await downloadImageWithRetry(imagesUrl[i], imagesName[i], i: i);
      if (downloadResult == true) {
        successCount++;

        /// Update current progress and uploaded image to local database.
        downloadTask.currentProgress = (downloadTask.currentProgress ?? 0) + 1;
        downloadTask.updatedAt = DateTime.now();
        await albumLocalRepository.putAlbumTask(downloadTask);

        /// Send event to update ui.
        eventBus.fire(AlbumTaskProgressUpdatedEvent(task: downloadTask));
      }
    }
    return successCount;
  }

  Future<bool> downloadImageWithRetry(
    String imageUrl,
    String imageName, {
    int attempt = 1,
    int maxRetry = 3,
    int? i,
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
        return downloadImageWithRetry(imageUrl, imageName, attempt: attempt + 1, i: i);
      } else {
        _log.e('download image $imageUrl error', e, stackTrace);
        return false;
      }
    } catch (e, stackTrace) {
      if (attempt <= maxRetry) {
        _log.w('download image $imageUrl error (attempt #$attempt), retrying...', e, stackTrace);
        return downloadImageWithRetry(imageUrl, imageName, attempt: attempt + 1, i: i);
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
