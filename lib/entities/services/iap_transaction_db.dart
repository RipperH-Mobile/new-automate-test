import 'package:isar_community/isar.dart';
import 'package:uchat/entities/collections/iap_transaction_collection.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/utils/fast_hash.dart';

typedef IsarIapTransactionCollection = IsarCollection<IapTransactionCollection>;
typedef IapTransactionCollectionList = List<IapTransactionCollection>;

class IapTransactionDb {
  // Singleton pattern
  static final IapTransactionDb instance = IapTransactionDb._internal();

  factory IapTransactionDb() => instance;

  IapTransactionDb._internal();

  // Start body
  Isar get dbInstance {
    return DbManager().authenticatedInstance!;
  }

  IsarIapTransactionCollection get iapTransactionCollection {
    return dbInstance.iapTransactions;
  }

  Future<IapTransactionCollectionList> getAllPendingTransaction() async {
    return await iapTransactionCollection.where().findAll();
  }

  Future<IapTransactionCollection?> getTransactionWithId(String id) async {
    return await iapTransactionCollection.where().idEqualTo(id).findFirst();
  }

  Future<void> deleteTransactionWithId(String id) async {
    await dbInstance.writeTxn(() async {
      await iapTransactionCollection.delete(fastHash(id));
    });
  }

  Future<void> putTransaction(IapTransactionCollection data) async {
    await dbInstance.writeTxn(() async {
      await iapTransactionCollection.put(data);
    });
  }
}
