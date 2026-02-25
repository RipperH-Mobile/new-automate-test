import 'dart:async';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:uchat/controllers/connectivity_controller.dart';
import 'package:uchat/controllers/permission_controller.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/entities/enum/call_method_type.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/call/data/models/models/room_call_model.dart';
import 'package:uchat/features/call/domain/params/start_call_param.dart';
import 'package:uchat/features/call/domain/user_cases/start_call_use_case.dart';
import 'package:uchat/features/call/livekit/parent/uchat_livekit_controller.dart';
import 'package:uchat/features/call/presentation/views/widgets/dialogs/action_unavailable_dialog.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/call_log/domain/entities/call_log_with_contact_entity.dart';
import 'package:uchat/features/call_log/domain/use_cases/search_call_logs_with_contact_use_case.dart';
import 'package:uchat/features/call_log/domain/use_cases/search_local_call_logs_with_contact_use_case.dart';
import 'package:uchat/features/call_log/presentation/utils/call_log_tracer.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/open_direct_chat_request.dart';
import 'package:uchat/features/chat_room/domain/use_cases/open_direct_chat_and_save_to_db_use_case.dart';
import 'package:uchat/features/chat_room_list/data/models/contact_search_result_model.dart';
import 'package:uchat/features/chat_room_list/data/models/recent_search_model.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/search/chat_list_search_use_case.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/features/profile/service/profile_service.dart';
import 'package:uchat/utils/get_room_id_from_contact_or_chat_helper.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class CallLogSearchScreenController extends GetxController with GetSingleTickerProviderStateMixin {
  static const _debounceTag = 'search-debouncer';
  static const pageSize = 50;

  final searchController = TextEditingController();
  final searchInputFocus = FocusNode();

  final keyword = ''.obs;
  final recentList = <RecentSearchModel>[].obs;

  final contactPreviewList = <ContactSearchResultModel>[].obs;

  final ScrollController scrollController = ScrollController();

  StreamSubscription<List<RoomCollection>>? recentSearchSubs;
  ChatListSearchUseCase useCase = GetIt.I<ChatListSearchUseCase>();

  /// For the "Friends" tab, filter items that have a contact.
  List<ContactSearchResultModel> get friendSection =>
      contactPreviewList.where((item) => item.contact != null && !(item.contact?.isOfficial ?? false)).toList();

  /// For the "Groups" tab, filter items that contain a room.
  List<ContactSearchResultModel> get groupSection => contactPreviewList.where((item) => item.room != null).toList();

  /// Merges friendSection + groupSection and sorts them by name alphabetically.
  List<ContactSearchResultModel> get contactSection {
    // Combine both lists
    final combined = <ContactSearchResultModel>[];
    combined.addAll(friendSection);
    combined.addAll(groupSection);

    // Sort by the contact's displayName or the room's roomName
    combined.sort(
      (a, b) {
        final aName = (a.contact?.showName ?? a.contact?.displayName ?? a.room?.roomName ?? '').toLowerCase();
        final bName = (b.contact?.showName ?? b.contact?.displayName ?? b.room?.roomName ?? '').toLowerCase();
        return aName.compareTo(bName);
      },
    );

    return combined;
  }

  // Rx variables for call logs & pagination.
  final callLogs = <CallLogWithContactEntity>[].obs;
  final currentPage = 1.obs;
  final total = 0.obs;
  final isLoading = false.obs;
  final hasMore = true.obs;

  final isRecentLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onSearchScroll);
    recentSearchSubs = roomDb.getLatestSearchQuery()?.watch(fireImmediately: true).listen((rooms) async {
      isRecentLoading.value = true;
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
        final roomId = room.id;
        if (roomId == null) continue;
        final contact = await useCase.getRoomContract(roomId);
        newRecentList.add(RecentSearchModel(room: room, contact: contact));
      }

      // Update the RxList atomically to reduce UI blinking.
      recentList.assignAll(newRecentList);
      isRecentLoading.value = false;
    });
  }

  @override
  void onReady() {
    // Request focus once the widget is built.
    searchInputFocus.requestFocus();
    super.onReady();
  }

  @override
  void onClose() {
    recentSearchSubs?.cancel();
    searchController.dispose();
    searchInputFocus.dispose();
    scrollController.removeListener(_onSearchScroll);
    scrollController.dispose();
    EasyDebounce.cancel(_debounceTag);
    super.onClose();
  }

  ConnectivityController get connectivityCtl => ConnectivityController.instance;

  void _onSearchScroll() {
    if (!scrollController.hasClients) return;
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      loadMore();
    }
  }

  Future<void> loadMore() async {
    if (keyword.value.trim().isEmpty || !hasMore.value || isLoading.value) {
      return;
    }

    currentPage.value++;
    await searchCallLogs();
  }

  void _clearSearchResults() {
    keyword.value = '';
    contactPreviewList.clear();
    callLogs.clear();
    isLoading.value = false;
    currentPage.value = 1;
    hasMore.value = true;
    EasyDebounce.cancel(_debounceTag);
  }

  Future<void> handleSearch(String searchText) async {
    if (searchText.trim().isEmpty) {
      // If search text is empty, clear results and return.
      _clearSearchResults();
      return;
    }
    keyword.value = searchText;

    EasyDebounce.debounce(
      _debounceTag,
      const Duration(milliseconds: 200),
      () async {
        currentPage.value = 1;
        hasMore.value = true;

        await CallLogTracer.trace(
          name: CallLogTraceNames.searchContacts,
          initialAttributes: {
            CallLogAttributeNames.searchKeyword: keyword.value,
          },
          body: (trace) async {
            final searchStopwatch = Stopwatch()..start();

            final searchContractResult = await useCase.fetchContacts(
              keyword.value,
              includePhoneNumber: true,
            );

            contactPreviewList.value = searchContractResult;

            searchStopwatch.stop();

            trace.incrementMetric(CallLogMetricNames.contactSearchDuration, searchStopwatch.elapsedMilliseconds);
            trace.incrementMetric(CallLogMetricNames.contactSearchResultsCount, searchContractResult.length);
          },
        );
        await searchLocalCallLogs();
        await searchCallLogs();
      },
    );
  }

  Future<void> searchLocalCallLogs() async {
    final localResults = await GetIt.I<SearchLocalCallLogsWithContactUseCase>().call(
      SearchLocalCallLogsWithContactUseCaseParams(
        keyword: keyword.value,
        limit: pageSize,
      ),
    );

    callLogs.value = localResults;
  }

  Future<void> searchCallLogs() async {
    if (isLoading.value) {
      return;
    }
    if (!hasMore.value) {
      return;
    }

    isLoading.value = true;

    await CallLogTracer.trace(
      name: CallLogTraceNames.searchCallLogs,
      initialAttributes: {
        CallLogAttributeNames.searchKeyword: keyword.value,
        CallLogAttributeNames.searchPage: currentPage.value.toString(),
      },
      body: (trace) async {
        final hasLocalResults = callLogs.isNotEmpty;

        try {
          final searchStopwatch = Stopwatch()..start();
          final callLogResponse = await GetIt.I<SearchCallLogsWithContactUseCase>().call(
            SearchCallLogsWithContactUseCaseParams(
              keyword: keyword.value,
              page: currentPage.value,
              pageSize: pageSize,
            ),
          );

          searchStopwatch.stop();

          total.value = callLogResponse.total;

          final serverResults = callLogResponse.data?.toList() ?? [];
          if (currentPage.value == 1) {
            callLogs.assignAll(serverResults);
          } else {
            callLogs.addAll(serverResults);
          }

          if (currentPage.value >= callLogResponse.totalPages) {
            hasMore.value = false;
          }

          trace.incrementMetric(CallLogMetricNames.searchDuration, searchStopwatch.elapsedMilliseconds);
          trace.incrementMetric(CallLogMetricNames.searchResultsCount, callLogResponse.data?.length ?? 0);
        } on FailedHostLookupException catch (_) {
          if (!hasLocalResults) {
            UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
          }
        } catch (e, stackTrace) {
          _log.e('searchCallLogs error in CallLogSearchScreenController.', e, stackTrace);
          if (!hasLocalResults) {
            UChatNewDialog.showGeneralErrorDialog(
              context: Get.context!,
              e: e is Exception ? e : null,
            );
          }
        } finally {
          isLoading.value = false;
        }
      },
    );
  }

  Future<void> handleCall(BuildContext context, CallLogWithContactEntity callLogModel) async {
    // Check call in progress
    if (UserController.instance.currentUser()?.isCalling == true) {
      ActionUnavailableDialog.show();
      return;
    }

    // Determine the call method based on callType from the model.
    final callMethod =
        callLogModel.callType.value.toUpperCase() == 'VIDEO' ? CallMethodType.video : CallMethodType.voice;
    final contact = callLogModel.contact;

    final confirmed = await UChatNewDialog.showDialog(
      context: context,
      title: 'Start @callType call'.trParams({
        'callType': callLogModel.callType.value.toLowerCase(),
      }),
      description: 'Are you sure you want to start a @callType call with @displayName?'.trParams({
        'callType': callLogModel.callType.value.toLowerCase(),
        'displayName': callLogModel.contact?.displayName ?? 'Unknown'.tr,
      }),
      cancelText: 'Cancel'.tr,
      confirmText: 'Call'.tr,
      confirmTextColor: context.theme.appColors.textPrimary,
      cancelTextColor: context.theme.appColors.textLight,
      isDestructive: true,
    );

    if (confirmed != true) {
      return;
    }

    // Check permissions (mic/camera)
    final passPerms = await checkPermissionBeforeCall(context, callMethod);
    if (!passPerms) return;

    // Check isDeletedUser
    if (contact?.isDeleted == true) {
      if (callLogModel.roomType == RoomType.group) {
        await checkIsInGroup(context, callLogModel);
        return;
      }
      await checkIsDeletedUser(context, callLogModel);
      return;
    }

    // Check isBlockedUser
    if (contact?.isBlocked == true) {
      await checkIsBlockedUser(context, callLogModel);
      return;
    }

    // Collect to recent search
    RoomCollection? room;
    if (callLogModel.roomType == RoomType.direct) {
      final friendId = callLogModel.contact?.id;
      if (friendId != null) {
        // Try local DB first
        final localRoomId = await roomMemberDb.getDirectRoomIdByOtherIdInRoom(friendId);
        room = await roomDb.getRoom(localRoomId ?? '');
        // If not found, create it from server
        if (room == null) {
          final roomEntity = await GetIt.I<OpenDirectChatAndSaveToDbUseCase>().call(
            OpenDirectChatRequest(friendAccountId: friendId),
          );
          if (roomEntity != null) {
            room = RoomCollection.fromEntity(roomEntity);
          }
        }
      }
    } else {
      final groupRoomId = callLogModel.roomId;
      if (groupRoomId.isNotEmpty) {
        room = await roomDb.getRoom(groupRoomId);
      }
    }

    // If room is found, add it to recent search
    if (room != null) {
      await useCase.addRecentSearch(room);
    }
    // Build image URL safely – fall back to empty string when IDs are missing.
    final String imageUrl;
    if (callLogModel.roomType == RoomType.group) {
      final photoId = callLogModel.room?.photoId;
      imageUrl = photoId != null ? FileService.instance.getFileUrl(photoId) : '';
    } else {
      final avatarId = contact?.avatarId;
      imageUrl = avatarId != null ? FileService.instance.getAvatarUrl(avatarId) : '';
    }

    final callData = RoomCallModel(
      imageBlurHash: callLogModel.room?.photoBlurhash,
      roomCallId: '',
      liveKitRoomSID: '',
      callState: CallState.idle,
      roomId: callLogModel.roomId,
      callType: callLogModel.callType,
      roomType: callLogModel.roomType,
      title: contact?.displayName,
      imageUrl: imageUrl,
      liveKitToken: '',
      callConnectionType:
          callLogModel.roomType == RoomType.group ? CallConnectionType.startGroup : CallConnectionType.start,
    );
    final param = StartCallParam(
      callData: callData,
    );
    await GetIt.I<StartCallUseCase>().call(param);
  }

  Future<void> handleContactCall(
    BuildContext context,
    ContactSearchResultModel item,
    bool isVideo,
  ) async {
    // Check call in progress
    if (UserController.instance.currentUser()?.isCalling == true) {
      ActionUnavailableDialog.show();
      return;
    }

    final callMethod = isVideo ? CallMethodType.video : CallMethodType.voice;

    final displayName = item.contact?.displayName ?? item.room?.roomName ?? 'Unknown';

    final callTypeStr = isVideo ? 'video' : 'voice';

    final confirmed = await UChatNewDialog.showDialog(
      context: context,
      title: 'Start @callType call'.trParams({
        'callType': callTypeStr,
      }),
      description: 'Are you sure you want to start a @callType call with @displayName?'.trParams({
        'callType': callTypeStr,
        'displayName': displayName,
      }),
      cancelText: 'Cancel'.tr,
      confirmText: 'Call'.tr,
      confirmTextColor: context.theme.appColors.textPrimary,
      cancelTextColor: context.theme.appColors.textLight,
      isDestructive: true,
    );

    if (confirmed != true) return;

    // Check permissions (mic/camera)
    final passPerms = await checkPermissionBeforeCall(context, callMethod);
    if (!passPerms) return;

    if (item.contact != null) {
      if (item.contact!.isDeleted) {
        await checkIsDeletedUserForContact(context, item.contact!, callTypeStr);
        return;
      }
      if (item.contact!.isBlocked) {
        await checkIsBlockedUserForContact(context, item.contact!, callTypeStr);
        return;
      }
    }

    RoomCollection? room;
    if (item.contact != null) {
      final contactId = item.contact!.id;
      if (contactId != null) {
        // Try local DB first
        final localRoomId = await roomMemberDb.getDirectRoomIdByOtherIdInRoom(contactId);
        room = await roomDb.getRoom(localRoomId ?? '');
        // If not found, create it from server
        if (room == null) {
          final roomEntity = await GetIt.I<OpenDirectChatAndSaveToDbUseCase>().call(
            OpenDirectChatRequest(friendAccountId: contactId),
          );

          if (roomEntity != null) {
            room = RoomCollection.fromEntity(roomEntity);
          }
        }
      }
    } else if (item.room != null) {
      room = await roomDb.getRoom(item.room!.id ?? '');
    }

    // If room is found, add it to recent search
    if (room != null) {
      await useCase.addRecentSearch(room);
      final param = StartCallParam(
        callData: RoomCallModel.generateDirectCall(
          room,
          isVideo ? CallType.video : CallType.voice,
        ),
      );
      if (isVideo) {
        GetIt.I<TaxonomyService>()
            .sendEvent(EventName.clickVideoCall, eventProperties: EventProperty.clickVideoCall('search result'));
      } else {
        GetIt.I<TaxonomyService>()
            .sendEvent(EventName.clickVoiceCall, eventProperties: EventProperty.clickVoiceCall('search result'));
      }
      await GetIt.I<StartCallUseCase>().call(param);
    }
  }

  Future<bool> checkPermissionBeforeCall(BuildContext context, CallMethodType callType) async {
    // For non-macOS devices, check permissions.
    if (!GetPlatform.isMacOS) {
      // Microphone permission
      bool micGranted = await PermissionController.instance.requestMicrophonePermissionDirect(context);
      if (!micGranted) {
        return false;
      }

      // Camera permission (for video calls)
      if (callType.isVideo) {
        bool cameraGranted = await PermissionController.instance.requestCameraPermissionDirect(context);
        if (!cameraGranted) {
          return false;
        }
      }
    }

    return true;
  }

  Future<void> checkIsInGroup(BuildContext context, CallLogWithContactEntity callLogModel) async {
    return UChatNewDialog.showSingleButtonDialog(
      context: context,
      title: 'Cannot Start @callType Call'.trParams({
        'callType': callLogModel.callType.value.capitalizeFirst ?? '',
      }),
      description: "You can't start a @callType call with \n@displayName because you are \nnot a member.".trParams({
        'callType': callLogModel.callType.value.toLowerCase(),
        'displayName': callLogModel.contact?.displayName ?? 'Unknown'.tr,
      }),
      confirmText: 'Got it'.tr,
      confirmTextColor: context.theme.appColors.textPrimary,
      isDestructive: true,
      onConfirm: () async {
        Get.back();
      },
    );
  }

  Future<void> checkIsDeletedUser(BuildContext context, CallLogWithContactEntity callLogModel) async {
    return UChatNewDialog.showSingleButtonDialog(
      context: context,
      title: 'Cannot Start @callType Call'.trParams({
        'callType': callLogModel.callType.value.capitalizeFirst ?? '',
      }),
      description:
          "You can't start a @callType call with \n@displayName because their account \nhas been deleted".trParams({
        'callType': callLogModel.callType.value.toLowerCase(),
        'displayName': callLogModel.contact?.displayName ?? 'Unknown'.tr,
      }),
      confirmText: 'Got it'.tr,
      confirmTextColor: context.theme.appColors.textPrimary,
      isDestructive: true,
      onConfirm: () async {
        Get.back();
      },
    );
  }

  Future<void> checkIsBlockedUser(BuildContext context, CallLogWithContactEntity callLogModel) async {
    return UChatNewDialog.showSingleButtonDialog(
      context: context,
      title: 'Cannot Start @callType Call'.trParams({
        'callType': callLogModel.callType.value.capitalizeFirst ?? '',
      }),
      description:
          "You can't start a @callType call with \n@displayName because their account \nhas been blocked".trParams({
        'callType': callLogModel.callType.value.toLowerCase(),
        'displayName': callLogModel.contact?.displayName ?? 'Unknown'.tr,
      }),
      confirmText: 'Got it'.tr,
      confirmTextColor: context.theme.appColors.textPrimary,
      isDestructive: true,
      onConfirm: () async {
        Get.back();
      },
    );
  }

  Future<void> checkIsInGroupForContact(BuildContext context, RoomCollection room, String callTypeStr) async {
    return UChatNewDialog.showSingleButtonDialog(
      context: context,
      title: 'Cannot Start @callType Call'.trParams({
        'callType': callTypeStr.capitalizeFirst ?? '',
      }),
      description: "You can't start a @callType call with \n@displayName because you are \nnot a member.".trParams({
        'callType': callTypeStr,
        'displayName': room.roomName ?? 'Unknown',
      }),
      confirmText: 'Got it'.tr,
      confirmTextColor: context.theme.appColors.textPrimary,
      isDestructive: true,
      onConfirm: () async {
        Get.back();
      },
    );
  }

  Future<void> checkIsDeletedUserForContact(
    BuildContext context,
    ContactCollection contact,
    String callTypeStr,
  ) async {
    return UChatNewDialog.showSingleButtonDialog(
      context: context,
      title: 'Cannot Start @callType Call'.trParams({
        'callType': callTypeStr.capitalizeFirst ?? '',
      }),
      description:
          "You can't start a @callType call with \n@displayName because their account \nhas been deleted".trParams({
        'callType': callTypeStr,
        'displayName': contact.displayName ?? 'Unknown',
      }),
      confirmText: 'Got it'.tr,
      confirmTextColor: context.theme.appColors.textPrimary,
      isDestructive: true,
    );
  }

  Future<void> checkIsBlockedUserForContact(
    BuildContext context,
    ContactCollection contact,
    String callTypeStr,
  ) async {
    return UChatNewDialog.showSingleButtonDialog(
      context: context,
      title: 'Cannot Start @callType Call'.trParams({
        'callType': callTypeStr.capitalizeFirst ?? '',
      }),
      description:
          "You can't start a @callType call with \n@displayName because their account \nhas been blocked".trParams({
        'callType': callTypeStr,
        'displayName': contact.displayName ?? 'Unknown',
      }),
      confirmText: 'Got it'.tr,
      confirmTextColor: context.theme.appColors.textPrimary,
      isDestructive: true,
    );
  }

  void handleSelectRecentItem(RecentSearchModel recentItem) async {
    // Open the room profile.
    await _openRoomProfile(recentItem, addToRecent: true);
  }

  Future<void> _openRoomProfile(RecentSearchModel item, {bool addToRecent = false}) async {
    if (addToRecent) {
      await useCase.addRecentSearch(item.room);
    }

    if (item.room.isGroup) {
      final roomId = item.room.id;
      if (roomId == null) return;
      await GetIt.I<ProfileService>().openGroupProfile(
        roomId: roomId,
      );
    } else {
      final contactId = item.contact.id;
      if (contactId == null) return;
      await GetIt.I<ProfileService>().openProfileScreen(contactId: contactId);
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
}
