import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/data/models/enums/api_exception_type.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/event_bus/events/notification_center_account_deleted_event.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/enum/source_performance_state.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/param/screen_lag_perf_attribute_param.dart';
import 'package:uchat/core/infrastructure/analytics/screen_lag_notification_performance_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/entities/enum/central_noti_type.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/features/add_contact/domain/use_cases/approve_group_requested_use_case.dart';
import 'package:uchat/features/central_notification/domain/param/central_notification_payload.dart';
import 'package:uchat/features/central_notification/domain/param/delete_notifications_param.dart';
import 'package:uchat/features/central_notification/domain/use_cases/delete_notifications_from_local_use_case.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/accept_group_invite_request.dart';
import 'package:uchat/features/chat_room/domain/params/chat_room_arguments.dart';
import 'package:uchat/features/contact/data/models/requests/add_contact_request.dart';
import 'package:uchat/features/contact/data/models/requests/approve_group_requested_request.dart';
import 'package:uchat/features/contact/domain/use_cases/add_contact_use_case.dart';
import 'package:uchat/features/profile/service/profile_service.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/screens.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

import '../../domain/entities/central_notification_entity.dart';
import '../../domain/use_cases/accept_room_use_case.dart';
import '../../domain/use_cases/clear_local_notifications_use_case.dart';
import '../../domain/use_cases/fetch_notifications_from_server_use_case.dart';
import '../../domain/use_cases/get_all_notifications_from_local_use_case.dart';

final _log = useLogger();

const pageSize = 50;
const notiUnreadCountKey = 'NOTI_UNREAD_COUNT_KEY';
const notiLastReadAtKey = 'NOTI_LAST_READ_AT_KEY';

class CentralNotificationController extends GetxController {
  static CentralNotificationController get instance => Get.find();

  final centralNotificationList = <CentralNotificationEntity>[].obs;
  final currentPage = 1.obs;
  final totalPage = 10.obs;
  final loadingNextPage = false.obs;
  final loadNextPageError = false.obs;
  final notiUnreadCount = 0.obs;
  final roomContact = Rx<RoomContactModel?>(null);

  final int nextPageTrigger = 3;

  final List friend = [
    CentralNotiType.friendAccept,
    CentralNotiType.declineFriend,
    CentralNotiType.newFriend,
    CentralNotiType.acceptFriend,
    CentralNotiType.requestGroup,
    CentralNotiType.requestGroupApproved,
    CentralNotiType.requestGroupDeclined,
    CentralNotiType.requestGroupJoined,
  ];
  final List group = [
    CentralNotiType.groupAccept,
    CentralNotiType.declineGroup,
    CentralNotiType.inviteGroup,
    CentralNotiType.acceptGroup,
  ];

  StreamSubscription? _centralNotiUpdateSub;
  StreamSubscription? _userCheckedSubscription;
  StreamSubscription? _contactUpdateSubscription;
  StreamSubscription? _accountDeleteNotiSubscription;

  final isLoadingInit = false.obs;

  ContactsController get contactCtl {
    return ContactsController.instance;
  }

  ConnectivityController get connectivityCtl => ConnectivityController.instance;

  RoomDb get roomDb => GetIt.I<RoomDb>();

  RoomMemberDb get roomMemberDb => GetIt.I<RoomMemberDb>();

  ClearLocalNotificationsUseCase get clearLocalNotificationsUseCase {
    return GetIt.I<ClearLocalNotificationsUseCase>();
  }

  DeleteNotificationsFromLocalUseCase get deleteNotificationsFromLocalUseCase {
    return GetIt.I<DeleteNotificationsFromLocalUseCase>();
  }

  GetAllNotificationsFromLocalUseCase get getAllNotificationsFromLocalUseCase {
    return GetIt.I<GetAllNotificationsFromLocalUseCase>();
  }

  FetchNotificationsFromServerUseCase get fetchCentralNotificationFromServerUseCase {
    return GetIt.I<FetchNotificationsFromServerUseCase>();
  }

  AcceptRoomUseCase get acceptRoomUseCase {
    return GetIt.I<AcceptRoomUseCase>();
  }

  ApproveGroupRequestedUseCase get approveGroupRequestedUseCase {
    return GetIt.I.get<ApproveGroupRequestedUseCase>();
  }

  @override
  void onInit() async {
    _centralNotiUpdateSub = eventBus.on<CentralNotificationUpdateEvent>().listen(
      (event) async {
        int listIndex = centralNotificationList.indexWhere((element) => element.id == event.centralNoti.id);

        if (listIndex != -1) {
          centralNotificationList[listIndex] = event.centralNoti.toEntity();
        } else {
          centralNotificationList.insert(0, event.centralNoti.toEntity());

          // Set add contact red dot status
          onSetAddContactRedDotStatus(event.centralNoti.notiType);

          await Future.delayed(const Duration(minutes: 1));
          centralNotificationList.refresh();
        }
      },
    );

    _contactUpdateSubscription = eventBus.on<ContactUpdateEvent>().listen(
      (event) {
        try {
          final contact = centralNotificationList.indexWhere((e) => e.data?.accountId == event.contact.id);

          if (contact == -1) return;

          centralNotificationList[contact].data?.displayName = event.contact.displayName;
          centralNotificationList[contact].data?.avatarId = event.contact.avatarId;
          centralNotificationList.refresh();
        } catch (e, stackTrace) {
          _log.e('On _contactUpdateSubscription error.', e, stackTrace);
        }
      },
    );

    // NotificationCenterAccountDeletedEvent
    _accountDeleteNotiSubscription = eventBus.on<NotificationCenterAccountDeletedEvent>().listen(
      (event) async {
        _deleteNotificationByAccountId(event.entity.accountId);
      },
    );

    super.onInit();
  }

  @override
  void onClose() async {
    await _centralNotiUpdateSub?.cancel();
    await _userCheckedSubscription?.cancel();
    await _contactUpdateSubscription?.cancel();
    await _accountDeleteNotiSubscription?.cancel();
    super.onClose();
  }

  void addNotificationToState(List<CentralNotificationEntity> centralNotiList) {
    for (var centralNoti in centralNotiList) {
      if (centralNotificationList.contains(centralNoti)) {
        continue;
      }
      centralNotificationList.add(centralNoti);
    }
    centralNotificationList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
  }

  Future<void> updateNotificationCenterData() async {
    final bool isFirstTimeLogin = UserController.instance.isFirstTimeLogin;
    final bool shouldTrackPerformance = HomeController.instance.isUserTappedCentralNoti;
    final sourceState = isFirstTimeLogin ? SourcePerformanceState.fromSignIn : SourcePerformanceState.fromClose;

    if (shouldTrackPerformance) {
      await useLagNotiPerformance().startPerformanceScreenLagNoti(
        ScreenLagPerfAttributeParams(
          userId: UserController.instance.currentUser()?.id,
          sourcePerformanceState: sourceState,
        ),
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        useLagNotiPerformance().trackFirstRenderMetric(sourceState);
      });
    }

    await getNotificationFromLocalDb();
    await fetchNotificationListFromServer();

    if (shouldTrackPerformance) {
      useLagNotiPerformance().stopPerformanceScreenLagNoti(
        sourcePerformanceState: sourceState,
      );
    }
  }

  Future<void> getNotificationFromLocalDb() async {
    try {
      isLoadingInit.value = true;

      final localCentralNoti = await getAllNotificationsFromLocalUseCase.call(NoParams());
      centralNotificationList.value = localCentralNoti;
      centralNotificationList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

      isLoadingInit.value = false;
    } catch (e, stackTrace) {
      _log.e('getNotificationFromLocalDb error.', e, stackTrace);
    }
  }

  Future<void> fetchNotificationListFromServer({int page = 1, int pageSize = 50}) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        loadingNextPage(true);
        final res = await fetchCentralNotificationFromServerUseCase.call(CentralNotificationParam(
          page: page,
          pageSize: pageSize,
        ));

        if (res == null) {
          _log.w('centralNotiListResponse is null');
          loadingNextPage(false);
          loadNextPageError(true);

          return;
        }

        loadingNextPage(false);
        loadNextPageError(false);

        final entityList = res.centralNotiList.map((e) => e.toEntity()).toList();
        addNotificationToState(entityList);

        currentPage(res.page);
        totalPage(res.totalPage);

        final lastNotiCreatedAt = res.centralNotiList.firstOrNull?.createdAt ?? DateTime.now().toUtc();
        final lastReadNotiAt =
            (await ConfigDb().authenticated.getDateTime(key: notiLastReadAtKey)) ?? DateTime.now().toUtc();

        if (lastNotiCreatedAt.isAfter(lastReadNotiAt)) {
          notiUnreadCount(res.notiUnreadCount);
        }
      });
    } catch (e, stackTrace) {
      _log.e('fetchNotificationListFromServer error.', e, stackTrace);

      final unreadCount = await ConfigDb().authenticated.getInt(key: notiUnreadCountKey);
      notiUnreadCount(unreadCount ?? 0);
    }
  }

  void onSelectNoti(CentralNotificationEntity? centralNoti) async {
    try {
      if (centralNoti == null) return;

      final notiType = centralNoti.notiType;

      if (group.contains(notiType)) {
        final roomId = centralNoti.data?.roomId ?? '';
        // Navigate to group profile
        await GetIt.I<ProfileService>().openGroupProfileFromNotification(
          roomId: roomId,
          groupInviteList: contactCtl.groupInviteList,
        );
      } else if (friend.contains(notiType)) {
        String? accountId = centralNoti.data?.accountId;

        if (accountId == null) {
          final list = contactCtl.friendRequestList;
          final listIndex = list.indexWhere((element) => element == accountId);

          if (listIndex != -1) {
            accountId = list[listIndex];
          }
        }

        GetIt.I<ProfileService>().openProfileScreen(
          contactId: accountId ?? '',
        );
      } else if (notiType == CentralNotiType.sendGiftSticker) {
        handleChat(centralNoti.data?.accountId);
      } else if (notiType == CentralNotiType.friendDeleted || notiType == CentralNotiType.groupDeleted) {
        // UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
      }
    } catch (e, stackTrace) {
      _log.e('updateLastTypeAt error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e is Exception ? e : null);
    }
  }

  void onAcceptFriendReq(String? id) async {
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.clickAcceptNotificationPage,
      eventProperties: EventProperty.clickAcceptNotificationPage('friends'),
    );
    if (id == null) return;

    if (ConnectivityController.instance.isOffline) {
      if (ConnectivityController.instance.isConnectMaintenanceWasOn.value) {
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
      } else {
        showOfflineDialog();
      }

      return;
    }

    try {
      UChatLoading.show(status: 'Accepting...'.tr);
      await GetIt.I<AddContactUseCase>().call(
        AddContactRequest(friendAccountId: id),
      );
      eventBus.fire(AcceptRequestEvent(id: id));
    } on ApiFriendLimitExceedException catch (_) {
      await UChatNewDialog.showFriendLimitExceededDialog();
    } on ApiOfficialAccountLimitExceedException catch (_) {
      await UChatNewDialog.showOfficialAccountLimitExceededDialog();
    } on ApiException catch (e, stackTrace) {
      if (e.exceptionType == ApiExceptionType.errorAccountHasBeenDeleted) {
        _log.w('onAcceptFriendReq ApiException account deleted error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          message: 'This account has been deleted'.tr,
        );
      }
    } catch (e, stackTrace) {
      _log.w('handleAcceptFriend error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
    }

    await UChatLoading.hide();
  }

  void onJoinGroupInvite(String? id) async {
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.clickAcceptNotificationPage,
      eventProperties: EventProperty.clickAcceptNotificationPage('groups'),
    );
    try {
      if (id == null) return;

      if (ConnectivityController.instance.isOffline) {
        if (ConnectivityController.instance.isConnectMaintenanceWasOn.value) {
          UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
        } else {
          showOfflineDialog();
        }

        return;
      }

      UChatLoading.show(status: 'Accepting...'.tr);
      await acceptRoomUseCase.call(AcceptGroupInviteRequest(roomId: id));

      eventBus.fire(AcceptRequestEvent(id: id));

      final roomCollection = await GetIt.I<RoomDb>().getRoom(id);
      roomCollection?.isJoined = true;

      if (roomCollection != null) {
        await GetIt.I<RoomDb>().putOrUpdateRoom(roomCollection);
      }

      eventBus.fire(RequireGroupInviteUpdateEvent());

      await UChatLoading.hide();
    } on ApiException catch (e, stackTrace) {
      _log.e('onJoinGroupInvite on ApiException error.', e, stackTrace);
      if (e.type == 'ERR_ROOM_MEMBER_EXCEED_LIMIT') {
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
        _log.e('ApiException onJoinGroupInvite error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!, e: e);
      }
    } catch (e, stackTrace) {
      _log.e('onJoinGroupInvite error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    } finally {
      await UChatLoading.hide();
    }
  }

  Future<void> handleApproveGroupRequest(String? requestId) async {
    if (requestId == null || requestId.isEmpty) return;

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

  void onUserLoggedOutOrBeforeSwitch() async {
    centralNotificationList([]);
  }

  void onUserLoggedOut() async {
    try {
      await clearLocalNotificationsUseCase.call(NoParams());
    } catch (e, stackTrace) {
      _log.w('onUserLoggedOut error, Cannot clear notification center from DB.', e, stackTrace);
    }
  }

  void handleChat(String? accId) async {
    String? id = await roomMemberDb.getDirectRoomIdByOtherIdInRoom(accId!);
    RoomCollection? room = await roomDb.getRoom(id!);
    final homeCtl = Get.find<HomeController>();

    if (room != null) {
      Get.offNamedUntil(
        Routes.chatRoomDirect.replaceAll(':id', room.id!),
        (r) => r.settings.name == Routes.home,
        arguments: ChatRoomArguments(room: room, fromPage: 'notificationCenter'),
      );
    }

    await Future.delayed(const Duration(milliseconds: 100));
    homeCtl.paneIndex(1);
  }

  void onSetAddContactRedDotStatus(CentralNotiType? notiType) async {
    if ([
      Routes.addContact,
      Routes.addContactByQr,
      Routes.addContactSearch,
    ].contains(Get.currentRoute)) {
      return;
    }

    if (notiType == CentralNotiType.inviteGroup) {
      ConfigDb.instance.authenticated.saveConfig(
        key: UChatConstant.groupStatus,
        value: true,
      );
    } else if (notiType == CentralNotiType.requestGroup) {
      ConfigDb.instance.authenticated.saveConfig(
        key: UChatConstant.groupRequestStatus,
        value: true,
      );
    }
  }

  void _deleteNotificationByAccountId(String accountId) async {
    try {
      final notificationsToDelete =
          centralNotificationList.where((element) => element.data?.accountId == accountId).toList();

      if (notificationsToDelete.isEmpty) return;

      await deleteNotificationsFromLocalUseCase.call(
        DeleteNotificationsParam(
          notiIds: notificationsToDelete.map((e) => e.id!).toList(),
        ),
      );
    } catch (e, stackTrace) {
      _log.e('On NotificationCenterAccountDeletedEvent error.', e, stackTrace);
    }
  }

  void showOfflineDialog() {
    UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
  }
}
