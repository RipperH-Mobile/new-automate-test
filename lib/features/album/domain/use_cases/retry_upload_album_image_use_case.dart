import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/app_exception.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/album/data/models/models/album_task_status.dart';
import 'package:uchat/features/album/domain/events/album_task_canceled_event.dart';
import 'package:uchat/features/album/domain/events/album_task_completed_event.dart';
import 'package:uchat/features/album/domain/events/album_task_failed_event.dart';
import 'package:uchat/features/album/domain/events/album_task_progress_updated_event.dart';
import 'package:uchat/features/album/domain/events/album_task_started_event.dart';
import 'package:uchat/features/album/domain/params/retry_upload_image_to_album_param.dart';
import 'package:uchat/features/album/domain/repositories/album_local_repository.dart';
import 'package:uchat/features/album/domain/repositories/album_server_repository.dart';
import 'package:uchat/features/album/data/models/requests/upload_image_to_album_request.dart';
import 'package:uchat/features/album/domain/use_cases/upload_image_to_album_use_case.dart';
import 'package:uchat/use_cases/use_case.dart';

final _log = useLogger();

// TODO (album) Sometimes retry can failed from file not found error. Probably because the saved path is a path to temporary file. Improve this later.
class RetryUploadImageToAlbumUseCase extends SimpleUseCase<void, RetryUploadImageToAlbumParam> {
  AlbumServerRepository get albumServerRepository {
    return GetIt.I<AlbumServerRepository>();
  }

  AlbumLocalRepository get albumLocalRepository {
    return GetIt.I<AlbumLocalRepository>();
  }

  static bool isCanceled = false;
  static CancelToken? cancelToken;

  @override
  Future<void> call(RetryUploadImageToAlbumParam params) async {
    /// If upload image to album is called, Reset isCancelled to false. To prevent cancel of previous task to cancel
    /// the current and new task.
    isCanceled = false;
    params.task.status = AlbumTaskStatus.inProgress;
    params.task.updatedAt = DateTime.now();

    /// Send event to update ui.
    eventBus.fire(AlbumTaskStartedEvent(
      task: params.task,
    ));
    List<String> retryImagesPath = List.from(params.task.inQueueImagesPath!);
    cancelToken = CancelToken();
    for (int i = 0; i < retryImagesPath.length; i++) {
      if (isCanceled) {
        /// If task is canceled, Stop the function.
        isCanceled = false;
        eventBus.fire(AlbumTaskCanceledEvent(task: params.task));
      }
      try {
        String path = retryImagesPath[i];

        /// Find the index of retry image.
        int? index = params.task.allImagesPath?.indexOf(path);
        if (index == null || index < 0) {
          throw AppException(message: 'Retry upload error because of invalid data.');
        }
        final uploadResult = await albumServerRepository.uploadImageIntoAlbum(UploadImageToAlbumRequest(
          totalImages: params.task.totalImages!,
          index: index + 1,
          // index start from 1
          taskId: params.task.taskId!,
          albumId: params.task.albumId!,
          filePath: path,
          cancelToken: UploadImageToAlbumUseCase.cancelToken,
        ));

        if (uploadResult?.nextIndexing != null) {
          if (uploadResult?.nextIndexing == 0) {
            /// Update completed status, current progress and uploaded image to local database.
            // Create newList and reassign to inQueueImagesPath because removeWhere at inQueueImagesPath directly throws
            // List is not growable error.
            final newList = List<String>.from(params.task.inQueueImagesPath ?? [], growable: true);
            newList.removeWhere((e) => e == path);
            params.task.inQueueImagesPath = newList;
            params.task.status = AlbumTaskStatus.completed;
            params.task.currentProgress = (params.task.currentProgress ?? 0) + 1;
            params.task.updatedAt = DateTime.now();
            await albumLocalRepository.putAlbumTask(params.task);

            /// Send event to update ui.
            eventBus.fire(AlbumTaskCompletedEvent(task: params.task));
          } else {
            /// Update current progress and uploaded image to local database.
            // Create newList and reassign to inQueueImagesPath because removeWhere at inQueueImagesPath directly throws
            // List is not growable error.
            final newList = List<String>.from(params.task.inQueueImagesPath ?? [], growable: true);
            newList.removeWhere((e) => e == path);
            params.task.inQueueImagesPath = newList;
            params.task.currentProgress = (params.task.currentProgress ?? 0) + 1;
            params.task.updatedAt = DateTime.now();
            await albumLocalRepository.putAlbumTask(params.task);

            /// Send event to update ui.
            eventBus.fire(AlbumTaskProgressUpdatedEvent(task: params.task));
          }
        }
      } on DioException catch (e) {
        if (e.type == DioExceptionType.cancel) {
          /// Update canceled status to local database.
          params.task.status = AlbumTaskStatus.canceled;
          params.task.updatedAt = DateTime.now();
          await albumLocalRepository.putAlbumTask(params.task);

          /// Send event to update ui.
          eventBus.fire(AlbumTaskCanceledEvent(task: params.task));
        } else {
          /// Update failed status to local database.
          params.task.status = AlbumTaskStatus.failed;
          params.task.updatedAt = DateTime.now();
          await albumLocalRepository.putAlbumTask(params.task);

          /// Send event to update ui.
          eventBus.fire(AlbumTaskFailedEvent(task: params.task));
        }
      } on PathNotFoundException catch (_) {
        /// Update failed status to local database.
        params.task.status = AlbumTaskStatus.failed;
        params.task.updatedAt = DateTime.now();

        /// For PathNotFoundException reduce remainingUploadRetryAttempt to stop user from retrying.
        /// because if file is not found, it will always fail.
        params.task.remainingUploadRetryAttempt -= 1;
        await albumLocalRepository.putAlbumTask(params.task);

        /// Send event to update ui.
        eventBus.fire(AlbumTaskFailedEvent(task: params.task));
      } on ApiException catch (e, stackTrace) {
        if (e.code == 404) {
          /// Update canceled status to local database.
          /// If somehow the album is not found, mark the task as canceled. to prevent task from being stuck to failed.
          params.task.status = AlbumTaskStatus.canceled;
          params.task.updatedAt = DateTime.now();
          await albumLocalRepository.putAlbumTask(params.task);

          /// Send event to update ui.
          eventBus.fire(AlbumTaskCanceledEvent(task: params.task));
        } else {
          _log.e('Retry upload error with ApiException.', e, stackTrace);

          /// Update failed status to local database.
          params.task.status = AlbumTaskStatus.failed;
          params.task.updatedAt = DateTime.now();
          await albumLocalRepository.putAlbumTask(params.task);

          /// Send event to update ui.
          eventBus.fire(AlbumTaskFailedEvent(task: params.task));
        }
      } catch (e, stackTrace) {
        _log.e('Retry upload error.', e, stackTrace);

        /// Update failed status to local database.
        params.task.status = AlbumTaskStatus.failed;
        params.task.updatedAt = DateTime.now();
        await albumLocalRepository.putAlbumTask(params.task);

        /// Send event to update ui.
        eventBus.fire(AlbumTaskFailedEvent(task: params.task));
        rethrow;
      }
    }
  }

  static void cancelUploadTask() {
    isCanceled = true;
    cancelToken?.cancel();
  }
}
