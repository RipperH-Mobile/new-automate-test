import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'package:uchat/controllers.dart';

import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/entities/models/room_data_model.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/read_message_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/toggle_hide_room_request.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_server_repository.dart';
import 'package:uchat/features/chat_room_list/data/models/read_all_request.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list/read_all_room_in_local_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list/read_all_room_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list/sort_rooms_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list_actions/toggle_hide_room_use_case.dart';
import 'package:uchat/features/home/home_controller.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class ChatRoomListEditController extends GetxController {
  final roomDb = GetIt.I<RoomDb>();
  final roomSubDb = GetIt.I<RoomSubscriptionDb>();

  final searchController = TextEditingController();
  final searchInputFocus = FocusNode();

  final keyword = ''.obs;
  final roomDataList = <RoomDataModel>[].obs;
  final roomSubList = <RoomSubscriptionCollection>[].obs;
  final selectedRooms = <RoomSubscriptionCollection>[].obs;
  List<RoomSubscriptionCollection> allRoom = [];
  List<RoomSubscriptionCollection> searchRooms = [];

  bool get isMobile => UChatScreenUtil.instance.isMobile;

  final chatRoomListServerRepository = GetIt.I<ChatRoomListServerRepository>();

  @override
  void onInit() async {
    searchController.addListener(handleSearch);
    final enableBookmark = UserController.instance.enableBookmark;

    allRoom = await roomSubDb.getAllRoom(enableBookmark: enableBookmark);

    final allRoomIds = allRoom.map((room) => room.roomId!).toList();
    final rooms = await roomDb.getRooms(allRoomIds);
    final roomMap = {for (var r in rooms ?? []) r.id!: r};
    for (final room in allRoom) {
      room.roomName ??= roomMap[room.roomId]?.title ?? 'UNKNOWN'.tr;
    }
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

    //NOTE.search room from title and roomName
    if (keyword().isNotEmpty) {
      searchRooms =
          allRoom.where((element) => (element.roomName ?? 'UNKNOWN'.tr).toLowerCase().contains(keyword())).toList();
    } else {
      searchRooms = allRoom;
    }

    final sortType = chatListController.chatFolderController.isEnabled
        ? chatListController.sortType.value
        : chatListController.manageChatController.sortingType.value;

    searchRooms = GetIt.I<SortRoomsUseCase>().call(
      SortRoomParams(
        roomList: searchRooms,
        sortType: sortType,
      ),
    );

    List<RoomSubscriptionCollection> roomListPinned = searchRooms.where((e) => e.isPinned == true).toList();
    List<RoomSubscriptionCollection> roomListNoPinned = searchRooms.where((e) => e.isPinned != true).toList();
    roomSubList.value = [...roomListPinned, ...roomListNoPinned];
  }

  void handleBack() {
    Get.back();
  }

  void handleClearSearch() {
    searchController.clear();
  }

  Future<void> handleHideAllSelectedChat() async {
    GetIt.I<TaxonomyService>()
        .sendEvent(EventName.chatlistEdited, eventProperties: EventProperty.chatListEdited('hide'));
    if (selectedRooms.isEmpty) return;
    UChatNewDialog.showDialog(
      context: Get.context!,
      title: 'Hide @count selected chats'.trParams({
        'count': selectedRooms.length.toString(),
      }),
      description: 'Hiding a chat will not delete its messages. They stay accessible when unhidden.'.tr,
      cancelText: 'Cancel'.tr,
      confirmText: 'Confirm'.tr,
      confirmTextColor: Get.context!.theme.appColors.textPrimary,
      cancelTextColor: Get.context!.theme.appColors.textLight,
      isDestructive: true,
      onConfirm: () async {
        try {
          final futures = <Future>[];
          for (int i = 0; i < selectedRooms.length; i++) {
            final room = selectedRooms.elementAt(i);
            futures.add(hideOneRoom(room));
          }
          await Future.wait(futures);
          selectedRooms.clear();
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
      },
    );
  }

  Future<void> hideOneRoom(RoomSubscriptionCollection room) async {
    try {
      final req = ToggleHideRoomRequest(roomId: room.roomId!, isHidden: true);

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

        final req = ReadMessageRequest(roomId: room.roomId!, seenMessageAt: DateTime.now());
        futures.add(GetIt.I<ChatRoomServerRepository>().triggerReadMessage(req));
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
    GetIt.I<TaxonomyService>()
        .sendEvent(EventName.chatlistEdited, eventProperties: EventProperty.chatListEdited('delete'));
    if (selectedRooms.isEmpty) return;
    UChatNewDialog.showDialog(
      context: Get.context!,
      title: 'Delete @count selected chats'.trParams({
        'count': selectedRooms.length.toString(),
      }),
      description: 'Permanently remove these chats and all its messages. This action cannot be undone.'.tr,
      cancelText: 'Cancel'.tr,
      confirmText: 'Confirm'.tr,
      confirmTextColor: Get.context!.theme.appColors.textError,
      cancelTextColor: Get.context!.theme.appColors.textLight,
      isDestructive: true,
      onConfirm: () async {
        try {
          for (int i = 0; i < selectedRooms.length; i++) {
            final roomSub = selectedRooms.elementAt(i);
            final room = await roomDb.getRoom(roomSub.roomId ?? '');
            if (room != null) {
              await chatListController.handleDeleteRoom(
                room,
                shouldShowDialog: false,
                shouldShowLoading: i == 0,
              );
            }
          }
        } on FailedHostLookupException catch (e, stackTrace) {
          useLogger().d('handleDeleteAllSelectedChat failed, no internet.', e, stackTrace);
          await UChatLoading.hide();
          UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
        } catch (e, stackTrace) {
          useLogger().e('Call handleDeleteChat error.', e, stackTrace);
          await UChatLoading.hide();
          UChatNewDialog.showGeneralErrorDialog(
            context: Get.context!,
            e: e is Exception ? e : null,
          );
        }
        selectedRooms.clear();
        Get.back();
      },
    );
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

  void handleReadAllChat() async {
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.chatlistEdited,
      eventProperties: EventProperty.chatListEdited('read all'),
    );
    Get.back();
    try {
      AppToast.showAllReadToast(
        context: Get.context!,
        title: 'Marking all messages as read'.tr,
        description: 'Processing your request. Please wait...'.tr,
        isLoading: true,
      );

      await GetIt.I<ReadAllRoomUseCase>().call(
        ReadAllRequest(seenMessageAt: DateTime.now()),
      );

      AppToast.showAllReadToast(
        context: Get.context!,
        title: 'All chats read'.tr,
        description: 'All chats marked as read successfully.'.tr,
        isLoading: false,
      );

      GetIt.I<ReadAllRoomInLocalUseCase>().call(const ReadAllRoomInLocalParams());
    } catch (e, stacktrace) {
      _log.e('handleReadAllChat : $e', e, stacktrace);
    }
  }
}
