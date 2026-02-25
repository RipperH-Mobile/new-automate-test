import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/data/models/enums/api_exception_type.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/album/data/models/models/album_task_status.dart';
import 'package:uchat/features/album/data/models/models/album_task_type.dart';
import 'package:uchat/features/album/data/models/requests/upload_image_to_album_request.dart';
import 'package:uchat/features/album/domain/entities/album_task_entity.dart';
import 'package:uchat/features/album/domain/events/album_task_canceled_event.dart';
import 'package:uchat/features/album/domain/events/album_task_completed_event.dart';
import 'package:uchat/features/album/domain/events/album_task_failed_event.dart';
import 'package:uchat/features/album/domain/events/album_task_progress_updated_event.dart';
import 'package:uchat/features/album/domain/events/album_task_started_event.dart';
import 'package:uchat/features/album/domain/params/upload_image_to_album_param.dart';
import 'package:uchat/features/album/domain/repositories/album_local_repository.dart';
import 'package:uchat/features/album/domain/repositories/album_server_repository.dart';
import 'package:uchat/features/media_gallery/media_gallery.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uuid/uuid.dart';

final _log = useLogger();

/// Use case to upload image to album.
/// If images is null, Will open gallery bottom sheet to pick images.
/// Otherwise will upload the images from params.
class UploadImageToAlbumUseCase extends SimpleUseCase<void, UploadImageToAlbumParam> {
  AlbumServerRepository get albumServerRepository {
    return GetIt.I<AlbumServerRepository>();
  }

  AlbumLocalRepository get albumLocalRepository {
    return GetIt.I<AlbumLocalRepository>();
  }

  static bool isCanceled = false;
  static CancelToken? cancelToken;

  @override
  Future<void> call(UploadImageToAlbumParam params) async {
    /// If upload image to album is called, Reset isCancelled to false. To prevent cancel of previous task to cancel
    /// the current and new task.
    isCanceled = false;
    List<String> uploadImagePathList = [];
    final mediaPaths = params.imagePathList ?? [];

    if (mediaPaths.isNotEmpty) {
      uploadImagePathList.assignAll(mediaPaths);
    } else if (params.mediaAssets.isNotEmpty) {
      for (final img in params.mediaAssets) {
        final path = await img.path;
        if (path != null) {
          uploadImagePathList.add(path);
        }
      }
    }

    /// If [uploadImagePathList] is empty, Open gallery bottom sheet to pick images.
    if (uploadImagePathList.isEmpty) {
      final mediaResult = await GetIt.I<GetMediaGalleryUseCase>().call(
        MediaGalleryParams(
          filterMediaType: MediaGalleryFilterMediaType.image,
          maxSelectable: UChatConstant.albumUploadLimit,
          doneButtonType: MediaGalleryDoneButtonType.add,
          enablePickingUnsupportedTypeOnAndroid: false,
        ),
      );

      await UChatLoading.show();
      final imagePaths = await mediaResult?.imagePaths;
      await UChatLoading.hide();
      if (imagePaths?.isNotEmpty != true) return;
      uploadImagePathList.assignAll(imagePaths!);
    }

    /// Generate id of this upload.
    String taskId = const Uuid().v4();

    /// Save this upload task to local database.
    final now = DateTime.now();
    final uploadTask = AlbumTaskEntity(
      taskId: taskId,
      roomId: params.roomId,
      albumId: params.albumId,
      currentProgress: 0,
      totalImages: uploadImagePathList.length,
      allImagesPath: uploadImagePathList,
      inQueueImagesPath: List<String>.from(uploadImagePathList),
      // Copy the list to prevent reference.
      status: AlbumTaskStatus.inProgress,
      type: AlbumTaskType.upload,
      createdAt: now,
      updatedAt: now,
    );
    await albumLocalRepository.putAlbumTask(uploadTask);

    /// Send event to update ui.
    eventBus.fire(AlbumTaskStartedEvent(
      task: uploadTask,
    ));
    cancelToken = CancelToken();
    for (int i = 0; i < uploadImagePathList.length; i++) {
      if (isCanceled) {
        /// If task is canceled, Stop the function.
        isCanceled = false;
        eventBus.fire(AlbumTaskCanceledEvent(task: uploadTask));
        return;
      }
      try {
        final uploadResult = await albumServerRepository.uploadImageIntoAlbum(UploadImageToAlbumRequest(
          totalImages: uploadImagePathList.length,
          index: i + 1,
          // index start from 1
          taskId: taskId,
          albumId: params.albumId,
          filePath: uploadImagePathList[i],
          cancelToken: cancelToken,
        ));
        if (uploadResult?.nextIndexing != null) {
          if (uploadResult?.nextIndexing == 0) {
            /// Update completed status, current progress and uploaded image to local database.
            uploadTask.inQueueImagesPath?.removeWhere((e) => e == uploadImagePathList[i]);
            uploadTask.status = AlbumTaskStatus.completed;
            uploadTask.currentProgress = (uploadTask.currentProgress ?? 0) + 1;
            uploadTask.updatedAt = DateTime.now();
            await albumLocalRepository.putAlbumTask(uploadTask);

            /// Send event to update ui.
            eventBus.fire(AlbumTaskCompletedEvent(task: uploadTask));
          } else {
            /// Update current progress and uploaded image to local database.
            uploadTask.inQueueImagesPath?.removeWhere((e) => e == uploadImagePathList[i]);
            uploadTask.currentProgress = (uploadTask.currentProgress ?? 0) + 1;
            uploadTask.updatedAt = DateTime.now();
            await albumLocalRepository.putAlbumTask(uploadTask);

            /// Send event to update ui.
            eventBus.fire(AlbumTaskProgressUpdatedEvent(task: uploadTask));
          }
        }
      } on DioException catch (e) {
        if (e.type == DioExceptionType.cancel) {
          /// Update canceled status to local database.
          uploadTask.status = AlbumTaskStatus.canceled;
          uploadTask.updatedAt = DateTime.now();
          await albumLocalRepository.putAlbumTask(uploadTask);

          /// Send event to update ui.
          eventBus.fire(AlbumTaskCanceledEvent(task: uploadTask));
        } else {
          /// Update failed status to local database.
          uploadTask.status = AlbumTaskStatus.failed;
          uploadTask.updatedAt = DateTime.now();
          await albumLocalRepository.putAlbumTask(uploadTask);

          /// Send event to update ui.
          eventBus.fire(AlbumTaskFailedEvent(task: uploadTask));
        }
      } on ApiException catch (e, stackTrace) {
        if (e.code == 404) {
          /// Update canceled status to local database.
          /// If somehow the album is not found, mark the task as canceled. to prevent task from being stuck to failed.
          uploadTask.status = AlbumTaskStatus.canceled;
          uploadTask.updatedAt = DateTime.now();
          await albumLocalRepository.putAlbumTask(uploadTask);

          /// Send event to update ui.
          eventBus.fire(AlbumTaskCanceledEvent(task: uploadTask));
        } else if (e.exceptionType == ApiExceptionType.permissionDenied) {
          UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);

          /// Update failed status to local database.
          uploadTask.status = AlbumTaskStatus.failed;
          uploadTask.updatedAt = DateTime.now();
          await albumLocalRepository.putAlbumTask(uploadTask);

          /// Send event to update ui.
          eventBus.fire(AlbumTaskFailedEvent(task: uploadTask));
          return;
        } else {
          _log.e('Upload image to album error with ApiException.', e, stackTrace);

          /// Update failed status to local database.
          uploadTask.status = AlbumTaskStatus.failed;
          uploadTask.updatedAt = DateTime.now();
          await albumLocalRepository.putAlbumTask(uploadTask);

          /// Send event to update ui.
          eventBus.fire(AlbumTaskFailedEvent(task: uploadTask));
        }
      } catch (e, stackTrace) {
        _log.e('Upload image to album error.', e, stackTrace);

        /// Update failed status to local database.
        uploadTask.status = AlbumTaskStatus.failed;
        uploadTask.updatedAt = DateTime.now();
        await albumLocalRepository.putAlbumTask(uploadTask);

        /// Send event to update ui.
        eventBus.fire(AlbumTaskFailedEvent(task: uploadTask));
        rethrow;
      }
    }
  }

  static void cancelUploadTask() {
    isCanceled = true;
    cancelToken?.cancel();
  }
}
