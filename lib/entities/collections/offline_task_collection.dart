import 'package:isar_community/isar.dart';
import 'package:uchat/utils/fast_hash.dart';

part 'offline_task_collection.g.dart';

@Collection(accessor: 'offlineTask')
@Name('OfflineTask')
class OfflineTaskCollection {
  @Index(unique: true, replace: true)
  String get id => '${type}_$ref';

  Id get isarId => fastHash(id);

  @Index()
  String? type;

  String? ref;

  String? data;

  OfflineTaskCollection({
    this.type,
    this.ref,
    this.data,
  });

  @override
  String toString() {
    return '[OfflineTaskCollection] ID: $id, TYPE: $type, REF: $ref, DATA: $data';
  }

  @override
  bool operator ==(Object other) {
    return other is OfflineTaskCollection && id == other.id;
  }

  @ignore
  @override
  int get hashCode => id.hashCode;
}
