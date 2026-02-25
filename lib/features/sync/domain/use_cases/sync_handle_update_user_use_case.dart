import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/collections/user_collection.dart';
import 'package:uchat/entities/services/user_db.dart';
import 'package:uchat/use_cases/use_case.dart';

import '../typedefs.dart';

class SyncHandleUpdateUserParams {
  // TODO: Move to UserEntity
  final UserCollection receiveUser;

  SyncHandleUpdateUserParams({required this.receiveUser});
}

class SyncHandleUpdateUserUseCase extends SimpleUseCase<EventListCallback, SyncHandleUpdateUserParams> {
  UserDb get _userDb {
    return GetIt.I<UserDb>();
  }

  @override
  Future<EventListCallback> call(SyncHandleUpdateUserParams params) async {
    final EventListCallback eventList = [];
    final receiveUser = params.receiveUser;

    if (receiveUser.id == UserController.instance.currentUser()?.id && receiveUser.isDeleted == true) {
      if (UserController.instance.isLoggingOut.isFalse) {
        eventList.add(() => eventBus.fire(UserExpiredEvent()));
      }
      useLogger().d('from sync isDeletedAcc ${receiveUser.isDeleted}');
    } else {
      // forceUpdateStatus: true is to make sure the status is reset to null when receiving update from server
      final UserCollection? eventData = await _userDb.putUserWithoutTxn(receiveUser, forceUpdateStatus: true);
      if (eventData != null) {
        eventList.add(() => eventBus.fire(UserUpdateEvent(user: eventData.toEntity())));
      }
    }

    return eventList;
  }
}
