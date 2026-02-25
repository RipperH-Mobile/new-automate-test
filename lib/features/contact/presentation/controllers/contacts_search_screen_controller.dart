import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:uchat/controllers/connectivity_controller.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/entities/interfaces/contact_interface.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/call/presentation/views/widgets/dialogs/action_unavailable_dialog.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/open_direct_chat_request.dart';
import 'package:uchat/features/chat_room/domain/use_cases/open_direct_chat_and_save_to_db_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/params/leave_group_params.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/leave_group_use_case.dart';
import 'package:uchat/features/chat_room_list/data/models/contact_search_result_model.dart';
import 'package:uchat/features/chat_room_list/data/models/recent_search_model.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/search/chat_list_search_use_case.dart';
import 'package:uchat/features/contact/data/models/requests/hide_contact_request.dart';
import 'package:uchat/features/contact/domain/params/block_contact_params.dart';
import 'package:uchat/features/contact/domain/use_cases/block_contact_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/hide_contact_use_case.dart';
import 'package:uchat/features/profile/service/profile_service.dart';
import 'package:uchat/utils/get_room_id_from_contact_or_chat_helper.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class ContactsSearchScreenController extends GetxController with GetSingleTickerProviderStateMixin {
  final searchController = TextEditingController();
  final searchInputFocus = FocusNode();

  final keyword = ''.obs;
  final recentList = <RecentSearchModel>[].obs;

  final contactPreviewList = <ContactSearchResultModel>[].obs;

  late TabController searchTabController;
  final currentTabIndex = 0.obs;
  final ScrollController scrollController = ScrollController();

  StreamSubscription<List<RoomCollection>>? recentSearchSubs;
  ChatListSearchUseCase useCase = GetIt.I<ChatListSearchUseCase>();

  // Store the current navigation future to prevent re-entrance.
  Future<void>? _navigationFuture;

  @override
  void onInit() async {
    searchTabController = TabController(length: 4, vsync: this);
    searchTabController.addListener(() {
      currentTabIndex.value = searchTabController.index;
    });

    recentSearchSubs = roomDb.getLatestSearchQuery()?.watch(fireImmediately: true).listen((rooms) async {
      // Sort rooms by latestSearch descending (newest first)
      rooms.sort((a, b) {
        if (a.latestSearch == null && b.latestSearch == null) return 0;
        if (a.latestSearch == null) return 1;
        if (b.latestSearch == null) return -1;
        return b.latestSearch!.compareTo(a.latestSearch!);
      });

      // Build the new recent search list in one go
      final newRecentList = <RecentSearchModel>[];
      for (var room in rooms) {
        final contact = await useCase.getRoomContract(room.id!);
        newRecentList.add(RecentSearchModel(room: room, contact: contact));
      }

      // Update the RxList atomically to reduce UI blinking.
      recentList.assignAll(newRecentList);
    });

    super.onInit();
  }

  @override
  void onReady() {
    // Request focus once the widget is built.
    searchInputFocus.requestFocus();
    super.onReady();
  }

  @override
  void onClose() {
    searchTabController.dispose();
    scrollController.dispose();

    super.onClose();
  }

  // A helper function to run a navigation and prevent re-entrance.
  Future<void> _runNavigation(Future<void> Function() navigationFunction) async {
    if (_navigationFuture != null) {
      // A navigation is already in progress; ignore new taps.
      return;
    }
    _navigationFuture = navigationFunction();
    try {
      await _navigationFuture;
    } finally {
      // Once navigation is complete, allow new taps.
      _navigationFuture = null;
    }
  }

  ConnectivityController get connectivityCtl => ConnectivityController.instance;

  Future<void> handleSearch(String searchText) async {
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.searchingContact,
      eventProperties: EventProperty.searchingUChatIdAddFriendPage(
        searchInput: searchText,
      ),
    );
    keyword(searchText);
    final searchContractResult = await useCase.fetchContacts(keyword.value);

    // clear old data and show loading ui immediately to prevent user from tapping old data
    contactPreviewList.clear();

    // don't use [...friendSearched, ...officialAccountSearched, ...roomSearched] because performance issue
    contactPreviewList.addAll(searchContractResult);
  }

  void handleClearSearch() {
    searchController.clear();
    keyword('');
  }

  void onSelectContact(ContactInterface contact) async {
    _runNavigation(() async {
      // TODO (refactor clean) Move this logic to use case
      String? id = await roomMemberDb.getDirectRoomIdByOtherIdInRoom(contact.id ?? '');
      RoomCollection? room = await roomDb.getRoom(id ?? '');
      // If room in local db is not found, Get it from server.
      if (room == null) {
        final roomEntity = await GetIt.I<OpenDirectChatAndSaveToDbUseCase>().call(
          OpenDirectChatRequest(friendAccountId: contact.id!),
        );
        if (roomEntity != null) {
          room = RoomCollection.fromEntity(roomEntity);
        }
      }
      final contactId = contact.id;
      if (room != null && contactId != null) {
        useCase.addRecentSearch(room);
        GetIt.I<ProfileService>().openProfileScreen(
          contactId: contactId,
        );
      } else {
        _log.w('room with first other account id $contactId not found');
      }
    });
  }

  void onSelectedRoom(RoomCollection room) async {
    _runNavigation(() async {
      await useCase.addRecentSearch(room);

      final roomId = room.id;
      if (roomId != null) {
        await GetIt.I<ProfileService>().openGroupProfile(
          roomId: roomId,
        );
      }
    });
  }

  void handleSelectRecentItem(RecentSearchModel recentItem) async {
    if (recentItem.room.isGroup) {
      // Open the room profile.
      onSelectedRoom(recentItem.room);
    } else {
      onSelectContact(recentItem.contact);
    }
  }

  Future<void> removeRecentSearch(RecentSearchModel recentItem) async {
    recentList.remove(recentItem);
    await useCase.removeRecentSearch(recentItem);
  }

  Future<void> handleClearRecentSearch() async {
    UChatNewDialog.showDialog(
      context: Get.context!,
      title: 'Clear recent searches'.tr,
      description: 'Clear all recent search records.'.tr,
      cancelText: 'Cancel'.tr,
      confirmText: 'Clear'.tr,
      confirmTextColor: Get.context!.theme.appColors.textPrimary,
      cancelTextColor: Get.context!.theme.appColors.textLight,
      isDestructive: true,
      onConfirm: () async {
        await useCase.clearRecentSearch();
        recentList.clear();
      },
    );
  }

  void handleHideContact(ContactInterface contact) async {
    List<String> accountIdList = [contact.id!];

    await UChatNewDialog.showDialog(
      context: Get.context!,
      title: 'Hide this account'.tr,
      description: 'Hiding an account will not delete its messages. They stay accessible when unhidden.'.tr,
      cancelText: 'Cancel'.tr,
      confirmText: 'Hide'.tr,
      confirmTextColor: Get.context!.theme.appColors.textPrimary,
      cancelTextColor: Get.context!.theme.appColors.textLight,
      isDestructive: true,
      onConfirm: () async {
        try {
          await GetIt.I<HideContactUseCase>().call(
            HideContactRequest(
              friendAccountIds: accountIdList,
            ),
          );
          // Remove the hidden contact from the list.
          contactPreviewList.removeWhere((item) => item.contact?.id == contact.id);
        } on ApiException catch (e, stackTrace) {
          if (e.type == 'ERR_EVENT_UNAVAILABLE_DURING_CALL') {
            await ActionUnavailableDialog.show();
          } else {
            _log.e('ApiException handle hide contact error.', e, stackTrace);
            UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e);
          }
        } on FailedHostLookupException catch (_) {
          UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
        } catch (e, stackTrace) {
          _log.e('handle hide contact error.', e, stackTrace);
          UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
        }
      },
    );
  }

  void handleBlockUser(ContactInterface contact) async {
    List<String> accountIdList = [contact.id!];

    final isConfirmed = await UChatNewDialog.showDialog(
      context: Get.context!,
      title: "Block '@userDisplayName'?".trParams({
        'userDisplayName': contact.displayName ?? '',
      }),
      description:
          'This account will no longer be able to contact you on UChat. \n \nTo unblock this account, go to: Settings > Friends > Blocked Accounts.'
              .tr,
      cancelText: 'Cancel'.tr,
      confirmText: 'Block'.tr,
      confirmTextColor: Get.context!.theme.appColors.textError,
      cancelTextColor: Get.context!.theme.appColors.textLight,
      isDestructive: true,
      onConfirm: () async {
        try {
          await GetIt.I<BlockContactUseCase>().call(
            BlockContactParams(
              contactIds: accountIdList,
            ),
          );

          // Remove the blocked contact from the list.
          contactPreviewList.removeWhere((item) => item.contact?.id == contact.id);
        } on ApiException catch (e, stackTrace) {
          if (e.type == 'ERR_EVENT_UNAVAILABLE_DURING_CALL') {
            await ActionUnavailableDialog.show();
          } else {
            _log.e('ApiException handle block contact error.', e, stackTrace);
            UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e);
          }
        } on FailedHostLookupException catch (_) {
          UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
        } catch (e, stackTrace) {
          _log.e('handle block contact error.', e, stackTrace);
          UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
        }
      },
    );
    if (!isConfirmed) return;
  }

  void handleLeaveGroup(RoomCollection room) async {
    await UChatNewDialog.showDialog(
      context: Get.context!,
      title: 'Leave this group'.tr,
      description: 'Leaving this group will remove access to the member list and chat history.'.tr,
      cancelText: 'Cancel'.tr,
      confirmText: 'Leave'.tr,
      confirmTextColor: Get.context!.theme.appColors.textError,
      cancelTextColor: Get.context!.theme.appColors.textLight,
      isDestructive: true,
      onConfirm: () async {
        try {
          await GetIt.I<LeaveGroupUseCase>().call(LeaveGroupParams(
            roomId: room.id ?? '',
            onRoomDeleted: (roomId) {
              eventBus.fire(RoomDeleteEvent(roomId: roomId));
            },
          ));

          contactPreviewList.removeWhere((item) => item.room?.id == room.id);
        } on ApiException catch (e, stackTrace) {
          if (e.type == 'ERR_EVENT_UNAVAILABLE_DURING_CALL') {
            await ActionUnavailableDialog.show();
            return;
          } else {
            _log.e('handleLeaveGroup ApiException error.', e, stackTrace);
            UChatNewDialog.showGeneralErrorDialog(
              context: Get.context!,
              e: e,
            );
          }
        } on FailedHostLookupException catch (_) {
          UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
        } catch (e, stackTrace) {
          _log.e('handleLeaveGroup error.', e, stackTrace);
          UChatNewDialog.showGeneralErrorDialog(
            context: Get.context!,
            e: e is Exception ? e : null,
          );
        }
      },
    );
  }

  /// For the "Friends" tab, filter items that have a contact.
  List<ContactSearchResultModel> get friendSection =>
      contactPreviewList.where((item) => item.contact != null && !(item.contact?.isOfficial ?? false)).toList();

  /// For the "Groups" tab, filter items that contain a room.
  List<ContactSearchResultModel> get groupSection => contactPreviewList.where((item) => item.room != null).toList();

  /// For the "Official Accounts" tab, filter items with a contact that is marked as official.
  List<ContactSearchResultModel> get officialAccountSection =>
      contactPreviewList.where((item) => item.contact != null && (item.contact?.isOfficial ?? false)).toList();
}
