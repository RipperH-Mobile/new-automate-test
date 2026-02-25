import 'package:isar_community/isar.dart';
import 'package:uchat/entities/collections/sorting_collection.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

typedef IsarSortingCollection = IsarCollection<SortingCollection>;

class SortingDb {
  final _log = useLogger();

  static final SortingDb instance = SortingDb._internal();

  factory SortingDb() => instance;

  SortingDb._internal();

  Isar get dbInstance {
    return DbManager().authenticatedInstance!;
  }

  IsarSortingCollection get _sortingsCollection {
    return dbInstance.sortings;
  }

  Future<List<SortingCollection>> getAll({
    bool sortDesc = false,
  }) async {
    try {
      return _sortingsCollection.where().findAll();
    } catch (e, stackTrace) {
      _log.w('Get all SortingCollection error.', e, stackTrace);
      return [];
    }
  }

  Future<SortingCollection?> getById({required String id}) async {
    final sorting = await _sortingsCollection.where().idEqualTo(id).findFirst();

    return sorting;
  }

  Future<SortingCollection?> putOrUpdate(SortingCollection sorting) async {
    return await dbInstance.writeTxn(() async {
      final localSorting = await getById(id: sorting.id!);
      if (localSorting != null) {
        localSorting.update(sorting);
        await _sortingsCollection.put(localSorting);
        return localSorting;
      } else {
        await _sortingsCollection.put(sorting);
        return sorting;
      }
    });
  }
}
