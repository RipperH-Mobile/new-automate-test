import 'package:uchat/features/sticker/domain/entities/my_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/repositories/my_sticker_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class ReorderOneStickerPackParams {
  // Old list before moving / reordering.
  final List<MyStickerPackEntity> packList;

  // Sticker pack that is being reordered.
  final MyStickerPackEntity reorderedPack;

  // The position of the sticker pack after the reorder.
  final int newIndex;

  ReorderOneStickerPackParams({
    required this.packList,
    required this.reorderedPack,
    required this.newIndex,
  });
}

class ReorderOneStickerPackUseCase extends SimpleUseCase<List<MyStickerPackEntity>, ReorderOneStickerPackParams> {
  MyStickerLocalRepository myStickerLocalRepository;

  ReorderOneStickerPackUseCase({
    required this.myStickerLocalRepository,
  });

  @override
  Future<List<MyStickerPackEntity>> call(ReorderOneStickerPackParams params) async {
    // Get the seq of the destination sticker pack.
    int newSeq = params.packList[params.newIndex].seq;
    int oldSeq = params.reorderedPack.seq;
    List<MyStickerPackEntity> editedPack = [];
    if (oldSeq > newSeq) {
      editedPack = await myStickerLocalRepository.getMyStickerPackBetweenSeq(
        startSeq: newSeq,
        endSeq: oldSeq,
        includeLower: true,
      );
      for (int i = 0; i < editedPack.length; i++) {
        editedPack[i] = editedPack[i].copyWith(seq: editedPack[i].seq + 1);
      }
    } else if (oldSeq < newSeq) {
      editedPack = await myStickerLocalRepository.getMyStickerPackBetweenSeq(
        startSeq: oldSeq,
        endSeq: newSeq,
        includeUpper: true,
      );
      for (int i = 0; i < editedPack.length; i++) {
        editedPack[i] = editedPack[i].copyWith(seq: editedPack[i].seq - 1);
      }
    }
    editedPack.add(params.reorderedPack.copyWith(seq: newSeq));
    await myStickerLocalRepository.putAllMyStickerPacks(editedPack);

    return await myStickerLocalRepository.getAllMyStickerPack();
  }
}
