import 'package:get_it/get_it.dart';
import 'package:uchat/features/album/domain/params/delete_album_task_param.dart';
import 'package:uchat/features/album/domain/repositories/album_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class DeleteAlbumTaskUseCase extends SimpleUseCase<void, DeleteAlbumTaskParam> {
  AlbumLocalRepository get albumLocalRepository {
    return GetIt.I<AlbumLocalRepository>();
  }

  @override
  Future<void> call(DeleteAlbumTaskParam params) async {
    return await albumLocalRepository.deleteFailedAlbumTaskWithAlbumId(params.albumId);
  }
}
