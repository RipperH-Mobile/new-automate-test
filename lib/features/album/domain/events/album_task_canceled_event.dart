import 'package:uchat/features/album/domain/entities/album_task_entity.dart';

/// Event to notify that the user has canceled the upload / download task.
/// This will be used to close the upload / download progress ui in chat room detail album image list screen and album image list screen.
class AlbumTaskCanceledEvent {
  AlbumTaskEntity task;

  AlbumTaskCanceledEvent({
    required this.task,
  });
}
