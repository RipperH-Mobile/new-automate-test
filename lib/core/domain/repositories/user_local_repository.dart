import 'package:uchat/core/domain/entities/user_entity.dart';

abstract class UserLocalRepository {
  /// Retrieve local user count, etc.
  Future<int> getUserCount({bool includeHiddenAccount = true});

  Future<List<UserEntity>> getAllUsers({bool sortedByLoginAt = false});

  Future<List<UserEntity>> getAllUsersIncludeHidden({bool sortedByLoginAt = false});

  Future<void> deleteUserById(String id);

  Future<UserEntity?> getUser(String id);

  Future<void> putUser(UserEntity user);

  Future<UserEntity?> findUserWithShortcutPasscode(String passcode);

  Future<void> clearAllPasscode();

  Future<UserEntity?> getNewCurrentUser();

  Future<bool> getAnyAccountHasShortcutPasscode();

  Future<void> clearUser();
}
