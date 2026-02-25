import 'package:uchat/features/chat_room/data/models/requests/get_secret_room_encryption_key_request.dart';
import 'package:uchat/features/chat_room/domain/entities/secret_room_encryption_key_entity.dart';
import 'package:uchat/features/chat_room/domain/params/get_secret_room_encryption_key_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetSecretRoomEncryptionKeyUseCase extends SimpleUseCase<SecretRoomEncryptionKeyEntity?, GetSecretRoomEncryptionKeyParams> {
  final ChatRoomServerRepository chatRoomServerRepository;

  GetSecretRoomEncryptionKeyUseCase({
    required this.chatRoomServerRepository,
  });

  @override
  Future<SecretRoomEncryptionKeyEntity?> call(GetSecretRoomEncryptionKeyParams params) async {
    return await chatRoomServerRepository.getSecretRoomEncryptionKey(GetSecretRoomEncryptionKeyRequest(
      roomId: params.roomId,
    ));
  }
}
