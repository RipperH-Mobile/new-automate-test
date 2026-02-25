import 'package:isar_community/isar.dart';
import 'package:uchat/utils/fast_hash.dart';

part 'config_collection.g.dart';

// final _log = useLogger();

@Collection(accessor: 'configs')
@Name('Config')
class ConfigCollection {
  @Index(type: IndexType.value)
  String? key;

  Id get isarId => fastHash(key!);

  String? stringValue;

  int? intValue;

  double? doubleValue;

  bool? boolValue;

  DateTime? dateTimeValue;

  ConfigCollection({
    required this.key,
    this.stringValue,
    this.intValue,
    this.boolValue,
    this.doubleValue,
  });

  void setValue(dynamic value) {
    switch (value.runtimeType) {
      case == String:
        stringValue = value;
        intValue = null;
        boolValue = null;
        dateTimeValue = null;
        doubleValue = null;
        break;
      case == int:
        stringValue = null;
        intValue = value;
        boolValue = null;
        dateTimeValue = null;
        doubleValue = null;
        break;
      case == bool:
        stringValue = null;
        intValue = null;
        boolValue = value;
        dateTimeValue = null;
        doubleValue = null;
        break;
      case == DateTime:
        stringValue = null;
        intValue = null;
        boolValue = null;
        dateTimeValue = value;
        doubleValue = null;
        break;
      case == double:
        stringValue = null;
        intValue = null;
        boolValue = null;
        dateTimeValue = null;
        doubleValue = value;
        break;
    }
  }

  @override
  bool operator ==(Object other) {
    return other is ConfigCollection && key == other.key;
  }

  @ignore
  @override
  int get hashCode => key.hashCode;
}
