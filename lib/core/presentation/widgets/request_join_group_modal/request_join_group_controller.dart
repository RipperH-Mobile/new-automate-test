import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/data/models/enums/api_exception_type.dart';
import 'package:uchat/core/exceptions/exceptions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/presentation/widgets/request_join_group_modal/request_join_group_modal.dart';
import 'package:uchat/entities/enum/invited_status.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/join_group_request.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/params/chat_room_arguments.dart';
import 'package:uchat/features/chat_room/domain/params/chat_room_params.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_room_by_id_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/entities/invite_room_entity.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list/fetch_chat_room_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/group_actions/join_group_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/verify_room_invite_link_use_case.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

final _log = useLogger();

class RequestJoinGroupController extends GetxController {
  static const String modalRouteName = 'RequestJoinGroupModal';

  final String inviteLink;

  RequestJoinGroupController({required this.inviteLink});

  InviteRoomEntity? roomInvite;
  InvitedStatus invitedStatus = InvitedStatus.none;
  String? inviteLinkToken;
  bool isLoading = false;
  bool isLoadingJoin = false;
  bool isViaLink = false;

  /// This us used to open modal (the initial loading state)
  /// so that we don't open modal if already joined the group
  /// and routed to the chat room
  Future<void> openModal() async {
    inviteLinkToken = inviteLink.split('/').last;

    if (inviteLinkToken == null || inviteLinkToken?.isEmpty == true) {
      return;
    } else {
      await _verifyInviteLink(inviteLinkToken!);
    }
  }

  /// This is used to close the modal from outside
  ///
  /// For example, when user click on the invite link multiple times
  /// we want to close the previous modal before open a new one
  /// so that we don't have multiple modals open
  void onClosePressed({bool isCloseOverlays = true}) {
    if (isLoading || isLoadingJoin) return;
    Get.back();
  }

  /// Verify invite link and show modal if not joined the group
  /// or route to chat room if already joined the group
  ///
  /// If the invite link is invalid, show error dialog
  ///
  /// If the invite link is valid, but the user is already a member of the group,
  /// route to the chat room
  ///
  /// If the invite link is valid, but the user is not a member of the group,
  /// show the request join group modal
  ///
  /// If the invite link is valid, but the user has already requested to join the group,
  /// show the request join group modal with pending status
  ///
  /// If the invite link is valid, but the user has been invited to the group,
  /// show the request join group modal with invited status
  Future<void> _verifyInviteLink(String inviteLinkToken) async {
    try {
      final roomInviteResult = await GetIt.I<VerifyRoomInviteLinkUseCase>().call(inviteLinkToken);
      if (roomInviteResult == null) {
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!, message: 'Invalid invite link');
        return;
      }

      roomInvite = roomInviteResult;
      invitedStatus = roomInviteResult.invitedStatus;
      isViaLink = roomInviteResult.isViaLink;

      // route to room if already joined (InvitedStatus is member)
      if (invitedStatus == InvitedStatus.member) {
        await _routeToChatRoom(roomInviteResult.id);
        return;
      }

      await Get.bottomSheet(
        enableDrag: true,
        isScrollControlled: true,
        settings: const RouteSettings(name: modalRouteName),
        RequestJoinGroupModal(inviteLink: inviteLink),
      );
    } on ApiException catch (e, stackTrace) {
      if (e.exceptionType == ApiExceptionType.roomInviteLinkInvalid) {
        UChatNewDialog.showSingleButtonDialog(
          context: Get.context!,
          title: 'This link has expired'.tr,
          description: 'This link is no longer available because it has expired'.tr,
        );
      } else {
        _log.e('api exception on verifyInviteLink', e, stackTrace);
      }
    } catch (e, stackTrace) {
      _log.e('error on verifyInviteLink', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, message: 'Failed to verify invite link'.tr);
    } finally {
      isLoading = false;
      if (!isClosed) {
        update();
      }
    }
  }

  /// Join group and route to chat room if successful
  ///
  /// If failed, show error dialog
  ///
  /// If already requested to join, show pending status
  ///
  /// If already a member, route to chat room
  ///
  /// If the group is full, show group member exceed limit dialog
  ///
  /// If offline, show you are offline dialog
  ///
  /// If other error, show general error dialog
  ///
  /// If any exception, log the error
  Future<void> joinGroup() async {
    try {
      if (isLoadingJoin) return;

      isLoadingJoin = true;
      update();

      final roomInviteLink = roomInvite;

      if (roomInviteLink == null) {
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!, message: 'Invalid invite link'.tr);
        return;
      }

      final result = await GetIt.I<JoinGroupUseCase>().call(
        JoinGroupRequest(roomId: roomInviteLink.id, isViaLink: isViaLink),
      );
      if (result == true) {
        _routeToChatRoom(roomInviteLink.id);
        return;
      }

      invitedStatus = InvitedStatus.pending;

      isLoadingJoin = false;
      update();
    } on ApiException catch (e, stackTrace) {
      if ([
        ApiExceptionType.roomNotFound,
        ApiExceptionType.roomAccountAlreadyInRoom,
        ApiExceptionType.roomAccountAlreadyRequestedToJoin,
      ].contains(e.exceptionType)) {
        Get.back();
        UChatNewDialog.showSingleButtonDialog(
          context: Get.context!,
          title: 'Unable to join the group'.tr,
          description: 'Sorry, you can’t join the group right now. Please try again later'.tr,
        );
      } else if (e.exceptionType == ApiExceptionType.roomMemberExceedLimit) {
        UChatNewDialog.showRoomMemberExceedLimit(context: Get.context!);
      } else {
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!, message: e.message);
        _log.e('api exception on joinGroup', e, stackTrace);
      }
    } on FailedHostLookupException catch (e, stackTrace) {
      _log.e('failed host lookup exception on joinGroup', e, stackTrace);
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('error on joinGroup', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, message: 'Failed to join group'.tr);
    } finally {
      isLoadingJoin = false;
      if (!isClosed) {
        update();
      }
    }
  }

  /// Route to chat room by room id
  ///
  /// If the room is not found, show error dialog
  /// If any exception, log the error
  Future<void> _routeToChatRoom(String roomId) async {
    try {
      final roomInviteLink = roomInvite;
      if (roomInviteLink == null) {
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!, message: 'Invalid invite link'.tr);
        return;
      }
      final roomRoute = Routes.chatRoomDirect.replaceAll(':id', roomInviteLink.id);
      if (Get.currentRoute == roomRoute) {
        return;
      }

      RoomEntity? roomEntity = await GetIt.I<GetRoomByIdUseCase>().call(ChatRoomParams(roomId: roomId));
      roomEntity ??= await GetIt.I<FetchChatRoomUseCase>().call(roomId);

      if (roomEntity == null) {
        UChatNewDialog.showGeneralErrorDialog(context: Get.context!, message: 'Failed to load chat room'.tr);
        return;
      }

      UChatLoading.show();
      // wait for bottom sheet to be fully closed
      await Future.delayed(const Duration(milliseconds: 300));
      Get.until(
        (r) {
          return r.settings.name == Routes.home;
        },
      );
      Get.toNamed(
        roomRoute,
        arguments: ChatRoomArguments(room: RoomCollection.fromEntity(roomEntity)),
      );
    } catch (e, stackTrace) {
      _log.e('error on routeToChatRoom', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!, message: 'Failed to open chat room'.tr);
    } finally {
      UChatLoading.hide();
    }
  }
}
