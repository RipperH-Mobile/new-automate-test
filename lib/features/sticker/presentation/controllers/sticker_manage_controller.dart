import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/connectivity_controller.dart';
import 'package:uchat/core/exceptions/app_exception.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/services/sticker/sticker_downloader_service.dart';
import 'package:uchat/features/sticker/domain/entities/my_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/repositories/my_sticker_local_repository.dart';
import 'package:uchat/features/sticker/domain/use_cases/reorder_all_sticker_use_case.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_controller.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

final _log = useLogger();

class StickerManageController extends GetxController {
  StickerController get stickerCtl => Get.find<StickerController>();
  final undownloadedStickersInEditSticker = <MyStickerPackEntity>[].obs;
  final initStickersInEditSticker = <MyStickerPackEntity>[].obs;
  final downloadedStickersInEditSticker = <MyStickerPackEntity>[].obs;
  final listOfDeleteSticker = <MyStickerPackEntity>[].obs;
  final isSameStickerSetValue = false.obs;

  StickerDownloaderService get stickerDownloaderService => GetIt.I<StickerDownloaderService>();

  List<MyStickerPackEntity> get stickerNotDownload {
    return stickerCtl.myStickerList
        .where((element) => element.isDownloaded == false && element.isExpire == false)
        .toList();
  }

  List<MyStickerPackEntity> get stickerDownloaded {
    return stickerCtl.myStickerList.where((element) => element.isDownloaded == true).toList();
  }

  List<MyStickerPackEntity> get stickerNotDownloadWithoutCareExpire {
    return stickerCtl.myStickerList.where((element) => element.isDownloaded == false).toList();
  }

  Rx<bool> listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) {
      return false.obs;
    }
    if (identical(a, b)) {
      return true.obs;
    }
    for (int index = 0; index < a.length; index += 1) {
      if (a[index] != b[index]) {
        return false.obs;
      }
    }
    return true.obs;
  }

  void handleDownloadStickerPack(MyStickerPackEntity sticker) async {
    try {
      await stickerDownloaderService.downloadStickerPack<MyStickerPackEntity>(stickerPack: sticker);
    } on NoInternetException catch (e) {
      _log.w('Failed to download sticker pack due to no internet connection.', e);
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, st) {
      _log.e('Failed to download sticker pack.', e, st);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
    }
  }

  void handleCancelDownloadStickerPack(MyStickerPackEntity sticker) async {
    stickerDownloaderService.cancelDownloadJob(sticker.id);
  }

  void handleDownloadAll() {
    if (ConnectivityController.instance.isOffline) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
      return;
    }
    final stickers = stickerNotDownload;
    for (final sticker in stickers) {
      stickerCtl.downloadStickerPack<MyStickerPackEntity>(pack: sticker);
    }
  }

  void goToManageSticker() {
    if (ConnectivityController.instance.isOffline) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
      return;
    }
    initStickersInEditSticker.assignAll(stickerDownloaded);
    downloadedStickersInEditSticker.assignAll(stickerDownloaded);
    undownloadedStickersInEditSticker.assignAll(stickerNotDownloadWithoutCareExpire);
    listOfDeleteSticker.clear();

    Get.toNamed(Routes.stickerSettingEditMySticker);
  }

  void handleDeleteStickerPack(MyStickerPackEntity sticker) {
    UChatNewDialog.showDialog(
      context: Get.context!,
      title: 'Delete this sticker from downloads?'.tr,
      cancelText: 'Cancel'.tr,
      confirmText: 'Delete'.tr,
      confirmTextColor: Get.context!.theme.appColors.textError,
      cancelTextColor: Get.context!.theme.appColors.textLight,
      isDestructive: true,
      onConfirm: () {
        listOfDeleteSticker.add(sticker);
        final updateSticker = sticker.copyWith(isDownloaded: false);
        undownloadedStickersInEditSticker.add(updateSticker);
        downloadedStickersInEditSticker.removeWhere((item) => item.id == sticker.id);
      },
    );
  }

  void onEditDone() async {
    await UChatLoading.show();

    if (listOfDeleteSticker.isNotEmpty) {
      List<MyStickerPackEntity> packs = [];
      for (final stickerPack in listOfDeleteSticker) {
        await stickerDownloaderService.deleteStickerPack(packId: stickerPack.id);
        packs.add(stickerPack.copyWith(isDownloaded: false));
      }

      await GetIt.I<MyStickerLocalRepository>().putAllMyStickerPacks(packs);
    }

    //NOTE. listOfDeleteStickerId is need to reorder seq with all undownload
    final List<MyStickerPackEntity> expireList =
        undownloadedStickersInEditSticker.where((item) => item.isExpire).toList();

    final List<MyStickerPackEntity> unexpiredUndownloaded =
        undownloadedStickersInEditSticker.where((item) => !item.isExpire).toList();

    unexpiredUndownloaded.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    expireList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    //NOTE. downloadedStickersInEditSticker is ready
    final List<MyStickerPackEntity> realList = [
      ...downloadedStickersInEditSticker,
      ...unexpiredUndownloaded,
      ...expireList,
    ];

    final List<MyStickerPackEntity> updatedRealList = List.generate(
      realList.length,
      (index) => realList[index].copyWith(seq: index),
    );

    List<String> myListStickerIds = realList.map((item) => item.id).toList();

    stickerCtl.myStickerList.assignAll(updatedRealList);

    try {
      await GetIt.I<ReorderAllStickerUseCase>().call(ReorderAllStickerPackParams(orderedStickerIds: myListStickerIds));
      Get.back();
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('ReorderStickerUseCase error:', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
    }

    await UChatLoading.hide();
  }
}
