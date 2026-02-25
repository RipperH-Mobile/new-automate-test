import 'package:get_it/get_it.dart';
import 'package:uchat/core/exceptions/app_exception.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/album/data/models/models/album_task_status.dart';
import 'package:uchat/features/album/data/models/models/album_task_type.dart';
import 'package:uchat/features/album/data/models/requests/cancel_album_upload_request.dart';
import 'package:uchat/features/album/domain/events/album_task_canceled_event.dart';
import 'package:uchat/features/album/domain/params/cancel_album_task_param.dart';
import 'package:uchat/features/album/domain/repositories/album_local_repository.dart';
import 'package:uchat/features/album/domain/repositories/album_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class CancelAlbumTaskUseCase extends SimpleUseCase<void, CancelAlbumTaskParam> {
  AlbumLocalRepository get albumLocalRepository {
    return GetIt.I<AlbumLocalRepository>();
  }

  AlbumServerRepository get albumServerRepository {
    return GetIt.I<AlbumServerRepository>();
  }

  @override
  Future<void> call(CancelAlbumTaskParam params) async {
    if (params.task.albumId == null || params.task.taskId == null || params.task.roomId == null) {
      throw AppException(message: 'CancelAlbumTaskUseCase param needs albumId, taskId, and roomId.');
    }

    if (params.task.type == AlbumTaskType.upload) {
      await albumServerRepository.cancelAlbumUpload(CancelAlbumUploadRequest(
        albumId: params.task.albumId!,
        taskId: params.task.taskId!,
        roomId: params.task.roomId!,
      ));
    }
    params.task.status = AlbumTaskStatus.canceled;
    params.task.updatedAt = DateTime.now();
    await albumLocalRepository.putAlbumTask(params.task);

    eventBus.fire(AlbumTaskCanceledEvent(task: params.task));
  }
}
