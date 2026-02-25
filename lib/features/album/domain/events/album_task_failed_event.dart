import 'package:uchat/features/album/domain/entities/album_task_entity.dart';

/// Event to notify that the upload / download to album has failed.
/// This will be used to update the upload / download progress in chat room detail album image list screen and album image list screen.
class AlbumTaskFailedEvent {
  AlbumTaskEntity task;

  AlbumTaskFailedEvent({
    required this.task,
  });
}
