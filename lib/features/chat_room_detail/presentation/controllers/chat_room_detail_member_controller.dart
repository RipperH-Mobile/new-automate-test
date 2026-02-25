import 'dart:async';

import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/data/models/enums/api_exception_type.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/event_bus/events/assign_admin_event.dart';
import 'package:uchat/core/event_bus/events/revoke_admin_event.dart';
import 'package:uchat/core/event_bus/events/update_admin_permission_event.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/group_request_type.dart';
import 'package:uchat/features/add_contact/data/model/requested_list_request.dart';
import 'package:uchat/features/add_contact/domain/entities/add_contact_group_requested_entity.dart';
import 'package:uchat/features/add_contact/domain/events/update_group_member_request_event.dart';
import 'package:uchat/features/add_contact/domain/use_cases/approve_group_requested_use_case.dart';
import 'package:uchat/features/add_contact/domain/use_cases/get_group_requested_list_use_case.dart';
import 'package:uchat/features/add_contact/domain/use_cases/reject_group_requested_use_case.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/domain/chat_room_domain.dart';
import 'package:uchat/features/chat_room/domain/params/fetch_room_member_params.dart';
import 'package:uchat/features/chat_room/domain/use_cases/fetch_room_member_use_case.dart';
import 'package:uchat/features/chat_room_detail/data/models/models/room_waiting_list_model.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_room_detail_waiting_list_request.dart';
import 'package:uchat/features/chat_room_detail/domain/params/get_one_member_params.dart';
import 'package:uchat/features/chat_room_detail/domain/params/get_room_member_and_pending_list_params.dart';
import 'package:uchat/features/chat_room_detail/domain/params/leave_group_params.dart';
import 'package:uchat/features/chat_room_detail/domain/params/remove_member_from_chat_params.dart';
import 'package:uchat/features/chat_room_detail/domain/params/remove_pending_members_params.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/use_cases.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/room_members_argument.dart';
import 'package:uchat/features/chat_room_detail/presentation/helper/chat_room_helper.dart';
import 'package:uchat/features/chat_room_list/presentation/arguments/select_member_arguments.dart';
import 'package:uchat/features/profile/presentation/arguments/profile_arguments.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/features/profile/service/profile_service.dart';
import 'package:uchat/utils/extension/extension_getx.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class ChatRoomDetailMemberIds {
  static const String memberListViewId = 'chat_room_detail_member_list_view_id';
  static const String memberRequestListViewId = 'chat_room_detail_member_request_list_view_id';

  static String memberItemId(String accountId) => 'chat_room_detail_member_item_id_$accountId';
}

class ChatRoomDetailMemberController extends GetxController with GetSingleTickerProviderStateMixin {
  final String? tag;

  final roomDb = GetIt.I<RoomDb>();
  final roomMemberDb = GetIt.I<RoomMemberDb>();

  final searchInputFocus = FocusNode();
  final searchController = TextEditingController();

  String roomId = '';

  String? _searchTerm;

  final room = Rx<RoomEntity?>(null);
  final currentUserMemberData = Rx<RoomMemberEntity?>(null);
  final membersList = <RoomDetailMemberAndPendingModel>[].obs;

  // All requested member list from server.
  final allRequestedList = <AddContactGroupRequestedEntity>[].obs;

  // Filtered requested member list to show in UI.
  List<AddContactGroupRequestedEntity> filteredRequestedList = <AddContactGroupRequestedEntity>[];
  final openActionPaneId = Rxn<String>();
  bool isInitializingMemberData = true;
  bool isInitializingRequestData = true;
  bool isLoadingMemberData = false;
  bool isLoadingRequestData = false;
  bool isLoadMoreRequestData = false;
  bool isNetworkErrorRequestData = false;
  int memberCurrentPage = 1;
  int requestCurrentPage = 1;
  int memberTotalPage = 0;
  int requestTotalPage = 0;

  ScrollController memberListScrollController = ScrollController();
  ScrollController requestListScrollController = ScrollController();
  late TabController tabController;
  final tabIndex = 0.obs;

  StreamSubscription? addAdminSub;
  StreamSubscription? removeAdminSub;
  StreamSubscription? updateAdminSub;
  StreamSubscription? _updateRoomMemberSubscription;
  StreamSubscription? _addRoomMemberSubscription;
  StreamSubscription? _removeRoomMemberSubscription;
  StreamSubscription? _roomRequestUpdateSub;
  StreamSubscription? _waitingMemberUpdateSub;

  ChatRoomDetailMemberController({
    this.roomId = '',
    this.tag,
  });

  bool get isAbleToAccessGroupMemberSetting => currentUserMemberData.value?.ableToAccessGroupMemberSetting == true;

  GetGroupRequestedListUseCase get getGroupRequestedListUseCase {
    return GetIt.I.get<GetGroupRequestedListUseCase>();
  }

  ApproveGroupRequestedUseCase get approveGroupRequestedUseCase {
    return GetIt.I.get<ApproveGroupRequestedUseCase>();
  }

  RejectGroupRequestedUseCase get rejectGroupRequestedUseCase {
    return GetIt.I.get<RejectGroupRequestedUseCase>();
  }

  bool get canGetGroupRequestList {
    return currentUserMemberData.value?.ableToAccessGroupMemberSetting == true;
  }

  @override
  void onInit() async {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      tabIndex.value = tabController.index;

      // Refresh the request member list when switching to the "Member" tab
      if (tabController.index == 0) {
        removeCancelRequestFromList();
      }
    });

    if (UChatScreenUtil.instance.isMobile) {
      final args = Get.arguments as RoomMemberArgument;
      roomId = args.roomId;
    }

    await getRoomToState();

    try {
      subscription();
    } catch (e, stackTrace) {
      _log.e(UChatLogMessage(
        message: 'Error for subscription.',
        error: e,
        stackTrace: stackTrace,
        additionalData: {
          'roomId': roomId,
        },
      ));
    }

    await getRoomMemberAndPendingList(page: 1);
    if (canGetGroupRequestList) {
      await getRoomRequestedList(page: 1);
    }

    memberListScrollController.addListener(onMemberListScroll);
    requestListScrollController.addListener(onRequestListScroll);

    // Initial fetch room member to ensure data is up to date
    fetchRoomMember();

    super.onInit();
  }

  @override
  void onClose() async {
    searchController.dispose();
    searchInputFocus.dispose();

    await _updateRoomMemberSubscription?.cancel();
    await _addRoomMemberSubscription?.cancel();
    await _removeRoomMemberSubscription?.cancel();
    await addAdminSub?.cancel();
    await removeAdminSub?.cancel();
    await updateAdminSub?.cancel();
    await _roomRequestUpdateSub?.cancel();
    await _waitingMemberUpdateSub?.cancel();

    memberListScrollController.removeListener(onMemberListScroll);
    memberListScrollController.dispose();
    requestListScrollController.removeListener(onRequestListScroll);
    requestListScrollController.dispose();

    super.onClose();
  }

  void fetchRoomMember() async {
    await GetIt.I<FetchRoomMemberUseCase>().call(
      FetchRoomMemberParams(roomId: roomId, useTransaction: true, saveToDb: true),
    );
  }

  void updateSearchTerm(String searchTerm) {
    _searchTerm = searchTerm;
    getRoomMemberAndPendingList(page: 1);
    getRoomRequestedList(page: 1);
  }

  void subscription() {
    _addRoomMemberSubscription = eventBus.on<AddRoomMemberEvent>().listen(
      (event) {
        if (room() == null) return;

        if (room()!.id == event.roomId) {
          _log.d('RoomUpdate: RoomMembersController AddRoomMemberEvent >>');
          final memberEntityList = event.member
              .map(
                (e) => RoomDetailMemberAndPendingModel.fromRoomMemberEntity(e.toEntity()),
              )
              .toList();

          membersList
              .removeWhere((e) => e.isPending && memberEntityList.any((member) => member.accountId == e.accountId));
          membersList.addAll(memberEntityList);
          membersList.sort(
            (a, b) {
              if (a.isOwner && !b.isOwner) {
                return -1;
              } else if (!a.isOwner && b.isOwner) {
                return 1;
              } else if (a.isPending && !b.isPending) {
                return 1;
              } else if (!a.isPending && b.isPending) {
                return -1;
              } else {
                return a.accountDisplayName?.toLowerCase().compareTo(b.accountDisplayName?.toLowerCase() ?? '') ?? 0;
              }
            },
          );
          update([ChatRoomDetailMemberIds.memberListViewId]);
        }
      },
    );

    _removeRoomMemberSubscription = eventBus.on<RemoveRoomMemberEvent>().listen(
      (event) {
        if (room() == null) return;

        if (room()!.id == event.roomId) {
          _log.d('RoomUpdate: RoomMembersController RemoveRoomMemberEvent >>');

          for (final accountId in event.memberIds) {
            membersList.removeWhere((element) => element.accountId == accountId);
          }
          update([ChatRoomDetailMemberIds.memberListViewId]);
        }
      },
    );

    _updateRoomMemberSubscription = eventBus.on<UpdateRoomMemberEvent>().listen(
      (event) {
        if (room() == null) return;

        if (room()!.id == event.roomId) {
          _log.d('RoomUpdate: RoomMembersController UpdateRoomMemberEvent >>');

          final updatedAccountIds = <String>[];
          for (final member in event.members) {
            int index = membersList.indexWhere((element) => element.accountId == member.accountId);
            if (index != -1) {
              membersList[index] = RoomDetailMemberAndPendingModel.fromRoomMemberEntity(member.toEntity());
              final id = member.accountId;
              if (id != null) {
                updatedAccountIds.add(ChatRoomDetailMemberIds.memberItemId(id));
              }
            }
          }
          update(updatedAccountIds);
        }
      },
    );

    addAdminSub = eventBus.on<AssignAdminEvent>().listen((event) {
      if (event.roomId == roomId) {
        final memberCollection = event.member;
        int index = membersList.indexWhere((element) => element.accountId == event.member.accountId);
        if (index != -1) {
          membersList[index] = RoomDetailMemberAndPendingModel.fromRoomMemberEntity(event.member.toEntity());

          if (currentUserMemberData.value?.account.id == event.member.accountId) {
            assignCurrentUserMember(event.member.toEntity());
          }
        }

        final accountId = memberCollection.accountId;
        if (accountId != null) {
          update([ChatRoomDetailMemberIds.memberItemId(accountId)]);
        }
      }
    });

    removeAdminSub = eventBus.on<RevokeAdminEvent>().listen((event) {
      if (event.roomId == roomId) {
        final memberCollection = event.member;
        int index = membersList.indexWhere((element) => element.accountId == event.member.accountId);
        if (index != -1) {
          membersList[index] = RoomDetailMemberAndPendingModel.fromRoomMemberEntity(
            event.member.toEntity(),
          );

          if (currentUserMemberData.value?.account.id == event.member.accountId) {
            assignCurrentUserMember(event.member.toEntity());
            tabController.animateTo(0);
          }
        }

        final accountId = memberCollection.accountId;
        if (accountId != null) {
          update([ChatRoomDetailMemberIds.memberItemId(accountId)]);
        }
      }
    });

    updateAdminSub = eventBus.on<UpdateAdminPermissionEvent>().listen((event) {
      if (event.roomId == roomId) {
        final memberCollection = event.member;
        final index = membersList.indexWhere((member) => member.accountId == memberCollection.accountId);
        if (index != -1) {
          final memberEntity = memberCollection.toEntity();
          membersList[index] = RoomDetailMemberAndPendingModel.fromRoomMemberEntity(
            memberEntity,
          );

          if (currentUserMemberData.value?.account.id == membersList[index].accountId) {
            assignCurrentUserMember(memberEntity);

            if (!memberEntity.ableToAccessGroupMemberSetting) {
              tabController.animateTo(0);
            }
          }
        }

        final accountId = memberCollection.accountId;
        if (accountId != null) {
          update([ChatRoomDetailMemberIds.memberItemId(accountId)]);
        }
      }
    });

    _roomRequestUpdateSub = eventBus.on<UpdateGroupMemberRequestEvent>().listen(
      (event) async {
        final type = event.type;

        if (type == GroupRequestType.newRequest) {
          onApproveMemberRequest();
        } else if (type == GroupRequestType.cancelRequest) {
          onRejectMemberRequest(event.requestId);
        }
      },
    );

    _waitingMemberUpdateSub = eventBus.on<WaitingMemberUpdateEvent>().listen((event) async {
      if (event.roomId == roomId) {
        if (event.type == WaitingMemberUpdateType.add) {
          for (final member in event.members) {
            membersList.add(RoomDetailMemberAndPendingModel(
              roomId: event.roomId,
              accountId: member.accountId,
              accountDisplayName: member.displayName,
              accountAvatarId: member.avatarId,
              isPending: true,
              isOwner: false,
            ));
          }
        } else {
          for (final member in event.members) {
            membersList.removeWhere((element) => element.accountId == member.accountId && element.isPending);
          }
        }
        update([ChatRoomDetailMemberIds.memberListViewId]);
      }
    });
  }

  Future<void> getRoomMemberAndPendingList({required int page}) async {
    if (roomId.contains('mock')) {
      // If it's mock room generate from troubleshoot, get data from local only.
      await getRoomMemberFromLocal(page);
      return;
    }
    try {
      isLoadingMemberData = true;
      final response = await GetIt.I<GetRoomMemberAndPendingListUseCase>().call(
        GetRoomMemberAndPendingListParams(
          roomId: roomId,
          page: page,
          keyword: _searchTerm,
        ),
      );
      if (response != null) {
        memberTotalPage = response.totalPages;
        memberCurrentPage = response.page;
        if (page == 1) {
          membersList.clear();
        }
        membersList.addAll(response.data!.toList());
      }
      isLoadingMemberData = false;
      isInitializingMemberData = false;
      update([ChatRoomDetailMemberIds.memberListViewId]);
    } catch (e, stackTrace) {
      _log.e('getRoomMemberAndPendingList from server error. Fallback to local data...', e, stackTrace);
      await getRoomMemberFromLocal(page);
    }
  }

  Future<void> getRoomMemberFromLocal(int page) async {
    try {
      isLoadingMemberData = true;
      final response = await GetIt.I<GetRoomMemberFromLocalUseCase>().call(
        GetRoomDetailMemberAndPendingRequest(
          roomId: roomId,
          page: page,
          keyword: _searchTerm,
        ),
      );
      final membersData = response.data?.map((e) => RoomDetailMemberAndPendingModel.fromRoomMemberEntity(e)).toList();
      if (membersData != null) {
        memberTotalPage = response.totalPages;
        memberCurrentPage = response.page;
        if (page == 1) {
          membersList.clear();
        }
        membersList.addAll(membersData);
        update([ChatRoomDetailMemberIds.memberListViewId]);
      }
      isLoadingMemberData = false;
      isInitializingMemberData = false;
      update([ChatRoomDetailMemberIds.memberListViewId]);
    } catch (e, stackTrace) {
      _log.e('getRoomMemberFromLocal error.', e, stackTrace);
      isLoadingMemberData = false;
      isInitializingMemberData = false;
      update([ChatRoomDetailMemberIds.memberListViewId]);
    }
  }

  Future<void> getRoomRequestedList({required int page, int pageSize = 20}) async {
    try {
      if (!canGetGroupRequestList) {
        isLoadingRequestData = false;
        update([ChatRoomDetailMemberIds.memberRequestListViewId]);
        return;
      }
      isLoadingRequestData = true;
      isLoadMoreRequestData = page > 1;
      isNetworkErrorRequestData = false;
      update([ChatRoomDetailMemberIds.memberRequestListViewId]);

      final response = await getGroupRequestedListUseCase.call(GetRequestedListRequest(
        page: page,
        pageSize: pageSize,
        roomId: roomId,
        keyword: _searchTerm,
      ));

      if (response != null) {
        requestTotalPage = response.totalPages;
        requestCurrentPage = response.page;
        if (page == 1) {
          allRequestedList.clear();
        }

        allRequestedList.addAll(response.data!.toList());
      }
    } catch (e, stackTrace) {
      isNetworkErrorRequestData = true;
      _log.e('getRoomRequestedList error.', e, stackTrace);
    } finally {
      isLoadingRequestData = false;
      isInitializingRequestData = false;
      isLoadMoreRequestData = false;
      searchLocalRequestList();
    }
  }

  void onApproveMemberRequest() async {
    final newItem = await getGroupRequestedListUseCase.call(GetRequestedListRequest(
      page: 1,
      pageSize: 1,
      roomId: roomId,
    ));

    final items = newItem?.data?.toList() ?? [];

    if (newItem != null && items.isNotEmpty) {
      final newRequest = items.first;

      // Remove any existing cancel request for the same accountId before adding the new request.
      allRequestedList
          .removeWhere((e) => e.accountId == newRequest.accountId && e.type == GroupRequestType.cancelRequest);
      allRequestedList.insert(0, newRequest);
    }
    searchLocalRequestList();
  }

  Future<void> onRejectMemberRequest(String? requestId) async {
    final index = allRequestedList.indexWhere((e) => e.requestId == requestId);

    if (index == -1) return;

    allRequestedList[index].type = GroupRequestType.cancelRequest;
    searchLocalRequestList();
  }

  Future<void> getRoomToState() async {
    final roomData = await GetIt.I<GetRoomByIdUseCase>().call(ChatRoomParams(roomId: roomId));
    if (roomData == null) {
      Get.back();
      return;
    }

    room(roomData);
    await getCurrentUserMemberData();
  }

  Future<void> getCurrentUserMemberData() async {
    if (room() == null) {
      Get.back();
      return;
    }
    final accountId = UserController.instance.currentUser()?.id;
    if (accountId == null) return;
    try {
      final memberData = await GetIt.I<GetOneMemberUseCase>().call(GetOneMemberParams(
        roomId: roomId,
        accountId: accountId,
      ));
      if (memberData != null) {
        assignCurrentUserMember(memberData);
      }
    } catch (e, stackTrace) {
      _log.e('getCurrentUserMemberData error.', e, stackTrace);
    }
  }

  void assignCurrentUserMember(RoomMemberEntity member) {
    currentUserMemberData.forceUpdate(member);
  }

  void handleShowDialogDeleteMember(String memberName, String accountId, bool isPending) {
    UChatNewDialog.showDialog(
      context: Get.context!,
      title: 'Remove @memberName'.trParams({
        'memberName': memberName,
      }),
      description: 'Do you want to remove @memberName from the group?'.trParams({
        'memberName': memberName,
      }),
      cancelText: 'Cancel'.tr,
      confirmText: 'Remove'.tr,
      confirmTextColor: Get.context!.theme.appColors.textError,
      cancelTextColor: Get.context!.theme.appColors.textLight,
      isDestructive: true,
      onConfirm: () {
        if (isPending) {
          handleRemovePendingMember(accountId);
        } else {
          handleRemoveMember(accountId);
        }
      },
    );
  }

  Future<void> handleRemovePendingMember(String accountId) async {
    try {
      if (isAbleToAccessGroupMemberSetting == false) {
        await UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
        return;
      }

      await GetIt.I<RemovePendingMembersUseCase>().call(
        RemovePendingMembersParams(
          roomId: roomId,
          invitedAccountIds: [accountId],
        ),
      );
      membersList.removeWhere((element) => element.accountId == accountId);
      update([ChatRoomDetailMemberIds.memberListViewId]);
    } on ApiException catch (e) {
      if (e.exceptionType == ApiExceptionType.permissionDenied) {
        UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      } else {
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          message: 'You cannot remove this member.'.tr,
        );
        _log.e('RemovePendingMember error', e);
      }
    } catch (e, stackTrace) {
      _log.e('RemovePendingMember error', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        message: 'You cannot remove this waiting member.'.tr,
      );
    }
  }

  Future<void> handleRemoveMember(String accountId) async {
    try {
      if (isAbleToAccessGroupMemberSetting == false) {
        await UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
        return;
      }

      await GetIt.I<RemoveMemberFromChatUseCase>().call(
        RemoveMemberFromChatParams(
          roomId: roomId,
          friendId: accountId,
        ),
      );
      membersList.removeWhere((element) => element.accountId == accountId);
      update([ChatRoomDetailMemberIds.memberListViewId]);
    } on ApiException catch (e, stackTrace) {
      if (e.exceptionType == ApiExceptionType.permissionDenied) {
        UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      } else {
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          message: 'You cannot remove this member.'.tr,
        );
        _log.e('RemoveMember error', e, stackTrace);
      }
    } catch (e, stackTrace) {
      _log.e('RemoveMember error', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        message: 'You cannot remove this member.'.tr,
      );
    }
  }

  void handleOpenInvite() async {
    if (isAbleToAccessGroupMemberSetting == false) {
      UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      return;
    }

    final dataRefreshNeeded = await Get.toNamed(
      Routes.roomDetailMemberInvite.replaceAll(':id', tag!),
      arguments: SelectMemberArguments(fromRoomDetailInvite: true, roomDetailMemberList: membersList, roomId: roomId),
    );
    if (dataRefreshNeeded == true) {
      await getRoomMemberAndPendingList(page: 1);
    }
  }

  void handleClearSearch() {
    searchController.clear();
  }

  Future<void> handleOpenProfile(RoomDetailMemberAndPendingModel member) async {
    final roomId = room.value?.id;
    if (roomId == null) {
      return;
    }
    await GetIt.I<ProfileService>().openProfileScreen(
      contactId: member.accountId,
      arguments: ProfileArgumentsV2(
        roomId: roomId,
        fromGroup: true,
      ),
    );
  }

  void showDialogLeaveGroup() {
    UChatNewDialog.showDialog(
      context: Get.context!,
      title: currentUserMemberData()!.isOwner ? 'Leave group as owner'.tr : 'Leave this group'.tr,
      description: currentUserMemberData()!.isOwner
          ? 'If you leave this group, ownership will be transferred to the first member who joined after you.'.tr
          : 'Leaving this group will remove access to the member list and chat history.'.tr,
      description2: currentUserMemberData()!.isOwner ? 'Are you sure you want to leave?'.tr : null,
      cancelText: 'Cancel'.tr,
      confirmText: 'Leave'.tr,
      confirmTextColor: Get.context!.theme.appColors.textError,
      cancelTextColor: Get.context!.theme.appColors.textLight,
      isDestructive: true,
      onConfirm: () {
        handleConfirmLeaveGroup();
      },
    );
  }

  void handleConfirmLeaveGroup() async {
    // await UChatLoading.show(status: 'Processing...'.tr);
    await GetIt.I<LeaveGroupUseCase>().call(
      LeaveGroupParams(
        roomId: room()!.id,
        onRoomDeleted: (roomId) {
          eventBus.fire(RoomDeleteEvent(roomId: roomId));
        },
      ),
    );
    // await UChatLoading.success(message: 'Leave.'.tr);

    Get.until((route) => route.settings.name == Routes.home);

    // onRemoveReactionsWhenDeleteOrUnsentMsgs(roomId: roomId, isLeaveTheChat: true);
    return;
  }

  void onSlideChange(String? itemId, bool isOpen) {
    if (isOpen) {
      openActionPaneId.value = itemId;
    } else if (openActionPaneId.value == itemId) {
      openActionPaneId.value = null;
    }
  }

  void onTapToOpenAccountProfile(String accountId) {
    GetIt.I<ProfileService>().openProfileScreen(
      contactId: accountId,
    );
  }

  Future<void> handleApproveGroupRequest(AddContactGroupRequestedEntity? item) async {
    final requestId = item?.requestId ?? '';
    final type = item?.type;

    if (requestId.isEmpty || type != GroupRequestType.newRequest) return;

    await ChatRoomHelper.handleGroupRequestApproval(requestId);
  }

  Future<void> handleRejectGroupRequest(AddContactGroupRequestedEntity? item) async {
    final requestId = item?.requestId ?? '';
    final type = item?.type;

    if (requestId.isEmpty || type != GroupRequestType.newRequest) return;

    await ChatRoomHelper.handleGroupRequestRejection(requestId);
  }

  Future<void> onMemberListScroll() async {
    final currentPixel = memberListScrollController.position.pixels;
    final maxScrollPixel = memberListScrollController.position.maxScrollExtent;
    final areaLoadingPercentage = .8;
    final shouldLoadMore = currentPixel >= maxScrollPixel * areaLoadingPercentage;

    final hasMore = memberCurrentPage < memberTotalPage;
    if (shouldLoadMore && hasMore && !isLoadingMemberData) {
      EasyThrottle.throttle(
        'fetch-more-members',
        const Duration(milliseconds: 500),
        () async {
          await getRoomMemberAndPendingList(page: memberCurrentPage + 1);
        },
      );
    }
  }

  Future<void> onRequestListScroll() async {
    final currentPixel = requestListScrollController.position.pixels;
    final maxScrollPixel = requestListScrollController.position.maxScrollExtent;
    final areaLoadingPercentage = .8;
    final shouldLoadMore = currentPixel >= maxScrollPixel * areaLoadingPercentage;

    final hasMore = requestCurrentPage < requestTotalPage;
    if (shouldLoadMore && hasMore && !isLoadingRequestData) {
      EasyThrottle.throttle(
        'fetch-more-request-members',
        const Duration(milliseconds: 500),
        () async {
          await getRoomRequestedList(page: requestCurrentPage + 1);
        },
      );
    }
  }

  void searchLocalRequestList() async {
    final searchTerm = _searchTerm;
    if (searchTerm?.isEmpty == true || searchTerm == null) {
      filteredRequestedList = allRequestedList.toList();
      update([ChatRoomDetailMemberIds.memberRequestListViewId]);
      return;
    }

    filteredRequestedList = allRequestedList.where((element) {
      return element.displayName?.toLowerCase().contains(searchTerm.toLowerCase()) == true;
    }).toList();

    update([ChatRoomDetailMemberIds.memberRequestListViewId]);
  }

  /// Update request list after cancel request
  void removeCancelRequestFromList() {
    // Remove all cancel request from the list
    allRequestedList.removeWhere((element) => element.type == GroupRequestType.cancelRequest);
    searchLocalRequestList();
  }
}
