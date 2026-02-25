import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/profile/domain/repositories/profile_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetRoomByAccountIdUseCase extends SimpleUseCase<RoomEntity?, String> {
  final ProfileLocalRepository profileLocalRepository;

  GetRoomByAccountIdUseCase({
    required this.profileLocalRepository,
  });

  @override
  Future<RoomEntity?> call(String accountId) async {
    return profileLocalRepository.getRoomByAccountId(accountId);
  }
}
