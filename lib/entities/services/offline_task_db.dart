import 'package:isar_community/isar.dart';
import 'package:uchat/entities/collections/offline_task_collection.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/utils/fast_hash.dart';

// final _log = useLogger();

typedef IsarOfflineTaskCollection = IsarCollection<OfflineTaskCollection>;
typedef OfflineTaskCollectionList = List<OfflineTaskCollection>;
typedef OfflineTaskCollectionQueryAfterFilter
    = QueryBuilder<OfflineTaskCollection, OfflineTaskCollection, QAfterFilterCondition>;

class OfflineTaskDb {
  // Singleton pattern
  static final OfflineTaskDb instance = OfflineTaskDb._internal();

  factory OfflineTaskDb() => instance;

  OfflineTaskDb._internal();

  // Start body
  Isar get dbInstance {
    return DbManager().authenticatedInstance!;
  }

  IsarOfflineTaskCollection get offlineTaskCollection {
    return dbInstance.offlineTask;
  }

  Future<void> putOfflineTask(OfflineTaskCollection offlineTask) async {
    await dbInstance.writeTxn(() async {
      await offlineTaskCollection.put(offlineTask);
    });
  }

  Future<List<OfflineTaskCollection>> getAllOfflineTask() async {
    return offlineTaskCollection.where().findAll();
  }

  Future<bool> deleteOfflineTask(String id) async {
    return await dbInstance.writeTxn(() async {
      return await offlineTaskCollection.delete(fastHash(id));
    });
  }

  Future<int> deleteOfflineTaskWithType(String type) async {
    return await dbInstance.writeTxn(() async {
      return await offlineTaskCollection.where().typeEqualTo(type).deleteAll();
    });
  }

  Future<void> clearCollection() async {
    await offlineTaskCollection.clear();
  }
}
