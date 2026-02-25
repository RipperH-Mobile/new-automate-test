import 'package:isar_community/isar.dart';
import 'package:uchat/entities/collections.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

typedef IsarPremiumPackageCollection = IsarCollection<PremiumPackageCollection>;

class PremiumPackageDb {
  final _log = useLogger();

  static final PremiumPackageDb instance = PremiumPackageDb._internal();

  factory PremiumPackageDb() => instance;

  PremiumPackageDb._internal();

  Isar get dbInstance {
    return DbManager().authenticatedInstance!;
  }

  IsarPremiumPackageCollection get _premiumPackageCollection {
    return dbInstance.premiumPackages;
  }

  /// Get PremiumPackageCollection by id
  ///
  /// If not found return null
  ///
  /// [id] is required, this is the id of PremiumPackageCollection
  Future<PremiumPackageCollection?> getById({required String id}) async {
    final premiumPackage = await _premiumPackageCollection.where().idEqualTo(id).findFirst();

    return premiumPackage;
  }

  /// Get PremiumPackageCollection by id synchronously
  ///
  /// If not found return null
  ///
  /// [id] is required, this is the id of PremiumPackageCollection
  PremiumPackageCollection? getByIdSync({required String id}) {
    final premiumPackage = _premiumPackageCollection.where().idEqualTo(id).findFirstSync();

    return premiumPackage;
  }

  /// Get all PremiumPackageCollection
  ///
  /// If not found return empty list
  ///
  /// [sortDesc] is optional, if true then it will sort by seq desc. Default is false (sort by seq asc)
  ///
  /// Default is empty list
  Future<List<PremiumPackageCollection>> getAll({
    bool sortDesc = false,
  }) async {
    try {
      return _premiumPackageCollection.where().sortByLevel().findAll();
    } catch (e, stackTrace) {
      _log.w('Get all premium package error.', e, stackTrace);
      return [];
    }
  }

  /// Put all PremiumPackageCollection at once
  ///
  /// [premiumPackage] is required, this is the list of PremiumPackageCollection that you want to put
  Future<void> putAll(List<PremiumPackageCollection> premiumPackage) async {
    await dbInstance.writeTxn(() async {
      await _premiumPackageCollection.putAll(premiumPackage);
    });
  }

  /// Put all PremiumPackageCollection at once without transaction
  ///
  /// [premiumPackage] is required, this is the list of PremiumPackageCollection that you want to put
  Future<void> putAllWithoutTxn(List<PremiumPackageCollection> premiumPackage) async {
    await _premiumPackageCollection.putAll(premiumPackage);
  }

  /// For updating all variable in PremiumPackageCollection or creating new one
  ///
  /// If you want to update only `few variable` in PremiumPackageCollection then use `putOrUpdate` method
  ///
  /// [premiumPackage] is required, this is the PremiumPackageCollection that you want to put
  Future<void> put(PremiumPackageCollection premiumPackage) async {
    await dbInstance.writeTxn(() async {
      await _premiumPackageCollection.put(premiumPackage);
    });
  }

  /// For updating a PremiumPackageCollection or creating new one if not exist
  ///
  /// [premiumPackage] is required, this is the PremiumPackageCollection that you want to put
  Future<PremiumPackageCollection?> putWithoutTxn(PremiumPackageCollection premiumPackage) async {
    await _premiumPackageCollection.put(premiumPackage);
    return premiumPackage;
  }

  /// For updating few variable in PremiumPackageCollection or creating new one if not exist
  ///
  /// If you want to update all variable in PremiumPackageCollection or creating new one then use `put` method
  ///
  /// [premiumPackage] is required, this is the PremiumPackageCollection that you want to put
  Future<PremiumPackageCollection?> putOrUpdate(PremiumPackageCollection premiumPackage) async {
    return await dbInstance.writeTxn(() async {
      final localPremiumPackage = await getById(id: premiumPackage.id!);
      if (localPremiumPackage != null) {
        localPremiumPackage.update(premiumPackage);
        await _premiumPackageCollection.put(localPremiumPackage);
        return localPremiumPackage;
      } else {
        await _premiumPackageCollection.put(premiumPackage);
        return premiumPackage;
      }
    });
  }

  /// For deleting a PremiumPackageCollection with id and transaction
  ///
  /// [id] is required, this is the id of PremiumPackageCollection that you want to delete
  ///
  /// If success return true, if not return false
  Future<bool> delete(String id) async {
    return await dbInstance.writeTxn(() async {
      return await _premiumPackageCollection.deleteById(id);
    });
  }

  /// For deleting a PremiumPackageCollection with id without transaction
  ///
  /// [id] is required, this is the id of PremiumPackageCollection that you want to delete
  ///
  /// If success return true, if not return false
  Future<bool> deleteWithoutTxn(String id) async {
    return await _premiumPackageCollection.deleteById(id);
  }

  /// For deleting all PremiumPackageCollection with ids and transaction at once
  ///
  /// [ids] is required, this is the list of id of PremiumPackageCollection that you want to delete
  ///
  /// If success return number of deleted PremiumPackageCollection
  Future<int> deleteAll(List<String?> ids) async {
    return await dbInstance.writeTxn(() async {
      return await _premiumPackageCollection.deleteAllById(ids);
    });
  }

  /// For clear all data in PremiumPackageCollection and reset auto increment id
  ///
  /// `be careful when using this method`
  Future<void> clearCollection() async {
    await _premiumPackageCollection.clear();
  }
}
