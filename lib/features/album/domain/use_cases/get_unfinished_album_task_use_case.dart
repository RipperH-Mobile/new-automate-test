import 'package:get_it/get_it.dart';
import 'package:uchat/features/album/domain/entities/album_task_entity.dart';
import 'package:uchat/features/album/domain/params/get_unfinished_album_task_param.dart';
import 'package:uchat/features/album/domain/repositories/album_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetUnfinishedAlbumTaskUseCase extends SimpleUseCase<List<AlbumTaskEntity>, GetUnfinishedAlbumTaskParam> {
  AlbumLocalRepository get albumLocalRepository {
    return GetIt.I<AlbumLocalRepository>();
  }

  @override
  Future<List<AlbumTaskEntity>> call(GetUnfinishedAlbumTaskParam params) async {
    return await albumLocalRepository.getAlbumTasksInRoom(params.roomId, albumId: params.albumId);
  }
}
