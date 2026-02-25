import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

class UpdateMemberInRoomParams {
  final RoomMemberCollection member;

  UpdateMemberInRoomParams({required this.member});
}

class UpdateMemberInRoomUseCase extends SimpleUseCase<void, UpdateMemberInRoomParams> {
  final _log = useLogger();

  @override
  Future<void> call(UpdateMemberInRoomParams params) async {
    try {
      await GetIt.I<ChatRoomLocalRepository>().updateMemberInRoom(params.member.toEntity());
    } catch (e, stackTrace) {
      _log.e('UpdateMemberInRoomUseCase error', e, stackTrace);
    }
  }
}
