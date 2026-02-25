import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_member_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/requests/create_secret_room_request.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/encrypt_helper.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

class CreateSecretRoomUseCase extends SimpleUseCase<RoomEntity?, CreateSecretRoomRequest> {
  ChatRoomListServerRepository get _chatRoomListServerRepository {
    return GetIt.I<ChatRoomListServerRepository>();
  }

  ChatRoomLocalRepository get _chatRoomLocalRepository {
    return GetIt.I<ChatRoomLocalRepository>();
  }

  @override
  Future<RoomEntity?> call(CreateSecretRoomRequest params) async {
    final responseEntity = await _chatRoomListServerRepository.createSecretRoom(params);

    if (responseEntity != null) {
      // Convert entity members to collections for local storage
      final memberCollections = responseEntity.members.map((entity) {
        return RoomMemberCollection.fromEntity(entity);
      }).toList();

      await _chatRoomLocalRepository.updateAllRoomMember(memberCollections.toEntities());

      // Get the room entity from response
      final roomEntity = responseEntity.room;

      // Get the room from the local repository as a collection for encryption
      final roomCollection = await _chatRoomLocalRepository.getRoom(roomEntity.id);

      if (roomCollection != null) {
        // Create crypto key for secret room
        final roomWithKey = await EncryptHelper.instance.createSecretRoomCryptoKey(roomCollection.toCollection());

        // If roomWithKey is null, log a warning
        if (roomWithKey == null) {
          useLogger().w('create key for secret chat result is null !');
        }
      }

      await _chatRoomLocalRepository.updateRoomSubscription(responseEntity.roomSub);

      // Return the entity from the response
      return roomEntity;
    }

    return null;
  }
}
