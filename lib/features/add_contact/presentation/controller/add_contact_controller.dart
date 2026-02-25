import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/controllers/connectivity_controller.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/infrastructure/orchestrator/navigation/deep_link_handler.dart';
import 'package:uchat/core/services/sharing/sharing_service.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/entities/enum/central_noti_type.dart';
import 'package:uchat/entities/enum/group_request_type.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/add_contact/data/model/invited_list_request.dart';
import 'package:uchat/features/add_contact/data/model/requested_list_request.dart';
import 'package:uchat/features/add_contact/domain/entities/add_contact_group_requested_entity.dart';
import 'package:uchat/features/add_contact/domain/events/update_group_member_request_event.dart';
import 'package:uchat/features/add_contact/domain/use_cases/approve_group_requested_use_case.dart';
import 'package:uchat/features/add_contact/domain/use_cases/get_group_requested_list_use_case.dart';
import 'package:uchat/features/add_contact/presentation/screens/add_contact_invite_screen.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/central_notification/data/model/collection/central_notification_collection.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/models/requests/accept_group_invite_request.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_text_parse_mention.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/bottom_sheet.dart';
import 'package:uchat/features/contact/data/models/requests/add_contact_request.dart';
import 'package:uchat/features/contact/data/models/requests/approve_group_requested_request.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_sync_use_case.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/features/profile/service/profile_service.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/utils/extension/extension_string.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

import '../../domain/entities/add_contact_invited_entity.dart';
import '../../domain/use_cases/accept_friend_requested_use_case.dart';
import '../../domain/use_cases/accept_group_invited_use_case.dart';
import '../../domain/use_cases/get_friend_requested_list_use_case.dart';
import '../../domain/use_cases/get_group_invited_list_use_case.dart';

final _log = useLogger();

const fetchTypeFriend = 'FRIEND';
const fetchTypeGroup = 'GROUP';
const fetchSize = 50;

class AddContactController extends GetxController with GetSingleTickerProviderStateMixin {
  static AddContactController get instance => Get.find();

  late TabController tabController;

  final tabIndex = 0.obs;
  final isNewFriend = false.obs;
  final isNewGroup = false.obs;
  final isNewGroupRequest = false.obs;
  final groupInviteList = <AddContactInvitedEntity>[].obs;
  final groupRequestList = <AddContactGroupRequestedEntity>[].obs;
  final friendRequestList = <AddContactInvitedEntity>[].obs;

  ScrollController? scrollController;

  StreamSubscription? _centralNotiUpdateSub;
  StreamSubscription? _roomRequestUpdateSub;
  PagingController<int, AddContactInvitedEntity> friendRequestPagingController = PagingController(firstPageKey: 1);
  PagingController<int, AddContactInvitedEntity> groupInvitePagingController = PagingController(firstPageKey: 1);
  PagingController<int, AddContactGroupRequestedEntity> groupRequestPagingController =
      PagingController(firstPageKey: 1);

  GetFriendRequestedListUseCase get getFriendRequestListUseCase {
    return GetIt.I.get<GetFriendRequestedListUseCase>();
  }

  GetGroupInvitedListUseCase get getGroupInvitedListUseCase {
    return GetIt.I.get<GetGroupInvitedListUseCase>();
  }

  GetGroupRequestedListUseCase get getGroupRequestedListUseCase {
    return GetIt.I.get<GetGroupRequestedListUseCase>();
  }

  AcceptFriendRequestedUseCase get acceptFriendRequestedUseCase {
    return GetIt.I.get<AcceptFriendRequestedUseCase>();
  }

  AcceptGroupInvitedUseCase get acceptGroupInvitedUseCase {
    return GetIt.I.get<AcceptGroupInvitedUseCase>();
  }

  ApproveGroupRequestedUseCase get approveGroupRequestedUseCase {
    return GetIt.I.get<ApproveGroupRequestedUseCase>();
  }

  @override
  void onInit() async {
    super.onInit();

    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      tabIndex.value = tabController.index;

      if (tabIndex.value == 0) {
        isNewFriend.value = false;
        saveTabStatus(UChatConstant.friendStatus, false);
      } else if (tabIndex.value == 1) {
        isNewGroup.value = false;
        saveTabStatus(UChatConstant.groupStatus, false);
      } else if (tabIndex.value == 2) {
        isNewGroupRequest.value = false;
        saveTabStatus(UChatConstant.groupRequestStatus, false);
      }
    });

    _centralNotiUpdateSub = eventBus.on<CentralNotificationUpdateEvent>().listen(
      (event) async {
        _log.d('CentralNotificationUpdateEvent in addContactController');
        final notiType = event.centralNoti.notiType;

        if (notiType == CentralNotiType.newFriend) {
          onAddNewItemFriendRequestList();
        } else if (notiType == CentralNotiType.inviteGroup) {
          onAddNewItemGroupInviteList(event.centralNoti);
        } else if ([
          CentralNotiType.acceptFriend,
          CentralNotiType.declineFriend,
        ].contains(notiType)) {
          await onUpdateFriendAcceptItemType(
            event.centralNoti.data?.accountId,
            event.centralNoti.notiType,
          );
        } else if ([
          CentralNotiType.acceptGroup,
          CentralNotiType.declineGroup,
        ].contains(notiType)) {
          await onUpdateGroupInviteItemType(
            event.centralNoti.data?.roomId,
            event.centralNoti.notiType,
          );
        }
      },
    );

    _roomRequestUpdateSub = eventBus.on<UpdateGroupMemberRequestEvent>().listen(
      (event) async {
        _log.d('UpdateRoomMemberRequestEvent in addContactController');
        final type = event.type;

        if (type == GroupRequestType.newRequest) {
          onAddNewItemGroupRequestedList();
        } else if (type == GroupRequestType.cancelRequest) {
          onBlockGroupRequestItem(event.requestId);
        }
      },
    );

    isNewGroup.value = (await getTabStatus(UChatConstant.groupStatus)) ?? false;
    isNewGroupRequest.value = (await getTabStatus(UChatConstant.groupRequestStatus)) ?? false;

    initPagingController();
  }

  @override
  void onClose() {
    _centralNotiUpdateSub?.cancel();
    _roomRequestUpdateSub?.cancel();

    super.onClose();
  }

  void saveTabStatus(String key, bool value) {
    ConfigDb.instance.authenticated.saveConfig(
      key: key,
      value: value,
    );
  }

  Future<bool?> getTabStatus(String key) async {
    return ConfigDb.instance.authenticated.getBool(key: key);
  }

  void initPagingController() {
    if (ConnectivityController.instance.isOffline) {
      if (ConnectivityController.instance.isConnectMaintenanceWasOn.value) {
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
      } else {
        showOfflineDialog();
      }

      friendRequestPagingController.itemList = [];
      groupInvitePagingController.itemList = [];
      groupRequestPagingController.itemList = [];

      return;
    }

    friendRequestPagingController.addPageRequestListener((pageKey) async {
      await onUpdateFriendRequestedList(page: pageKey);
    });

    groupInvitePagingController.addPageRequestListener((pageKey) async {
      await onUpdateGroupInvitedList(page: pageKey);
    });

    groupRequestPagingController.addPageRequestListener((pageKey) async {
      await onUpdateGroupRequestedList(page: pageKey);
    });

    friendRequestPagingController.notifyPageRequestListeners(1);
    groupInvitePagingController.notifyPageRequestListeners(1);
    groupRequestPagingController.notifyPageRequestListeners(1);
  }

  Future<PaginationPayload<AddContactInvitedEntity>?> fetchFriendRequestList(InvitedListRequest request) async {
    if (UserController.instance.currentUser() == null) {
      return null;
    }

    PaginationPayload<AddContactInvitedEntity>? requestList;

    try {
      final res = await getFriendRequestListUseCase.call(request);

      if (res != null) {
        requestList = res;
      }
    } catch (e, stackTrace) {
      _log.e('fetchInvitedList error.', e, stackTrace);
    }

    return requestList;
  }

  Future<PaginationPayload<AddContactInvitedEntity>?> fetchGroupInvitedList(InvitedListRequest request) async {
    if (UserController.instance.currentUser() == null) {
      return null;
    }

    PaginationPayload<AddContactInvitedEntity>? invitedList;

    try {
      final res = await getGroupInvitedListUseCase.call(request);

      if (res != null) {
        invitedList = res;
      }
    } catch (e, stackTrace) {
      _log.e('fetchInvitedList error.', e, stackTrace);
    }

    return invitedList;
  }

  Future<PaginationPayload<AddContactGroupRequestedEntity>?> fetchGroupRequestedList(
    GetRequestedListRequest request,
  ) async {
    if (UserController.instance.currentUser() == null) {
      return null;
    }

    PaginationPayload<AddContactGroupRequestedEntity>? requestedList;

    try {
      final res = await getGroupRequestedListUseCase.call(GetRequestedListRequest(
        page: request.page,
        pageSize: request.pageSize,
      ));

      if (res != null) {
        requestedList = res;
      }
    } catch (e, stackTrace) {
      _log.e('fetchGroupRequestedList error.', e, stackTrace);
    }

    return requestedList;
  }

  Future<void> onUpdateFriendRequestedList({required int page, int pageSize = fetchSize}) async {
    try {
      final friendRequestRes = await fetchFriendRequestList(InvitedListRequest(
        page: page,
        pageSize: pageSize,
      ));

      if (friendRequestRes != null) {
        final friendItems = friendRequestRes.data?.toList() ?? [];
        friendRequestList.addAll(friendItems);

        if (friendRequestRes.page == friendRequestRes.totalPages) {
          friendRequestPagingController.appendLastPage(friendItems);
        } else {
          friendRequestPagingController.appendPage(friendItems, page + 1);
        }
      }
    } catch (e, stackTrace) {
      _log.e('fetchFriendRequestedList error.', e, stackTrace);
    }
  }

  Future<void> onUpdateGroupInvitedList({required int page, int pageSize = fetchSize}) async {
    try {
      final groupInviteRes = await fetchGroupInvitedList(InvitedListRequest(
        page: page,
        pageSize: pageSize,
      ));

      if (groupInviteRes != null) {
        final groupItems = groupInviteRes.data?.toList() ?? [];
        groupInviteList.addAll(groupItems);

        groupInviteList.sort((a, b) {
          /// If the [invitedAt] is a null, put the item at the bottom of the list
          final oldestTime = DateTime.fromMillisecondsSinceEpoch(0);
          final aTime = a.invitedAt ?? oldestTime;
          final bTime = b.invitedAt ?? oldestTime;

          /// Newest always be on top
          return bTime.compareTo(aTime);
        });

        if (groupInviteRes.page == groupInviteRes.totalPages) {
          groupInvitePagingController.appendLastPage(groupItems);
        } else {
          groupInvitePagingController.appendPage(groupItems, page + 1);
        }
      }
    } catch (e, stackTrace) {
      _log.e('fetchAllGroupInvitedList error.', e, stackTrace);
    }
  }

  Future<void> onUpdateGroupRequestedList({required int page, int pageSize = fetchSize}) async {
    try {
      final groupRequestRes = await fetchGroupRequestedList(GetRequestedListRequest(
        page: page,
        pageSize: pageSize,
      ));

      if (groupRequestRes != null) {
        final requestedItems = groupRequestRes.data?.toList() ?? [];
        groupRequestList.addAll(requestedItems);

        if (groupRequestRes.page == groupRequestRes.totalPages) {
          groupRequestPagingController.appendLastPage(requestedItems);
        } else {
          groupRequestPagingController.appendPage(requestedItems, page + 1);
        }
      }
    } catch (e, stackTrace) {
      _log.e('fetchGroupRequestedList error.', e, stackTrace);
      groupRequestPagingController.appendLastPage([]);
    }
  }

  void onAddNewItemFriendRequestList() async {
    isNewFriend.value = tabIndex.value != 0;
    saveTabStatus(UChatConstant.friendStatus, isNewFriend.value);

    final newItem = await fetchFriendRequestList(InvitedListRequest(
      page: 1,
      pageSize: 1,
    ));

    final items = newItem?.data?.toList() ?? [];

    if (newItem != null && items.isNotEmpty) {
      friendRequestList.insert(0, items.first);
      friendRequestPagingController.appendLastPage(friendRequestList);
    }
  }

  void onAddNewItemGroupInviteList(CentralNotificationCollection noti) async {
    isNewGroup.value = tabIndex.value != 1;
    saveTabStatus(UChatConstant.groupStatus, isNewGroup.value);

    final newItem = AddContactInvitedEntity(
      id: noti.data?.roomId,
      name: noti.data?.roomName,
      senderName: noti.data?.displayName,
      senderId: noti.data?.accountId,
      avatarId: noti.data?.roomPhotoId,
      isGroupInvite: true,
      invitedAt: noti.createdAt,
      type: noti.notiType,
    );

    groupInviteList.insert(0, newItem);
    final currentItems = groupInvitePagingController.itemList ?? [];
    groupInvitePagingController.itemList = [newItem, ...currentItems];
  }

  void onAddNewItemGroupRequestedList() async {
    isNewGroupRequest.value = tabIndex.value != 2;
    saveTabStatus(UChatConstant.groupRequestStatus, isNewGroupRequest.value);

    final newItem = await fetchGroupRequestedList(GetRequestedListRequest(
      page: 1,
      pageSize: 1,
    ));

    final items = newItem?.data?.toList() ?? [];

    if (newItem != null && items.isNotEmpty) {
      groupRequestList.insert(0, items.first);
      groupRequestPagingController.appendLastPage(groupRequestList);
    }
  }

  Future<void> onUpdateFriendAcceptItemType(String? id, CentralNotiType? type) async {
    final friendIndex = friendRequestList.indexWhere((e) => e.id == id);

    if (friendIndex != -1) {
      friendRequestList[friendIndex].type = type;
      friendRequestList.refresh();
    }
  }

  Future<void> onUpdateGroupInviteItemType(String? id, CentralNotiType? type) async {
    final groupIndex = groupInviteList.indexWhere((e) => e.id == id);

    if (groupIndex != -1) {
      groupInviteList[groupIndex].type = type;
      groupInviteList.refresh();
    }
  }

  Future<void> onBlockGroupRequestItem(String? requestId) async {
    final groupIndex = groupRequestList.indexWhere((e) => e.requestId == requestId);

    if (groupIndex != -1) {
      groupRequestList[groupIndex].type = GroupRequestType.cancelRequest;
      groupRequestList.refresh();
    }
  }

  void handleInvite(BuildContext context) async {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickInviteAddFriendPage);

    final url = '${AppEnv.addFriendPrefix}${UserController.instance.currentUser()?.username}';
    final text =
        'Unlimited messaging, free calls, and group chat support connect with people effortlessly on UChat! @url'
            .trParams({'url': url});

    BottomSheetUChat.bottomSheet(
      context,
      title: 'Invite'.tr,
      description: Padding(
        padding: EdgeInsets.only(top: AppSpace.space3.spMin, left: AppSpace.space4.spMin, right: AppSpace.space4.spMin),
        child: MentionTextParse(
          message: text,
          style: context.theme.appTexts.body1.copyWith(color: context.theme.appColors.textDarkest),
          styleMatch: context.theme.appTexts.body1.copyWith(color: context.theme.appColors.textPrimary),
        ),
      ),
      child: AddContactInviteScreen(
        onShare: () => onInviteShare(text, context),
        onCopy: () => onInviteCopy(text, context),
      ),
    );
  }

  void onInviteShare(String text, BuildContext context) async {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickShareInvite);

    Get.back();
    final result = await GetIt.I<SharingService>().shareToOtherApp(text: text);

    if (result.status == ShareResultStatus.dismissed) return;

    GetIt.I<TaxonomyService>().sendEvent(EventName.inviteShared);

    if (!context.mounted) return;

    AppToast.showToast(
      context: context,
      message: 'Shared'.tr,
      icon: Assets.vectors.iconShare.svg(),
    );
  }

  void onInviteCopy(String text, BuildContext context) async {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickCopyInvite);

    Get.back();
    await Clipboard.setData(ClipboardData(text: text));
    GetIt.I<TaxonomyService>().sendEvent(EventName.inviteCopied);

    if (!context.mounted) return;

    AppToast.showToast(
      context: context,
      message: 'Copied link to connect on UChat'.tr,
      icon: Assets.vectors.contentCopy.svg(
        color: context.theme.appColors.iconPrimaryInverse,
      ),
      sbMargin: EdgeInsets.only(bottom: 42.spMin),
    );
  }

  void handleScanQRCode() async {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickQRCodeAddFriendPage);

    if (UChatCallController.instance.isSomeoneCameraOn) {
      UChatNewDialog.showSingleButtonDialog(
        context: Get.context!,
        title: 'Unable to access the camera while on a video call. Please try again after the call ends.'.tr,
        confirmText: 'Got it'.tr,
        confirmTextColor: Get.theme.appColors.textPrimary,
      );

      return;
    }

    Get.toNamed(Routes.addContactByQr)?.then((url) async {
      if (url == null) return;

      final isQRCodeUChat = url.toString().isUChatQRCode;

      GetIt.I<TaxonomyService>().sendEvent(
        EventName.qrCodeScanned,
        eventProperties: EventProperty.qrCodeScanned(isUChat: isQRCodeUChat),
      );

      if (isQRCodeUChat) {
        GetIt.I<DeepLinkHandler>().processLink(Uri.parse(url));
      } else {
        AppToast.showToast(
          context: Get.context!,
          message: 'Invalid QR Code'.tr,
        );
      }
    });
  }

  void handleSearchFriend() async {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickSearchAddFriendPage);
    Get.toNamed(Routes.addContactSearch);
  }

  Future<void> handleAcceptRequest(String id, CentralNotiType? type, BuildContext context) async {
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.clickAcceptAddFriendPage,
      eventProperties: EventProperty.clickAcceptAddFriendPage(
        requestType: type == CentralNotiType.newFriend ? 'Friend' : 'Group',
      ),
    );

    if (ConnectivityController.instance.isOffline) {
      if (ConnectivityController.instance.isConnectMaintenanceWasOn.value) {
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
      } else {
        showOfflineDialog();
      }

      return;
    }

    if (type == CentralNotiType.newFriend) {
      await handleAcceptFriend(id);
    } else if (type == CentralNotiType.inviteGroup) {
      await handleJoinGroup(id, context);
    }
  }

  Future<void> handleAcceptFriend(String id) async {
    await UChatLoading.show(status: 'Accepting...'.tr);
    try {
      UChatLoading.show(status: 'Accepting...'.tr);
      await acceptFriendRequestedUseCase.call(AddContactRequest(friendAccountId: id));

      eventBus.fire(AcceptRequestEvent(id: id));
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } on ApiFriendLimitExceedException catch (e, stackTrace) {
      _log.e('handleAcceptFriend on ApiFriendLimitExceedException error.', e, stackTrace);
      UChatNewDialog.showSingleButtonDialog(
        context: Get.context!,
        title: 'Friend Limit Reached'.tr,
        description:
            'You have reached the maximum number of friends. To add a new friend, please remove someone from your contact list.'
                .tr,
        confirmText: 'Got it'.tr,
        confirmTextColor: Get.theme.appColors.textPrimary,
      );
    } catch (e, stackTrace) {
      _log.e('handleAcceptFriend error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
    } finally {
      await UChatLoading.hide();
    }
  }

  Future<void> handleJoinGroup(String id, BuildContext context) async {
    try {
      UChatLoading.show(status: 'Accepting...'.tr);
      await acceptGroupInvitedUseCase.call(AcceptGroupInviteRequest(roomId: id));

      eventBus.fire(AcceptRequestEvent(id: id));

      final roomCollection = await GetIt.I<RoomDb>().getRoom(id);
      roomCollection?.isJoined = true;

      if (roomCollection != null) {
        await GetIt.I<RoomDb>().putOrUpdateRoom(roomCollection);
      }

      eventBus.fire(RequireGroupInviteUpdateEvent());
    } on ApiException catch (e, stackTrace) {
      if (e.type == 'ERR_ROOM_MEMBER_EXCEED_LIMIT') {
        _log.e('handleJoinGroup on ApiException error.', e, stackTrace);
        UChatNewDialog.showSingleButtonDialog(
          context: Get.context!,
          title: 'Group member limit reached'.tr,
          description:
              'This group has reached its maximum member limit, and you cannot join at this time.\n\nYou may be able to join in the future if space becomes available.'
                  .tr,
          confirmText: 'Got it'.tr,
          confirmTextColor: Get.theme.appColors.textPrimary,
        );
      } else {
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e);
      }
    } catch (e, stackTrace) {
      _log.e('handleJoinGroup error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
    }

    await UChatLoading.hide();
  }

  void onTapItem(AddContactInvitedEntity item) {
    if (item.isFriendRequest == true) {
      onTapToOpenAccountProfile(item.id);
    } else {
      final roomId = item.id;

      if (roomId == null) return;

      GetIt.I<ProfileService>().openGroupProfile(
        roomId: roomId,
      );
    }
  }

  void onTapToOpenAccountProfile(String? contactId) {
    if (contactId == null) return;

    GetIt.I<ProfileService>().openProfileScreen(
      contactId: contactId,
    );
  }

  Future<void> handleApproveGroupRequest(AddContactGroupRequestedEntity? item) async {
    final requestId = item?.requestId ?? '';
    final type = item?.type;

    if (requestId.isEmpty || type != GroupRequestType.newRequest) return;

    try {
      UChatLoading.show(status: 'Approving...'.tr);
      await approveGroupRequestedUseCase.call(ApproveGroupRequestedRequest(requestId: requestId));
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } on ApiException catch (e, stackTrace) {
      _log.e('handleApproveGroupRequest on ApiException error.', e, stackTrace);
      if (e.code == 403 || e.type == 'ERR_PERMISSION_DENIED') {
        UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      } else if (e.code == 404 || e.type == 'ERR_ROOM_MEMBER_REQUEST_NOT_FOUND') {
        UChatNewDialog.showRequestNotFoundDialog(context: Get.context!);
      } else {
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e);
      }
    } catch (e, stackTrace) {
      _log.e('handleApproveGroupRequest error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
    } finally {
      await UChatLoading.hide();
    }
  }

  String? getNickName(String? id) {
    if (id == null) return null;
    final contact = GetIt.I<GetContactSyncUseCase>().call(id);
    return contact?.nickname;
  }

  void showOfflineDialog() {
    UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
  }
}
