import 'package:get_it/get_it.dart';
import 'package:uchat/core/exceptions/null_response_exception.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/put_room_subscription_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/toggle_hide_message_notification_request.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_local_repository.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class ToggleHideMessageNotificationUseCase extends SimpleUseCase<bool, ToggleHideMessageNotificationRequest> {
  ChatRoomDetailServerRepository get chatRoomDetailServerRepository {
    return GetIt.I<ChatRoomDetailServerRepository>();
  }
  ChatRoomDetailLocalRepository get chatRoomDetailLocalRepository {
    return GetIt.I<ChatRoomDetailLocalRepository>();
  }

  @override
  Future<bool> call(ToggleHideMessageNotificationRequest params) async {
    final response = await chatRoomDetailServerRepository.toggleHideMessageNotification(params);
    if (response != null) {
      final request = RoomSubscriptionEntity(
        id: response.id,
        roomId: response.roomId,
        isHideMessageNotification: response.isHideMessageNotification,
      );
      final result = await chatRoomDetailLocalRepository.putRoomSubscription(
        PutRoomSubscriptionRequest(
          roomSub: request,
        ),
      );
      return result?.isHideMessageNotification ?? false;
    } else {
      throw NullResponseException('ToggleHideMessageNotificationUseCase response is null.');
    }
  }
}
