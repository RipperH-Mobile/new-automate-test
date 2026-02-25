import 'package:uchat/features/sticker/domain/entities/my_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/repositories/my_sticker_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetSortedMyStickerListUseCase extends SimpleUseCase<List<MyStickerPackEntity>, NoParams> {
  final MyStickerLocalRepository myStickerLocalRepository;

  GetSortedMyStickerListUseCase({required this.myStickerLocalRepository});

  @override
  Future<List<MyStickerPackEntity>> call(NoParams params) async {
    return await myStickerLocalRepository.getAllMyStickerPack();
  }
}
