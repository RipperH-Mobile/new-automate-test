import 'package:isar_community/isar.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/features/central_notification/data/model/collection/central_notification_collection.dart';
import 'package:uchat/utils/fast_hash.dart';

// final _log = useLogger();

typedef IsarCentralNotificationCollection = IsarCollection<CentralNotificationCollection>;
typedef CentralNotiCollectionList = List<CentralNotificationCollection>;
typedef CentralNotiQueryAfterFilter
    = QueryBuilder<CentralNotificationCollection, CentralNotificationCollection, QAfterFilterCondition>;

class CentralNotificationDb {
  Isar? customDbInstance;

  CentralNotificationDb({this.customDbInstance});

  // Start body
  Isar get dbInstance {
    return customDbInstance ?? DbManager().authenticatedInstance!;
  }

  IsarCentralNotificationCollection get centralNotificationCollection {
    return dbInstance.centralNotification;
  }

  Future<void> clearCollection() async {
    await dbInstance.writeTxn(() async {
      await centralNotificationCollection.clear();
    });
  }

  Future<bool> deleteCentralNotiOnDb(String id) async {
    return await dbInstance.writeTxn(() async {
      return await centralNotificationCollection.delete(fastHash(id));
    });
  }

  Future<void> deleteCentralNotifications(List<String> ids) async {
    await dbInstance.writeTxn(() async {
      final hashedIds = ids.map((id) => fastHash(id)).toList();
      await centralNotificationCollection.deleteAll(hashedIds);
    });
  }

  Future<List<CentralNotificationCollection>> getAllCentralNoti() async {
    return centralNotificationCollection.where().sortByCreatedAtDesc().findAll();
  }

  Future<CentralNotificationCollection?> getCentralNoti(String id) async {
    return centralNotificationCollection.get(fastHash(id));
  }

  Future<void> putAllCentralNoti(List<CentralNotificationCollection> centralNoti) async {
    await dbInstance.writeTxn(() async {
      await centralNotificationCollection.putAll(centralNoti);
    });
  }

  Future<void> putAllCentralNotiWithoutTxn(List<CentralNotificationCollection> centralNoti) async {
    await centralNotificationCollection.putAll(centralNoti);
  }

  Future<void> putCentralNoti(CentralNotificationCollection centralNoti) async {
    await dbInstance.writeTxn(() async {
      await centralNotificationCollection.put(centralNoti);
    });
  }
}
