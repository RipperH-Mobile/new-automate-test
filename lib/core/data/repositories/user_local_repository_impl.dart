import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/domain/repositories/user_local_repository.dart';
import 'package:uchat/entities/collections/user_collection.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/entities/services/user_db.dart';

class UserLocalRepositoryImpl implements UserLocalRepository {
  final UserDb userDb;
  final ConfigInstance configGeneral;

  UserLocalRepositoryImpl({
    required this.userDb,
    required this.configGeneral,
  });

  @override
  Future<int> getUserCount({bool includeHiddenAccount = true}) async {
    return userDb.getUserCount(includeHiddenAccount: includeHiddenAccount);
  }

  @override
  Future<List<UserEntity>> getAllUsers({bool sortedByLoginAt = false}) async {
    final result = await userDb.getAllUser(sortedByLoginAt: sortedByLoginAt);

    return result.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<UserEntity>> getAllUsersIncludeHidden({bool sortedByLoginAt = false}) async {
    final result = await userDb.getAllUsersIncludeHidden(sortedByLoginAt: sortedByLoginAt);

    return result.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> deleteUserById(String id) async {
    await userDb.deleteUserById(id);
  }

  @override
  Future<UserEntity?> getUser(String id) async {
    final result = await userDb.getUser(id);

    return result?.toEntity();
  }

  @override
  Future<void> putUser(UserEntity user) async {
    await userDb.putUser(UserCollection.fromEntity(user));
  }

  @override
  Future<UserEntity?> findUserWithShortcutPasscode(String passcode) async {
    final result = await userDb.findUserWithPasscode(passcode);

    return result?.toEntity();
  }

  @override
  Future<void> clearAllPasscode() async {
    await userDb.clearAllPasscode();
  }

  @override
  Future<UserEntity?> getNewCurrentUser() async {
    final result = await userDb.getNewCurrentUser();

    return result?.toEntity();
  }

  @override
  Future<bool> getAnyAccountHasShortcutPasscode() async {
    return await userDb.getAnyAccountHasShortcutPasscode();
  }

  @override
  Future<void> clearUser() async {
    await userDb.clearUser();
  }
}
