import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class DeleteAllMessageInRoomUseCase extends SimpleUseCase<void, String> {
  DeleteAllMessageInRoomUseCase({
    required this.messageRepoLocal,
  });

  final MessageLocalRepository messageRepoLocal;

  @override
  Future<void> call(String roomId) async {
    return await messageRepoLocal.deleteAllMessageInRoom(roomId: roomId);
  }
}
