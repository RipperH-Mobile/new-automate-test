import 'package:uchat/features/album/domain/entities/album_task_entity.dart';

/// Event to notify that the app has completed uploading / downloading an image to an album.
/// This will be used to update the upload / download progress in chat room detail album image list screen and album image list screen.
class AlbumTaskProgressUpdatedEvent {
  AlbumTaskEntity task;

  AlbumTaskProgressUpdatedEvent({
    required this.task,
  });
}
