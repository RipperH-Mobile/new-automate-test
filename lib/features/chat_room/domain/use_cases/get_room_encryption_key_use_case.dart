import 'package:uchat/features/chat_room/data/models/requests/get_room_encryption_key_request.dart';
import 'package:uchat/features/chat_room/domain/entities/room_encryption_key_entity.dart';
import 'package:uchat/features/chat_room/domain/params/get_room_encryption_key_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetRoomEncryptionKeyUseCase extends SimpleUseCase<RoomEncryptionKeyEntity?, GetRoomEncryptionKeyParams> {
  final ChatRoomServerRepository chatRoomServerRepository;

  GetRoomEncryptionKeyUseCase({
    required this.chatRoomServerRepository,
  });

  @override
  Future<RoomEncryptionKeyEntity?> call(GetRoomEncryptionKeyParams params) async {
    return await chatRoomServerRepository.getRoomEncryptionKey(GetRoomEncryptionKeyRequest(roomId: params.roomId));
  }
}
