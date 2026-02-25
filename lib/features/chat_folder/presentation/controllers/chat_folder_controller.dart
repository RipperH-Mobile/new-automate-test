import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/payloads.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/data/data_sources/account_service.dart';
import 'package:uchat/entities/enum/chat_sorting_type.dart';
import 'package:uchat/entities/enum/room_contact_type.dart';
import 'package:uchat/entities/models/chat_settings_model.dart';
import 'package:uchat/entities/models/room_contact_model.dart';
import 'package:uchat/entities/models/room_data_model.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_folder/data/models/payloads/pin_chat_room_in_folder.dart';
import 'package:uchat/features/chat_folder/data/models/payloads/update_chat_folder.dart';
import 'package:uchat/features/chat_folder/domain/repositories/chat_folder_local_repository.dart';
import 'package:uchat/features/chat_folder/domain/repositories/chat_folder_remote_repository.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_mapper_extensions.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/room_sub_local_repository.dart';
import 'package:uchat/features/chat_room_list/presentation/arguments/select_member_arguments.dart';
import 'package:uchat/features/chat_room_list/presentation/controllers/chat_list_controller.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

import '../../../chat_room/data/models/models/chat_folder_model.dart';
import '../../data/models/payloads/create_chat_folder.dart';
import '../../data/models/payloads/fetch_folders.dart';
import '../../domain/entities/chat_folder_entity.dart';
import '../../domain/enums/chat_folder_type.dart';
import '../../domain/events/chat_folder_create_event.dart';
import '../../domain/events/chat_folder_unread_update_event.dart';
import '../../domain/events/chat_folder_update_event.dart';
import '../../domain/events/chat_folder_update_room_sub_event.dart';
import '../arguments/chat_folder_edit_detail_arguments.dart';

final _log = useLogger();

/// The 'gb' is short term to 'GetBuilder'.
const gbChatFolderDefaultTabController = 'chat-folder-default-tab-controller';
const gbChatFolderTabBar = 'chat-folder-tab-bar';
const gbChatFolderTabBarItemPrefix = 'chat-folder-tab-bar-item-';
const gbChatFolderTabBarView = 'chat-folder-tab-bar-view';
const gbChatFolderList = 'chat-folder-list';
const gbChatFolderListHead = 'chat-folder-list-head';

const gbAll = [
  gbChatFolderTabBar,
  gbChatFolderTabBarView,
  gbChatFolderList,
  gbChatFolderListHead,
];

class ChatFolderController extends GetxController with GetTickerProviderStateMixin {
  static final instance = Get.find<ChatFolderController>();

  final isAllowManageFolder = true.obs;

  final sortingType = ChatSortingType.timeLastest.obs;

  final chatFolders = <ChatFolderEntity>[
    ChatFolderEntity(id: 'all', name: ChatFolderType.all.displayName, type: ChatFolderType.all, seq: 0),
  ];

  List<ScrollController> scrollControllers = [ScrollController()];
  int _prevChatFolderItemLength = 1;
  String _currentTabId = 'all';

  StreamSubscription? _userUpdateSubscription;
  StreamSubscription? _updateBlueDotEvent;
  StreamSubscription? _updateChatFolderEvent;
  StreamSubscription? _createChatFolderEvent;
  StreamSubscription? _updateChatFolderInRoomSubEvent;

  bool get isEnabled => UserController.instance.enableChatFolderV2;

  @override
  void onInit() {
    _userUpdateSubscription = eventBus.on<UserUpdateEvent>().listen((event) async {
      if (event.user.accountSettings?.chat?.chatFolder != isAllowManageFolder() &&
          event.user.accountSettings?.chat?.chatFolder != null) {
        isAllowManageFolder(event.user.accountSettings?.chat?.chatFolder);
      }
    });

    _updateBlueDotEvent = eventBus.on<ChatFolderUnreadUpdateEvent>().listen((event) async {
      updateUnread(event.receiveRoomSubscription);
    });

    _updateChatFolderEvent = eventBus.on<ChatFolderUpdateEvent>().listen((event) async {
      // print('ZZZ => Receipt updateChatFolderEvent: ${event.chatFolders}');
      final folders = event.chatFolders;
      for (final folder in folders) {
        if (folder.deleted == true) {
          await deleteChatFolderFromState(folder);
        } else {
          await addOrUpdateChatFolderToState(folder);
        }
      }

      sortChatFolders();
      updateDefaultTabController();
      update(gbAll);
      // print('ZZZ => Receipt2 updateChatFolderEvent: ${event.chatFolders}');
    });

    _createChatFolderEvent = eventBus.on<ChatFolderCreateEvent>().listen((event) async {
      // print('ZZZ => Receipt createChatFolderEvent: ${event.chatFolder.id}');
      final folder = event.chatFolder;
      await addOrUpdateChatFolderToState(folder);
      sortChatFolders();
      updateDefaultTabController();
      update(gbAll);
      // print('ZZZ => Receipt2 createChatFolderEvent: ${event.chatFolder.id}');
    });

    _updateChatFolderInRoomSubEvent = eventBus.on<ChatFolderUpdateRoomSubEvent>().listen((event) async {
      try {
        await getChatFoldersFromLocal();
        updateDefaultTabController();
        update(gbAll);
      } catch (e, stacktrace) {
        _log.e('updateChatFolderInRoomSubEvent error.', e, stacktrace);
      }
    });

    super.onInit();
  }

  @override
  Future<void> onClose() async {
    await _userUpdateSubscription?.cancel();
    await _updateBlueDotEvent?.cancel();
    await _updateChatFolderEvent?.cancel();
    await _createChatFolderEvent?.cancel();
    await _updateChatFolderInRoomSubEvent?.cancel();

    // print('onClose ChatFolderController');

    super.onClose();
  }

  void updateDefaultTabController() {
    final newChatFolderItemLength = chatFolders.length;

    // Scroll controllers section
    // Check if scrollControllers is less than current chatFolders length
    if (newChatFolderItemLength > scrollControllers.length) {
      // Add more scrollControllers
      for (int i = scrollControllers.length; i < newChatFolderItemLength; i++) {
        scrollControllers.add(ScrollController());
      }
    } else if (_prevChatFolderItemLength < scrollControllers.length) {
      for (int i = newChatFolderItemLength; i < scrollControllers.length; i++) {
        scrollControllers[i].dispose();
      }
      scrollControllers = scrollControllers.sublist(0, newChatFolderItemLength);
    }

    // Update default tab controller section
    if (_prevChatFolderItemLength != chatFolders.length) {
      update([gbChatFolderDefaultTabController]);
    }

    _prevChatFolderItemLength = chatFolders.length;
  }

  Future<void> initialTabChatFolderData() async {
    if (UserController.instance.currentUser.value == null) {
      return;
    }

    if (!isEnabled) {
      return;
    }

    await getChatFoldersFromLocal();
    if (chatFolders.length == 1) {
      await fetchChatFoldersFromRemote();
    }

    isAllowManageFolder(
      UserController.instance.currentUser()?.accountSettings?.chat?.chatFolder ?? false,
    );

    update(gbAll);
    updateDefaultTabController();
  }

  void handleToggleManageFolder(bool? value) async {
    try {
      if (value == null) return;
      await UChatLoading.show(status: 'Saving...'.tr);

      await AccountService().updateAccountSetting(
        UpdateAccountSettingRequest.create(
          chat: ChatSettingsModel(chatFolder: value),
        ),
      );
      isAllowManageFolder.value = value;

      await UChatLoading.success(message: 'Saved'.tr);
    } catch (e, stacktrace) {
      handleException(e, onUnknownException: () async {
        _log.e('handleToggleManageFolder error.', e, stacktrace);
        await UChatLoading.hide();
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
  }

  Future<void> onTapOnTabBar(int index) async {
    final folder = chatFolders[index];
    _currentTabId = folder.id;
    updateClearBlueDot(index);

    eventBus.fire(CloseSlidablePanelEvent());
  }

  final remainingRecommendedFolders = <ChatFolderType>[].obs;

  /// It is used to sort the remaining recommended folders
  /// Recommended folders that should be shown in the chat folder list
  /// Should not be changed
  final recommendedFolders = [
    ChatFolderType.unread,
    ChatFolderType.direct,
    ChatFolderType.group,
    ChatFolderType.oa,
  ];

  bool get showEditFolderListButton {
    return chatFolders.isNotEmpty && chatFolders.length > 1;
  }

  Future<void> addOrUpdateChatFolderToState(ChatFolderEntity cf) async {
    final updatedChatFolder = await GetIt.I<ChatFolderLocalRepository>().putOrUpdate(chatFolder: cf);

    if (chatFolders.contains(cf)) {
      final chatFolderIndex = chatFolders.indexWhere((element) => element.id == cf.id);
      if (chatFolderIndex == -1) return;

      chatFolders[chatFolderIndex] = cf.copyWith(
        roomSubscriptions: chatFolders[chatFolderIndex].roomSubscriptions,
        isUnread: chatFolders[chatFolderIndex].isUnread,
      );
    } else {
      chatFolders.add(updatedChatFolder);
    }

    if (cf.isRecommended == true) {
      if (remainingRecommendedFolders.contains(cf.type)) {
        remainingRecommendedFolders.remove(cf.type);
        sortRemainingRecommendedFolder();
        remainingRecommendedFolders.refresh();
      }
    }
  }

  Future<void> deleteChatFolderFromState(ChatFolderEntity cf) async {
    // print('ZZZ => deleteChatFolderFromState: ${cf.id}');
    await GetIt.I<ChatFolderLocalRepository>().delete(id: cf.id);
    chatFolders.removeWhere((element) => element.id == cf.id);

    if (cf.isRecommended == true) {
      if (!remainingRecommendedFolders.contains(cf.type)) {
        remainingRecommendedFolders.add(cf.type);
        sortRemainingRecommendedFolder();
        remainingRecommendedFolders.refresh();
      }
    }
  }

  void findRemainingRecommendedFolder() {
    final recommendedFolderInChatFolders = chatFolders.where((folder) {
      return folder.isRecommended == true;
    }).map((e) {
      return e.type;
    }).toList();

    remainingRecommendedFolders.clear();
    for (ChatFolderType f in recommendedFolders) {
      if (!recommendedFolderInChatFolders.contains(f)) {
        remainingRecommendedFolders.add(f);
      }
    }

    sortRemainingRecommendedFolder();
    remainingRecommendedFolders.refresh();
  }

  void sortRemainingRecommendedFolder() {
    remainingRecommendedFolders.sortLike(recommendedFolders);
  }

  void sortChatFolders() {
    chatFolders.sort((a, b) => a.seq.compareTo(b.seq));
  }

  Future<void> getChatFoldersFromLocal() async {
    try {
      final folders = await GetIt.I<ChatFolderLocalRepository>().getAll();
      chatFolders.assignAll([
        ChatFolderEntity(
          id: 'all',
          name: ChatFolderType.all.displayName,
          type: ChatFolderType.all,
          seq: 0,
          isUnread: false,
          isHidden: false,
        ),
        ...folders,
      ]);
      findRemainingRecommendedFolder();
      updateDefaultTabController();
      update([]);
    } catch (e, stacktrace) {
      _log.e('fetchChatFolders error.', e, stacktrace);
    }
  }

  // TODO: Can move to "Use case"?
  Future<void> fetchChatFoldersFromRemote() async {
    try {
      final folderResp = await GetIt.I<ChatFolderRemoteRepository>().fetchFolders(FetchFoldersParams());
      final folders = folderResp?.data?.toList() ?? [];

      for (final folder in folders) {
        final folderOnState = chatFolders.firstWhereOrNull((element) => element.id == folder.id);
        if (folderOnState == null && folder.deleted == false) {
          await addOrUpdateChatFolderToState(folder);
        } else {
          if (folder.deleted == true) {
            await deleteChatFolderFromState(folder);
          } else {
            await addOrUpdateChatFolderToState(folder);
          }
        }
      }

      for (final folder in chatFolders.where((element) => element.type != ChatFolderType.all)) {
        if (folders.indexWhere((element) => element.id == folder.id) == -1) {
          await deleteChatFolderFromState(folder);
        }
      }

      sortChatFolders();
      updateDefaultTabController();
    } catch (e, stacktrace) {
      _log.e('fetchChatFoldersFromServer error.', e, stacktrace);
    }
  }

  Future<void> handlerOpenCreateChatFolderScreen() async {
    final result = await showLimitDialog();
    if (result == false) {
      return;
    }
    Get.toNamed(Routes.chatFolderCreate);
  }

  Future<List<RoomContactModel>> handlerOpenAddChatFolderScreen({
    required ChatFolderEntity chatFolder,
    bool isFromScreen = false,
  }) async {
    final List<RoomContactModel> currentChatRooms = [];
    final roomSubscriptions = chatFolder.roomSubscriptions ?? [];

    for (final room in roomSubscriptions) {
      final temp = await GetIt.I<ChatRoomLocalRepository>().getRoom(room.roomId!);
      final roomCollection = temp?.toCollection();
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
        currentChatRooms.add(roomContact);
      }
    }
    final roomList = await Get.toNamed(
      Routes.groupCreate,
      arguments: SelectMemberArguments(
        isManageFolder: true,
        contactAndGroupList: currentChatRooms,
        fromRoomScreen: isFromScreen,
        chatFolderCollection: chatFolder,
      ),
    );
    return roomList;
  }

  Future<void> handleOpenChatFolderEditDetailScreen(ChatFolderEntity folder) async {
    Get.toNamed(
      Routes.chatFolderEditDetail.replaceFirst(':id', folder.id),
      arguments: ChatFolderEditDetailArguments(chatFolder: folder),
    );
  }

  Future<void> updateClearBlueDot(int index) async {
    // print('ZZZ => updateClearBlueDot: $index');
    if (index == -1) {
      return;
    }

    if (chatFolders[index].isUnread == false) {
      return;
    }

    chatFolders[index] = chatFolders[index].copyWith(isUnread: false);
    if (chatFolders[index].type != ChatFolderType.all) {
      await GetIt.I<ChatFolderLocalRepository>().putOrUpdate(chatFolder: chatFolders[index]);
    }

    update(['$gbChatFolderTabBarItemPrefix${chatFolders[index].id}']);
  }

  Future<void> updateShowBlueDot(int index) async {
    if (index == -1) {
      return;
    }
    // print('ZZZ => updateShowBlueDot: $index');
    if ((_currentTabId.isEmpty) || chatFolders[index].id == _currentTabId) {
      return;
    }

    if (chatFolders[index].isUnread == true) {
      // print('ZZZ => updateShowBlueDot: already true');
      return;
    }

    chatFolders[index] = chatFolders[index].copyWith(isUnread: true);
    if (chatFolders[index].type != ChatFolderType.all) {
      await GetIt.I<ChatFolderLocalRepository>().putOrUpdate(chatFolder: chatFolders[index]);
    }

    // print('ZZZ => updateShowBlueDot2: ${chatFolders[index]} => $gbChatFolderTabBarItemPrefix${chatFolders[index].id}');

    update(['$gbChatFolderTabBarItemPrefix${chatFolders[index].id}']);
  }

  Future<void> updateUnread(RoomSubscriptionCollection receiveRoomSubscription) async {
    // print('ZZZ => updateUnread: ${receiveRoomSubscription.roomId}');
    final tempRoom = await GetIt.I<ChatRoomLocalRepository>().getRoom(receiveRoomSubscription.roomId!);
    if (receiveRoomSubscription.unreadCount == 0) {
      return;
    }

    final room = tempRoom?.toCollection();

    final roomSub = await GetIt.I<RoomSubLocalRepository>().getRoomSubscriptionWithRoomId(
      receiveRoomSubscription.roomId!,
    );
    if (roomSub?.chatFolders != null) {
      for (final folder in roomSub!.chatFolders!) {
        final targetFolderIndex = chatFolders.indexWhere((cf) => cf.id == folder.folderId);
        if (targetFolderIndex == -1) {
          return;
        }
        updateShowBlueDot(targetFolderIndex);
      }
    }
    if (room?.isGroup == true) {
      final index = chatFolders.indexWhere((cf) => cf.type == ChatFolderType.group);
      await updateShowBlueDot(index);
    }
    if (room?.isDirect == true) {
      if (room?.firstOtherInRoom?.account?.isOfficial == true) {
        final index = chatFolders.indexWhere((cf) => cf.type == ChatFolderType.oa);
        await updateShowBlueDot(index);
      } else {
        final index = chatFolders.indexWhere((cf) => cf.type == ChatFolderType.direct);
        await updateShowBlueDot(index);
      }
    }
    final indexAll = chatFolders.indexWhere((cf) => cf.type == ChatFolderType.all);
    await updateShowBlueDot(indexAll);
    final indexUnread = chatFolders.indexWhere((cf) => cf.type == ChatFolderType.unread);
    await updateShowBlueDot(indexUnread);
  }

  Future<List<RoomSubscriptionCollection>> findRoomSub(List<RoomContactModel> rooms) async {
    final roomSubs = <RoomSubscriptionCollection>[];
    for (final room in rooms) {
      final roomSub = await GetIt.I<RoomSubLocalRepository>().getRoomSubscriptionWithRoomId(room.id!);
      if (roomSub != null) {
        roomSubs.add(RoomSubscriptionCollection.fromEntity(roomSub));
      }
    }
    return roomSubs;
  }

  Future<void> addChatFolderToRoomSub({
    required String chatFolderId,
    required List<RoomSubscriptionCollection> roomSubs,
  }) async {
    final futures = <Future>[];
    for (var roomSub in roomSubs) {
      futures.add(() async {
        roomSub.chatFolders ??= [];
        roomSub.chatFolders = roomSub.chatFolders?.toList();
        roomSub.chatFolders!.add(ChatFolderModel(folderId: chatFolderId));
        await GetIt.I<RoomSubscriptionDb>().putRoomSubscription(roomSub);
      }());
    }

    await Future.wait(futures);
  }

  Future<void> deleteChatFolderFromRoomSub({
    required String chatFolderId,
    required List<RoomSubscriptionCollection> roomSubs,
  }) async {
    final futures = <Future>[];
    for (var roomSub in roomSubs) {
      futures.add(() async {
        roomSub.chatFolders ??= [];
        roomSub.chatFolders = roomSub.chatFolders?.toList();
        roomSub.chatFolders!.removeWhere((element) => element.folderId == chatFolderId);
        await GetIt.I<RoomSubscriptionDb>().putRoomSubscription(roomSub);
      }());
    }

    await Future.wait(futures);
  }

  Future<void> addRecommendedFolder(ChatFolderType type) async {
    try {
      final result = await showLimitDialog();
      if (result == false) {
        return;
      }

      final response = await GetIt.I<ChatFolderRemoteRepository>().createFolder(CreateChatFolderParams(
        name: type.displayName,
        type: type,
        roomSubIds: [],
      ));
      if (response != null) {
        await addOrUpdateChatFolderToState(response.chatFolder);
        updateDefaultTabController();
        update(gbAll);
      }
    } catch (e, stacktrace) {
      handleException(e, onUnknownException: () async {
        _log.e('addRecommendedFolder error.', e, stacktrace);
        await UChatLoading.show();
        await initialTabChatFolderData();
        findRemainingRecommendedFolder();
        await UChatLoading.hide();
      });
    }
  }

  /// Create chat folder
  /// Return true if create success. Otherwise return false.
  Future<bool> createChatFolder({
    required String folderName,
    required ChatFolderType type,
    required List<RoomSubscriptionCollection> roomSubs,
  }) async {
    try {
      final roomSubIds = roomSubs.map((e) => e.id!).toList();

      final response = await GetIt.I<ChatFolderRemoteRepository>().createFolder(CreateChatFolderParams(
        name: folderName,
        type: type,
        roomSubIds: roomSubIds,
      ));
      if (response != null) {
        await addOrUpdateChatFolderToState(response.chatFolder);
      }

      return true;
    } catch (e, stacktrace) {
      handleException(e, onUnknownException: () {
        _log.e('createChatFolder error.', e, stacktrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });

      return false;
    }
  }

  Future<void> pinChatRoomInFolder({
    required bool? isPinned,
    required List<RoomSubscriptionCollection> roomSubs,
    required String chatFolderId,
    required List<RoomDataModel> roomDataList,
    required int index,
    required String folderId,
  }) async {
    try {
      final roomSub = roomDataList.elementAtOrNull(index)?.roomSub();

      if (roomSub == null) {
        return;
      }

      int maxPin = UserController.instance.maxPin;

      int countPinedRoomAllChat = await GetIt.I<RoomSubLocalRepository>().countPinedRoomAllChat();
      int countPinedRoomInFolder = await GetIt.I<RoomSubLocalRepository>().countPinedRoomInFolder();

      int userCurrentPinAmount = countPinedRoomAllChat + countPinedRoomInFolder;

      if (roomSub.chatFolders?.firstWhereOrNull((element) => element.folderId == folderId)?.isPinned != true &&
          userCurrentPinAmount >= maxPin) {
        return UChatDialog.showDialogPinLimit();
      }

      final roomSubIds = roomSubs.map((e) => e.id!).toList();
      final chatFolderRequest = PinChatRoomInFolderParams(
        roomSubIds: roomSubIds,
        chatFolderId: chatFolderId,
        isPinned: isPinned != null ? !isPinned : true,
      );

      await GetIt.I<ChatFolderRemoteRepository>().pinChatRoomInFolder(chatFolderRequest);
    } catch (e, stacktrace) {
      handleException(e, onUnknownException: () {
        _log.e('pinChatRoomInFolder error.', e, stacktrace);
        UChatDialog.showDialogPinLimit();
      });
    }
  }

  Future<void> updateChatFolderNormal({
    required ChatFolderEntity folder,
    required List<RoomContactModel> newRoomList,
    List<RoomContactModel> deletedRoomList = const [],
  }) async {
    final result = await Future.wait<List<RoomSubscriptionCollection>>([
      findRoomSub(newRoomList),
      findRoomSub(deletedRoomList),
    ]);

    final newRooms = result.firstOrNull ?? [];
    final deletedRooms = result.lastOrNull ?? [];

    await addOrUpdateChatFolderToState(folder);
    await addChatFolderToRoomSub(
      chatFolderId: folder.id,
      roomSubs: newRooms,
    );
    if (deletedRooms.isNotEmpty) {
      await deleteChatFolderFromRoomSub(
        chatFolderId: folder.id,
        roomSubs: deletedRooms,
      );
    }

    await updateChatFolderToServer(
      folder,
      newRooms,
      deletedRooms,
    );
  }

  Future<void> updateChatFolderToServer(
    ChatFolderEntity folder,
    List<RoomSubscriptionCollection> newRoomSubs,
    List<RoomSubscriptionCollection> deletedRoomSubs,
  ) async {
    try {
      final newRoomSubIds = newRoomSubs.map((e) => e.id ?? '').toList();
      final deletedRoomSubIds = deletedRoomSubs.map((e) => e.id ?? '').toList();
      newRoomSubIds.removeWhere((e) => e.isEmpty);
      deletedRoomSubIds.removeWhere((e) => e.isEmpty);

      final response = await GetIt.I<ChatFolderRemoteRepository>().updateFolder(UpdateChatFolderParams(
        chatFolderId: folder.id,
        name: folder.name,
        roomSubIds: newRoomSubIds,
        removeRoomSubIds: deletedRoomSubIds,
      ));

      if (response != null) {
        final folderResp = response.chatFolder;
        if (folderResp.deleted == true) {
          await deleteChatFolderFromState(folderResp);
        } else {
          await addOrUpdateChatFolderToState(folderResp);
        }
      }
    } catch (e, stackTrace) {
      handleException(e, onUnknownException: () {
        _log.e('updateChatFolderToServer error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
  }

  void handleOpenChatFolderEditListScreen() {
    Get.toNamed(Routes.chatFolderEditList);
  }

  Future<bool> showLimitDialog() async {
    if ((chatFolders.length - 1) >= UserController.instance.maxChatFolder) {
      await UChatDialog.showUpgradePremiumDialog();

      return false;
    } else {
      return true;
    }
  }

  void showLimitMemberDialog() {
    UChatDialog.showAlertDialog(
      title: 'Chat Attempt Limit.'.tr,
      description: 'You can add up to @limit chats.'.trParams({
        'limit': UserController.instance.maxRoomInChatFolder.toString(),
      }),
      buttonText: 'Got it'.tr,
      buttonColor: Colors.red.shade400,
    );
  }

  ///
  /// Below code is helper for calling [ChatListController] instance.
  /// vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

  ChatListController get chatListController {
    return ChatListController.instance;
  }
}
