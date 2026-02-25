import 'package:app_badge_plus/app_badge_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

import '../../data/models/entities/update_state_model.dart';
import '../../data/models/enum/update_state_type.dart';
import '../typedefs.dart';
import 'sync_handle_update_room_subscription_use_case.dart';
import 'sync_handle_update_user_use_case.dart';

class ProcessGroupRoomSubscriptionUseCase extends SimpleUseCase<EventListCallback, UpdateStateModel> {
  SyncHandleUpdateRoomSubscriptionUseCase get _updateRoomSubscription {
    return GetIt.I<SyncHandleUpdateRoomSubscriptionUseCase>();
  }

  @override
  Future<EventListCallback> call(UpdateStateModel state) async {
    final EventListCallback eventList = [];

    switch (state.type) {
      case UpdateStateType.updateUser:
        if (state.user case final user?) {
          // print('ZZZ => RoomSub > UpdateStateType.updateUser');
          final eventCb =
              await GetIt.I<SyncHandleUpdateUserUseCase>().call(SyncHandleUpdateUserParams(receiveUser: user));
          eventList.addAll(eventCb);
        }
        break;
      case UpdateStateType.newSubscription:
      case UpdateStateType.updateSubscription:
      case UpdateStateType.deleteSubscription:
        final roomSubscription = state.roomSubscription;
        if (roomSubscription != null) {
          final eventCb = await _updateRoomSubscription.call(SyncHandleUpdateRoomSubscriptionParams(
            receiveRoomSubscription: roomSubscription.toEntity(),
            isDeleteLastMessage: state.data['lastMessage'] == '',
          ));

          if (roomSubscription.unreadCount != null || roomSubscription.isHidden != null) {
            /// If there is a new unread count, update the badge.
            /// Or If the room is hidden or unhidden, update the badge.
            final unreadCount = await GetIt.I<RoomSubscriptionDb>().getAllUnreadCount();
            await AppBadgePlus.updateBadge(unreadCount);
          }
          eventList.addAll(eventCb);
        }
        break;
      default:
        useLogger().w('Skipping state type ${state.type} from ProcessGroupRoomSubscriptionUseCase');
        break;
    }

    return eventList;
  }
}
