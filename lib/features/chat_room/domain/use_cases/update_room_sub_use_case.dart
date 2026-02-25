import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

class UpdateRoomSubParams {
  final RoomSubscriptionCollection roomSub;

  UpdateRoomSubParams({required this.roomSub});
}

class UpdateRoomSubUseCase extends SimpleUseCase<void, UpdateRoomSubParams> {
  final _log = useLogger();

  @override
  Future<void> call(UpdateRoomSubParams params) async {
    try {
      await GetIt.I<ChatRoomLocalRepository>().updateRoomSubscription(params.roomSub.toEntity());
    } catch (e, stackTrace) {
      _log.e('UpdateRoomSubUseCase error', e, stackTrace);
    }
  }
}
