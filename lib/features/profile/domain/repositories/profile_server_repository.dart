import 'package:uchat/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileServerRepository {
  Future<ProfileEntity> getProfile(String accountId);
}