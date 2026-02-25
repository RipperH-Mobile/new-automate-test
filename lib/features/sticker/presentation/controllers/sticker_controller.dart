import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:async_queue/async_queue.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rive/rive.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/services/sticker/sticker_downloader_service.dart';
import 'package:uchat/features/chat_room/domain/events/sticker_input_pack_update_event.dart';
import 'package:uchat/features/sticker/data/models/payloads/reorder_sticker_packs_to_the_top_payload.dart';
import 'package:uchat/features/sticker/domain/abstracts/sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/entities/my_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/entities/sticker_entity.dart';
import 'package:uchat/features/sticker/domain/enums/sticker_download_status.dart';
import 'package:uchat/features/sticker/domain/events/sticker_pack_download_status_event.dart';
import 'package:uchat/features/sticker/domain/repositories/my_sticker_local_repository.dart';
import 'package:uchat/features/sticker/domain/use_cases/fetch_and_save_all_my_stickers_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/get_sorted_my_sticker_list_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/reorder_sticker_packs_to_the_top_use_case.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/download_sticker_fail_dialog.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class StickerController extends GetxController {
  static StickerController get instance => Get.find();

  String? stickerUserCachePath;
  String? stickerTempCachePath;

  final stickerUserPackList = <FileSystemEntity>[].obs;
  final stickerTempPackList = <FileSystemEntity>[].obs;
  final pendingSwitchAccountComplete = false.obs;

  final stickerRecentlyUsed = <StickerEntity>[].obs;
  final myStickerList = <MyStickerPackEntity>[].obs;
  final downloadingStickerPackIds = HashMap<String, double>().obs;

  StickerDownloaderService get stickerDownloaderService => GetIt.I<StickerDownloaderService>();

  Map<String, AsyncQueue> loadingRivStickerQueue = {};
  Map<String, RiveFile> riveStickerCache = {};

  final stickerInQueueDownloadStatus = <String, StickerDownloadStatus>{}.obs;
  final stickerInQueueDownloading = <String, double>{}.obs;
  StreamSubscription? reorderSubscription;
  StreamSubscription? downloadStatusSubscription;

  // This list is used for keeping downloaded sticker pack Id. After all download is finished this list will be sent to server
  // to move the downloaded sticker packs to the top of the list.
  List<String> completeDownloadingStickerPackIds = [];

  @override
  void onInit() {
    super.onInit();
    downloadStatusSubscription = eventBus.on<StickerPackDownloadStatusEvent>().listen(onStickerPackDownloading);
    reorderSubscription = eventBus.on<ReorderStickerEvent>().listen(onStickerReorder);
  }

  @override
  onClose() {
    downloadStatusSubscription?.cancel();
    reorderSubscription?.cancel();
    super.onClose();
  }

  Future<void> onStickerPackDownloading(StickerPackDownloadStatusEvent event) async {
    if (event.status == StickerDownloadStatus.cancelled) {
      stickerInQueueDownloadStatus.remove(event.packId);
      stickerInQueueDownloading.remove(event.packId);
      if (stickerInQueueDownloadStatus.isEmpty) {
        List<String> listStringAllMyStickers = myStickerList.map((item) => item.id).toList();
        listStringAllMyStickers = listStringAllMyStickers.reversed.toList();

        try {
          await GetIt.I<ReorderStickerPacksToTheTopUseCase>()
              .call(ReorderStickerPacksToTheTopRequest(downloadedStickerIds: listStringAllMyStickers));
        } catch (e, stackTrace) {
          _log.e('DownloadStickerReorderUseCase error:', e, stackTrace);
        }
      }
      return;
    } else if (event.status == StickerDownloadStatus.completed) {
      stickerInQueueDownloadStatus.remove(event.packId);
      stickerInQueueDownloading.remove(event.packId);
      completeDownloadingStickerPackIds.add(event.packId);
      //NOTE.: update sticker list when download finish
      int index = myStickerList.indexWhere((item) => item.id == event.packId);
      if (index != -1) {
        myStickerList[index] = myStickerList[index].copyWith(isDownloaded: true);

        //NOTE.localDB save isDownloaded == true
        await GetIt.I<MyStickerLocalRepository>().putMyStickerPack(myStickerList[index]);

        final item = myStickerList.removeAt(index);
        myStickerList.insert(0, item);
        myStickerList.refresh();
        eventBus.fire(StickerInputPackDownloadedEvent(packId: item.id));
      }
    } else {
      stickerInQueueDownloadStatus[event.packId] = event.status;
      stickerInQueueDownloading[event.packId] = event.currentProgress / event.totalProgress;
    }

    if (stickerInQueueDownloadStatus.isEmpty && myStickerList.isNotEmpty) {
      List<String> listStringAllMyStickers = myStickerList.map((item) => item.id).toList();

      final index = listStringAllMyStickers.indexWhere((id) => id == event.packId);
      final stickerPackId = listStringAllMyStickers.firstWhere((id) => id == event.packId);

      listStringAllMyStickers.removeAt(index);
      listStringAllMyStickers = listStringAllMyStickers.reversed.toList();
      listStringAllMyStickers.add(stickerPackId);

      try {
        await GetIt.I<ReorderStickerPacksToTheTopUseCase>().call(
          ReorderStickerPacksToTheTopRequest(downloadedStickerIds: completeDownloadingStickerPackIds),
        );
        completeDownloadingStickerPackIds.clear();
      } catch (e, stackTrace) {
        _log.e('DownloadStickerReorderUseCase error:', e, stackTrace);
      }
    }
  }

  Future<void> onStickerReorder(ReorderStickerEvent event) async {
    myStickerList.assignAll(await GetIt.I<GetSortedMyStickerListUseCase>().call(NoParams()));
  }

  RiveFile? getRiveStickerFile(String packId, String fileId) {
    /// Retrieves a Rive sticker file from the cache using the specified pack ID and file ID.
    ///
    /// Returns the cached [RiveFile] if it exists, otherwise returns `null`.

    final key = '$packId-$fileId';
    if (riveStickerCache.containsKey(key)) {
      return riveStickerCache[key];
    }
    return null;
  }

  void cacheRiveStickerFile(String packId, String fileId, RiveFile riveFile) {
    final key = '$packId-$fileId';
    riveStickerCache[key] = riveFile;
  }

  void addLoadingRivStickerQueue(String packId, Future<void> Function() callback) {
    if (!loadingRivStickerQueue.containsKey(packId)) {
      loadingRivStickerQueue[packId] = AsyncQueue.autoStart(allowDuplicate: false);
    }

    loadingRivStickerQueue[packId]!.addJob((_) async {
      await callback.call();
    });
  }

  void onUserLoggedOutOrBeforeSwitch() {
    cancelDownloadAllSticker();
    pendingSwitchAccountComplete(true);
    myStickerList.clear();
    stickerRecentlyUsed.clear();
  }

  void initCurrentUserSticker() async {
    if (UserController.instance.currentUser() == null) {
      return;
    }

    try {
      final user = UserController.instance.currentUser();
      final userId = user?.id;
      if (userId == null) {
        _log.e('User ID is null, cannot initialize sticker directory.');
        return;
      }
      await stickerDownloaderService.initializeDirectory(userId: userId);
      await initSticker(userId);
      pendingSwitchAccountComplete(false);
    } catch (e, stackTrace) {
      _log.e('Cannot create sticker directory.', e, stackTrace);
    }
  }

  Future<void> initSticker(String userId) async {
    try {
      getRecentlyUsedStickers();
      loadMyStickerList();
    } catch (e, stackTrace) {
      _log.e('initSticker failed.', e, stackTrace);
    }
  }

  Future<void> getRecentlyUsedStickers() async {
    try {
      final stickerItems = await GetIt.I<MyStickerLocalRepository>().getRecentlyUsedStickers();
      if (stickerItems.isNotEmpty) {
        stickerRecentlyUsed(stickerItems);
        stickerRecentlyUsed.refresh();
      }
    } catch (e, stackTrace) {
      _log.e('getRecentlyUsedStickers failed.', e, stackTrace);
    }
  }

  String get currentDownloadingPackId {
    return stickerDownloaderService.currentDownloadingPackId;
  }

  Future<void> updateRecentlyUsedSticker(
    String? packId,
    String? fileId,
  ) async {
    try {
      if (packId == null || fileId == null) {
        return;
      }
      await GetIt.I<MyStickerLocalRepository>().updateStickerLastUsedAt(
        packId,
        fileId,
        DateTime.now(),
      );
      await getRecentlyUsedStickers();
    } catch (e, stackTrace) {
      _log.e('updateRecentlyUsedSticker failed.', e, stackTrace);
    }
  }

  Future<void> loadMyStickerList() async {
    try {
      myStickerList.assignAll(await GetIt.I<GetSortedMyStickerListUseCase>().call(NoParams()));
      GetIt.I<FetchAndSaveAllMyStickersUseCase>().call(NoParams());
    } on FailedHostLookupException catch (_) {
      // If fetch is failed from no internet, Do nothing.
    } catch (e, stackTrace) {
      _log.e('load sticker data from server error.', e, stackTrace);
    }
  }

  String getStickerItemPath(
    String packId,
    String fileId,
  ) {
    return stickerDownloaderService.getStickerItemPath(packId, fileId);
  }

  Future<void> downloadStickerPack<T extends StickerPackEntity>({required T pack}) async {
    try {
      await stickerDownloaderService.downloadStickerPack(stickerPack: pack);
    } on NoInternetException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, st) {
      _log.e('Failed to download sticker pack.', e, st);
      showDownloadFailAlert();
    }
  }

  void cancelDownloadAllSticker() {
    stickerDownloaderService.cancelAllDownloadJobs();
  }

  // TODO: Important! Waiting design for sticker download fail dialog
  void showDownloadFailAlert() {
    Get.dialog(
      const DownloadStickerFailDialog(),
    );
  }

  bool get isAllStickerDownload {
    final sticker = myStickerList.firstWhereOrNull(
      (element) => element.isDownloaded == false && element.isExpire == false,
    );
    return sticker == null;
  }

  int get amountCanDownload {
    return myStickerList.where((item) => item.isDownloaded == false && item.isExpire == false).length;
  }
}
