import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/call/presentation/views/widgets/dialogs/action_unavailable_dialog.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room_detail/domain/params/leave_group_params.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/leave_group_use_case.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

abstract class IChatRoomUtils {
  Future<String?> getRoomName({
    required RoomEntity? room,
  });

  /// Show leave group dialog without transfer owner flow. If user is owner, ownership will be transferred to the first
  /// member who joined after the owner without the flow to transfer ownership.
  /// Used in contacts and chat list screens.
  Future<void> showLeaveGroupDialogWithoutTransferOwner(RoomEntity room);
}

class ChatRoomUtils implements IChatRoomUtils {
  final RoomMemberDb roomMemberDb;

  ChatRoomUtils({
    required this.roomMemberDb,
  });

  @override
  Future<String?> getRoomName({
    required RoomEntity? room,
  }) async {
    if (room == null) return null;

    String? processedRoomName;
    if (room.roomName == null) {
      // Process room name
      if (room.roomType == RoomType.direct || room.roomType == RoomType.directSecret) {
        RoomMemberCollection? friendMember = await roomMemberDb.getFirstOtherInRoom(room.id);

        if (friendMember != null) {
          processedRoomName = friendMember.account?.name ?? friendMember.account?.username;
        } else {
          processedRoomName = 'UNKNOWN'.tr.toUpperCase();
        }
      } else if (room.roomType == RoomType.group) {
        processedRoomName = 'UNTITLED'.tr;
      }
    }
    return processedRoomName ?? room.roomName;
  }

  @override
  Future<void> showLeaveGroupDialogWithoutTransferOwner(RoomEntity room) async {
    if (UChatCallController.instance.roomIsCalling(room.id)) {
      ActionUnavailableDialog.show();
      return;
    }

    final currentUser = Get.find<UserController>().currentUser();
    bool isOwner = room.ownerId == currentUser?.id;
    await UChatNewDialog.showDialog(
      context: Get.context!,
      title: isOwner && (room.memberCount ?? 0) > 1 ? 'Leave this group as owner'.tr : 'Leave this group'.tr,
      description: isOwner && (room.memberCount ?? 0) > 1
          ? 'If you leave this group, ownership \nwill be transferred to the first \nmember who joined after you. \n \nAre you sure you want to leave?'
              .tr
          : 'Leaving this group will remove access to the member list and chat history.'.tr,
      cancelText: 'Cancel'.tr,
      confirmText: 'Leave'.tr,
      confirmTextColor: Get.context!.theme.appColors.textError,
      cancelTextColor: Get.context!.theme.appColors.textLight,
      isDestructive: true,
      onConfirm: () async {
        try {
          await UChatLoading.show(status: 'Processing...'.tr);
          await GetIt.I<LeaveGroupUseCase>().call(LeaveGroupParams(
            roomId: room.id,
            onRoomDeleted: (roomId) {
              eventBus.fire(RoomDeleteEvent(roomId: roomId));
            },
          ));
          await UChatLoading.success(message: 'Leave.'.tr);
        } on ApiException catch (e, stackTrace) {
          if (e.type == 'ERR_EVENT_UNAVAILABLE_DURING_CALL') {
            await ActionUnavailableDialog.show();
            return;
          } else {
            useLogger().e('handleLeaveGroup ApiException error.', e, stackTrace);
            UChatNewDialog.showGeneralErrorDialog(
              context: Get.context!,
              e: e,
            );
          }
        } on FailedHostLookupException catch (_) {
          UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
        } catch (e, stackTrace) {
          useLogger().e('handleLeaveGroup error.', e, stackTrace);
          UChatNewDialog.showGeneralErrorDialog(
            context: Get.context!,
            e: e is Exception ? e : null,
          );
        } finally {
          await UChatLoading.hide();
        }
      },
    );
  }
}
