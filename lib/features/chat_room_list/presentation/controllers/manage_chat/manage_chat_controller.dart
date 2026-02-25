import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/entities/collections/chat_category_collection.dart';
import 'package:uchat/entities/collections/sorting_collection.dart';
import 'package:uchat/entities/enum/chat_category_type.dart';
import 'package:uchat/entities/enum/chat_sorting_type.dart';
import 'package:uchat/entities/models/chat_category_model.dart';
import 'package:uchat/entities/models/chat_settings_model.dart';
import 'package:uchat/entities/services/chat_category_db.dart';
import 'package:uchat/entities/services/sorting_db.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/toggle_chat_category_request.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list_actions/toggle_chat_category_use_case.dart';
import 'package:uchat/features/chat_room_list/presentation/controllers/chat_list_controller.dart';
import 'package:uchat/widgets/loading/loading.dart';

class ManageChatController extends GetxController with GetTickerProviderStateMixin {
  static ManageChatController get instance => Get.find<ManageChatController>();

  final roomDb = GetIt.I<RoomDb>();
  final _chatCategoryDb = ChatCategoryDb.instance;
  final _sortingDb = SortingDb.instance;

  ChatListController get chatListController => Get.find<ChatListController>();

  final initialChatCategories = <ChatCategoryModel>[
    ChatCategoryModel(name: 'All'.tr, type: ChatCategoryType.all, seq: 0),
    ChatCategoryModel(name: 'Friends'.tr, type: ChatCategoryType.friend, seq: 1),
    ChatCategoryModel(name: 'Groups'.tr, type: ChatCategoryType.group, seq: 2),
    ChatCategoryModel(name: 'Official Accounts'.tr, type: ChatCategoryType.oa, seq: 3),
  ].obs;

  final chatCategories = <ChatCategoryCollection>[].obs;

  late TabController tabController = TabController(
    initialIndex: 0,
    length: initialChatCategories.length,
    vsync: this,
  );
  final enableChatCategory = false.obs;

  final sortingType = ChatSortingType.timeLastest.obs;

  StreamSubscription? _userUpdateSub;
  StreamSubscription? _updateBlueDotEvent;

  @override
  void onInit() async {
    //NOTE. get enableChatCategory or not from event state
    _userUpdateSub = eventBus.on<UserUpdateEvent>().listen(
      (event) async {
        enableChatCategory(event.user.accountSettings?.chat?.showCategory);
      },
    );

    //NOTE. update blue dot when have new message
    _updateBlueDotEvent = eventBus.on<ChatCategoryUnreadUpdateEvent>().listen((event) async {
      updateUnread(event.receiveRoomSubscription);
    });

    super.onInit();
  }

  @override
  Future<void> onClose() async {
    await _userUpdateSub?.cancel();
    await _updateBlueDotEvent?.cancel();
    tabController.dispose();

    super.onClose();
  }

  ///
  /// Move from [onInit] to [initialize] to avoid calling on boot app and avoid guest user
  ///
  Future<void> initialize() async {
    // NOTE. get sorting type from Sorting LocalDB and if != null will be set to sortingType
    final sortingTypeLocalDB = await _sortingDb.getById(id: '0');
    if (sortingTypeLocalDB != null) {
      sortingType(sortingTypeLocalDB.type);
    }

    // NOTE. get enableChatCategory or not from server
    enableChatCategory(UserController.instance.currentUser()?.accountSettings?.chat?.showCategory ?? false);

    final chatCategoryLocalDb = await _chatCategoryDb.getAll();
    //NOTE. if chatCategoryLocalDb is empty will automatic put to localDB to avoid error case.
    if (chatCategoryLocalDb.isEmpty) {
      List<ChatCategoryCollection> chatCategoryCollections = initialChatCategories.map((model) {
        return ChatCategoryCollection(
          id: model.seq.toString(),
          type: model.type,
          isUnread: false,
        );
      }).toList();

      //NOTE. assignAll to can show in UI
      chatCategories.assignAll(chatCategoryCollections);

      _chatCategoryDb.putAll(chatCategoryCollections);
    } else {
      //NOTE. if already have localDB will assignAll to can show in UI
      chatCategories.assignAll(chatCategoryLocalDb);
    }
  }

  void toggleChatCategory(bool value) async {
    try {
      ToggleChatCategoryRequest req = ToggleChatCategoryRequest(chat: ChatSettingsModel(showCategory: value));

      final response = await GetIt.I<ToggleChatCategoryUseCase>().call(req);

      //NOTE. If enable will put in localDB and set isUnread is false
      if (response) {
        List<ChatCategoryCollection> chatCategoryCollections = initialChatCategories.map((model) {
          return ChatCategoryCollection(
            id: model.seq.toString(),
            type: model.type,
            isUnread: false,
          );
        }).toList();

        chatCategories.assignAll(chatCategoryCollections);
        _chatCategoryDb.putAll(chatCategoryCollections);
      }
      enableChatCategory(value);
      tabController.index = 0;
    } catch (e) {
      UChatLoading.hide();
    }
  }

  Future<void> updateUnread(RoomSubscriptionCollection receiveRoomSubscription) async {
    final room = await roomDb.getRoom(receiveRoomSubscription.roomId!);
    if (receiveRoomSubscription.unreadCount == 0) {
      return;
    }

    final int nowIndex = tabController.index;

    if (chatCategories.getOrNull(nowIndex) == null) {
      return;
    }

    //NOTE. blue dot group
    if (room?.isGroup == true && chatCategories[nowIndex].type != ChatCategoryType.group) {
      final group = chatCategories.firstWhereOrNull((item) => item.type == ChatCategoryType.group);

      if (group != null) {
        group.isUnread = true;
        chatCategories.refresh();
        await _chatCategoryDb.putOrUpdate(group);
      }
    }

    if (room?.isDirect == true) {
      if (room?.firstOtherInRoom?.account?.isOfficial == true && chatCategories[nowIndex].type != ChatCategoryType.oa) {
        //NOTE. blue dot oa
        final oa = chatCategories.firstWhereOrNull((item) => item.type == ChatCategoryType.oa);

        if (oa != null) {
          oa.isUnread = true;
          chatCategories.refresh();
          await _chatCategoryDb.putOrUpdate(oa);
        }
      } else if (chatCategories[nowIndex].type != ChatCategoryType.friend) {
        //NOTE. blue dot friend
        final friend = chatCategories.firstWhereOrNull((item) => item.type == ChatCategoryType.friend);

        if (friend != null) {
          friend.isUnread = true;
          chatCategories.refresh();
          await _chatCategoryDb.putOrUpdate(friend);
        }
      }
    }
    if (chatCategories[nowIndex].type != ChatCategoryType.all) {
      //NOTE. bluedot all
      final all = chatCategories.firstWhereOrNull((item) => item.type == ChatCategoryType.all);

      if (all != null) {
        all.isUnread = true;
        chatCategories.refresh();
        await _chatCategoryDb.putOrUpdate(all);
      }
    }
  }

  Future<void> onTapOnTabBar(int index) async {
    if (chatCategories.getOrNull(index) == null) {
      return;
    }
    
    if (chatCategories[index].isUnread == false) {
      return;
    }
    //NOTE. clear blue dot when click each tab
    chatCategories[index].isUnread = false;
    chatCategories.refresh();
    await _chatCategoryDb.putOrUpdate(chatCategories[index]);
  }

  void setSortingType(ChatSortingType chatSortingType) {
    //NOTE. if click to sorting will be put to localDB Sorting because when close and open app again will be the same setting sorting
    sortingType(chatSortingType);
    _sortingDb.putOrUpdate(SortingCollection(id: '0', type: chatSortingType));
    chatListController.sortedRoomList();
  }
}
