import 'dart:async';

import 'package:isar_community/isar.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/collections.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/utils/fast_hash.dart';

final _log = useLogger();

typedef IsarUserCollection = IsarCollection<UserCollection>;
typedef AccountListSubscription = StreamSubscription<List<UserCollection>>;
typedef AccountListQuery = QueryBuilder<UserCollection, UserCollection, QAfterFilterCondition>;

class UserDb {
  // Singleton pattern
  static final UserDb instance = UserDb._internal();

  @Deprecated('Use GetIt instead.')
  factory UserDb() => instance;

  UserDb._internal();

  // Start body
  Isar get dbInstance {
    return DbManager().generalInstance!;
  }

  IsarUserCollection get userCollection {
    return dbInstance.users;
  }

  Future<void> putUser(UserCollection user) async {
    await dbInstance.writeTxn(() async {
      await userCollection.put(user);
    });
  }

  Future<void> replaceUser(String fromUserId, UserCollection user) async {
    await dbInstance.writeTxn(() async {
      await userCollection.delete(fastHash(fromUserId));
      await userCollection.put(user);
    });
  }

  Future<void> updateUser(UserCollection user) async {
    await dbInstance.writeTxn(() async {
      await putUserWithoutTxn(user);
    });
  }

  Future<UserCollection?> putUserWithoutTxn(UserCollection user, {bool forceUpdateStatus = false}) async {
    try {
      UserCollection? localUser = await getUser(user.id!);
      if (localUser != null) {
        // if update user
        localUser.update(user, forceUpdateStatus: forceUpdateStatus);
        await userCollection.put(localUser);
        return localUser;
      } else {
        // if new user
        await userCollection.put(user);
        return user;
      }
    } catch (e, stacktrace) {
      _log.e('putUserWithoutTxn error', e, stacktrace);
      return null;
    }
  }

  Future<void> deleteUser(int id) async {
    await dbInstance.writeTxn(() async {
      await userCollection.delete(id);
    });
  }

  Future<void> deleteUserById(String id) async {
    await dbInstance.writeTxn(() async {
      await userCollection.deleteById(id);
    });
  }

  Future<void> deleteUserWithoutTxn(int id) async {
    await userCollection.delete(id);
  }

  Future<void> clearUser() async {
    await dbInstance.writeTxn(() async {
      await userCollection.clear();
    });
  }

  Future<UserCollection?> getUser(String id) async {
    // Perform asynchronous database query
    final user = await getUserByIsarId(fastHash(id));
    return user;
  }

  Future<UserCollection?> getUserByIsarId(Id id) async {
    // Perform asynchronous database query
    final userByIsarId = await userCollection.get(id);
    return userByIsarId;
  }

  Future<int> getUserCount({bool includeHiddenAccount = true}) async {
    if (includeHiddenAccount) {
      return await userCollection.count();
    } else {
      return await userCollection.filter().isMAHiddenEqualTo(false).or().isMAHiddenIsNull().count();
    }
  }

  Future<List<UserCollection>> getAllUser({bool sortedByLoginAt = false}) async {
    if (sortedByLoginAt) {
      return await getAccountListQuery().sortByLoginAtDesc().findAll();
    } else {
      return await getAccountListQuery().findAll();
    }
  }

  Future<List<UserCollection>> getAllUsersIncludeHidden({bool sortedByLoginAt = false}) async {
    if (sortedByLoginAt) {
      return await userCollection.where().sortByLoginAtDesc().findAll();
    } else {
      return await userCollection.where().findAll();
    }
  }

  Future<UserCollection?> findUserWithPasscode(String passcode) async {
    return await userCollection.where().shortcutPasscodeEqualTo(passcode).findFirst();
  }

  Future<bool> getAnyAccountHasShortcutPasscode() async {
    return await userCollection.where().shortcutPasscodeIsNotNull().isNotEmpty();
  }

  String? getDisplayNameByIdSync(String id) {
    return userCollection.getSync(fastHash(id))?.displayName;
  }

  Future<void> clearAllPasscode() async {
    List<UserCollection> allUser = await userCollection.where().shortcutPasscodeIsNotNull().findAll();
    await dbInstance.writeTxn(() async {
      for (UserCollection user in allUser) {
        user.shortcutPasscode = null;
        await userCollection.put(user);
      }
    });
  }

  AccountListQuery getAccountListQuery() {
    return userCollection
        .filter()
        .isMAHiddenEqualTo(false)
        .or()
        .isMAHiddenIsNull()
        .or()
        .idEqualTo(UserController.instance.currentUser()?.id);
  }

  Future<UserCollection?> getNewCurrentUser() {
    return getAccountListQuery().sortByDisplayName().findFirst();
  }
}
