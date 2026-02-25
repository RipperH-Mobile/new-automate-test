import 'package:uchat/features/album/domain/entities/album_task_entity.dart';

/// Event to notify that the app has completed the upload / download task.
/// This will be used to close the upload / download progress ui in chat room detail album image list screen and album image list screen.
class AlbumTaskCompletedEvent {
  AlbumTaskEntity task;

  AlbumTaskCompletedEvent({
    required this.task,
  });
}
