import 'package:get_it/get_it.dart';
import 'package:uchat/features/album/domain/entities/album_entity.dart';
import 'package:uchat/features/album/domain/params/get_album_param.dart';
import 'package:uchat/features/album/domain/repositories/album_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetAlbumUseCase extends SimpleUseCase<AlbumEntity?, GetAlbumParam> {
  AlbumLocalRepository get albumLocalRepository {
    return GetIt.I<AlbumLocalRepository>();
  }

  @override
  Future<AlbumEntity?> call(GetAlbumParam params) async {
    return albumLocalRepository.getAlbum(params.albumId);
  }
}
