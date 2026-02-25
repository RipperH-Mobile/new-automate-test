import 'package:isar_community/isar.dart';

const defaultName = 'default';

abstract class DatabaseServiceInterface {
  Map<String, Isar> isarInstances = {};

  String getPrefixName({String name = defaultName});

  String getName({String name = defaultName});

  List<CollectionSchema> getSchema();

  Future<bool> hasInstance({String name = defaultName});

  Future<Isar> getInstance({String name = defaultName});

  Isar getInstanceSync({String name = defaultName});

  Future<void> clearData({String name = defaultName});

  Future<void> clearDataAllInstance();

  Future<bool> closeInstance({String name = defaultName, bool deleteFromDisk});

  Future<void> closeAllInstance({bool deleteFromDisk});

  Future<bool> deleteInstance({String name = defaultName});

  Future<void> deleteAllInstance();

  bool get useInspector;
}
