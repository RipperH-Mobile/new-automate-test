import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileLocalRepository {
  Future<ProfileEntity?> getContact(String id);

  Future<RoomEntity?> getRoomByAccountId(String accountId);

  Future<void> updateProfile(ProfileEntity profile);
}
