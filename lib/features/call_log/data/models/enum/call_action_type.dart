import 'package:collection/collection.dart';

enum CallActionType {
  outgoing('OUTGOING'),
  incoming('INCOMING'),
  missed('MISSED');

  const CallActionType(this.value);
  final String value;

  static CallActionType? fromString(String value) {
    return CallActionType.values.firstWhereOrNull(
      (e) => e.value == value,
    );
  }
}
