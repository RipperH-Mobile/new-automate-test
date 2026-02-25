import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/data/models/responses/update_secret_room_expire_at_response.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/update_secret_room_expire_at_request.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class UpdateSecretRoomExpiredAtUseCase
    extends SimpleUseCase<UpdateSecretRoomExpireAtResponse?, UpdateSecretRoomExpireAtRequest> {
  ChatRoomDetailServerRepository get chatRoomDetailServerRepository {
    return GetIt.I<ChatRoomDetailServerRepository>();
  }

  @override
  Future<UpdateSecretRoomExpireAtResponse?> call(UpdateSecretRoomExpireAtRequest params) async {
    return await chatRoomDetailServerRepository.updateSecretRoomExpiredAt(params);
  }
}
