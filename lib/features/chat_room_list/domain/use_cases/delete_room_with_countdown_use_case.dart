import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room/data/models/requests/delete_room_with_countdown_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/undo_delete_room_with_countdown_request.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room_list/domain/params/delete_room_with_countdown_params.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

final _log = useLogger();

class DeleteRoomWithCountdownUseCase extends SimpleUseCase<void, DeleteRoomWithCountdownParams> {
  ChatRoomListServerRepository get chatRoomListServerRepository {
    return GetIt.I.get<ChatRoomListServerRepository>();
  }

  ChatRoomLocalRepository get chatRoomLocalRepository {
    return GetIt.I.get<ChatRoomLocalRepository>();
  }

  @override
  Future<void> call(DeleteRoomWithCountdownParams params) async {
    AppToast.hideToast(Get.context!);
    DeleteRoomWithCountdownRequest request = DeleteRoomWithCountdownRequest(
      roomId: params.roomId,
      isForceDelete: params.forceDelete,
    );

    /// Send delete request to server.
    await chatRoomListServerRepository.deleteRoomWithCountdown(request);

    /// Set room subscription to deleted in local db.
    RoomSubscriptionEntity? roomSub = await chatRoomLocalRepository.getRoomSubscription(params.roomId);
    if (roomSub != null) {
      roomSub = roomSub.copyWith(
        isLocalDeleting: true,
      );
      await chatRoomLocalRepository.putRoomSub(roomSub);
      eventBus.fire(RoomUpdateSubscriptionEvent(roomSubscription: roomSub));
    }

    // If force deleted, Don't show undo toast.
    if (params.forceDelete == true) return;

    AppToast.showToastWithUndo(
      context: Get.context!,
      title: 'Chat deleted'.tr,
      description: 'The chat will be deleted. Undo to cancel.'.tr,
      margin: const EdgeInsets.only(
        bottom: AppSpace.space20,
        left: AppSpace.space4,
        right: AppSpace.space4,
      ),
      duration: const Duration(seconds: 5),
      onTapUndo: () async {
        try {
          if (params.function != null) {
            params.function!();
          }

          AppToast.hideToast(Get.context!);
          await chatRoomListServerRepository.undoDeleteRoomWithCountdown(
            UndoDeleteRoomWithCountdownRequest(roomId: params.roomId),
          );
          if (roomSub != null) {
            roomSub = roomSub!.copyWith(
              isLocalDeleting: false,
            );
            await chatRoomLocalRepository.putRoomSub(roomSub!);
            eventBus.fire(RoomUpdateSubscriptionEvent(roomSubscription: roomSub!));
          }
        } catch (e, stackTrace) {
          _log.e('undoDeleteRoomWithCountdown error.', e, stackTrace);
        }
      },
    );
  }
}
