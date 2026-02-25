import 'dart:async';
import 'dart:ui';

import 'package:dlibphonenumber/dlibphonenumber.dart' as dlib;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/domain/entities/share_bottom_sheet_data_entity.dart';
import 'package:uchat/core/domain/services/url_service.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/api_friend_limit_exceed_exception.dart';
import 'package:uchat/core/exceptions/api_official_account_limit_exceed_exception.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/services/sharing/sharing_service.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/entities/enum/contact_type.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/entities/interfaces.dart';
import 'package:uchat/entities/models/contact_model.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/call/data/models/models/room_call_model.dart';
import 'package:uchat/features/call/domain/params/start_call_param.dart';
import 'package:uchat/features/call/domain/user_cases/start_call_use_case.dart';
import 'package:uchat/features/call/presentation/views/widgets/dialogs/action_unavailable_dialog.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/open_direct_chat_request.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/params/chat_room_arguments.dart';
import 'package:uchat/features/chat_room/domain/params/chat_room_params.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_room_subscription_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/open_direct_chat_and_save_to_db_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/params/toggle_mute_room_params.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list_actions/toggle_mute_room_use_case.dart';
import 'package:uchat/features/contact/data/models/requests/add_contact_request.dart';
import 'package:uchat/features/contact/data/models/requests/add_friend_in_group_request.dart';
import 'package:uchat/features/contact/domain/params/block_contact_params.dart';
import 'package:uchat/features/contact/domain/params/unblock_contact_params.dart';
import 'package:uchat/features/contact/domain/use_cases/add_contact_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/add_friend_in_group_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/block_contact_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/unblock_contact_use_case.dart';
import 'package:uchat/features/profile/domain/entities/profile_entity.dart';
import 'package:uchat/features/profile/domain/use_cases/get_profile_local_use_case.dart';
import 'package:uchat/features/profile/domain/use_cases/get_profile_server_use_case.dart';
import 'package:uchat/features/profile/domain/use_cases/get_room_by_account_id_use_case.dart';
import 'package:uchat/features/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:uchat/features/profile/presentation/arguments/profile_arguments.dart';
import 'package:uchat/features/report/data/models/enum/report_type.dart';
import 'package:uchat/features/report/presentation/controller/main_dialog_controller.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';
import 'package:uchat/widgets/qr_code/qr_code_bottom_sheet.dart';

class ProfileControllerV2 extends GetxController {
  final String accountId;
  final ProfileArgumentsV2? args;
  final LoggerService log;
  final TaxonomyService taxonomyService;
  final GetProfileLocalUseCase getProfileLocalUseCase;
  final GetProfileServerUseCase getProfileServerUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final StartCallUseCase startCallUseCase;
  final GetRoomByAccountIdUseCase getRoomByAccountIdUseCase;
  final GetRoomSubscriptionUseCase getRoomSubscriptionUseCase;
  final OpenDirectChatAndSaveToDbUseCase openDirectChatAndSaveToDbUseCase;
  final AddFriendInGroupUseCase addFriendInGroupUseCase;
  final AddContactUseCase addContactUseCase;
  final BlockContactUseCase blockContactUseCase;
  final UnblockContactUseCase unblockContactUseCase;
  final ToggleMuteRoomUseCase toggleMuteRoomUseCase;

  ProfileControllerV2({
    required this.accountId,
    this.args,
    required this.log,
    required this.taxonomyService,
    required this.getProfileLocalUseCase,
    required this.getProfileServerUseCase,
    required this.updateProfileUseCase,
    required this.startCallUseCase,
    required this.getRoomByAccountIdUseCase,
    required this.getRoomSubscriptionUseCase,
    required this.openDirectChatAndSaveToDbUseCase,
    required this.addFriendInGroupUseCase,
    required this.addContactUseCase,
    required this.blockContactUseCase,
    required this.unblockContactUseCase,
    required this.toggleMuteRoomUseCase,
  });

  final profile = Rxn<ProfileEntity>();
  final isMuted = false.obs;
  final room = Rxn<RoomEntity>();

  final loading = false.obs;
  final loadingProfile = false.obs;

  StreamSubscription? _roomUpdateSubscription;
  StreamSubscription? _contactUpdateSubscription;
  StreamSubscription? _contactDeleteSubscription;
  StreamSubscription? _userUpdateSubscription;
  StreamSubscription? _roomNewSubscription;
  StreamSubscription? _roomDeleteSubscription;

  /// default value is true
  bool get hidePhoneNumber =>
      (profile.value?.settings.profile?.hiddenPhoneNumber ?? true) || ((profile.value?.phoneNumber ?? '').isEmpty);

  bool get allowAddFriend => profile.value?.settings.friend?.allowFriendAdd?.enabled ?? false;

  bool get allowAddByPhoneNumber => profile.value?.settings.friend?.allowFriendAdd?.canAddByPhoneNumber ?? false;

  bool get allowAddByUsername => profile.value?.settings.friend?.allowFriendAdd?.canAddByUsername ?? false;

  bool get allowAddFromGroup => profile.value?.settings.friend?.allowFriendAdd?.canAddFromGroup ?? false;

  bool get isBlocked => profile.value?.isBlocked ?? false;

  bool get isFriend => profile.value?.isFriend ?? false;

  bool get showAddFriendButton => allowAddFriend && allowAddFromGroup;

  bool get showCallButton => !isBlocked && profile.value?.type == ContactType.normal;

  bool get canEditProfile => profile.value?.type == ContactType.normal && isFriend;

  String get formattedPhoneNumber {
    final rawPhoneNumber = profile.value?.phoneNumber;

    if (rawPhoneNumber == null || rawPhoneNumber.isEmpty) {
      return 'Phone number not found'.tr; // Fallback message
    }

    try {
      final parsed = dlib.PhoneNumberUtil.instance.parse(rawPhoneNumber, 'ZZ');
      final formatted = dlib.PhoneNumberUtil.instance.format(parsed, dlib.PhoneNumberFormat.international);

      return formatted; // “+66 81 234 5678”
    } catch (e, st) {
      log.w('Could not format phone "$rawPhoneNumber": $e', e, st);
      return rawPhoneNumber; // Fallback message
    }
  }

  @override
  void onInit() async {
    super.onInit();
    loading.value = true;
    await fetchProfile();
    await initialSubscription();
    loading.value = false;
  }

  @override
  void onClose() async {
    await _roomUpdateSubscription?.cancel();
    await _contactUpdateSubscription?.cancel();
    await _contactDeleteSubscription?.cancel();
    await _userUpdateSubscription?.cancel();
    await _roomNewSubscription?.cancel();
    await _roomDeleteSubscription?.cancel();
    super.onClose();
  }

  Future<void> fetchProfile() async {
    try {
      loadingProfile.value = true;
      final profileLocal = await getProfileLocalUseCase.call(accountId);
      if (profileLocal != null) {
        profile.value = profileLocal;
        // If local profile found, update it with server data.
        profile.value = await updateProfileUseCase.call(accountId);
      } else {
        // If local profile not found, fetch from server.
        profile.value = await getProfileServerUseCase.call(accountId);
      }
    } catch (e, stackTrace) {
      log.e('getProfileById error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    } finally {
      loadingProfile.value = false;
    }
  }

  Future<void> initialSubscription() async {
    if (isFriend) {
      await getRoomByAccountId(accountId);
      await getRoomSubscription();
      _roomUpdateSubscription = eventBus.on<RoomUpdateSubscriptionEvent>().listen((event) {
        if (room.value?.id == event.roomSubscription.id) {
          // roomSubscriptionEntity.value = event.roomSubscription;
          isMuted.value = event.roomSubscription.isMuted ?? false;
        }
      });
      _contactUpdateSubscription = eventBus.on<ContactUpdateEvent>().listen(
        (event) {
          if (event.contact.id == accountId) {
            updateProfileFromContact(event.contact);
          }
        },
      );
      _contactDeleteSubscription = eventBus.on<ContactDeleteEvent>().listen(
        (event) {
          if (event.contact.id == accountId) {
            updateProfileFromContact(event.contact);
          }
        },
      );
      _userUpdateSubscription = eventBus.on<UserUpdateEvent>().listen((event) {
        if (event.user.id == accountId) {
          updateProfileFromContact(event.user.toContact());
        }
      });
      _roomNewSubscription = eventBus.on<RoomNewEvent>().listen((event) {
        if (event.room.id == room.value?.id) {
          room.value = event.room.toEntity();
        }
      });
      _roomUpdateSubscription = eventBus.on<RoomUpdateEvent>().listen((event) {
        if (event.room.id == room.value?.id) {
          room.value = event.room.toEntity();
        }
      });
      _roomDeleteSubscription = eventBus.on<RoomDeleteEvent>().listen((event) {
        if (event.roomId == room.value?.id) {
          log.d('DeleteRoom: ${event.roomId}');
          room.value = room.value?.copyWith(
            isJoined: false,
          );
        }
      });
    }
  }

  Future<void> getRoomSubscription() async {
    if (room.value == null) {
      log.e('getRoomSubscription: roomId not found.');
      return;
    }
    try {
      final response = await getRoomSubscriptionUseCase.call(
        ChatRoomParams(
          roomId: room.value!.id,
        ),
      );
      isMuted.value = response?.isMuted ?? false;
    } catch (e) {
      if (e is FailedHostLookupException) {
        UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
      } else {
        log.e('getRoomSubscription error.', e);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: e is Exception ? e : null,
        );
      }
    }
  }

  Future<void> updateProfileFromContact(ContactInterface contact) async {
    try {
      profile.value = profile.value?.copyWith(
        id: contact.id,
        username: contact.username,
        phoneNumber: contact.phoneNumber,
        statusMessage: contact.originalStatusMessage,
        isFriend: contact.isFriend,
        isBlocked: contact.blocked,
        displayName: contact.displayName,
        avatarId: contact.avatarId,
        deleted: contact.isDeleted,
        settings: contact.settings,
        onlineStatus: contact.onlineStatus,
        friendNickname: contact.nickname,
      );
    } catch (e, stackTrace) {
      log.e('updateProfileFromContact error.', e, stackTrace);
    }
  }

  Future<void> getRoomByAccountId(String accountId) async {
    try {
      // UChatLoading.show(status: 'Loading...'.tr);
      final response = await getRoomByAccountIdUseCase.call(accountId);
      if (response != null) {
        room.value = response;
        return;
      }
      // If room not found in local db get it from server.
      final roomEntity = await openDirectChatAndSaveToDbUseCase.call(
        OpenDirectChatRequest(friendAccountId: accountId),
      );
      if (roomEntity != null) {
        room.value = roomEntity;
      }
    } catch (e, stackTrace) {
      if (e is FailedHostLookupException) {
        UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
      } else {
        log.e('getRoomByAccountId error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      }
    }
    return;
  }

  void handleEditNickname() {
    Get.toNamed(
      Routes.profileNickname.replaceAll(':id', accountId),
    );
  }

  void handleCall(CallType callType) async {
    UChatNewDialog.showDialog(
      context: Get.context!,
      title: callType == CallType.voice
          ? 'Start a voice call with @name?'.trParams({'name': profile.value?.getName ?? ''})
          : 'Start a video call with @name?'.trParams({'name': profile.value?.getName ?? ''}),
      confirmText: 'Start Call'.tr,
      confirmTextColor: Get.context!.theme.appColors.textPrimary,
      onConfirm: () {
        _uChatCall(callType);
      },
    );
  }

  void _uChatCall(CallType callType) async {
    try {
      if (room.value != null) {
        final param = StartCallParam(
          callData: RoomCallModel.generateDirectCall(
            RoomCollection.fromEntity(room.value!),
            callType,
          ),
        );
        if (callType == CallType.video) {
          taxonomyService.sendEvent(
            EventName.clickVideoCall,
            eventProperties: EventProperty.clickVideoCall('profile'),
          );
        } else {
          taxonomyService.sendEvent(
            EventName.clickVoiceCall,
            eventProperties: EventProperty.clickVoiceCall('profile'),
          );
        }
        await startCallUseCase.call(param);
      }
    } catch (e) {
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        message: 'Call failed.'.tr,
      );
    }
  }

  void handlePhoneCall() {
    if ((profile.value?.phoneNumber ?? '').isEmpty) {
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        message: 'Phone number not found.'.tr,
      );
      return;
    }

    final phoneNumber = profile.value!.phoneNumber;
    if (phoneNumber == null || phoneNumber.isEmpty) {
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        message: 'Phone number not found.'.tr,
      );
      return;
    }

    GetIt.I<UrlService>().tel(phoneNumber);
  }

  void handleShowMyQR() {
    if (profile.value == null) {
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        message: 'Profile not found.'.tr,
      );
      return;
    }
    QrCodeBottomSheet.show(
      displayName: profile.value!.shortDisplayName,
      username: profile.value!.username,
    );
  }

  void handleCopyUchatId() {
    final uchatId = profile.value?.username;

    if (uchatId == null || uchatId.isEmpty) {
      return;
    }

    // haptic feedback for better UX
    HapticFeedback.lightImpact();

    Clipboard.setData(ClipboardData(text: uchatId));

    final context = Get.context;
    if (context != null) {
      // Show success toast
      AppToast.showToast(
        context: context,
        message: 'copied UChat ID'.tr,
        icon: Assets.vectors.contentCopy.svg(
          colorFilter: ColorFilter.mode(
            context.theme.appColors.iconPrimaryInverse,
            BlendMode.srcIn,
          ),
        ),
      );
    }
  }

  void handleChat() async {
    if (room.value != null) {
      Get.back();
      Get.toNamed(
        Routes.chatRoomDirect.replaceAll(':id', room.value!.id),
        arguments: ChatRoomArguments(room: RoomCollection.fromEntity(room.value!)),
      );
    }
  }

  void handleAddFriend() async {
    if (args?.fromGroup ?? false) {
      _handleAddFriendFromGroup(accountId);
    } else {
      _handleAddFriend(accountId);
    }
  }

  void _handleAddFriendFromGroup(String id) async {
    final roomId = args?.roomId;

    if (roomId == null) {
      return;
    }

    try {
      await UChatLoading.show(status: 'Loading...'.tr);
      await addFriendInGroupUseCase.call(
        AddFriendInGroupRequest(
          friendAccountId: id,
          roomId: roomId,
        ),
      );

      await UChatLoading.hide();
      profile.value = profile.value?.copyWith(
        isFriend: true,
      );
      initialSubscription();
      eventBus.fire(AcceptRequestEvent(id: id));
    } on ApiFriendLimitExceedException catch (_) {
      await UChatLoading.hide();
      await UChatNewDialog.showFriendLimitExceededDialog();
    } on ApiOfficialAccountLimitExceedException catch (_) {
      await UChatLoading.hide();
      await UChatNewDialog.showOfficialAccountLimitExceededDialog();
    } on ApiException catch (e, stackTrace) {
      await UChatLoading.hide();
      if (e.name == 'AccountIsNotMemberOfGroupError') {
        log.e('addFriendFromGroup error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          message: 'This account is not member of the group.'.tr,
        );
      } else if (e.name == 'FriendNotAllowGroupAddFriendError') {
        log.e('addFriendFromGroup error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          message: 'This account does not allow add friend from group.'.tr,
        );
      } else {
        log.e('addFriendFromGroup SocketException error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          message: 'Add friend failed.'.tr,
        );
      }
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      log.e('addFriendFromGroup error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
    }
  }

  void _handleAddFriend(String id) async {
    await UChatLoading.show(status: 'Updating...'.tr);
    try {
      await addContactUseCase.call(
        AddContactRequest(friendAccountId: id),
      );

      // If a valid contact is returned, update UI state.
      profile.value = profile.value?.copyWith(
        isFriend: true,
      );

      initialSubscription();
      eventBus.fire(AcceptRequestEvent(id: id));
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(
        context: Get.context!,
      );
    } on ApiFriendLimitExceedException catch (_) {
      await UChatNewDialog.showFriendLimitExceededDialog();
    } on ApiOfficialAccountLimitExceedException catch (_) {
      await UChatNewDialog.showOfficialAccountLimitExceededDialog();
    } catch (e, stackTrace) {
      log.e('handleAdd error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
      );
    } finally {
      await UChatLoading.hide();
      eventBus.fire(RequireFriendRequestUpdateEvent());
    }
  }

  void handleShareContact() {
    GetIt.I<SharingService>().share(
      data: ShareBottomSheetDataEntity(
        newMessage: MessageCollection(
          type: MessageType.contact,
          shareContactId: accountId,
          contact: ContactModel(
            id: accountId,
            avatarId: profile.value?.avatarId,
            nickname: profile.value?.friendNickname,
            displayName: profile.value?.displayName,
            originalStatusMessage: profile.value?.statusMessage,
          ),
        ),
      ),
    );
  }

  void handleToggleMuteChat() async {
    if (room.value == null) {
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        message: 'Room not found.'.tr,
      );
      return;
    }
    await UChatLoading.show(status: 'Processing...'.tr);
    try {
      final response = await toggleMuteRoomUseCase.call(
        ToggleMuteRoomParams(
          roomId: room.value!.id,
          isMuted: !isMuted.value,
        ),
      );
      if (response != null) {
        isMuted.value = response;
        await UChatLoading.success(
          message: response ? 'Muted'.tr : 'Unmuted'.tr,
        );
      }
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(
        context: Get.context!,
      );
    } catch (e, stackTrace) {
      log.e('handleToggleMuteChat error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }

    await UChatLoading.hide();
  }

  Future<void> handleBlockUser() async {
    try {
      await UChatLoading.show(status: 'Updating...'.tr);
      await blockContactUseCase.call(
        BlockContactParams(
          contactIds: [accountId],
        ),
      );
      profile.value = profile.value?.copyWith(
        isBlocked: true,
      );
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(
        context: Get.context!,
      );
    } catch (e, stackTrace) {
      log.e('handleBlockUser error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    } finally {
      await UChatLoading.hide();
    }
  }

  Future<void> handleUnblock() async {
    try {
      await UChatLoading.show(status: 'Processing...'.tr);
      await unblockContactUseCase.call(
        UnblockContactParams(
          contactIds: [accountId],
        ),
      );
      profile.value = profile.value?.copyWith(
        isBlocked: false,
      );

      await UChatLoading.success(message: 'Unblocked.'.tr);
    } on FailedHostLookupException catch (_) {
      await UChatLoading.hide();
      UChatNewDialog.showYouAreOfflineDialog(
        context: Get.context!,
      );
    } catch (e, stackTrace) {
      log.e('handleUnblock error.', e, stackTrace);
      await UChatLoading.hide();
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
      );
    }
  }

  void showDialogBlockUser() {
    if (room.value != null) {
      if (UChatCallController.instance.roomIsCalling(room.value!.id)) {
        ActionUnavailableDialog.show();
        return;
      }
    }

    UChatNewDialog.showBlockUserDialog(
      context: Get.context!,
      name: profile.value?.getName ?? '',
      onConfirm: () {
        handleBlockUser();
      },
    );
  }

  void showDialogUnBlockUser() {
    UChatNewDialog.showUnblockUserDialog(
      context: Get.context!,
      name: profile.value?.getName ?? '',
      onConfirm: () {
        handleUnblock();
      },
    );
  }

  Future<void> handleReportUser({
    bool callBackOnOpen = false,
  }) async {
    MainDialogController.handleOpenDialog(
      context: Get.context!,
      reportType: ReportType.reportUser,
      displayName: profile.value?.getName ?? '',
      userId: accountId,
    );
  }

  void copyPhoneNumberToClipboard() async {
    // Check if phone number is available and not the fallback message
    final phoneNumber = profile.value?.phoneNumber;

    if (phoneNumber == null || phoneNumber.isEmpty) {
      // Don't copy if no phone number
      return;
    }

    try {
      // haptic feedback for better UX
      HapticFeedback.lightImpact();

      // Copy the formatted phone number to clipboard
      await Clipboard.setData(ClipboardData(text: phoneNumber));

      // Show success toast
      AppToast.showToast(
        context: Get.context!,
        message: 'Copied phone number'.tr,
        icon: Assets.vectors.contentCopy.svg(
          colorFilter: ColorFilter.mode(
            Get.context!.theme.appColors.iconPrimaryInverse,
            BlendMode.srcIn,
          ),
        ),
      );
    } catch (e, stackTrace) {
      log.e('Failed to copy phone number to clipboard', e, stackTrace);
    }
  }
}
