import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/call/data/models/models/room_call_model.dart';
import 'package:uchat/features/call/domain/params/start_call_param.dart';
import 'package:uchat/features/call/domain/user_cases/start_call_use_case.dart';
import 'package:uchat/features/call/presentation/views/widgets/dialogs/action_unavailable_dialog.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/chat_room/chat_room_barrel.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/accept_group_invite_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/reject_group_invite_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/remove_reactions_in_room_request.dart';
import 'package:uchat/features/chat_room/domain/params/fetch_room_member_params.dart';
import 'package:uchat/features/chat_room/domain/use_cases/fetch_room_member_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/remove_reactions_by_room_id_use_case.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/change_group_owner_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/find_group_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_next_owner_suggestion_list_request.dart';
import 'package:uchat/features/chat_room_detail/domain/params/leave_group_params.dart';
import 'package:uchat/features/chat_room_detail/domain/params/toggle_mute_room_params.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/change_group_owner_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/find_group_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/get_next_owner_suggestion_list_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/leave_group_use_case.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/room_members_argument.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/owner_transfer_helper.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list_actions/toggle_mute_room_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/group_actions/accept_room_handle_accept_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/group_actions/reject_room_use_case.dart';
import 'package:uchat/features/contact/presentation/controllers/contacts_controller.dart';
import 'package:uchat/features/profile/presentation/arguments/group_profile_arguments.dart';
import 'package:uchat/features/report/data/models/enum/report_type.dart';
import 'package:uchat/features/report/presentation/controller/main_dialog_controller.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/utils/extension/extension_getx.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

class GroupProfileController extends GetxController {
  final String roomId;
  final GroupProfileArgumentsV2? args;
  final LoggerService log;
  final AcceptRoomHandleAcceptUseCase acceptRoomHandleAcceptUseCase;
  final RejectRoomUseCase rejectRoomUseCase;
  final ToggleMuteRoomUseCase toggleMuteRoomUseCase;
  final StartCallUseCase startCallUseCase;
  final GetAllMemberInRoomUseCase getAllMemberInRoomUseCase;
  final FetchRoomMemberUseCase fetchRoomMemberUseCase;
  final GetRoomByIdUseCase getRoomByIdUseCase;
  final FindGroupUseCase findGroupUseCase;
  final TaxonomyService taxonomyService;

  GroupProfileController({
    required this.roomId,
    this.args,
    required this.log,
    required this.acceptRoomHandleAcceptUseCase,
    required this.rejectRoomUseCase,
    required this.toggleMuteRoomUseCase,
    required this.startCallUseCase,
    required this.getAllMemberInRoomUseCase,
    required this.fetchRoomMemberUseCase,
    required this.getRoomByIdUseCase,
    required this.findGroupUseCase,
    required this.taxonomyService,
  });

  final room = Rxn<RoomEntity>();
  final members = <RoomMemberEntity>[].obs;
  final loading = false.obs;
  final isMuted = false.obs;

  // Owner transfer related
  final nextOwnerSuggestionList = Rx<List<RoomMemberEntity>>([]);
  final allAdminAndMembersCount = 0.obs;

  bool get canEdit => (room.value?.isJoined ?? false) && (currentUserMemberData?.ableChangeGroupInfo ?? false);

  /// Get current user's member data from members list
  RoomMemberEntity? get currentUserMemberData {
    final currentUserId = UserController.instance.currentUser()?.id;
    if (currentUserId == null) return null;

    return members.firstWhereOrNull(
      (member) => member.account.id == currentUserId,
    );
  }

  /// TODO: don't call another controller
  ContactsController get contactCtl {
    return Get.find<ContactsController>();
  }

  StreamSubscription? _roomUpdateSubscription;
  StreamSubscription? _roomDeleteSubscription;
  StreamSubscription? _updateRoomMemberSubscription;
  StreamSubscription? _addRoomMemberSubscription;
  StreamSubscription? _removeRoomMemberSubscription;
  StreamSubscription? _roomNewSubscription;

  @override
  void onInit() async {
    super.onInit();
    await fetchGroupData();
    await initialSubscription();
  }

  @override
  void onClose() async {
    await _roomUpdateSubscription?.cancel();
    await _roomDeleteSubscription?.cancel();
    await _updateRoomMemberSubscription?.cancel();
    await _addRoomMemberSubscription?.cancel();
    await _removeRoomMemberSubscription?.cancel();
    await _roomNewSubscription?.cancel();
    super.onClose();
  }

  Future<void> fetchGroupData() async {
    try {
      loading.value = true;

      // if args is not null, use it as room
      final roomEntity = args?.room;
      if (roomEntity != null) {
        room.value = roomEntity;
      } else {
        // get groupInviteList from contacts controller
        final roomInviteModel = contactCtl.groupInviteList.firstWhereOrNull((element) => element.id == roomId);

        // if roomInviteModel is not null, use it as room, open profile from group invite notification
        if (roomInviteModel != null) {
          room.value = roomInviteModel.toRoomCollection().toEntity();
        } else {
          // Fetch room data from local DB
          room.value = await getRoomByIdUseCase.call(ChatRoomParams(roomId: roomId));
        }
      }

      if (room.value == null) {
        final findGroupResponse = await findGroupUseCase.call(
          FindGroupRequest(roomId: roomId),
        );
        room.value = findGroupResponse?.room.toEntity();
      }

      await fetchMembers();
      await getRoomSubscription();
    } catch (e, stackTrace) {
      log.e('fetchGroupData error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
    } finally {
      loading.value = false;
    }
  }

  Future<void> fetchMembers() async {
    try {
      List<RoomMemberEntity> tempMembers = await getAllMemberInRoomUseCase.call(
        ChatRoomParams(roomId: roomId),
      );

      /// Fetch from server if local db members count is not equal to member count in room
      /// or no members found in local db
      if (tempMembers.isEmpty) {
        final roomMemberUseCase = await fetchRoomMemberUseCase.call(
          FetchRoomMemberParams(
            roomId: roomId,
            useTransaction: true,
            saveToDb: true,
          ),
        );
        tempMembers = roomMemberUseCase.$1;
      }
      // both joinedAt are null, keep original order
      // if a joinedAt is null, a go to last
      // if b joinedAt is null, b go to last
      tempMembers.sort(
        (a, b) {
          if (a.joinedAt == b.joinedAt) return 0;
          if (a.joinedAt == null) return 1;
          if (b.joinedAt == null) return -1;
          return a.joinedAt!.compareTo(b.joinedAt!);
        },
      );
      members.value = tempMembers;
    } catch (e, stackTrace) {
      log.e('fetchMembers error.', e, stackTrace);
    }
  }

  Future<void> initialSubscription() async {
    _roomNewSubscription = eventBus.on<RoomNewEvent>().listen((event) {
      if (event.room.id == roomId) {
        room.forceUpdate(event.room.toEntity());
      }
    });
    _roomUpdateSubscription = eventBus.on<RoomUpdateEvent>().listen((event) {
      if (event.room.id == roomId) {
        room.forceUpdate(event.room.toEntity());
      }
    });

    _roomDeleteSubscription = eventBus.on<RoomDeleteEvent>().listen((event) {
      if (event.roomId == roomId) {
        log.d('DeleteRoom: ${event.roomId}');
        room.forceUpdate(
          room.value?.copyWith(
            isJoined: false,
          ),
        );
      }
    });

    _updateRoomMemberSubscription = eventBus.on<UpdateRoomMemberEvent>().listen((event) {
      if (room.value?.isGroupRoom == true && event.roomId == roomId) {
        for (final memberCollection in event.members) {
          final memberEntity = memberCollection.toEntity();
          int index = members.indexWhere((element) => element.account.id == memberEntity.account.id);
          if (index != -1) {
            members[index] = memberEntity;
          }
        }
        members.refresh();
      }
    });

    _addRoomMemberSubscription = eventBus.on<AddRoomMemberEvent>().listen((event) {
      if (room.value?.isGroupRoom == true && event.roomId == roomId) {
        final newMembers = event.member.map((m) => m.toEntity()).toList();
        members.addAll(newMembers);
      }
    });

    _removeRoomMemberSubscription = eventBus.on<RemoveRoomMemberEvent>().listen((event) {
      if (room.value?.isGroupRoom == true && event.roomId == roomId) {
        for (final accountId in event.memberIds) {
          members.removeWhere((element) => element.account.id == accountId);
        }
      }
    });
  }

  Future<void> showDialogAcceptGroup() async {
    await UChatDialogV3.showDefaultDialog(
      context: Get.context!,
      title: 'Do you want to confirm joining this group?'.tr,
      onConfirm: handleAcceptGroup,
    );
  }

  /// Handle accepting group invitation
  Future<void> handleAcceptGroup() async {
    try {
      await UChatLoading.show(status: 'Accepting...'.tr);

      await acceptRoomHandleAcceptUseCase.call(
        AcceptGroupInviteRequest(roomId: roomId),
      );

      eventBus.fire(AcceptRequestEvent(id: roomId));
      eventBus.fire(RequireGroupInviteUpdateEvent());

      // await fetchGroupData();

      await UChatLoading.hide();
    } on ApiException catch (e, stackTrace) {
      await UChatLoading.hide();

      if (e.type == 'ERR_ROOM_MEMBER_EXCEED_LIMIT') {
        UChatNewDialog.showSingleButtonDialog(
          context: Get.context!,
          title: 'Group member limit reached'.tr,
          description:
              'This group has reached its maximum member limit, and you cannot join at this time.\n\nYou may be able to join in the future if space becomes available.'
                  .tr,
          confirmText: 'Got it'.tr,
        );
      } else {
        log.e('ApiException handleAcceptGroup error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: e,
        );
      }
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      log.e('handleAcceptGroup error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }

  /// Get room subscription status (mute/unmute)
  Future<void> getRoomSubscription() async {
    if (room.value == null) {
      log.e('getRoomSubscription: room not found.');
      return;
    }
    try {
      final response = await GetIt.I<GetRoomSubscriptionUseCase>().call(
        ChatRoomParams(
          roomId: room.value!.id,
        ),
      );
      isMuted.value = response?.isMuted ?? false;
    } catch (e, stackTrace) {
      if (e is FailedHostLookupException) {
        UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
      } else {
        log.e('getRoomSubscription error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    }
  }

  /// show dialog decline group invitation
  Future<void> showDialogDeclineGroup() async {
    await UChatDialogV3.showDefaultDialog(
      context: Get.context!,
      title: 'Do you want to decline the invitation to join this group?',
      confirmText: 'Decline'.tr,
      isRedButton: true,
      onConfirm: handleDeclineGroup,
    );
  }

  /// Handle rejecting/declining group invitation
  Future<void> handleDeclineGroup() async {
    try {
      await UChatLoading.show(status: 'Declining...'.tr);

      await rejectRoomUseCase.call(
        RejectGroupInviteRequest(roomId: roomId),
      );

      await UChatLoading.hide();

      // Navigate back after declining
      Get.back();
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      log.e('handleDeclineGroup error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
    }
  }

  /// Handle reporting group
  Future<void> handleReportGroup() async {
    if (room.value == null) {
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        message: 'Group not found'.tr,
      );
      return;
    }

    MainDialogController.handleOpenDialog(
      context: Get.context!,
      reportType: ReportType.reportGroup,
      displayName: room.value?.roomName ?? 'Unknown'.tr,
      roomId: roomId,
      enableLeaveGroup: room.value?.isJoined == true,
    );
  }

  /// Handle chat navigation
  void handleChat() async {
    if (room.value != null) {
      Get.back();
      Get.toNamed(
        Routes.chatRoomDirect.replaceAll(':id', room.value!.id),
        arguments: ChatRoomArguments(room: RoomCollection.fromEntity(room.value!)),
      );
    }
  }

  /// Handle call (voice or video)
  void handleCall(CallType callType) async {
    if (room.value == null) {
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        message: 'Group not found'.tr,
      );
      return;
    }

    UChatNewDialog.showDialog(
      context: Get.context!,
      title: callType == CallType.voice
          ? 'Start a voice call with @name?'.trParams({'name': room.value?.roomName ?? ''})
          : 'Start a video call with @name?'.trParams({'name': room.value?.roomName ?? ''}),
      confirmText: 'Start Call'.tr,
      confirmTextColor: Get.context!.theme.appColors.textPrimary,
      onConfirm: () {
        _uChatCall(callType);
      },
    );
  }

  /// Internal method to start call
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

  /// Handle toggle mute/unmute
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
    } on SocketException catch (_) {
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

  /// Handle open edit room name
  void handleOpenEditGroupName() {
    taxonomyService.sendEvent(
      EventName.clickEditNameRoomdetails,
      eventProperties: EventProperty.clickEditNameRoomDetails('groups'),
    );
    Get.toNamed(
      Routes.roomDetailGroupEditName.replaceAll(':id', roomId),
    );
  }

  /// Handle open room member view
  void handleOpenRoomMemberView() {
    Get.toNamed(
      Routes.roomDetailMember.replaceAll(':id', roomId),
      arguments: RoomMemberArgument(
        roomId: roomId,
      ),
    );
  }

  /// Initialize next owner suggestion list
  Future<void> initNextOwnerSuggestion() async {
    try {
      final nextOwnerSuggestionModel = await GetIt.I<GetNextOwnerSuggestionListUseCase>().call(
        GetNextOwnerSuggestionListRequest(
          roomId: roomId,
        ),
      );

      nextOwnerSuggestionList.value = nextOwnerSuggestionModel.suggestionMembers;
      allAdminAndMembersCount.value = nextOwnerSuggestionModel.countMembers;
    } catch (e, stackTrace) {
      log.e('initNextOwnerSuggestion error.', e, stackTrace);
    }
  }

  /// Handle owner transfer
  void handleOwnerTransfer(RoomMemberEntity member) async {
    try {
      await GetIt.I<ChangeGroupOwnerUseCase>().call(
        ChangeGroupOwnerRequest(
          roomId: roomId,
          newOwnerId: member.account.id ?? '',
        ),
      );

      Get.back();
      showDialogLeaveGroup();
    } catch (e, stackTrace) {
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
      log.e('handleOwnerTransfer error.', e, stackTrace);
    }
  }

  /// Handle leave group action with owner transfer check
  Future<void> handleLeaveGroup(BuildContext context) async {
    await initNextOwnerSuggestion();

    if (currentUserMemberData?.isOwner == true && nextOwnerSuggestionList.value.isNotEmpty && context.mounted) {
      OwnerTransferHelper.showOwnerTransferBottomSheet(
        context: context,
        nextOwnerSuggestionList: nextOwnerSuggestionList,
        allAdminAndMembersCount: allAdminAndMembersCount,
        onOwnerTransfer: handleOwnerTransfer,
        onSkipAndLeave: showDialogLeaveGroup,
      );
    } else {
      showDialogLeaveGroup();
    }
  }

  /// Show leave group confirmation dialog
  void showDialogLeaveGroup() {
    if (UChatCallController.instance.roomIsCalling(room.value?.id)) {
      ActionUnavailableDialog.show();
      return;
    }

    UChatNewDialog.showLeaveGroupDialog(
      context: Get.context!,
      onConfirm: handleConfirmLeaveGroup,
    );
  }

  /// Handle confirm leave group
  void handleConfirmLeaveGroup() async {
    try {
      await UChatLoading.show(status: 'Processing...'.tr);
      await GetIt.I<LeaveGroupUseCase>().call(LeaveGroupParams(
        roomId: roomId,
        onRoomDeleted: (roomId) {
          eventBus.fire(RoomDeleteEvent(roomId: roomId));
        },
      ));
      await UChatLoading.success(message: 'Leave.'.tr);

      Get.until((route) => route.settings.name == Routes.home);
      await GetIt.I<RemoveReactionsByRoomIdUseCase>().call(
        RemoveReactionsByRoomIdRequest(
          roomId: roomId,
        ),
      );
    } on FailedHostLookupException catch (_) {
      await UChatLoading.hide();
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      log.e('handleConfirmLeaveGroup error.', e, stackTrace);
      await UChatLoading.hide();
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
    }
  }
}
