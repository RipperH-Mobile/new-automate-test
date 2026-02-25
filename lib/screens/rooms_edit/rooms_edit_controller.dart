import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/entities/models/room_data_model.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/toggle_hide_room_request.dart';
import 'package:uchat/features/chat_room/domain/params/trigger_read_message_params.dart';
import 'package:uchat/features/chat_room/domain/use_cases/trigger_read_message_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list/sort_rooms_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list_actions/toggle_hide_room_use_case.dart';
import 'package:uchat/features/home/home_controller.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class RoomsEditController extends GetxController {
  final roomDb = GetIt.I<RoomDb>();
  final roomSubDb = GetIt.I<RoomSubscriptionDb>();

  final searchController = TextEditingController();
  final searchInputFocus = FocusNode();

  final keyword = ''.obs;
  final roomDataList = <RoomDataModel>[].obs;
  final roomSubList = <RoomSubscriptionCollection>[].obs;
  final selectedRooms = <RoomSubscriptionCollection>[].obs;

  bool get isMobile => UChatScreenUtil.instance.isMobile;

  @override
  void onInit() async {
    searchController.addListener(handleSearch);
    handleSearch();

    super.onInit();
  }

  ChatListController get chatListController => Get.find<ChatListController>();

  HomeController get homeController {
    return Get.find<HomeController>();
  }

  Future<void> handleSearch() async {
    roomDataList(chatListController.roomDataList());
    keyword(searchController.text.toLowerCase());

    final searchedList = await roomSubDb.searchRoomCanEdit(keyword());

    roomSubList(
      GetIt.I<SortRoomsUseCase>().call(
        SortRoomParams(
          roomList: searchedList,
          sortType: chatListController.manageChatController.sortingType.value,
        ),
      ),
    );
  }

  void handleBack() {
    Get.back();
  }

  void handleClearSearch() {
    searchController.clear();
  }

  Future<void> handleHideAllSelectedChat() async {
    if (selectedRooms.isEmpty) return;

    try {
      final isConfirmed = await UChatDialog.showDialog(
        title: 'Hide chat'.tr,
        description: 'Are you sure you want to hide selected chat'.tr,
        confirmText: 'Hide'.tr,
        confirmButtonColor: UChatDialog.blackDialogButtonColor,
        showCloseButton: true,
      );
      if (!isConfirmed) return;

      await UChatLoading.show(status: 'Updating...'.tr);

      final futures = <Future>[];
      for (int i = 0; i < selectedRooms.length; i++) {
        final room = selectedRooms.elementAt(i);
        futures.add(hideOneRoom(room));
      }
      await Future.wait(futures);

      selectedRooms.clear();
      await UChatLoading.success(message: 'Updated.'.tr);
    } catch (e, stackTrace) {
      handleException(e, onUnknownException: () async {
        _log.e('handleHideAllSelectedChat error.', e, stackTrace);
        await UChatLoading.hide();
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }

    Get.back();
  }

  Future<void> hideOneRoom(RoomSubscriptionCollection room) async {
    try {
      final req = ToggleHideRoomRequest(roomId: room.roomId!, isHidden: true);

      if (!isMobile) {
        // TODO: implement desktop
      }

      await GetIt.I<ToggleHideRoomUseCase>().call(req);
    } catch (e, stackTrace) {
      _log.e('hideOneRoom error.', e, stackTrace);
      rethrow;
    }
  }

  Future<void> handleTriggerReadAllSelectedChat() async {
    if (selectedRooms.isEmpty) return;

    try {
      final isConfirmed = await UChatDialog.showDialog(
        title: 'Mark all as read'.tr,
        description: 'Are you sure you want to mark selected chat as read'.tr,
        showCloseButton: true,
      );

      if (!isConfirmed) return;

      await UChatLoading.show(status: 'Updating...'.tr);

      final futures = <Future>[];
      for (int i = 0; i < selectedRooms.length; i++) {
        final room = selectedRooms.elementAt(i);

        futures.add(GetIt.I<TriggerReadMessageUseCase>().call(TriggerReadMessageParams(
          roomId: room.roomId!,
          seenMessageAt: DateTime.now(),
        )));
      }
      await Future.wait(futures);

      selectedRooms.clear();
      await UChatLoading.success(message: 'Updated.'.tr);
    } catch (e, stackTrace) {
      handleException(e, onUnknownException: () async {
        _log.e('handleTriggerRead error.', e, stackTrace);
        await UChatLoading.hide();
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }

    Get.back();
  }

  Future<void> handleDeleteAllSelectedChat() async {
    if (selectedRooms.isEmpty) return;
    try {
      final isConfirmed = await UChatDialog.showDialog(
        title: 'Delete chat'.tr,
        description: 'Are you sure you want to delete selected chat'.tr,
        confirmButtonColor: UChatDialog.redDialogButtonColor,
        showCloseButton: true,
      );
      if (!isConfirmed) return;

      await UChatLoading.show(status: 'Updating...'.tr);

      // final futures = <Future>[];
      for (int i = 0; i < selectedRooms.length; i++) {
        final roomSub = selectedRooms.elementAt(i);
        final room = await roomDb.getRoom(roomSub.roomId ?? '');
        if (room != null) {
          // futures.add(
          await chatListController.handleDeleteRoom(
            room,
            shouldShowDialog: false,
            shouldShowLoading: i == 0,
          );
          // );
        }
      }
      // await Future.wait(futures);

      selectedRooms.clear();
      await UChatLoading.success(message: 'Updated.'.tr);
    } catch (e, stackTrace) {
      _log.e('Call handleDeleteChat error.', e, stackTrace);
      await UChatLoading.hide();
    }

    Get.back();
  }

  void handleSelectCheckbox(RoomSubscriptionCollection roomSub) {
    bool isSelected = selectedRooms.contains(roomSub);

    if (isSelected) {
      selectedRooms.remove(roomSub);
    } else {
      selectedRooms.add(roomSub);
    }
  }

  void handleCancelSelectedRooms() {
    selectedRooms.clear();
    Get.back();
  }
}
