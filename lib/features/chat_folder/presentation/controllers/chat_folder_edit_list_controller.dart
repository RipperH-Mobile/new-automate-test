import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/utils/reorder.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

import '../../data/models/payloads/reorder_folders.dart';
import '../../domain/entities/chat_folder_entity.dart';
import '../../domain/enums/chat_folder_type.dart';
import '../../domain/repositories/chat_folder_local_repository.dart';
import '../../domain/repositories/chat_folder_remote_repository.dart';
import 'chat_folder_controller.dart';

final _log = useLogger();

class ChatFolderEditListController extends GetxController {
  ChatFolderController get chatFolderController => Get.find<ChatFolderController>();

  final chatFolderTempList = <ChatFolderEntity>[].obs;
  final deletedChatFolders = <ChatFolderEntity>[].obs;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  void initData() {
    chatFolderTempList.assignAll(chatFolderController.chatFolders);
  }

  bool get hasChanged {
    final chatFolders = chatFolderController.chatFolders;

    if (chatFolders.length != chatFolderTempList.length) {
      return true;
    }

    for (var i = 0; i < chatFolders.length; i++) {
      if (chatFolders[i].seq != chatFolderTempList[i].seq) {
        return true;
      }
    }

    return false;
  }

  Future<void> deleteTempChatFolder(ChatFolderEntity item) async {
    final isConfirm = await UChatDialog.showDialog(
      title: 'Delete folder'.tr,
      description: 'Are you sure you want to\ndelete this folder?'.tr,
      confirmButtonColor: const Color(0xFFFF1552),
      showCloseButton: true,
    );
    if (isConfirm) {
      deletedChatFolders.add(item);
      chatFolderTempList.removeWhere((element) => element.id == item.id && element.type == item.type);
    }
  }

  int _keyToIndex(ReorderKey key) {
    try {
      final id = key.value.replaceAll(RegExp(r"[\[\]<>']"), '');
      return chatFolderTempList.indexWhere((element) => element.id == id);
    } catch (e, stacktrace) {
      _log.w('Error on _keyToIndex', e, stacktrace);
      return 0;
    }
  }

  bool onReorder(ReorderKey draggingItemKey, ReorderKey replaceItemKey) {
    try {
      final draggingItemIndex = _keyToIndex(draggingItemKey);
      final replaceItemIndex = _keyToIndex(replaceItemKey);
      if (replaceItemIndex < 1) return false; // prevent reordering all folder (fixed position)
      _log.d('onReorder: $draggingItemIndex, $replaceItemIndex');

      final draggingItem = chatFolderTempList.removeAt(draggingItemIndex);
      chatFolderTempList.insert(replaceItemIndex, draggingItem);

      _log.d('reordered: ${chatFolderTempList.map((e) => e.seq).toList()}');

      return false;
    } catch (e, stacktrace) {
      _log.w('Error on onReorder', e, stacktrace);
      return false;
    }
  }

  void onReorderDone(ReorderKey itemKey) {
    final itemIndex = _keyToIndex(itemKey);
    _log.d('onReorderDone: $itemIndex');
  }

  Future<void> handleOnSaveData() async {
    if (hasChanged == false) {
      return;
    }

    try {
      UChatLoading.show(status: 'Saving...'.tr);
      for (var i = 0; i < chatFolderTempList.length; i++) {
        chatFolderTempList[i] = chatFolderTempList[i].copyWith(seq: i);
      }
      List<ChatFolderEntity> resultChatFolderSorted = [
        ...chatFolderTempList.where((e) => e.type != ChatFolderType.all)
      ];

      final deletedChatFolderIds = deletedChatFolders.map((e) => e.id).toList();
      final chatFolderTempListIds = resultChatFolderSorted.map((e) => e.id).toList();
      deletedChatFolderIds.removeWhere((e) => e.isEmpty);
      chatFolderTempListIds.removeWhere((e) => e.isEmpty);

      final reorderParams = ReorderFoldersParams(
        chatFolderIds: chatFolderTempListIds,
        delChatFolderIds: deletedChatFolderIds,
      );

      final result = await GetIt.I<ChatFolderRemoteRepository>().reorderFolders(reorderParams);
      final chatFolders = result?.chatFolders ?? [];

      for (final folder in chatFolders) {
        if (folder.deleted == true) {
          await GetIt.I<ChatFolderLocalRepository>().delete(id: folder.id);
        } else {
          await GetIt.I<ChatFolderLocalRepository>().putOrUpdate(chatFolder: folder);
        }
      }

      UChatLoading.hide();
      await chatFolderController.getChatFoldersFromLocal();
      await UChatLoading.success(message: 'Saved'.tr);
      Get.back();
      UChatLoading.hide();
    } catch (e, stacktrace) {
      handleException(e, onUnknownException: () async {
        _log.e('handleOnSaveData error.', e, stacktrace);
        await UChatLoading.hide();
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
  }

  Future<void> handleBack() async {
    if (hasChanged) {
      final isConfirm = await UChatDialog.showDialog(
        title: 'Discard folder edits'.tr,
        description: 'Are you sure you want to discard editing this folder?'.tr,
        confirmButtonColor: const Color(0xFFFF1552),
        showCloseButton: true,
      );

      if (isConfirm) {
        Get.back();
      }
    } else {
      Get.back();
    }
  }

  Future<bool> handleOnWillPop() async {
    if (hasChanged) {
      final isConfirm = await UChatDialog.showDialog(
        title: 'Discard folder edits'.tr,
        description: 'Are you sure you want to discard editing this folder?'.tr,
        confirmButtonColor: const Color(0xFFFF1552),
        showCloseButton: true,
      );
      if (isConfirm) {
        return true;
      }
    } else {
      return true;
    }

    return false;
  }
}
