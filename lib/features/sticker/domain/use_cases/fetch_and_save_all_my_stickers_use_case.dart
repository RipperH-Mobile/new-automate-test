import 'package:uchat/core/services/sticker/sticker_downloader_service.dart';
import 'package:uchat/features/sticker/domain/entities/my_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/repositories/my_sticker_local_repository.dart';
import 'package:uchat/features/sticker/domain/repositories/my_sticker_remote_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class FetchAndSaveAllMyStickersUseCase extends SimpleUseCase<void, NoParams> {
  final MyStickerRemoteRepository myStickerRemoteRepository;
  final MyStickerLocalRepository myStickerLocalRepository;
  final StickerDownloaderService stickerDownloaderService;

  FetchAndSaveAllMyStickersUseCase({
    required this.myStickerRemoteRepository,
    required this.myStickerLocalRepository,
    required this.stickerDownloaderService,
  });

  @override
  Future<void> call(NoParams params) async {
    List<MyStickerPackEntity> serverData = await myStickerRemoteRepository.getAllMySticker();
    List<MyStickerPackEntity> updatedData = [];
    // Update isDownloaded data.
    for (MyStickerPackEntity stickerPack in serverData) {
      final isDownloadFromService = await stickerDownloaderService.isPackDownloaded(
        packId: stickerPack.id,
        stickerCount: stickerPack.stickerItems.length,
      );
      updatedData.add(stickerPack.copyWith(isDownloaded: isDownloadFromService));
      // Save sticker data into local db.
      await myStickerLocalRepository.updateAllStickers(stickerPack.stickerItems);
    }

    // Save all updated sticker packs and save isar link into local db.
    await myStickerLocalRepository.putAllMyStickerPacks(updatedData);
  }
}
