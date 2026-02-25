import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_subscription_mapper_extension.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/room_sub_local_repository.dart';
import 'package:uchat/features/chat_room_list/presentation/arguments/select_member_arguments.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/utils/extension/extension_string.dart';
import 'package:uchat/widgets.dart';

import '../../domain/enums/chat_folder_type.dart';
import 'chat_folder_controller.dart';

// final _log = useLogger();

class ChatFolderCreateController extends GetxController {
  TextEditingController folderNameController = TextEditingController();

  final folderName = ''.obs;
  final folderNameLength = 0.obs;
  final maxFolderNameLength = 20;

  final selectedChatRooms = <RoomContactModel>[].obs;

  final showRequireFolderName = false.obs;

  @override
  onClose() {
    folderNameController.dispose();
    super.onClose();
  }

  ChatFolderController get chatFolderController {
    if (!Get.isRegistered<ChatFolderController>()) {
      Get.put<ChatFolderController>(ChatFolderController());
    }

    return Get.find<ChatFolderController>();
  }

  bool get hasChanged => folderName.isNotEmpty || selectedChatRooms.isNotEmpty;

  bool get ableToCreate => folderName.value.isNotEmpty && selectedChatRooms.isNotEmpty;

  void handleFolderNameChange(String value) {
    if (value.effectiveLength > maxFolderNameLength) {
      folderNameController.text = folderName.value;
      return;
    }

    if (value.isEmpty) {
      showRequireFolderName.value = true;
    } else {
      showRequireFolderName.value = false;
    }

    folderName.value = value;
    folderNameLength.value = value.effectiveLength;
  }

  void handleClearFolderName() {
    showRequireFolderName.value = true;
    folderNameController.clear();
    folderName.value = '';
    folderNameLength.value = 0;
  }

  Future<void> handleConfirmCreateChatFolder() async {
    if (folderName.value.isEmpty || selectedChatRooms.isEmpty) {
      return;
    }

    UChatLoading.show();

    final roomSubIds = <String>[];
    final roomSubs = <RoomSubscriptionCollection>[];
    for (RoomContactModel room in selectedChatRooms) {
      if (room.id == null) {
        continue;
      }

      final roomSub = await GetIt.I<RoomSubLocalRepository>().getRoomSubscriptionWithRoomId(room.id!);
      if (roomSub != null) {
        roomSubIds.add(roomSub.id!);
        roomSubs.add(roomSub.toCollection());
      }
    }

    final result = await chatFolderController.createChatFolder(
      folderName: folderName.value,
      type: ChatFolderType.normal,
      roomSubs: roomSubs,
    );

    if (result) {
      UChatLoading.hide();
      await UChatLoading.success();

      chatFolderController.updateDefaultTabController();
      Get.back();
    }
  }

  Future<void> handlerOpenAddChatScreen() async {
    if (selectedChatRooms.length >= UserController.instance.maxRoomInChatFolder) {
      chatFolderController.showLimitMemberDialog();
      return;
    }
    final roomList = await Get.toNamed(
      Routes.groupCreate,
      arguments: SelectMemberArguments(
        isManageFolder: true,
        contactAndGroupList: selectedChatRooms,
        fromRoomScreen: false,
      ),
    );
    if (roomList != null) {
      selectedChatRooms.clear();
      selectedChatRooms.assignAll(roomList);
    }
  }

  Future<void> handleRemoveRoom(RoomContactModel room) async {
    selectedChatRooms.remove(room);
  }

  Future<void> handleBack({bool? fromAppbarCloseButton = false}) async {
    if (hasChanged) {
      final isConfirm = await UChatDialog.showDialog(
        title: 'Discard folder creation'.tr,
        description: 'Are you sure you want to discard creating this folder?'.tr,
        confirmButtonColor: const Color(0xFFFF1552),
        showCloseButton: true,
      );
      if (isConfirm) {
        Get.back();
        if (fromAppbarCloseButton == true) {
          Get.close(2);
        }
      }
    } else {
      Get.back();
      if (fromAppbarCloseButton == true) {
        Get.close(2);
      }
    }
  }

  Future<bool> handleOnWillPop() async {
    if (hasChanged) {
      final isConfirm = await UChatDialog.showDialog(
        title: 'Discard folder creation'.tr,
        description: 'Are you sure you want to discard creating this folder?'.tr,
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
