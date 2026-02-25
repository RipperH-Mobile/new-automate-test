import 'dart:async';

import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/entities/enum/recent_search_type.dart';
import 'package:uchat/entities/interfaces/contact_interface.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/open_direct_chat_request.dart';
import 'package:uchat/features/chat_room/domain/params/chat_room_arguments.dart';
import 'package:uchat/features/chat_room/domain/use_cases/open_direct_chat_and_save_to_db_use_case.dart';
import 'package:uchat/features/chat_room_list/data/models/collection/recent_search_collection.dart';
import 'package:uchat/features/chat_room_list/data/models/contact_search_result_model.dart';
import 'package:uchat/features/chat_room_list/data/models/search_messages_result_model.dart';
import 'package:uchat/features/chat_room_list/domain/params/save_recent_search_result_param.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_list_search_local_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_list_search_server_repository.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/search/chat_list_search_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/search/save_recent_search_result_use_case.dart';
import 'package:uchat/features/chat_room_list/presentation/arguments/chat_search_messages_arguments.dart';
import 'package:uchat/features/chat_room_list/presentation/arguments/search_all_contact_result_argument.dart';
import 'package:uchat/features/chat_room_list/presentation/arguments/search_all_message_result_argument.dart';
import 'package:uchat/features/profile/domain/use_cases/get_room_by_account_id_use_case.dart';
import 'package:uchat/features/profile/service/profile_service.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/utils/get_room_id_from_contact_or_chat_helper.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class ChatSearchController extends GetxController {
  final searchController = TextEditingController();
  final scrollController = ScrollController();
  final searchInputFocus = FocusNode();

  final keyword = ''.obs;
  final recentList = <RecentSearchCollection>[].obs;

  final contactPreviewList = <ContactSearchResultModel>[].obs;
  final messagePreviewList = <SearchMessagesResultModel>[].obs;
  final allMessageCount = 0.obs;
  final isLoading = false.obs;

  ChatListSearchUseCase useCase = GetIt.I<ChatListSearchUseCase>();

  ChatListSearchServerRepository get chatListSearchServerRepository {
    return GetIt.I<ChatListSearchServerRepository>();
  }

  ChatListSearchLocalRepository get chatListSearchLocalRepository {
    return GetIt.I<ChatListSearchLocalRepository>();
  }

  @override
  void onInit() async {
    isLoading.value = true;
    searchInputFocus.requestFocus();
    await getRecentSearchResultList();
    isLoading.value = false;

    super.onInit();
  }

  @override
  onClose() {
    searchController.dispose();
    searchInputFocus.dispose();
  }

  void handleClearSearch() {
    searchController.clear();
    keyword('');
  }

  void handleSelectContact(ContactSearchResultModel contact) async {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickSearchResultChatlist);

    String? searchRoomId;
    if (contact.contact != null) {
      onSelectContact(contact.contact!);

      if (contact.contact?.id case final contactId?) {
        final room = await GetIt.I<GetRoomByAccountIdUseCase>().call(contactId);
        searchRoomId = room?.id;
      }
    } else if (contact.room != null) {
      onSelectedRoom(contact.room!);
      searchRoomId = contact.room?.id;
    }

    if (searchRoomId case final roomId?) {
      onSaveContactSearchResult(roomId);
    }
  }

  void onSelectedRoom(RoomCollection room) async {
    final roomId = room.id;

    if (roomId == null) {
      _log.w('room id is null');
      return;
    }

    await GetIt.I<ProfileService>().openGroupProfile(
      roomId: roomId,
    );
  }

  void onSelectContact(ContactInterface contact) async {
    // TODO (refactor clean) Move this logic to use case
    String? id = await roomMemberDb.getDirectRoomIdByOtherIdInRoom(contact.id ?? '');
    RoomCollection? room = await roomDb.getRoom(id ?? '');
    // If room in local db is not found, Get it from server.
    if (room == null) {
      try {
        final roomEntity = await GetIt.I<OpenDirectChatAndSaveToDbUseCase>().call(
          OpenDirectChatRequest(friendAccountId: contact.id!),
        );
        if (roomEntity != null) {
          room = RoomCollection.fromEntity(roomEntity);
        }
      } on ApiException catch (e) {
        _log.e('Failed to open direct chat: ${e.message}');
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
        return;
      }
    }
    final contactId = contact.id;
    if (room != null && contactId != null) {
      GetIt.I<ProfileService>().openProfileScreen(
        contactId: contactId,
      );
    } else {
      _log.w('room with first other account id $contactId not found');
    }
  }

  void handleSelectRecentItem(RecentSearchCollection recentItem) async {
    if (recentItem.type == RecentSearchType.search) {
      if (recentItem.keyword case final keyword?) {
        searchInputFocus.requestFocus();
        searchController.text = keyword;
        handleSearch(keyword, isOnSubmitted: true);
      }
    } else {
      final contact = ContactSearchResultModel(
        contact: recentItem.contact?.toCollection(),
        room: recentItem.room?.toCollection(),
      );

      handleSelectContact(contact);
    }
  }

  void handleSelectRoom(RoomCollection room) async {
    Get.toNamed(
      Routes.chatRoomDirect.replaceAll(':id', room.id!),
      arguments: ChatRoomArguments(room: room, fromPage: 'search'),
    );
  }

  void handleSelectMessage(SearchMessagesResultModel data) {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickSearchResultChatlist);

    Get.toNamed(
      Routes.universalSearchRoomMessages,
      arguments: ChatSearchMessagesArguments(
        keyword: keyword.value,
        searchResult: data,
      ),
    );

    onSaveKeywordSearchResult();
  }

  Future<void> removeRecentSearch(RecentSearchCollection recentItem) async {
    RecentSearchCollection? removedItem;
    int? removedIndex;

    try {
      GetIt.I<TaxonomyService>().sendEvent(
        EventName.clickClearSearchresult,
        eventProperties: EventProperty.clickClearSearchResult('contact list'),
      );

      if (recentItem.id case final id?) {
        removedIndex = recentList.indexWhere((e) => e.id == id);

        if (removedIndex != -1) {
          removedItem = recentList.removeAt(removedIndex);
          await chatListSearchServerRepository.removeRecentSearchResult(id);
          await chatListSearchLocalRepository.deleteRecentSearch(id);
        }
      }
    } catch (e, stackTrace) {
      _log.e('removeRecentSearch error.', e, stackTrace);

      if (removedIndex != null && removedItem != null) {
        recentList.insert(removedIndex, removedItem);
      }

      showRemoveHistoryErrorToast();
    }
  }

  void onClearAllRecentSearch(BuildContext context) {
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.clickClearSearchresult,
      eventProperties: EventProperty.clickClearSearchResult('clear all'),
    );

    UChatNewDialog.showDialog(
      context: context,
      title: 'Clear All Searches'.tr,
      description: 'Permanently delete all search history from this app'.tr,
      confirmText: 'Clear all'.tr,
      confirmTextColor: context.theme.appColors.textPrimary,
      onConfirm: () {
        handleClearRecentSearch();
      },
    );
  }

  Future<void> handleClearRecentSearch() async {
    final removedList = List<RecentSearchCollection>.from(recentList);

    try {
      recentList.clear();
      await chatListSearchServerRepository.clearAllRecentSearchResult();
      await chatListSearchLocalRepository.clearCollection();
    } catch (e, stackTrace) {
      _log.e('handleClearRecentSearch error.', e, stackTrace);

      recentList.value = removedList;
      showRemoveHistoryErrorToast();
    }
  }

  void showRemoveHistoryErrorToast() {
    AppToast.clearToast(Get.context!);
    AppToast.showToast(
      context: Get.context!,
      message: 'Couldn\'t remove search. Try again'.tr,
      icon: Assets.vectors.iconInfo.svg(),
      duration: const Duration(milliseconds: 1000),
    );
  }

  Future<void> handleSearch(String searchText, {bool isOnSubmitted = false}) async {
    if (searchText.length == 1) {
      GetIt.I<TaxonomyService>().sendEvent(EventName.searchingChatlistpage);
    }

    if (searchText.runes.length > UChatConstant.maxLengthForSearchExecution) {
      /// If the text length exceeds [UChatConstant.maxLengthForSearchExecution], then do nothing

      if (isOnSubmitted) {
        // This toast will shows when pressed submit button only
        EasyThrottle.throttle(
          'Search_limit_exceeded',
          const Duration(seconds: 3),
              () {
            AppToast.showToast(
              context: Get.context!,
              message: 'Search Limit Exceeded'.tr,
              subtitle: 'Please shorten your search to continue'.tr,
              icon: Assets.vectors.iconInfo.svg(),
            );
          },
        );

        /// Show “no result” even if the search finds matches.
        keyword(searchText);
        allMessageCount(0);
        messagePreviewList.clear();
        contactPreviewList.clear();
      }

      return;
    }

    keyword(searchText);
    final searchContractResult = await useCase.fetchContacts(keyword.value);

    /// To save [keyword] to search history
    if (isOnSubmitted) {
      onSaveKeywordSearchResult();
    }

    // clear old data and show loading ui immediately to prevent user from tapping old data
    allMessageCount(0);
    messagePreviewList.clear();
    contactPreviewList.clear();

    // don't use [...friendSearched, ...officialAccountSearched, ...roomSearched] because performance issue
    contactPreviewList.addAll(searchContractResult);

    final searchMessageResult = await useCase.fetchMessages(keyword.value);
    allMessageCount(searchMessageResult.count);
    messagePreviewList(searchMessageResult.result.toList());
  }

  void onSeeMoreSearchContactResult() {
    Get.toNamed(
      Routes.searchAllContactResult,
      arguments: SearchAllContactResultArgument(
        keyword: keyword.value,
        contactPreviewList: contactPreviewList,
      ),
    );
  }

  void onSeeMoreSearchMessageResult() {
    Get.toNamed(
      Routes.searchAllMessageResult,
      arguments: SearchAllMessageResultArgument(
        keyword: keyword.value,
        messagePreviewList: messagePreviewList,
        allMessageCount: allMessageCount.value,
      ),
    );
  }

  Future<void> getRecentSearchResultList() async {
    List<RecentSearchCollection> recentSearchList = [];

    try {
      final list = await chatListSearchServerRepository.getRecentSearchResult();
      recentSearchList = await GetIt.I<SaveRecentSearchResultUseCase>().call(list);
    } catch (e, stackTrace) {
      _log.w('getRecentSearchResultList error.', e, stackTrace);
      recentSearchList = (await chatListSearchLocalRepository.getAllRecentSearch()) ?? [];
    }

    recentList.value = recentSearchList;
  }

  void onSaveKeywordSearchResult() async {
    try {
      final newList = await chatListSearchServerRepository.saveRecentSearchResult(SaveRecentSearchResultParam(
        type: RecentSearchType.search.value,
        value: keyword.value,
      ));

      recentList.value = await GetIt.I<SaveRecentSearchResultUseCase>().call(newList);
    } catch (e, stackTrace) {
      _log.e('onSaveKeywordSearchResult error.', e, stackTrace);
    }
  }

  void onSaveContactSearchResult(String contactId) async {
    try {
      if (contactId.isEmpty) return;

      final newList = await chatListSearchServerRepository.saveRecentSearchResult(SaveRecentSearchResultParam(
        type: RecentSearchType.room.value,
        value: contactId,
      ));

      recentList.value = await GetIt.I<SaveRecentSearchResultUseCase>().call(newList);
    } catch (e, stackTrace) {
      _log.e('onSaveContactSearchResult error.', e, stackTrace);
    }
  }
}
