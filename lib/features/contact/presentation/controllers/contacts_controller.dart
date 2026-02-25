import 'dart:async';
import 'dart:collection';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/data/data_sources/account_service.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/implementation/screen_lag_contact_performance_service_impl.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/entities/enum/central_noti_type.dart';
import 'package:uchat/entities/enum/online_status.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/interfaces.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/entities/models/room_data_model.dart';
import 'package:uchat/features/call/data/models/models/room_call_model.dart';
import 'package:uchat/features/call/domain/params/start_call_param.dart';
import 'package:uchat/features/call/domain/user_cases/start_call_use_case.dart';
import 'package:uchat/features/call/presentation/views/widgets/dialogs/action_unavailable_dialog.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/open_direct_chat_request.dart';
import 'package:uchat/features/chat_room/domain/params/chat_room_arguments.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_rooms_type_group_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/open_direct_chat_and_save_to_db_use_case.dart';
import 'package:uchat/features/chat_room/utils/chat_room_utils.dart';
import 'package:uchat/features/chat_room_detail/data/models/models/room_invite_model.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/get_room_invite_list_use_case.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/contact/data/models/mapper/contact_mapper_extensions.dart';
import 'package:uchat/features/contact/data/models/requests/get_friend_request_request.dart';
import 'package:uchat/features/contact/data/models/requests/hide_contact_request.dart';
import 'package:uchat/features/contact/data/models/requests/remove_friend_request.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/params/block_contact_params.dart';
import 'package:uchat/features/contact/domain/params/contact_params.dart';
import 'package:uchat/features/contact/domain/params/put_contact_params.dart';
import 'package:uchat/features/contact/domain/use_cases/block_contact_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/get_all_online_friends_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/get_friend_contact_by_id_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/get_friend_contact_list_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/get_friend_request_list_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/get_official_account_contact_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/hide_contact_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/put_contact_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/remove_friend_use_case.dart';
import 'package:uchat/features/contact/presentation/arguments/contact_sorting_type.dart';
import 'package:uchat/features/contact/presentation/views/sections/contact_section.dart';
import 'package:uchat/features/contact/presentation/views/widgets/hold_contact_with_menu.dart';
import 'package:uchat/features/sync/domain/events/contact_new_event.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/features/profile/service/profile_service.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/menu_list/menu_list_item.dart';

final _log = useLogger();

class ContactsController extends GetxController with GetSingleTickerProviderStateMixin {
  static ContactsController get instance => Get.find<ContactsController>();

  late TabController listTabController;

  bool get isMobile => UChatScreenUtil.instance.isMobile;

  ScrollController? scrollController;
  final expandableListController = ExpandableListController();

  final friendRequestList = <String?>[].obs;
  final groupInviteList = <RoomInviteModel>[].obs;
  final isContactsMaintenanceWasOn = false.obs;
  final friendsCollapse = false.obs;
  final officialAccountsCollapse = false.obs;
  final friendRequestListCollapse = false.obs;
  final groupInviteListCollapse = false.obs;
  final focusSearch = false.obs;
  final friendRequestCount = 0.obs;
  final groupInviteCount = 0.obs;
  final allInviteCount = 0.obs;

  // TODO (improve) This is used in desktop version only, Update this to use ContactCollection later.
  @Deprecated('Change this to use the ContactCollection class instead.')
  final myProfileSection = ContactSection(
    'My Profile'.tr,
    [],
    0,
  ).obs;

  final officialAccountList = <ContactCollection>[].obs;
  final friendList = <ContactCollection>[].obs;
  final groupList = <RoomCollection>[].obs;

  final notiPermGranted = true.obs;

  final contactOnlineStatus = Rx<HashMap<String, Rx<OnlineStatus>>>(HashMap<String, Rx<OnlineStatus>>());
  final contactOnlineStatusTimers = HashMap<String, Timer?>();

  StreamSubscription? _contactNewSub;
  StreamSubscription? _contactUpdateSub;
  StreamSubscription? _contactDeleteSub;
  StreamSubscription? _roomNewSub;
  StreamSubscription? _roomUpdateSub;
  StreamSubscription? _roomDeleteSub;
  StreamSubscription? _updateRoomMemberSub;
  StreamSubscription? _addRoomMemberSub;
  StreamSubscription? _removeRoomMemberSub;
  StreamSubscription? _requireFriendRequestCountUpdateSub;
  StreamSubscription? _requireGroupInviteCountUpdateSub;
  StreamSubscription? _userUpdateSub;
  StreamSubscription? _appResumeSub;
  StreamSubscription? _maintenanceModeUpdateSub;
  StreamSubscription? _updateFriendRequestListSub;
  StreamSubscription? _acceptRequestSubscription;

  final AutoSizeGroup autoSizeTextGroup = AutoSizeGroup();

  bool get hasFriendRequest {
    return friendRequestCount > 0;
  }

  bool get hasGroupInvite {
    return groupInviteCount > 0;
  }

  bool get hasFriendRequestOrGroupInvite {
    return hasFriendRequest || hasGroupInvite;
  }

  final isGlobalReversed = false.obs;
  static const String _keyGlobalReversed = 'globalReversed';

  final Rx<ContactSortingType> sortingType = ContactSortingType.nameASC.obs;

  // Store the current navigation future to prevent re-entrance.
  Future<void>? _navigationFuture;

  ConnectivityController get connectivityCtl {
    return ConnectivityController.instance;
  }

  @override
  void onInit() async {
    listTabController = TabController(length: 4, vsync: this);

    _requireFriendRequestCountUpdateSub = eventBus.on<RequireFriendRequestUpdateEvent>().listen(
      (event) async {
        await fetchFriendRequestList(fetchFirstPage: true);
      },
    );

    _requireGroupInviteCountUpdateSub = eventBus.on<RequireGroupInviteUpdateEvent>().listen(
      (event) async {
        await fetchGroupInviteList();
      },
    );

    _userUpdateSub = eventBus.on<UserUpdateEvent>().listen(
      (event) {
        myProfileSection.update(
          (val) {
            if (val == null) {
              return;
            }

            val.items = [
              event.user.toContact(),
            ];
          },
        );

        initGroupListDataFromLocal();
        initFriendListDataFromLocal();
        initOAListDataFromLocal();
      },
    );

    _acceptRequestSubscription = eventBus.on<AcceptRequestEvent>().listen(
      (event) {
        onRemoveFriendRequest(event.id);
      },
    );

    _contactNewSub = eventBus.on<ContactNewEvent>().listen(
      (event) {
        List<ContactCollection> dataList;
        // Update to officialAccountList if the new contact is official account.
        if (event.contact.isOfficial) {
          dataList = officialAccountList;
        } else {
          // Update to friendList if the new contact is normal account.
          dataList = friendList;
        }
        // Add new contact to list if it is not already in the list.
        dataList.addIf(!dataList.any((e) => e.id == event.contact.id), event.contact);
        dataList.sort((first, second) {
          return first.nameLowercase?.compareTo(second.nameLowercase ?? '') ?? 0;
        });
        updateOnlineStatus(event.contact);
      },
    );

    _contactUpdateSub = eventBus.on<ContactUpdateEvent>().listen(
      (event) {
        // Update to officialAccountList if the updated contact is official account.
        if (event.contact.isOfficial) {
          final friendData = officialAccountList.firstWhereOrNull((e) => e.id == event.contact.id);
          if (friendData != null) {
            // Update contact data from event.
            friendData.update(event.contact);
            // Check whether the contact should be remove from the list. (some should be removed such as hidden or block account)
            if ((event.contact.type == ContactType.normal.value && !event.contact.canShowInFriendList) ||
                (event.contact.isOfficial && !event.contact.canShowInOfficialAccountList)) {
              officialAccountList.remove(friendData);
            }
          } else {
            // Check whether the contact should be added to the list. (some should be added such as unhidden or unblock account)
            if ((event.contact.type == ContactType.normal.value && event.contact.canShowInFriendList) ||
                (event.contact.isOfficial && event.contact.canShowInOfficialAccountList)) {
              // Add updated contact to list if it is not already in the list.
              officialAccountList.addIf(!officialAccountList.any((e) => e.id == event.contact.id), event.contact);
              officialAccountList.sort((first, second) {
                return first.nameLowercase?.compareTo(second.nameLowercase ?? '') ?? 0;
              });
            }
          }

          officialAccountList.refresh();
        } else {
          // Update to friendList if the updated contact is normal account.
          final friendData = friendList.firstWhereOrNull((e) => e.id == event.contact.id);
          if (friendData != null) {
            // Update contact data from event.
            friendData.update(event.contact);
            // Check whether the contact should be remove from the list. (some should be removed such as hidden or block account)
            if ((event.contact.type == ContactType.normal.value && !event.contact.canShowInFriendList) ||
                (event.contact.isOfficial && !event.contact.canShowInOfficialAccountList)) {
              friendList.remove(friendData);
            }
          } else {
            // Check whether the contact should be added to the list. (some should be added such as unhidden or unblock account)
            if ((event.contact.type == ContactType.normal.value && event.contact.canShowInFriendList) ||
                (event.contact.isOfficial && event.contact.canShowInOfficialAccountList)) {
              // Add updated contact to list if it is not already in the list.
              friendList.addIf(!friendList.any((e) => e.id == event.contact.id), event.contact);
              friendList.sort((first, second) {
                return first.nameLowercase?.compareTo(second.nameLowercase ?? '') ?? 0;
              });
            }
          }

          friendList.refresh();
        }

        updateOnlineStatus(event.contact);
      },
    );

    _contactDeleteSub = eventBus.on<ContactDeleteEvent>().listen(
      (event) {
        friendList.removeWhere((e) => e.id == event.contact.id);
      },
    );

    _roomNewSub = eventBus.on<RoomNewEvent>().listen(
      (event) {
        if (event.room.isGroup == false) {
          return;
        }

        groupList.addIf(!groupList.any((e) => e.id == event.room.id), event.room);
        groupList.sort((first, second) {
          return first.nameLowercase?.compareTo(second.nameLowercase ?? '') ?? 0;
        });
      },
    );

    _roomUpdateSub = eventBus.on<RoomUpdateEvent>().listen(
      (event) {
        if (event.room.isGroup == false) {
          return;
        }

        final room = groupList.firstWhereOrNull((e) => e.id == event.room.id);
        if (room != null) {
          room.update(event.room);
          groupList.sort((first, second) {
            return first.nameLowercase?.compareTo(second.nameLowercase ?? '') ?? 0;
          });
        }
      },
    );

    _roomDeleteSub = eventBus.on<RoomDeleteEvent>().listen(
      (event) {
        if (event.isDeleteInContact == false) return;
        groupList.removeWhere((e) => e.id == event.roomId);
      },
    );

    _appResumeSub = eventBus.on<AppResumedEvent>().listen(
      (event) {
        // Check permission status to update ui after going to phone setting
        checkImportantPermission();
      },
    );

    _maintenanceModeUpdateSub = eventBus.on<MaintenanceModeUpdateEvent>().listen(
      (event) {
        isContactsMaintenanceWasOn(event.isMaintenanceOn);
      },
    );

    _updateFriendRequestListSub = eventBus.on<CentralNotificationUpdateEvent>().listen(
      (event) async {
        final accountId = event.centralNoti.data?.accountId;

        if (event.centralNoti.notiType != CentralNotiType.declineFriend || accountId == null) return;

        onRemoveFriendRequest(accountId);
      },
    );

    // Load persisted sort preferences.
    loadSortingPreferences();

    super.onInit();
  }

  @override
  void onClose() async {
    scrollController?.dispose();
    expandableListController.dispose();

    await _contactNewSub?.cancel();
    await _contactUpdateSub?.cancel();
    await _contactDeleteSub?.cancel();
    await _roomNewSub?.cancel();
    await _roomUpdateSub?.cancel();
    await _updateRoomMemberSub?.cancel();
    await _addRoomMemberSub?.cancel();
    await _removeRoomMemberSub?.cancel();
    await _roomDeleteSub?.cancel();
    await _requireFriendRequestCountUpdateSub?.cancel();
    await _requireGroupInviteCountUpdateSub?.cancel();
    await _userUpdateSub?.cancel();
    await _appResumeSub?.cancel();
    await _maintenanceModeUpdateSub?.cancel();
    await _updateFriendRequestListSub?.cancel();
    await _acceptRequestSubscription?.cancel();

    clearOnlineStatusTimer();
    super.onClose();
  }

  void onUserLoaded() {
    myProfileSection.update(
      (val) {
        if (val == null) {
          return;
        }

        val.items = [
          UserController.instance.currentUser()!.toContact(),
        ];
      },
    );
    checkImportantPermission();
    initGroupListDataFromLocal();
    initFriendListDataFromLocal();
    initOAListDataFromLocal();
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

  void onUserLoggedOutOrBeforeSwitch() {
    clearOnlineStatusTimer();
    clearContactsList();
  }

  void clearOnlineStatusTimer() {
    for (var element in contactOnlineStatusTimers.values) {
      element?.cancel();
    }
  }

  void checkImportantPermission() async {
    if (UChatScreenUtil.instance.isMobilePlatform) {
      final permCtl = PermissionController.instance;
      bool notiPerm = await permCtl.getPermissionStatus(Permission.notification);

      notiPermGranted(notiPerm);
    }
  }

  int sortContact(ContactCollection a, ContactCollection b) {
    return a.showName.compareTo(b.showName);
  }

  Future<void> loadSortingPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isGlobalReversed.value = prefs.getBool(_keyGlobalReversed) ?? false;
  }

  /// This method sets the sorting type for all tab and saves it locally.
  void setSortingType(ContactSortingType type) async {
    bool reversed = (type == ContactSortingType.nameDESC);
    isGlobalReversed.value = reversed;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Save global preference
    await prefs.setBool(_keyGlobalReversed, reversed);
  }

  Future<void> clearFriendList() async {
    friendList.clear();
  }

  Future<void> initFriendListDataFromLocal() async {
    try {
      await ScreenLagContactPerformanceService.initFriendListDataFromLocal.start();
      final entities = await GetIt.I<GetFriendContactListUseCase>().call(NoParams());
      final friendContacts = entities.toCollections();
      friendList(friendContacts);

      ScreenLagContactPerformanceService.initFriendListDataFromLocal.setMetric(
        ScreenLagContactMetricName.totalFriendListCount.value,
        friendList.length,
      );
      await ScreenLagContactPerformanceService.initFriendListDataFromLocal.stop();
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('initFriendListDataFromLocal error.', e, stackTrace);
    }
  }

  Future<void> clearOAList() async {
    officialAccountList.clear();
  }

  void clearContactOnlineStatus() {
    contactOnlineStatus().clear();
  }

  Future<void> clearContactsList() async {
    clearGroupList();
    clearFriendList();
    clearOAList();
  }

  Future<void> onSyncInitAfterWriteToDb() async {
    if (DbManager().authenticatedInstance == null) {
      return;
    }

    initGroupListDataFromLocal();
    initFriendListDataFromLocal();
    initOAListDataFromLocal();
  }

  Future<void> initOAListDataFromLocal() async {
    try {
      await ScreenLagContactPerformanceService.initOAListDataFromLocal.start();
      final entities = await GetIt.I<GetOfficialAccountContactUseCase>().call(NoParams());
      officialAccountList(entities.toCollections());
      ScreenLagContactPerformanceService.initOAListDataFromLocal.setMetric(
        ScreenLagContactMetricName.totalOaListCount.value,
        officialAccountList.length,
      );
      await ScreenLagContactPerformanceService.initOAListDataFromLocal.stop();
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('initOAListDataFromLocal error in contact controller.', e, stackTrace);
      await UChatLoading.hide();
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }

  Future<void> clearGroupList() async {
    groupList.clear();
  }

  Future<void> initGroupListDataFromLocal() async {
    await ScreenLagContactPerformanceService.initGroupListDataFromLocal.start();
    final groupList = await GetIt.I<GetRoomsTypeGroupUseCase>().call(NoParams());
    if (groupList == null) {
      return;
    }
    this.groupList(groupList);
    ScreenLagContactPerformanceService.initGroupListDataFromLocal.setMetric(
      ScreenLagContactMetricName.totalGroupListCount.value,
      this.groupList.length,
    );
    await ScreenLagContactPerformanceService.initGroupListDataFromLocal.stop();
  }

  void handleSearch() async {
    GetIt.I<TaxonomyService>().sendEvent(EventName.clickSearchContactHomepage);

    Get.toNamed(Routes.contactsSearchScreen);
  }

  void onOpenAddContactScreen(BuildContext context) async {
    Get.toNamed(Routes.addContact);
  }

  Future<void> handleProfile(ContactInterface contact, String contactType) async {
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.clickContact,
      eventProperties: EventProperty.clickContact(contactType: contactType),
    );
    _runNavigation(() async {
      await GetIt.I<ProfileService>().openProfileScreen(
        contactId: contact.id!,
      );
    });
  }

  void handleGroupInfo(RoomCollection data) async {
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.clickContact,
      eventProperties: EventProperty.clickContact(contactType: 'Group'),
    );
    _runNavigation(() async {
      String roomId = data.id!;
      await GetIt.I<ProfileService>().openGroupProfile(
        roomId: roomId,
      );
    });
  }

  void handleBlockUser({
    required ContactInterface contact,
    required String contactType,
    bool quickAction = false,
  }) async {
    if (quickAction) {
      sendEventQuickAction(action: 'Block', contactType: contactType);
    } else {
      GetIt.I<TaxonomyService>().sendEvent(
        EventName.swipeActionContactPage,
        eventProperties: EventProperty.swipeActionContactPage(
          swipeAction: 'Block',
          contactType: contactType,
        ),
      );
    }

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
        } on ApiException catch (e, stackTrace) {
          if (e.type == 'ERR_EVENT_UNAVAILABLE_DURING_CALL') {
            await ActionUnavailableDialog.show();
            return;
          } else {
            _log.e('ApiException blockFriend error.', e, stackTrace);
            return;
          }
        } on FailedHostLookupException catch (_) {
          UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
        } catch (e, stackTrace) {
          _log.e('blockFriend error.', e, stackTrace);
        }
      },
    );
    if (!isConfirmed) return;
  }

  void handleRemoveFriend(
    ContactInterface contact,
    String contactType,
  ) async {
    sendEventQuickAction(action: 'Delete', contactType: contactType);

    final isConfirmed = await UChatNewDialog.showDialog(
      context: Get.context!,
      title: 'Delete this account'.tr,
      description: 'Do you want to unfriend "@userDisplayName" and remove it form your friends list?'.trParams({
        'userDisplayName': contact.displayName ?? '',
      }),
      cancelText: 'Cancel'.tr,
      confirmText: 'Delete'.tr,
      confirmTextColor: Get.context!.theme.appColors.textError,
      cancelTextColor: Get.context!.theme.appColors.textLight,
      isDestructive: true,
      onConfirm: () async {
        try {
          await GetIt.I<RemoveFriendUseCase>().call(
            RemoveFriendRequest(
              friendAccountId: contact.id!,
            ),
          );
          friendList.removeWhere((item) => item.id == contact.id);

          // Update the contact in local database to reflect unfriended status
          // This prevents the contact from reappearing when ContactUpdateEvent fires
          final contactToUpdateEntity =
              await GetIt.I<GetFriendContactByIdUseCase>().call(ContactParams(accountId: contact.id!));
          final contactToUpdate = contactToUpdateEntity?.toCollection();
          if (contactToUpdate != null) {
            contactToUpdate.isFriend = false;
            await GetIt.I<PutContactUseCase>().call(PutContactParams(contact: contactToUpdate.toEntity()));
            _log.d('Updated contact isFriend status to false in database: ${contact.id}');
          }
        } on ApiException catch (e, stackTrace) {
          if (e.type == 'ERR_EVENT_UNAVAILABLE_DURING_CALL') {
            await ActionUnavailableDialog.show();
            return;
          } else {
            _log.e('ApiException removeFriend error.', e, stackTrace);
            return;
          }
        } on FailedHostLookupException catch (_) {
          UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
        } catch (e, stackTrace) {
          _log.e('removeFriend error.', e, stackTrace);
        }
      },
    );
    if (!isConfirmed) return;
  }

  void handleLeaveGroup({
    required RoomCollection room,
    bool quickAction = false,
  }) async {
    if (quickAction) {
      sendEventQuickAction(action: 'Leave group', contactType: 'Group');
    } else {
      GetIt.I<TaxonomyService>().sendEvent(
        EventName.swipeActionContactPage,
        eventProperties: EventProperty.swipeActionContactPage(
          swipeAction: 'Leave group',
          contactType: 'Group',
        ),
      );
    }

    GetIt.I<IChatRoomUtils>().showLeaveGroupDialogWithoutTransferOwner(room.toEntity());
  }

  void handleHideContact(
      {required ContactInterface contact, required String contactType, bool quickAction = false}) async {
    if (quickAction) {
      sendEventQuickAction(action: 'Hide', contactType: contactType);
    } else {
      GetIt.I<TaxonomyService>().sendEvent(
        EventName.swipeActionContactPage,
        eventProperties: EventProperty.swipeActionContactPage(
          swipeAction: 'Hide',
          contactType: contactType,
        ),
      );
    }

    List<String> accountIdList = [contact.id!];
    final isConfirmed = await UChatNewDialog.showDialog(
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
        } on ApiException catch (e, stackTrace) {
          if (e.type == 'ERR_EVENT_UNAVAILABLE_DURING_CALL') {
            await ActionUnavailableDialog.show();
            return;
          } else {
            _log.e('ApiException hideContact error.', e, stackTrace);
            return;
          }
        } on FailedHostLookupException catch (_) {
          UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
        } catch (e, stackTrace) {
          _log.e('hideContact error.', e, stackTrace);
        }
      },
    );
    if (!isConfirmed) return;
  }

  void handleCall(
    dynamic contact,
    String contactType,
  ) async {
    sendEventQuickAction(action: 'Call', contactType: contactType);

    final room = await getRoomHelper(contact);
    if (room == null) {
      return;
    }
    final param = StartCallParam(
      callData: RoomCallModel.generateDirectCall(room, CallType.voice),
    );
    GetIt.I<TaxonomyService>()
        .sendEvent(EventName.clickVoiceCall, eventProperties: EventProperty.clickVoiceCall('contact'));
    await GetIt.I<StartCallUseCase>().call(param);
  }

  void handleOpenChat(dynamic contact, String contactType) async {
    sendEventQuickAction(action: 'Chat', contactType: contactType);

    final room = await getRoomHelper(contact);

    if (room != null && room.id != null) {
      Get.toNamed(
        Routes.chatRoomDirect.replaceAll(':id', room.id!),
        arguments: ChatRoomArguments(room: room, fromPage: 'contract'),
      );
    }
  }

  Future<RoomCollection?> getRoomHelper(contact) async {
    RoomCollection? room;

    if (contact is ContactInterface) {
      try {
        final roomId = GetIt.I<RoomMemberDb>().getDirectRoomIdByOtherIdInRoomSync(contact.id!);
        room = GetIt.I<RoomDb>().getRoomSync(roomId!);
      } catch (_) {
        _log.w('getRoomHelper getDirectRoomIdByOtherIdInRoomSync error.');
      }
    }

    if (room == null && contact is ContactInterface) {
      UChatLoading.show();

      try {
        final roomId = await GetIt.I<RoomMemberDb>().getDirectRoomIdByOtherIdInRoom(contact.id!);
        room = await GetIt.I<RoomDb>().getRoom(roomId!);
      } catch (_) {
        _log.w('getRoomHelper getDirectRoomIdByOtherIdInRoom error.');
      }
    } else if (contact is RoomDataModel) {
      room = contact.room();
    } else if (contact is RoomCollection) {
      room = contact;
    }

    if (room == null && contact is ContactInterface) {
      UChatLoading.show();

      try {
        final roomEntity = await GetIt.I
            .get<OpenDirectChatAndSaveToDbUseCase>()
            .call(OpenDirectChatRequest(friendAccountId: contact.id!));
        if (roomEntity != null) {
          room = RoomCollection.fromEntity(roomEntity);
        }
      } catch (e, stackTrace) {
        handleException(e, onUnknownException: () async {
          _log.e('handleChat openDirectChat error.', e, stackTrace);
          await UChatLoading.hide();
          UChatNewDialog.showGeneralErrorDialog(
            context: Get.context!,
          );
        });
      }
    }
    UChatLoading.hide();

    return room;
  }

  Future<void> onRemoveFriendRequest(String accountId) async {
    try {
      final index = friendRequestList.indexWhere((id) => id == accountId);

      if (index == -1) return;

      friendRequestList.removeAt(index);
      friendRequestCount.value--;
      allInviteCount(groupInviteCount() + friendRequestCount());
    } catch (e, stackTrace) {
      _log.e('onRemoveFriendRequest error.', e, stackTrace);
    }
  }

  Future<void> fetchFriendRequestList({
    int pageSize = 50,
    bool fetchFirstPage = false,
  }) async {
    if (UserController.instance.currentUser() == null) {
      return;
    }

    try {
      int totalPages = 0;
      PaginationPayload<ContactEntity>? contactResp;
      contactResp = await GetIt.I<GetFriendRequestListUseCase>().call(GetFriendRequestRequest(
        page: 1,
        pageSize: pageSize,
      ));

      if (contactResp == null) return;

      totalPages = contactResp.totalPages;
      final newList = (contactResp.data?.map((e) => e.id) ?? []).toList();

      if (fetchFirstPage) {
        // Fetch only first page to update friend request list
        addNewRequestToFriendRequestList(newList);
        return;
      } else {
        friendRequestList.addAll(newList);
        friendRequestCount(contactResp.total);
        allInviteCount(groupInviteCount() + friendRequestCount());
      }

      for (int i = 2; i < totalPages; i++) {
        contactResp = await GetIt.I<GetFriendRequestListUseCase>().call(GetFriendRequestRequest(
          page: i,
          pageSize: pageSize,
        ));

        if (contactResp == null) continue;

        final newList = (contactResp.data?.map((e) => e.id) ?? []).toList();

        friendRequestList.addAll(newList);
        friendRequestCount(contactResp.total);
        allInviteCount(groupInviteCount() + friendRequestCount());
      }
    } catch (e, stackTrace) {
      _log.e('fetchFriendRequestList error.', e, stackTrace);
    }
  }

  void addNewRequestToFriendRequestList(List<String?> newRequestList) {
    for (final data in newRequestList) {
      if (!friendRequestList.contains(data)) {
        friendRequestList.add(data);
        friendRequestCount.value++;
        allInviteCount(groupInviteCount() + friendRequestCount());
      }
    }
  }

  Future<void> fetchGroupInviteList() async {
    if (UserController.instance.currentUser() == null) {
      return;
    }

    try {
      final groupResp = await GetIt.I<GetRoomInviteListUseCase>().call(NoParams());
      if (groupResp == null) {
        _log.e('GetRoomInviteListUseCase return null.');
        return;
      }
      groupInviteList(groupResp.rooms);
      groupInviteCount(groupResp.roomsCount);
      allInviteCount(groupInviteCount() + friendRequestCount());
    } catch (e, stackTrace) {
      _log.e('fetchGroupInviteList error.', e, stackTrace);
    }
  }

  void addNewFriendRequestToList(data) {
    final newFriendRequest = ContactCollection.fromMap(data['friendData']);

    if (newFriendRequest.id == null) return;

    friendRequestList.add(newFriendRequest.id!);
    friendRequestCount(data['friendRequestCount']);
    allInviteCount(groupInviteCount() + friendRequestCount());
  }

  void addNewGroupInviteToList(data) {
    for (final room in data['roomData']) {
      final newGroupInvite = RoomInviteModel.fromMap(room);
      switch (data['type']) {
        case 'UPDATE_ROOM':
          if (groupInviteList.contains(newGroupInvite)) {
            groupInviteList[groupInviteList.indexWhere((element) => element == newGroupInvite)] = newGroupInvite;
          } else {
            groupInviteList.add(newGroupInvite);
          }
          break;
        case 'DELETE_ROOM':
          groupInviteList.removeWhere((element) => element == newGroupInvite);
          break;
        default:
          break;
      }
    }

    groupInviteCount(data['roomRequestCount']);
    allInviteCount(groupInviteCount() + friendRequestCount());
  }

  /// Update online status using data from [contact]
  void updateOnlineStatus(ContactCollection contact) {
    OnlineStatus onlineStatus;
    // Check whether this contact last seen at is within [secondsInOnlineStatus] seconds
    bool isOnline = isContactOnline(contact);
    if (isOnline) {
      // If last seen at is within [secondsInOnlineStatus] seconds, Save data from
      // contact to state.
      onlineStatus = contact.onlineStatus ?? OnlineStatus.online;
    } else {
      onlineStatus = OnlineStatus.offline;
    }
    if (isOnline) {
      if (contactOnlineStatusTimers[contact.id] != null) {
        // If there is timer already, Cancel the old one to setup a new one with
        // updated delay.
        contactOnlineStatusTimers[contact.id!]?.cancel();
      }
      // Set timer to reset online status to offline
      final timeDiff = DateTime.now().difference(contact.lastSeenAt!);
      final delay = UChatConstant.secondsInOnlineStatus - timeDiff.inSeconds + 1;
      contactOnlineStatusTimers[contact.id!] = Timer(
        Duration(seconds: delay),
        () {
          contactOnlineStatus.value[contact.id!] = OnlineStatus.offline.obs;
          contactOnlineStatus.refresh();
        },
      );
    }
    // Save online status in this controller.
    contactOnlineStatus.value[contact.id!] = onlineStatus.obs;
    contactOnlineStatus.refresh();
  }

  bool isContactOnline(ContactCollection contact) {
    if (contact.lastSeenAt == null) return false;
    final timeDiff = DateTime.now().difference(contact.lastSeenAt!);
    bool onlineStatus = timeDiff.inSeconds <= UChatConstant.secondsInOnlineStatus;

    return onlineStatus;
  }

  void updateAllFriendLastSeen() async {
    if (UserController.instance.currentUser() == null) {
      return;
    }

    try {
      final dataList = await AccountService().getAllFriendLastSeen();
      if (dataList != null) {
        // Update local db with data from server.
        for (final res in dataList) {
          final contactEntity =
              await GetIt.I<GetFriendContactByIdUseCase>().call(ContactParams(accountId: res.friendAccountId));
          final contact = contactEntity?.toCollection();
          if (contact != null) {
            contact.lastSeenAt = res.lastSeenAt;
            contact.onlineStatus = res.onlineStatus;

            try {
              await GetIt.I<PutContactUseCase>().call(PutContactParams(contact: contact.toEntity()));
              eventBus.fire(ContactUpdateEvent(contact: contact));
              updateOnlineStatus(contact);
            } catch (e, stacktrace) {
              _log.e(
                'put contact in updateAllFriendLastSeen error.',
                e,
                stacktrace,
              );
            }
          } else {
            // _log.w('local contact is null in updateAllFriendLastSeen. account id : ${res.friendAccountId}');
          }
        }
      }
      // Put all online friend in ContactsController state.
      final entities = await GetIt.I<GetAllOnlineFriendsUseCase>().call(NoParams());
      final onlineFriendList = entities.toCollections();
      for (final contact in onlineFriendList) {
        updateOnlineStatus(contact);
      }
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('updateAllFriendLastSeen error : $e', e, stackTrace);
    }
  }

  /// Handle long press contact list item
  ///
  /// Show dialog with options:
  Future<void> onLongPressContactListItem(BuildContext context, dynamic contact) async {
    GetIt.I<TaxonomyService>().sendEvent(EventName.longPressContactPage);

    if (contact is ContactInterface) {
      // TODO: clean architecture
      // p'mickey or p'nut please comment for me on github, i'll change later i promise, for now i wanna finish another card on time.
      // thank you kub please be mercy
      if (contact.isOfficial) {
        await HoldContactWithMenu.show<ContactInterface>(
          contact,
          [
            MenuListItem(
                text: 'Chat'.tr,
                suffixIcon: Assets.vectors.iconChat.svg(
                  colorFilter: ColorFilter.mode(
                    context.theme.appColors.icon,
                    BlendMode.srcIn,
                  ),
                ),
                onTap: () {
                  Get.back();
                  handleOpenChat(contact, 'Official account');
                }),
            MenuListItem(
              text: 'Hide'.tr,
              suffixIcon: Assets.vectors.iconHide.svg(),
              onTap: () {
                Get.back();
                handleHideContact(contact: contact, contactType: 'Official account', quickAction: true);
              },
            ),
            MenuListItem(
              text: 'Block'.tr,
              textColor: context.theme.appColors.textError,
              suffixIcon: Assets.vectors.iconBlock.svg(),
              onTap: () {
                Get.back();
                handleBlockUser(contact: contact, contactType: 'Official account', quickAction: true);
              },
            ),
            MenuListItem(
              text: 'Delete'.tr,
              textColor: context.theme.appColors.textError,
              suffixIcon: Assets.vectors.trash.svg(),
              onTap: () {
                Get.back();
                handleRemoveFriend(contact, 'Official account');
              },
            ),
          ],
        );
      } else if (contact.isFriend) {
        await HoldContactWithMenu.show<ContactInterface>(
          contact,
          [
            MenuListItem(
                text: 'Chat'.tr,
                suffixIcon: Assets.vectors.iconChat.svg(
                  colorFilter: ColorFilter.mode(
                    context.theme.appColors.icon,
                    BlendMode.srcIn,
                  ),
                ),
                onTap: () {
                  Get.back();
                  handleOpenChat(contact, 'Friend');
                }),
            MenuListItem(
                text: 'Voice call'.tr,
                suffixIcon: Assets.vectors.iconCall.svg(
                  colorFilter: ColorFilter.mode(
                    context.theme.appColors.icon,
                    BlendMode.srcIn,
                  ),
                ),
                onTap: () async {
                  Get.back();
                  handleCall(contact, 'Friend');
                }),
            MenuListItem(
              text: 'Hide'.tr,
              suffixIcon: Assets.vectors.iconHide.svg(),
              onTap: () {
                Get.back();
                handleHideContact(contact: contact, contactType: 'Friend', quickAction: true);
              },
            ),
            MenuListItem(
              text: 'Block'.tr,
              textColor: context.theme.appColors.textError,
              suffixIcon: Assets.vectors.iconBlock.svg(),
              onTap: () {
                Get.back();
                handleBlockUser(contact: contact, contactType: 'Friend', quickAction: true);
              },
            ),
            MenuListItem(
              text: 'Delete'.tr,
              textColor: context.theme.appColors.textError,
              suffixIcon: Assets.vectors.trash.svg(),
              onTap: () {
                Get.back();
                handleRemoveFriend(contact, 'Friend');
              },
            ),
          ],
        );
      }
    } else if (contact is RoomCollection) {
      await HoldContactWithMenu.show<RoomCollection>(
        contact,
        [
          MenuListItem(
            text: 'Group chat'.tr,
            suffixIcon: Assets.vectors.iconChat.svg(
              colorFilter: ColorFilter.mode(
                context.theme.appColors.icon,
                BlendMode.srcIn,
              ),
            ),
            onTap: () {
              Get.back();
              handleOpenChat(contact, 'Group');
            },
          ),
          MenuListItem(
            text: 'Leave'.tr,
            textColor: context.theme.appColors.textError,
            suffixIcon: Assets.vectors.iconLeaveGroup.svg(),
            onTap: () {
              Get.back();
              handleLeaveGroup(room: contact, quickAction: true);
            },
          ),
        ],
      );
    } else {
      _log.e('no type support for this ${contact.runtimeType}');
    }
  }

  void sendEventQuickAction({
    required String action,
    required String contactType,
  }) async {
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.clickLongPressAction,
      eventProperties: EventProperty.clickLongPressAction(
        longPressQuickAction: action,
        contactType: contactType,
      ),
    );
  }
}
