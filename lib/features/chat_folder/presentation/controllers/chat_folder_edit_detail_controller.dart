import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/features/chat_folder/domain/entities/chat_folder_entity.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_mapper_extensions.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room_list/presentation/arguments/select_member_arguments.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/utils/extension/extension_string.dart';
import 'package:uchat/widgets.dart';

import '../../domain/use_cases/get_all_room_subscription_by_chat_folder_use_case.dart';
import '../arguments/chat_folder_edit_detail_arguments.dart';
import 'chat_folder_controller.dart';

class ChatFolderEditDetailController extends GetxController {
  final _log = useLogger();

  TextEditingController folderNameController = TextEditingController();

  ChatFolderEditDetailArguments? arguments;

  ChatFolderEntity? targetChatFolder;

  final folderName = ''.obs;
  final folderNameLength = 0.obs;
  final maxFolderNameLength = 20;

  final initialChatRooms = <RoomContactModel>[].obs;
  final currentChatRooms = <RoomContactModel>[].obs;

  final isInitiated = false.obs;

  ChatFolderEditDetailController({this.arguments});

  @override
  onInit() {
    initData();
    super.onInit();
  }

  @override
  void onClose() {
    folderNameController.dispose();
    super.onClose();
  }

  ChatFolderController get chatFolderController {
    if (!Get.isRegistered<ChatFolderController>()) {
      Get.put<ChatFolderController>(ChatFolderController());
    }

    return Get.find<ChatFolderController>();
  }

  bool get hasChanged {
    if (currentChatRooms.length < initialChatRooms.length || currentChatRooms.length > initialChatRooms.length) {
      return true;
    }

    final isNotSameName = targetChatFolder?.name != folderName.value;
    bool isNotSameList = false;

    for (final room in currentChatRooms) {
      if (!initialChatRooms.contains(room)) {
        isNotSameList = true;
        break;
      }
    }

    return isNotSameName || isNotSameList;
  }

  bool get ableToSave {
    return folderName.value.isNotEmpty && currentChatRooms.isNotEmpty && isInitiated.value;
  }

  Future<void> initData() async {
    if (Get.arguments == null && arguments == null) {
      Get.back();
    }

    if ((Get.arguments ?? arguments) is! ChatFolderEditDetailArguments) {
      Get.back();
    }

    final tempChatFolder = ((Get.arguments ?? arguments) as ChatFolderEditDetailArguments).chatFolder;

    targetChatFolder = tempChatFolder.copyWith();
    folderName.value = tempChatFolder.name;
    folderNameController.text = tempChatFolder.name;
    folderNameLength.value = tempChatFolder.name.effectiveLength;

    final tempRooms = <RoomContactModel>[];
    final roomSubscriptionMetas = await GetIt.I<GetAllRoomSubscriptionByChatFolderUseCase>().call(
      GetAllRoomSubscriptionByChatFolderParams(
        chatFolderId: tempChatFolder.id,
      ),
    );

    for (final roomSubscriptionMeta in roomSubscriptionMetas) {
      if (roomSubscriptionMeta.roomSubscription case final roomSub?) {
        final tempRoom = await GetIt.I<ChatRoomLocalRepository>().getRoom(roomSub.roomId!);
        final roomCollection = tempRoom?.toCollection();
        if (roomCollection != null) {
          late RoomContactModel roomContact;
          if (roomCollection is ContactCollection) {
            roomContact = RoomContactModel(
              data: roomCollection,
              type: (roomCollection as ContactCollection).isOfficial == true
                  ? RoomContactType.official
                  : RoomContactType.contact,
            );
          } else {
            roomContact = RoomContactModel(data: roomCollection, type: RoomContactType.room);
          }

          tempRooms.add(roomContact);
        }
      }
    }

    currentChatRooms.assignAll(tempRooms);
    currentChatRooms.refresh();

    initialChatRooms.assignAll(currentChatRooms);
    isInitiated.value = true;
  }

  Future<void> handleRemoveRoom(RoomContactModel roomContact) async {
    currentChatRooms.remove(roomContact);
  }

  Future<void> handlerOpenCreateChatFolderScreen() async {
    if (currentChatRooms.length >= UserController.instance.maxRoomInChatFolder) {
      chatFolderController.showLimitMemberDialog();
      return;
    }
    final roomList = await Get.toNamed(
      Routes.groupCreate,
      arguments: SelectMemberArguments(
        isManageFolder: true,
        contactAndGroupList: currentChatRooms,
      ),
    );
    if (roomList != null) {
      currentChatRooms.clear();
      currentChatRooms.assignAll(roomList);
      currentChatRooms.refresh();
    }
  }

  Future<void> handleOnSave() async {
    try {
      UChatLoading.show(status: 'Saving...'.tr);
      final updatedFolder = targetChatFolder?.copyWith(name: folderName.value);
      final newChatRooms = currentChatRooms.where((element) => !initialChatRooms.contains(element)).toList();
      final deletedChatRooms = initialChatRooms.where((element) => !currentChatRooms.contains(element)).toList();

      await chatFolderController.updateChatFolderNormal(
        folder: updatedFolder!,
        newRoomList: newChatRooms,
        deletedRoomList: deletedChatRooms,
      );
      UChatLoading.hide();
      UChatLoading.success(message: 'Saved'.tr);
      Get.back();
    } catch (e, stacktrace) {
      UChatLoading.hide();
      _log.e('handleOnSave error : $e', e, stacktrace);
    } finally {
      UChatLoading.hide();
    }
  }

  void handleFolderNameChange(String value) {
    if (value.effectiveLength > maxFolderNameLength) {
      folderNameController.text = folderName.value;
      return;
    }

    folderName.value = value;
    folderNameLength.value = value.effectiveLength;
  }

  void handleClearFolderName() {
    folderNameController.clear();
    folderName.value = '';
    folderNameLength.value = 0;
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
