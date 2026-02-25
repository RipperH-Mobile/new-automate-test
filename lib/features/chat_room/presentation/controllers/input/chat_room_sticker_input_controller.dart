import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/exceptions/exceptions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/domain/entities/sticker_sending_entity.dart';
import 'package:uchat/features/chat_room/domain/events/sticker_input_pack_update_event.dart';
import 'package:uchat/features/chat_room/presentation/controllers/input/chat_room_input_controller.dart';
import 'package:uchat/features/sticker/domain/entities/my_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/entities/sticker_entity.dart';
import 'package:uchat/features/sticker/domain/entities/store_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/use_cases/reorder_all_sticker_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/reorder_one_sticker_pack_use_case.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_controller.dart';
import 'package:uchat/widgets/dialog/uchat_dialog.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class ChatRoomStickerInputController extends GetxController with GetTickerProviderStateMixin {
  final String tag;

  ChatRoomStickerInputController({required this.tag});

  static const String recentlyUsedStickerPackId = 'recently_used_sticker_pack';

  final ScrollController scrollController = ScrollController();
  final isAddSizedBox = true.obs;
  final selectedStickerPackId = recentlyUsedStickerPackId.obs;
  int currentStickerCount = 0;

  StreamSubscription? myStickerListSubs;
  StreamSubscription? firstMyStickerUpdate;

  StreamSubscription? _stickerPackDownloadStatusSubscription;

  late final PageController pageController;
  final currentStickerPage = 0.obs;
  bool isPageAnimating = false;

  @override
  void onInit() {
    pageController = PageController(initialPage: currentStickerPage.value, keepPage: true);
    try {
      if (stickerCtl.myStickerList.isEmpty) {
        return;
      }

      selectedStickerPackId(stickerCtl.myStickerList.first.id);
    } on StateError catch (_) {
      // this happen when open app from notification and chat room is open before
      // mySticker list is initialized
      firstMyStickerUpdate = stickerCtl.myStickerList.listen((pack) {
        if (pack.isEmpty) {
          return;
        }

        // add listener and update value when mySticker is initialized and then
        // cancel this subscription
        selectedStickerPackId(pack.first.id);
        firstMyStickerUpdate?.cancel();
        firstMyStickerUpdate = null;
      });
    } catch (e, st) {
      _log.e('onInit failed in ChatStickerGroupController :', e, st);
    }

    _stickerPackDownloadStatusSubscription = eventBus.on<StickerInputPackDownloadedEvent>().listen((event) {
      if (selectedStickerPackId.value == recentlyUsedStickerPackId) {
        currentStickerPage(0);
      } else {
        int index = stickerCtl.myStickerList.indexWhere((e) => e.id == selectedStickerPackId.value);
        if (index >= 0) {
          currentStickerPage(index + 1); // +1 because of recently used tab
          if (pageController.hasClients) {
            pageController.jumpToPage(currentStickerPage.value);
          }
        }
      }
    });

    super.onInit();
  }

  @override
  Future<void> onClose() async {
    await myStickerListSubs?.cancel();
    await firstMyStickerUpdate?.cancel();
    await _stickerPackDownloadStatusSubscription?.cancel();

    pageController.dispose();
    super.onClose();
  }

  Future<void> onOpenStickerSelection() async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        pageController.jumpToPage(currentStickerPage.value);
      });
    } catch (e, stackTrace) {
      _log.e('onOpenStickerSelection failed : $e', e, stackTrace);
    }
  }

  Future<void> onTapStickerPack(int index) async {
    isPageAnimating = true;
    _updateSelectedStickerValue(index);
    await pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    isPageAnimating = false;
  }

  void onStickerPageChanged(int index) {
    if (isPageAnimating) {
      return;
    }

    if (index < 0 || index >= stickerCtl.myStickerList.length + 1) {
      return; // Prevent out of bounds access
    }

    if (index == currentStickerPage.value) {
      return; // No change in page
    }

    _updateSelectedStickerValue(index);
  }

  void _updateSelectedStickerValue(int index) {
    currentStickerPage(index);
    if (index == 0) {
      selectedStickerPackId(recentlyUsedStickerPackId);
    } else {
      // -1 because of recently used tab is at index 0
      final selectedPack = stickerCtl.myStickerList.elementAtOrNull(index - 1);
      if (selectedPack != null) {
        selectedStickerPackId(selectedPack.id);
      }
    }
  }

  Future<void> selectSticker(
    String? packId,
    String? fileId,
    Function(StickerSendingEntity) onSendSticker,
  ) async {
    if (packId == null || fileId == null) {
      return;
    }
    chatRoomInputCtl.selectSticker(
      StickerSendingEntity(
        stickerPackId: packId,
        stickerId: fileId,
      ),
      (sticker) {
        onSendSticker(sticker);
      },
    );
  }

  Future<void> downloadStickerPack() async {
    try {
      MyStickerPackEntity? downloadSelected = stickerCtl.myStickerList.elementAtOrNull(
        currentStickerPage.value - 1,
      ); // subtract the sticker recently used.
      if (downloadSelected == null) {
        UChatDialog.showDownloadStickerFailed();
        return;
      }
      final pack = downloadSelected;
      await stickerCtl.downloadStickerPack<MyStickerPackEntity>(pack: pack);
    } on NoInternetException catch (e) {
      _log.w('Failed to download sticker pack due to no internet connection.', e);
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, st) {
      _log.e('Failed to download sticker pack.', e, st);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }

  void handleReorderStickerPack(int oldIndex, int newIndex) async {
    // If the oldIndex is 0, it means the recently used sticker pack, recently used tab can't be reorder so do nothing.
    if (oldIndex != 0) {
      if (newIndex <= 0) {
        // item is dragged before recently used sticker which changes the item next to right side.
        return;
      }
      // This is because of the reorder lib. Given the list is like this
      // ['recently used' (index 0), 'sticker pack 1' (index 1), 'sticker pack 2' (index 2), 'sticker pack 3' (index 3)]
      // When dragging 'sticker pack 1' to the right most position the new index will be index 4 because lib probably see it as
      // ['recently used' (index 0), 'sticker pack 1' (index 1 OLD INDEX), 'sticker pack 2' (index 2), 'sticker pack 3' (index 3), 'sticker pack 1' (index 4 NEW INDEX)]
      // So we need to subtract 1 from the new index to get the correct index in the list because we see it like this.
      // ['recently used' (index 0), 'sticker pack 2' (index 1), 'sticker pack 3' (index 2), 'sticker pack 1' (index 3 NEW INDEX)]
      if (newIndex > oldIndex) {
        newIndex--;
      }
      try {
        final oldPackList = List<MyStickerPackEntity>.from(stickerCtl.myStickerList);
        // Immediately reorder data for fast ui update.
        // Without this there will be a delay in the ui update.
        final item = stickerCtl.myStickerList.removeAt(oldIndex - 1);
        stickerCtl.myStickerList.insert(newIndex - 1, item);

        // Reorder and update seq data in local db.
        final updatedData = await GetIt.I<ReorderOneStickerPackUseCase>().call(ReorderOneStickerPackParams(
          packList: oldPackList,
          reorderedPack: oldPackList[oldIndex - 1], // oldIndex - 1 because the first index is recently used sticker
          newIndex: newIndex - 1, // newIndex - 1 because the first index is recently used sticker
        ));

        // Update the myStickerList with the updated data.
        stickerCtl.myStickerList.assignAll(updatedData);

        onTapStickerPack(newIndex);

        // Update to server as well.
        try {
          await GetIt.I<ReorderAllStickerUseCase>().call(
            ReorderAllStickerPackParams(
              orderedStickerIds: stickerCtl.myStickerList.map((item) => item.id).toList(),
            ),
          );
        } catch (e, stackTrace) {
          _log.e('ReorderStickerUseCase error:', e, stackTrace);
        }
      } catch (e, stackTrace) {
        _log.e('Reorder sticker error.', e, stackTrace);
      }
    }
  }

  ChatRoomInputController get chatRoomInputCtl {
    return Get.find<ChatRoomInputController>(tag: tag);
  }

  StickerController get stickerCtl {
    return Get.find<StickerController>();
  }

  int get stickerTabLength {
    return stickerCtl.myStickerList.length + 1;
  }

  RxList<StickerEntity> get stickerRecentlyUsedList {
    return stickerCtl.stickerRecentlyUsed;
  }

  RxList<StoreStickerPackEntity> get downloadQueueList {
    return RxList<StoreStickerPackEntity>();
  }

  String get currentStickerDownloading {
    return stickerCtl.currentDownloadingPackId;
  }
}
