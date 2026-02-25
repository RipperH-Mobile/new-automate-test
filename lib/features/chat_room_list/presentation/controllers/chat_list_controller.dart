import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/entities/enum/chat_category_type.dart';
import 'package:uchat/entities/enum/chat_sorting_type.dart';
import 'package:uchat/entities/enum/online_status.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/entities/models/room_data_model.dart';
import 'package:uchat/entities/models/typing_model.dart';
import 'package:uchat/entities/services/bookmark_tag_db.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/call/presentation/views/widgets/dialogs/action_unavailable_dialog.dart';
import 'package:uchat/features/chat_folder/domain/entities/chat_folder_entity.dart';
import 'package:uchat/features/chat_folder/domain/enums/chat_folder_type.dart';
import 'package:uchat/features/chat_folder/presentation/controllers/chat_folder_controller.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/message_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_file_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/read_message_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/remove_reactions_in_room_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/toggle_hide_room_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/toggle_pin_room_request.dart';
import 'package:uchat/features/chat_room/domain/params/chat_room_arguments.dart';
import 'package:uchat/features/chat_room/domain/params/trigger_read_message_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_server_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/delete_all_message_in_room_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/remove_reactions_by_room_id_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/trigger_offline_queue_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/trigger_read_message_use_case.dart';
import 'package:uchat/features/chat_room/utils/chat_room_utils.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/toggle_hide_message_notification_request.dart';
import 'package:uchat/features/chat_room_detail/domain/params/toggle_mute_room_params.dart';
import 'package:uchat/features/chat_room_list/domain/params/delete_room_with_countdown_params.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list/get_all_room_last_seen_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/services/chat_list_performance_tracker.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list/sort_rooms_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list_actions/delete_room_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list_actions/toggle_hide_room_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list_actions/toggle_mute_room_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list_actions/toggle_pin_room_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/delete_room_with_countdown_use_case.dart';
import 'package:uchat/features/chat_room_list/presentation/controllers/manage_chat/manage_chat_controller.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/chat_room_hold_and_scroll_dialog.dart';
import 'package:uchat/features/contact/domain/params/block_contact_params.dart';
import 'package:uchat/features/contact/domain/params/unblock_contact_params.dart';
import 'package:uchat/features/contact/domain/use_cases/block_contact_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/unblock_contact_use_case.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/screens.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/get_name.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/utils/secret_chat_expire_text.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/menu_list/menu_list_item.dart';

final _log = useLogger();

class ChatListController extends GetxController with GetSingleTickerProviderStateMixin {
  static ChatListController get instance => Get.find();

  final focusSearch = false.obs;
  final openActionPaneId = RxnString();

  RoomDb get roomDb => GetIt.I<RoomDb>();

  RoomMemberDb get roomMemberDb => GetIt.I<RoomMemberDb>();

  RoomSubscriptionDb get roomSubDb => GetIt.I<RoomSubscriptionDb>();

  TriggerOfflineQueueUseCase get triggerOfflineQueueUseCase {
    return GetIt.I<TriggerOfflineQueueUseCase>();
  }

  ChatListPerformanceTracker get performanceTracker {
    return GetIt.I<ChatListPerformanceTracker>();
  }

  ChatFolderController get chatFolderController {
    if (!Get.isRegistered<ChatFolderController>()) {
      Get.put<ChatFolderController>(ChatFolderController());
    }

    return Get.find<ChatFolderController>();
  }

  ManageChatController get manageChatController {
    if (!Get.isRegistered<ManageChatController>()) {
      Get.put<ManageChatController>(ManageChatController());
    }

    return Get.find<ManageChatController>();
  }

  final roomDataList = <RoomDataModel>[].obs;

  ///
  /// The [sortType] and [sortTypeWorker] now is only use for Chat Folder feature
  ///
  final sortType = ChatSortingType.timeLastest.obs;
  Worker? sortTypeWorker;

  final isHideSearchBar = false.obs;
  final lastPixels = 0.0.obs;
  final scrollController = ScrollController();

  // HashMap key is room id
  final roomOnlineStatus = Rx<HashMap<String, Rx<OnlineStatus>>>(HashMap<String, Rx<OnlineStatus>>());

  // HashMap key is room id
  final roomOnlineStatusTimers = HashMap<String, Timer?>();

  final isTypingTimers = HashMap<String, Timer?>();
  final isRoomsTyping = Rx<HashMap<String, bool>>(HashMap<String, bool>());
  final typingModelList = <TypingModel>[].obs;

  final showBlueDot = false.obs;

  bool get isMobile => UChatScreenUtil.instance.isMobile;

  final isEditChat = false.obs;

  RoomsEditController get roomEditController {
    if (!Get.isRegistered<RoomsEditController>()) {
      Get.put<RoomsEditController>(RoomsEditController());
    }

    return Get.find<RoomsEditController>();
  }

  StreamSubscription? _roomListRefreshSub;
  StreamSubscription? _roomDbUpdateSub;
  StreamSubscription? _roomSubDbUpdateSub;
  StreamSubscription? _cancelDbUpdateSub;
  StreamSubscription? _contactUpdateSub;
  StreamSubscription? _userInRoomTypingSubscription;
  StreamSubscription? _toggleFailedMessageSubscription;
  StreamSubscription? _messageNewSubscription;
  StreamSubscription? _changeNavBarSubscription;

  /// Room id of the room that is on countdown from being deleted. Will be set to room id when user press delete room
  /// and countdown is started and will be reset back to null after the countdown is finished, user press undo or user
  /// press something else and force delete is called.
  String? deleteCountdownRoomId;

  @override
  void onInit() async {
    _messageNewSubscription = eventBus.on<NewRoomAfterDeleteEvent>().listen(onClearValueAfterDelete);

    _changeNavBarSubscription = eventBus.on<CloseToastForceDeleteEvent>().listen(
      (event) async {
        forceDeleteRoomWhenChangePage();
      },
    );

    _cancelDbUpdateSub = eventBus.on<RoomListRequireCancelDbUpdateSubscriptionEvent>().listen(
      (event) async {
        // _log.d('RoomListRequireCancelDbUpdateSubscriptionEvent');
        await _roomDbUpdateSub?.cancel();
        _roomDbUpdateSub = null;
      },
    );

    _userInRoomTypingSubscription = eventBus.on<UserInRoomTypingEvent>().listen((event) {
      final room = roomDataList.firstWhereOrNull((element) => element.id == event.roomId);
      if (room != null) {
        String? name = getDisplayNameFromAccountId(event.accountId);
        if (event.isTyping == false) {
          typingModelList.removeWhere((item) => event.roomId == item.roomId && event.accountId == item.accountId);
          isRoomsTyping.value[event.roomId] = typingModelList.any((e) => e.roomId == event.roomId);
          isRoomsTyping.refresh();
        } else {
          getTypingStatus(
            event.roomId,
            TypingModel(
              accountId: event.accountId,
              lastTypeAt: event.lastTypedAt,
              name: name ?? event.displayName,
              roomId: event.roomId,
            ),
          );
        }
      }
    });

    _contactUpdateSub = eventBus.on<ContactUpdateEvent>().listen(
      (event) async {
        final trace = performanceTracker.trackContactUpdate();
        trace.start();
        await getRoomsToState();
        trace.stop();
      },
    );

    _toggleFailedMessageSubscription = eventBus.on<ToggleFailedMessageEvent>().listen(
      (event) async {
        toggleHasFailedMessage(event.roomId, event.show);
      },
    );

    super.onInit();
  }

  @override
  void onClose() async {
    await _roomListRefreshSub?.cancel();
    await _roomDbUpdateSub?.cancel();
    await _roomSubDbUpdateSub?.cancel();
    await _cancelDbUpdateSub?.cancel();
    await _contactUpdateSub?.cancel();
    await _userInRoomTypingSubscription?.cancel();
    await _toggleFailedMessageSubscription?.cancel();
    await _messageNewSubscription?.cancel();
    await _changeNavBarSubscription?.cancel();

    cancelTypingAndRoomOnlineTimer();
    disposeSortTypeWorker();

    super.onClose();
  }

  Future<void> onClearValueAfterDelete(NewRoomAfterDeleteEvent? event) async {
    //NOTE.if delete room success value deleteCountdownRoomId will be reset to null
    if (deleteCountdownRoomId != null && event?.roomId == deleteCountdownRoomId) {
      deleteCountdownRoomId = null;
    }
  }

  void disposeSortTypeWorker() {
    if (sortTypeWorker?.disposed == false) {
      sortTypeWorker?.dispose();
      sortTypeWorker = null;
    }
  }

  void cancelTypingAndRoomOnlineTimer() {
    for (var element in roomOnlineStatusTimers.values) {
      element?.cancel();
    }

    for (var element in isTypingTimers.values) {
      element?.cancel();
    }
  }

  ///
  /// For use with [onUserLoaded] hook on [RootController]
  Future<void> onUserLoaded() async {
    final currentUserId = Get.find<UserController>().currentUser()?.id;
    final firstTimeLogin = Get.find<UserController>().isFirstTimeLogin;

    final trace = performanceTracker.startTrackingChatListFetch(
      userId: currentUserId ?? 'Unknown',
      isFirstTimeLogin: firstTimeLogin,
    );

    // load config from setting db
    final configAuthenticated = ConfigDb().authenticated;
    final sortTypeFromConfig = await configAuthenticated.getStringWithDefault(
      key: ConfigDb.getChatFolderSortingKey(),
      defaultValue: ChatSortingType.timeLastest.value,
    );
    sortType.value = ChatSortingType.fromString(sortTypeFromConfig);

    // Sort type worker is only used for Chat Folder feature
    // use for watch sort type value.
    sortTypeWorker ??= ever(sortType, (currentValue) async {
      await sortedRoomList();

      // Save to db when sort type changed
      final configAuthenticated = ConfigDb().authenticated;
      await configAuthenticated.saveConfig(
        key: ConfigDb.getChatFolderSortingKey(),
        value: currentValue.value,
      );
    });

    await getRoomsToState();

    trace.stop();

    useLogger().d('UserLoggedInEvent');
  }

  void onSocketConnected() {
    triggerOfflineQueue();
    updateAllRoomsLastSeen();
  }

  void onSyncInitBeforeWriteToDb() async {
    await _roomDbUpdateSub?.cancel();
    _roomDbUpdateSub = null;
  }

  void onSyncInitAfterWriteToDb() async {
    await _roomDbUpdateSub?.cancel();
    _roomDbUpdateSub = null;
  }

  void triggerOfflineQueue() async {
    await triggerOfflineQueueUseCase(NoParams());
  }

  Future<void> onUserLoggedOutOrBeforeSwitch() async {
    cancelTypingAndRoomOnlineTimer();
    disposeSortTypeWorker();

    await _roomDbUpdateSub?.cancel();
    _roomDbUpdateSub = null;

    await _roomSubDbUpdateSub?.cancel();
    _roomSubDbUpdateSub = null;

    await _roomListRefreshSub?.cancel();
    _roomListRefreshSub = null;

    roomOnlineStatus().clear();
    isRoomsTyping().clear();
    roomDataList.clear();

    useLogger().d('onUserLoggedOutOrSwitch');
  }

  // Future<void> onRoomListRequireRefresh(event) async {
  //   _log.d('RoomListRequireRefreshEvent');

  //   await _roomDbUpdateSub?.cancel();
  //   _roomDbUpdateSub = null;

  //   if (DbManager().authenticatedInstance != null) {
  //     getRoomsToState();
  //   }
  // }

  void handleRead({required String roomId}) async {
    final req = ReadMessageRequest(
      roomId: roomId,
      seenMessageAt: DateTime.now(),
    );
    // TODO (refactor clean) Change this to use case.
    await GetIt.I<ChatRoomServerRepository>().triggerReadMessage(req);
  }

  void handleAddToFolder({
    required ChatFolderEntity folder,
    required List<RoomContactModel> newRoomList,
  }) async {
    // if (folder.chatRooms.length >= UserController.instance.maxRoomInChatFolder) {
    //   chatFolderController.showLimitMemberDialog();
    //   return;
    // }
    // await chatFolderController.updateChatFolderNormal(
    //   folder: folder,
    //   newRoomList: newRoomList,
    // );
  }

  Future<void> getTypingStatus(String? roomId, TypingModel? typingModel) async {
    if (roomId == null || typingModel == null) return;

    final isTypingModelAbsent = typingModelList.every(
      (e) => e.accountId != typingModel.accountId || e.roomId != roomId,
    );

    if (isTypingModelAbsent) {
      typingModelList.add(typingModel);
      isRoomsTyping.value[roomId] = true;
      isRoomsTyping.refresh();

      // Cancel existing timer and set a new one
      isTypingTimers['$roomId-${typingModel.accountId}']?.cancel();
      isTypingTimers['$roomId-${typingModel.accountId}'] = Timer(
        const Duration(seconds: 4),
        () {
          typingModelList.removeWhere((item) => item.accountId == typingModel.accountId && item.roomId == roomId);
          isRoomsTyping.value[roomId] = typingModelList.any((e) => e.roomId == roomId);
          isRoomsTyping.refresh();
        },
      );
    }
  }

  bool isRoomOnline(RoomCollection room) {
    if (room.latestLastSeenAt == null) return false;
    final timeDiff = DateTime.now().difference(room.latestLastSeenAt!);
    bool onlineStatus = timeDiff.inSeconds <= UChatConstant.secondsInOnlineStatus;

    // _log.d(
    //     'Get online : Room with ID ${room.id} has timeDiff: $timeDiff. Online status determined as: $onlineStatus');

    return onlineStatus;
  }

  void updateOnlineStatus(
    RoomCollection room, // TODO: Should change to RoomEntity
  ) {
    OnlineStatus onlineStatus;
    // Check whether this room latest last seen at is within [secondsInOnlineStatus] seconds
    if (isRoomOnline(room)) {
      onlineStatus = OnlineStatus.online;
    } else {
      onlineStatus = OnlineStatus.offline;
    }
    if (onlineStatus == OnlineStatus.online) {
      if (roomOnlineStatusTimers[room.id] != null) {
        // If there is timer already, Cancel the old one to setup a new one with
        // updated delay.
        roomOnlineStatusTimers[room.id!]?.cancel();
      }
      // Set timer to reset online status to offline
      final timeDiff = DateTime.now().difference(room.latestLastSeenAt!);
      final delay = UChatConstant.secondsInOnlineStatus - timeDiff.inSeconds + 1;
      roomOnlineStatusTimers[room.id!] = Timer(
        Duration(seconds: delay),
        () {
          roomOnlineStatus.value[room.id!] = OnlineStatus.offline.obs;
          roomOnlineStatus.refresh();
        },
      );
    }
    // Save online status in this controller.
    roomOnlineStatus.value[room.id!] = onlineStatus.obs;
    roomOnlineStatus.refresh();
  }

  void handleSearch() {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickSearchboxChatlistpage);
    Get.toNamed(Routes.universalSearchMain);
  }

  Future<void> getRoomsToState() async {
    await sortedRoomList();

    _roomDbUpdateSub ??= roomDb.watchLazy()?.listen((_) async {
      final trace = performanceTracker.trackSortByRoomDb();
      trace.start();
      await sortedRoomList();
      trace.stop();
    });

    _roomSubDbUpdateSub ??= roomSubDb.watchLazy().listen((_) async {
      final trace = performanceTracker.trackSortByRoomSubDb();
      trace.start();
      await sortedRoomList();
      trace.stop();
    });
  }

  ///
  /// This method work for ChatFolder feature
  /// for sort room follow [sortType] variable.
  ///
  Future<void> sortedRoomList() async {
    // _log.d('Get online : sortedRoomList: Fetching rooms from the database.');
    final enableBookmark = UserController.instance.enableBookmark;
    List<RoomSubscriptionCollection> allRoom = await roomSubDb.getAllRoom(enableBookmark: enableBookmark);

    final allRoomIds = allRoom.map((room) => room.roomId!).toList();
    final rooms = await roomDb.getRooms(allRoomIds);
    final roomMap = {for (var r in rooms ?? []) r.id!: r};
    for (final room in allRoom) {
      // Sync roomName (RoomSub) with the latest title from roomMap (RoomCollection),
      // in case they're out of sync.
      room.roomName = roomMap[room.roomId]?.title;
    }

    ///
    /// This statement is only for Chat Folder feature
    /// For sort room follow [sortType] variable.
    ///

    if (chatFolderController.isEnabled) {
      allRoom = GetIt.I<SortRoomsUseCase>().call(SortRoomParams(
        roomList: allRoom,
        sortType: sortType.value,
      ));
    } else {
      allRoom = GetIt.I<SortRoomsUseCase>().call(SortRoomParams(
        roomList: allRoom,
        sortType: manageChatController.sortingType.value,
      ));
    }

    // _log.d(
    //     'Get online : sortedRoomList: Rooms list populated with total count: ${finalRooms.length}.');
    final newRoomDataList = <RoomDataModel>[];
    List<String>? roomIds = allRoom.map((room) => room.roomId!).toList();
    List<RoomCollection>? roomList = await roomDb.getRooms(roomIds);
    if (roomList != null) {
      for (final room in roomList) {
        RoomDataModel newRoomData = await RoomDataModel.fromRoom(room);
        newRoomData.roomSub = allRoom.firstWhereOrNull((roomSub) => roomSub.roomId == room.id).obs;
        newRoomDataList.add(newRoomData);
      }
    }

    roomDataList.clear();
    roomDataList.addAll(newRoomDataList);
  }

  RoomCollection? getRoom(String id) {
    return roomDb.getRoomSync(id);
  }

  List<RoomDataModel> getRoomList({required ChatFolderType? chatFolderType, required String? folderId}) {
    switch (chatFolderType) {
      case ChatFolderType.all:
        return [
          ...roomDataList.where((element) => element.roomSub()?.isPinned == true),
          ...roomDataList.where((element) => element.roomSub()?.isPinned != true),
        ];
      case ChatFolderType.direct:
        return [
          ...roomDataList.where((element) =>
              element.roomSub()?.roomType == RoomType.direct &&
              roomDb.getRoomSync(element.roomSub()?.roomId ?? '')?.firstOtherInRoom?.account?.isOfficial == false &&
              (element.roomSub()?.chatFolders?.firstWhereOrNull((folder) => folder.folderId == folderId)?.isPinned ==
                  true)),
          ...roomDataList.where((element) =>
              element.roomSub()?.roomType == RoomType.direct &&
              roomDb.getRoomSync(element.roomSub()?.roomId ?? '')?.firstOtherInRoom?.account?.isOfficial == false &&
              (element.roomSub()?.chatFolders?.firstWhereOrNull((folder) => folder.folderId == folderId)?.isPinned !=
                  true))
        ];
      case ChatFolderType.unread:
        return [
          ...roomDataList
              .where((element) => element.roomSub()?.isPinned == true && element.roomSub()?.unreadCount != 0),
          ...roomDataList
              .where((element) => element.roomSub()?.isPinned != true && element.roomSub()?.unreadCount != 0),
        ];

      case ChatFolderType.group:
        return [
          ...roomDataList.where((element) =>
              element.roomSub()?.roomType == RoomType.group &&
              roomDb.getRoomSync(element.roomSub()?.roomId ?? '')?.firstOtherInRoom?.account?.isOfficial != true &&
              (element.roomSub()?.chatFolders?.firstWhereOrNull((folder) => folder.folderId == folderId)?.isPinned ==
                  true)),
          ...roomDataList.where((element) =>
              element.roomSub()?.roomType == RoomType.group &&
              roomDb.getRoomSync(element.roomSub()?.roomId ?? '')?.firstOtherInRoom?.account?.isOfficial != true &&
              (element.roomSub()?.chatFolders?.firstWhereOrNull((folder) => folder.folderId == folderId)?.isPinned !=
                  true))
        ];
      case ChatFolderType.oa:
        return [
          ...roomDataList.where((element) =>
              element.roomSub()?.roomType == RoomType.direct &&
              roomDb.getRoomSync(element.roomSub()?.roomId ?? '')?.firstOtherInRoom?.account?.isOfficial == true &&
              (element.roomSub()?.chatFolders?.firstWhereOrNull((folder) => folder.folderId == folderId)?.isPinned ==
                  true)),
          ...roomDataList.where((element) =>
              element.roomSub()?.roomType == RoomType.direct &&
              roomDb.getRoomSync(element.roomSub()?.roomId ?? '')?.firstOtherInRoom?.account?.isOfficial == true &&
              (element.roomSub()?.chatFolders?.firstWhereOrNull((folder) => folder.folderId == folderId)?.isPinned !=
                  true))
        ];
      case ChatFolderType.normal:
        return [
          ...roomDataList.where((element) =>
              element.roomSub()?.chatFolders?.any((folder) => folder.folderId == folderId && folder.isPinned == true) ??
              false),
          ...roomDataList.where((element) =>
              element.roomSub()?.chatFolders?.any((folder) => folder.folderId == folderId && folder.isPinned != true) ??
              false)
        ];
      case ChatFolderType.secret:
        return [
          ...roomDataList.where((element) => element.roomSub()?.isPinned == true),
          ...roomDataList.where((element) => element.roomSub()?.isPinned != true),
        ];
      default:
        return [
          ...roomDataList.where((element) => element.roomSub()?.isPinned == true),
          ...roomDataList.where((element) => element.roomSub()?.isPinned != true),
        ];
    }
  }

  List<RoomDataModel> getRoomListChatCategory({required ChatCategoryType? chatCategoryType}) {
    switch (manageChatController.sortingType.value) {
      case ChatSortingType.timeLastest:
        return getRoomListChatCategoryTimeLastest(chatCategoryType: chatCategoryType);
      case ChatSortingType.timeOldest:
        return getRoomListChatCategoryTimeOldest(chatCategoryType: chatCategoryType);
      case ChatSortingType.nameASC:
        return getRoomListChatCategoryNameASC(chatCategoryType: chatCategoryType);
      case ChatSortingType.nameDESC:
        return getRoomListChatCategoryNameDESC(chatCategoryType: chatCategoryType);
      case ChatSortingType.unread:
        return getRoomListChatCategoryUnread(chatCategoryType: chatCategoryType);
    }
  }

  List<RoomDataModel> getFriendRooms() {
    return [
      ...roomDataList.where(
        (element) =>
            element.roomSub()?.roomType == RoomType.direct &&
            roomDb.getRoomSync(element.roomSub()?.roomId ?? '')?.firstOtherInRoom?.account?.isOfficial == false,
      ),
    ];
  }

  List<RoomDataModel> getGroupRooms() {
    return [
      ...roomDataList.where(
        (element) =>
            element.roomSub()?.roomType == RoomType.group &&
            roomDb.getRoomSync(element.roomSub()?.roomId ?? '')?.firstOtherInRoom?.account?.isOfficial != true,
      )
    ];
  }

  List<RoomDataModel> getOARooms() {
    return [
      ...roomDataList.where(
        (element) =>
            element.roomSub()?.roomType == RoomType.direct &&
            roomDb.getRoomSync(element.roomSub()?.roomId ?? '')?.firstOtherInRoom?.account?.isOfficial == true,
      ),
    ];
  }

  List<RoomDataModel> getRoomListChatCategoryTimeLastest({required ChatCategoryType? chatCategoryType}) {
    List<RoomDataModel> roomList;
    switch (chatCategoryType) {
      case ChatCategoryType.all:
        roomList = roomDataList;
        break;
      case ChatCategoryType.friend:
        roomList = getFriendRooms();
        break;
      case ChatCategoryType.group:
        roomList = getGroupRooms();
        break;
      case ChatCategoryType.oa:
        roomList = getOARooms();
        break;
      default:
        roomList = roomDataList;
        break;
    }
    List<RoomDataModel> roomListPinned = roomList.where((e) => e.roomSub()?.isPinned == true).toList();
    List<RoomDataModel> roomListNoPinned = roomList.where((e) => e.roomSub()?.isPinned != true).toList();

    return [...roomListPinned, ...roomListNoPinned];
  }

  List<RoomDataModel> getRoomListChatCategoryTimeOldest({required ChatCategoryType? chatCategoryType}) {
    List<RoomDataModel> roomList;

    switch (chatCategoryType) {
      case ChatCategoryType.friend:
        roomList = getFriendRooms();
        break;
      case ChatCategoryType.group:
        roomList = getGroupRooms();
        break;
      case ChatCategoryType.oa:
        roomList = getOARooms();
        break;
      case ChatCategoryType.all:
      default:
        roomList = roomDataList;
        break;
    }

    List<RoomDataModel> roomListPinned = roomList.where((e) => e.roomSub()?.isPinned == true).toList().toList();
    List<RoomDataModel> roomListNoPinned = roomList.where((e) => e.roomSub()?.isPinned != true).toList().toList();

    return [...roomListPinned, ...roomListNoPinned];
  }

  List<RoomDataModel> getRoomListChatCategoryNameASC({required ChatCategoryType? chatCategoryType}) {
    List<RoomDataModel> roomList;

    switch (chatCategoryType) {
      case ChatCategoryType.friend:
        roomList = getFriendRooms();
        break;
      case ChatCategoryType.group:
        roomList = getGroupRooms();
        break;
      case ChatCategoryType.oa:
        roomList = getOARooms();
        break;
      case ChatCategoryType.all:
      default:
        roomList = roomDataList;
        break;
    }

    List<RoomDataModel> roomListPinned = roomList.where((e) => e.roomSub()?.isPinned == true).toList();
    List<RoomDataModel> roomListNoPinned = roomList.where((e) => e.roomSub()?.isPinned != true).toList();

    return [...roomListPinned, ...roomListNoPinned];
  }

  List<RoomDataModel> getRoomListChatCategoryNameDESC({required ChatCategoryType? chatCategoryType}) {
    List<RoomDataModel> roomList;

    switch (chatCategoryType) {
      case ChatCategoryType.friend:
        roomList = getFriendRooms();
        break;
      case ChatCategoryType.group:
        roomList = getGroupRooms();
        break;
      case ChatCategoryType.oa:
        roomList = getOARooms();
        break;
      case ChatCategoryType.all:
      default:
        roomList = roomDataList;
        break;
    }

    List<RoomDataModel> roomListPinned = roomList.where((e) => e.roomSub()?.isPinned == true).toList();
    List<RoomDataModel> roomListNoPinned = roomList.where((e) => e.roomSub()?.isPinned != true).toList();

    return [...roomListPinned, ...roomListNoPinned];
  }

  List<RoomDataModel> getRoomListChatCategoryUnread({required ChatCategoryType? chatCategoryType}) {
    List<RoomDataModel> roomList;

    switch (chatCategoryType) {
      case ChatCategoryType.friend:
        roomList = getFriendRooms();
        break;
      case ChatCategoryType.group:
        roomList = getGroupRooms();
        break;
      case ChatCategoryType.oa:
        roomList = getOARooms();
        break;
      case ChatCategoryType.all:
      default:
        roomList = roomDataList;
        break;
    }

    List<RoomDataModel> roomListPinned = roomList.where((e) => e.roomSub()?.isPinned == true).toList();
    List<RoomDataModel> roomListNoPinned = roomList.where((e) => e.roomSub()?.isPinned != true).toList();

    return [...roomListPinned, ...roomListNoPinned];
  }

  // TODO unused function. remove ?
  void deleteRoomToState(RoomCollection room) {
    try {
      final deleteIndex = roomDataList.indexWhere((element) => element.id == room.id);
      roomDataList.removeAt(deleteIndex);
    } catch (_) {}
  }

  int get allUnreadCount {
    return roomDataList
        .map((element) => element.roomSub.value)
        .fold(0, (value, sub) => value + (sub?.unreadCount ?? 0));
  }

  void handleDesktopCreateChat() {
    if (!isMobile) {
      Get.back();
      UChatDialog.showCustomDialog<void, CreateChatController>(
        init: CreateChatController(selectCreateType: 'Chats'),
        child: (_) => const CreateChatScreen(),
      );
    } else {
      Get.toNamed(
        Routes.roomsCreate,
        parameters: <String, String>{'selectCreate': 'Chats'},
      );
    }
  }

  void handleCreateGroupChat() async {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickCreateGroup);
    if (!isMobile) {
      Get.back();
      UChatDialog.showCustomDialog<void, SelectMemberController>(
        init: SelectMemberController(),
        child: (_) => const SelectMemberScreen(),
      );
    } else {
      Get.toNamed(Routes.groupCreate);
    }
  }

  void handleDesktopSecretChat() {
    if (!isMobile) {
      Get.back();
      UChatDialog.showCustomDialog<void, CreateChatController>(
        init: CreateChatController(selectCreateType: 'SecretChat'),
        child: (_) => const CreateChatScreen(),
      );
    } else {
      Get.toNamed(
        Routes.roomsCreate,
        parameters: <String, String>{'selectCreate': 'SecretChat'},
      );
    }
  }

  void handleCreateChat() {
    showUChatModalTopSheet(
      title: 'Create'.tr,
      menus: [
        UChatTopSheetItem(
          label: 'Chat'.tr,
          iconImage: 'assets/images/chat_icon.png',
          onPressed: () {
            Get.back();
            Get.toNamed(Routes.roomsCreate, parameters: <String, String>{'selectCreate': 'Chats'});
          },
        ),
        UChatTopSheetItem(
          label: 'Group'.tr,
          iconImage: 'assets/images/group_create_icon.png',
          onPressed: () {
            Get.back();
            Get.toNamed(Routes.groupCreate);
          },
        ),
        if (UserController.instance.enableSecretChat)
          UChatTopSheetItem(
            label: 'Secret Chat'.tr,
            iconImage: 'assets/images/secret_chat_icon.png',
            onPressed: () {
              Get.back();
              Get.toNamed(Routes.roomsCreate, parameters: <String, String>{'selectCreate': 'SecretChat'});
            },
          ),
      ],
    );
  }

  void handleEditChatRoom() {
    Get.back();
    Get.toNamed(Routes.roomsEdit);
  }

  void handleSelectRoom(RoomCollection room) {
    Get.toNamed(
      Routes.chatRoomDirect.replaceAll(':id', room.id!),
      arguments: ChatRoomArguments(room: room, fromPage: 'chatList'),
    );
  }

  void handlePinRoomChatFolder(RoomSubscriptionCollection roomSub) async {
    try {
      int maxPin = UserController.instance.maxPin;
      int countPinedRoomAllChat = await roomSubDb.countPinedRoomAllChat();
      int countPinedRoomInFolder = await roomSubDb.countPinedRoomInFolder();

      int userCurrentPinAmount = countPinedRoomAllChat + countPinedRoomInFolder;

      if (roomSub.isSecretRoom == false && roomSub.isPinned != true && userCurrentPinAmount >= maxPin) {
        return UChatDialog.showDialogPinLimit();
      }

      if (roomSub.isSecretRoom == true &&
          roomSub.isPinned != true &&
          roomDataList
                  .where((element) => element.roomSub()?.isPinned == true && element.roomSub()?.isSecretRoom == true)
                  .length >=
              maxPin) {
        return UChatDialog.showDialogPinLimit();
      }

      await UChatLoading.show(status: 'Updating...'.tr);

      // TODO (refactor clean) Change this to use case.
      final response = await GetIt.I<ChatRoomListServerRepository>().togglePinRoom(
        TogglePinRoomRequest(
          roomId: roomSub.roomId!,
          isPinned: !(roomSub.isPinned ?? false),
        ),
      );

      if (response != null) {
        final updateRoomSubData = RoomSubscriptionCollection(
          id: response.id,
          roomId: response.roomId,
          isPinned: response.isPinned,
        );
        await roomSubDb.putRoomSubscription(updateRoomSubData);
      }

      await UChatLoading.hide();
    } on ApiException catch (e, stackTrace) {
      if (roomSub.isSecretRoom && e.type == 'ERR_ROOM_SUBSCRIPTION_NOT_FOUND') {
        final updateRoomSubData = RoomSubscriptionCollection(
          id: roomSub.id,
          roomId: roomSub.roomId,
          isPinned: !(roomSub.isPinned ?? false),
        );
        final response = await roomSubDb.putRoomSubscription(updateRoomSubData);
        if (response != null) {
          eventBus.fire(
            RoomUpdateSubscriptionEvent(
              roomSubscription: response.toEntity(),
            ),
          );
        }
        await roomSubDb.putRoomSubscription(updateRoomSubData);
      } else if (e.type == 'ERR_PIN_LIMIT_EXCEEDED') {
        UChatDialog.showDialogPinLimit();
      } else {
        _log.e('handlePinRoomChatFolder ApiException error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e);
      }
    } catch (e, stackTrace) {
      handleException(e, onUnknownException: () async {
        _log.e('handlePinRoom error.', e, stackTrace);
        await UChatLoading.hide();
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
  }

  void handlePinRoom(RoomSubscriptionCollection roomSub) async {
    try {
      await UChatLoading.show(status: 'Updating...'.tr);

      await GetIt.I<TogglePinRoomUseCase>().call(TogglePinRoomRequest(
        roomId: roomSub.roomId!,
        isPinned: !(roomSub.isPinned ?? false),
      ));
      await UChatLoading.hide();
    } on ApiException catch (e, stackTrace) {
      await UChatLoading.hide();
      if (roomSub.isSecretRoom && e.type == 'ERR_ROOM_SUBSCRIPTION_NOT_FOUND') {
        final updateRoomSubData = RoomSubscriptionCollection(
          id: roomSub.id,
          roomId: roomSub.roomId,
          isPinned: !(roomSub.isPinned ?? false),
        );
        final response = await roomSubDb.putRoomSubscription(updateRoomSubData);
        if (response != null) {
          eventBus.fire(
            RoomUpdateSubscriptionEvent(
              roomSubscription: response.toEntity(),
            ),
          );
        }
        await roomSubDb.putRoomSubscription(updateRoomSubData);
      } else if (e.type == 'ERR_PIN_LIMIT_EXCEEDED') {
        UChatDialog.showDialogPinLimit();
      } else {
        _log.e('handlePinRoom ApiException error.', e, stackTrace);
        await UChatLoading.hide();
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: e,
        );
      }
    } on FailedHostLookupException catch (_) {
      await UChatLoading.hide();
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('handlePinRoom error.', e, stackTrace);
      await UChatLoading.hide();
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }

  void handleMuteRoom(RoomSubscriptionCollection roomSub) async {
    await UChatLoading.show(status: 'Updating...'.tr);

    try {
      final response = await GetIt.I<ToggleMuteRoomUseCase>().call(ToggleMuteRoomParams(
        roomId: roomSub.roomId!,
        isMuted: !(roomSub.isMuted ?? false),
      ));
      if (response == true && roomSub.isSecretRoom) handleHideMessageSecretChatNotifications(roomSub);
      await UChatLoading.hide();
    } on FailedHostLookupException catch (_) {
      await UChatLoading.hide();
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('handleMuteRoom error.', e, stackTrace);
      await UChatLoading.hide();
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }

  void handleReadRoom(RoomSubscriptionCollection roomSub) async {
    await UChatLoading.show(status: 'Updating...'.tr);

    try {
      await GetIt.I<TriggerReadMessageUseCase>().call(TriggerReadMessageParams(
        roomId: roomSub.roomId!,
        seenMessageAt: DateTime.now(),
      ));
      await UChatLoading.hide();
    } catch (e) {
      await UChatLoading.hide();
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }

  Future<void> handleHideMessageSecretChatNotifications(RoomSubscriptionCollection roomSub) async {
    try {
      ToggleHideMessageNotificationRequest req = ToggleHideMessageNotificationRequest(
        roomId: roomSub.roomId!,
        isHideMessageNotification: false,
      );

      await GetIt.I<ChatRoomListServerRepository>().toggleHideMessageNotification(req);
    } on ApiException catch (e, stackTrace) {
      _log.e('handleHideMessageSecretChatNotifications ApiException error, $e', e, stackTrace);

      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e,
      );
    } catch (e, stackTrace) {
      handleException(e, onUnknownException: () {
        _log.e('handleHideMessageSecretChatNotifications error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
  }

  Future<void> showDialogDeleteChat(RoomCollection room, {bool isGoBackTwoTimes = false}) async {
    if (UChatCallController.instance.roomIsCalling(room.id)) {
      ActionUnavailableDialog.show();
      return;
    }
    UChatNewDialog.showConfirmDeleteChatDialog(
      context: Get.context!,
      onConfirm: () async {
        if (isGoBackTwoTimes) {
          Get.close(2);
        }
        AppToast.hideToast(Get.context!);
        // change state to close slidable panel before delete room
        eventBus.fire(CloseSlidablePanelEvent(
          forceClosePanel: true,
          duration: const Duration(milliseconds: 250),
        ));

        if (deleteCountdownRoomId != null) {
          //NOTE.if user delete a lot of chat room the older chat room will be clear message in local by don't need to wait BE
          await GetIt.I<DeleteAllMessageInRoomUseCase>().call(deleteCountdownRoomId!);
        }

        deleteCountdownRoomId = room.id;

        try {
          await GetIt.I<DeleteRoomWithCountdownUseCase>().call(
            DeleteRoomWithCountdownParams(
                roomId: deleteCountdownRoomId!,
                function: () {
                  deleteCountdownRoomId = null;
                }),
          );
          // Reset open action pane id after delete is completed. to prevent this room's action pane from reopening when
          // undo delete or when room is recreated after other send message to this room.
          openActionPaneId.value = null;
          GetIt.I<TaxonomyService>().sendEvent(EventName.clickDelete);
        } on FailedHostLookupException catch (e, stackTrace) {
          useLogger().d('showDialogDeleteChat failed, no internet.', e, stackTrace);
          UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
        } catch (e, stackTrace) {
          useLogger().e('showDialogDeleteChat error.', e, stackTrace);
          UChatNewDialog.showGeneralErrorDialog(
            context: Get.context!,
            e: e is Exception ? e : null,
          );
        }
      },
    );
  }

  void forceDeleteRoomWhenChangePage() async {
    if (deleteCountdownRoomId == null) return;

    try {
      //NOTE.if state delete room take too long time in FE site will be delete message in local first
      await GetIt.I<DeleteAllMessageInRoomUseCase>().call(deleteCountdownRoomId!);

      AppToast.hideToast(Get.context!);

      await GetIt.I<DeleteRoomWithCountdownUseCase>().call(DeleteRoomWithCountdownParams(
        roomId: deleteCountdownRoomId!,
        forceDelete: true,
      ));
    } catch (e) {
      deleteCountdownRoomId = null;
    }

    deleteCountdownRoomId = null;
  }

  Future<void> handleDeleteRoom(
    RoomCollection room, {
    bool shouldShowDialog = true,
    bool shouldShowLoading = true,
  }) async {
    try {
      final roomId = room.id;
      if (roomId == null) return;

      if (shouldShowDialog) {
        final result = room.isBookmark
            ? await UChatDialog.showDeleteBookmarkChatDialog()
            : await UChatDialog.showDeleteChatDialog();

        if (!result) return;
      }
      if (shouldShowLoading) {
        await UChatLoading.show(status: 'Deleting...'.tr);
      }

      await GetIt.I<DeleteAllMessageInRoomUseCase>().call(roomId);

      if (room.isSecretRoom) {
        final roomSub = await roomSubDb.getRoomSubscriptionWithRoomId(roomId);
        final expireStatus = calculateSecretChatExpireStatus(
          now: DateTime.now(),
          expireAt: room.expireAt ?? DateTime.now(),
        );

        if (expireStatus == SecretChatExpireStatus.expired && roomSub != null) {
          roomSub.isRoomDeleted = true;
          await roomSubDb.putRoomSubscription(roomSub);
        } else if (expireStatus != SecretChatExpireStatus.expired) {
          await GetIt.I<DeleteRoomUseCase>().call(room);
        }
      } else {
        await GetIt.I<DeleteRoomUseCase>().call(room);
      }

      // When delete group,
      // keep room in local db.
      if (!(room.isGroup || room.isSecretRoom || room.isBookmark)) {
        await roomDb.deleteRoom(roomId);
        await GetIt.I<MessageDb>().deleteBookmarkMessagesByOriginalRoomId(roomId: roomId);
      }
      // Remove all room file data from this room
      await GetIt.I<RoomFileDb>().deleteAllFileInRoom(roomId);
      if (shouldShowLoading) {
        await UChatLoading.success(message: 'Deleted'.tr);
      }

      if (room.isBookmark) {
        handleUpdateAllBookmarkMessageIdToNull();
        await BookmarkTagDb().clearCollection();
      } else {
        await GetIt.I<RemoveReactionsByRoomIdUseCase>().call(
          RemoveReactionsByRoomIdRequest(
            roomId: roomId,
          ),
        );

        final bookmarkMsgCount = await GetIt.I<MessageDb>().getAllBookmarkMessagesCount();

        if (bookmarkMsgCount == 0) {
          final bookmarkRoom = await roomDb.getBookmarkRoom();
          final bookmarkRoomSub = await roomSubDb.getRoomSubscriptionWithRoomId(bookmarkRoom?.id ?? '');

          if (bookmarkRoomSub != null) {
            bookmarkRoomSub.lastMessage = null;
            await roomSubDb.putRoomSubscription(bookmarkRoomSub, replaceData: true);
          }
        }
      }
    } catch (e, stackTrace) {
      handleException(e, onUnknownException: () async {
        _log.e('handleDeleteRoom error.', e, stackTrace);
        await UChatLoading.hide();
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
  }

  /// When remove bookmark chat room
  /// update all of messages that [bookmarkMessageId] isn't null to null
  Future<void> handleUpdateAllBookmarkMessageIdToNull() async {
    final originalMsgs = await GetIt.I<MessageDb>().getAllOriginalMessagesOfBookmark();

    for (final message in originalMsgs) {
      message.bookmarkMessageId = '';
      await GetIt.I<MessageDb>().putMessage(message);
    }
  }

  void showDialogHideChat(RoomSubscriptionCollection roomSub) {
    if (UChatCallController.instance.roomIsCalling(roomSub.roomId)) {
      ActionUnavailableDialog.show();
      return;
    }

    UChatNewDialog.showDialog(
      context: Get.context!,
      title: 'Hide this chat'.tr,
      description: 'Hiding a chat will not delete its messages. They stay accessible when unhidden.'.tr,
      cancelText: 'Cancel'.tr,
      confirmText: 'Hide'.tr,
      confirmTextColor: Get.context!.theme.appColors.textPrimary,
      cancelTextColor: Get.context!.theme.appColors.textLight,
      onConfirm: () {
        handleHideChat(roomSub);
      },
    );
  }

  void handleHideChat(RoomSubscriptionCollection roomSub) async {
    try {
      await UChatLoading.show(status: 'Updating...'.tr);

      await GetIt.I<ToggleHideRoomUseCase>().call(ToggleHideRoomRequest(roomId: roomSub.roomId!, isHidden: true));

      await UChatLoading.hide();
    } catch (e, stackTrace) {
      _log.e('handleHideChat error.', e, stackTrace);

      handleException(e, onUnknownException: () async {
        await UChatLoading.hide();
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: e is Exception ? e : null,
        );
      });
    }
  }

  Future<void> handleUnBlock(RoomCollection room) async {
    if (room.firstOtherInRoom == null || room.firstOtherInRoom?.account == null) return;
    final otherInRoomId = room.firstOtherInRoom!.account!.id!;

    UChatLoading.show(status: 'Updating...'.tr);

    try {
      await GetIt.I<UnblockContactUseCase>().call(
        UnblockContactParams(contactIds: [otherInRoomId]),
      );
      await UChatLoading.hide();
    } on FailedHostLookupException catch (_) {
      await UChatLoading.hide();
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('handleUnBlock error.', e, stackTrace);
      await UChatLoading.hide();
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }

  void showDialogBlockUser(RoomCollection room) {
    if (UChatCallController.instance.roomIsCalling(room.id)) {
      ActionUnavailableDialog.show();
      return;
    }

    if (room.firstOtherInRoom == null || room.firstOtherInRoom?.account == null) return;
    final otherInRoomName = room.firstOtherInRoom?.account?.displayName;

    UChatNewDialog.showDialog(
      context: Get.context!,
      title: 'Block ‘@userDisplayName‘?'.trParams({
        'userDisplayName': otherInRoomName ?? '',
      }),
      description:
          'This account will no longer be able to contact you on UChat.\n\nTo unblock this account, go to: Settings > Friends > Blocked Accounts.'
              .tr,
      cancelText: 'Cancel'.tr,
      confirmText: 'Block'.tr,
      confirmTextColor: Get.context!.theme.appColors.textError,
      cancelTextColor: Get.context!.theme.appColors.textLight,
      onConfirm: () {
        handleBlockUser(room);
      },
    );
  }

  void handleBlockUser(RoomCollection room) async {
    final otherInRoomId = room.firstOtherInRoom!.account!.id!;

    await UChatLoading.show(status: 'Updating...'.tr);

    try {
      await GetIt.I<BlockContactUseCase>().call(
        BlockContactParams(contactIds: [otherInRoomId]),
      );
      await UChatLoading.hide();
    } on FailedHostLookupException catch (_) {
      await UChatLoading.hide();
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('handleBlockUser error.', e, stackTrace);
      await UChatLoading.hide();
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }

  void showDialogLeaveGroup(RoomCollection room) async {
    GetIt.I<IChatRoomUtils>().showLeaveGroupDialogWithoutTransferOwner(room.toEntity());
  }

  Future<void> toggleHasFailedMessage(
    String roomId,
    bool hasFailedMessage,
  ) async {
    try {
      final int roomIndex = roomDataList.indexWhere(
        (element) => element.id == roomId,
      );

      if (roomIndex != -1) {
        RoomCollection? updatedRoom = await roomDb.getRoom(roomId);
        if (updatedRoom != null) {
          updatedRoom.hasFailedMessage = hasFailedMessage;
          roomDataList.elementAt(roomIndex).room.value?.update(updatedRoom);
          roomDataList.elementAt(roomIndex).room.refresh();
          await roomDb.putRoom(updatedRoom);
        }
      }
    } catch (e, stackTrace) {
      _log.e('Call toggleHasFailedMessage error.', e, stackTrace);
    }
  }

  void updateAllRoomsLastSeen() async {
    try {
      await GetIt.I<GetAllRoomLastSeenUseCase>().call(
        GetAllRoomLastSeenParams(
          onRoomUpdateEvent: (roomUpdateEvent) => eventBus.fire(roomUpdateEvent),
          onUpdateOnlineStatus: (roomCollection) {
            // Guard: Check if controller is still registered before updating
            // Reference: UCHAT3-27698
            if (Get.isRegistered<ChatListController>()) {
              ChatListController.instance.updateOnlineStatus(roomCollection);
            }
          },
        ),
      );
    } catch (e, stackTrace) {
      _log.e('updateAllRoomsLastSeen error : $e', e, stackTrace);
    }

    // Put all online room in RoomsController state.
    final onlineRoomList = await roomDb.getRoomTypeGroup();
    if (onlineRoomList == null) {
      return;
    }
    final now = DateTime.now();
    for (final room in onlineRoomList) {
      if (room.latestLastSeenAt != null) {
        final timeDiff = now.difference(room.latestLastSeenAt!);
        if (timeDiff.inSeconds <= UChatConstant.secondsInOnlineStatus) {
          updateOnlineStatus(room);
        }
      }
    }
  }

  void handleSelectCheckbox(RoomSubscriptionCollection roomSub) {
    if (isEditChat() && roomSub.isBookmark) return;
    roomEditController.handleSelectCheckbox(roomSub);
  }

  ConnectivityController get connectivityCtl => ConnectivityController.instance;

  void handleEditChatRoomNew() {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickEditChatlist);
    Get.toNamed(Routes.newEditRoom);
  }

  /// Handle long press chat list item
  ///
  /// Show dialog with options:
  /// - Mark as read
  /// - Mute/Unmute
  /// - Hide
  /// - Delete
  Future<void> onLongPressChatListItem(RoomCollection room) async {
    GetIt.I<TaxonomyService>().sendEvent(EventName.longpressChatlist);
    final roomData = roomDataList.firstWhereOrNull((element) => element.id == room.id);
    if (roomData == null) return;

    if (roomData.roomSub.value == null) return;

    final isMuted = roomData.roomSub.value?.isMuted == true;

    await ChatRoomHoldAndScrollDialog.show(
      room,
      [
        MenuListItem(
            text: 'Mark as read'.tr,
            suffixIcon: Assets.vectors.iconRead.svg(),
            onTap: () {
              Get.back();
              GetIt.I<TaxonomyService>().sendEvent(EventName.longpressActionChatlist,
                  eventProperties: EventProperty.longPressActionChatList('mark as read'));
              handleReadRoom(roomData.roomSub.value!);
            }),
        MenuListItem(
          text: isMuted ? 'Unmute'.tr : 'Mute'.tr,
          suffixIcon: isMuted ? Assets.vectors.iconUnmuted.svg() : Assets.vectors.iconMuted.svg(),
          onTap: () {
            Get.back();
            GetIt.I<TaxonomyService>().sendEvent(EventName.longpressActionChatlist,
                eventProperties: EventProperty.longPressActionChatList(isMuted ? 'unmute' : 'mute'));
            handleMuteRoom(roomData.roomSub.value!);
          },
        ),
        MenuListItem(
          text: 'Hide'.tr,
          suffixIcon: Assets.vectors.iconHide.svg(),
          onTap: () {
            Get.back();
            GetIt.I<TaxonomyService>().sendEvent(EventName.longpressActionChatlist,
                eventProperties: EventProperty.longPressActionChatList('hide'));
            showDialogHideChat(roomData.roomSub.value!);
          },
        ),
        MenuListItem(
          text: 'Delete'.tr,
          textColor: Get.context!.theme.appColors.textError,
          suffixIcon: Assets.vectors.trash.svg(
            color: Get.context!.theme.appColors.iconError,
          ),
          onTap: () {
            Get.back();
            showDialogDeleteChat(room);
          },
        ),
      ],
    );
  }

  void onActionPaneOpenChanged(String? itemId, bool isOpen) {
    if (isOpen) {
      GetIt.I<TaxonomyService>().sendEvent(EventName.swipeChatlistpage);
    }
    if (isOpen) {
      openActionPaneId.value = itemId;
    } else if (openActionPaneId.value == itemId) {
      openActionPaneId.value = null;
    }
  }

  /// For temporary use with 'ChatFolder' feature
  /// TODO: [ChatFolder] Remove this when real feature is go live
  void handleManageChatFolder() {
    Get.back();
    chatFolderController.getChatFoldersFromLocal();
    Get.toNamed(Routes.chatFolder);
  }
}
