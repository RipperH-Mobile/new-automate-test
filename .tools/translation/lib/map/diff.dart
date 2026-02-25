class MapDiff<K, V> {
  final Set<K> newKeys;
  final Set<K> removedKeys;
  final Set<K> commonKeys;

  MapDiff({
    required this.newKeys,
    required this.removedKeys,
    required this.commonKeys,
  });

  @override
  String toString() {
    return '''
New keys: ${newKeys.toList()}
Removed keys: ${removedKeys.toList()}
Common keys: ${commonKeys.toList()}
''';
  }

  static MapDiff<K, V> compare<K, V>(
    Map<K, V> oldMap,
    Map<K, V> newMap,
  ) {
    final oldKeys = oldMap.keys.toSet();
    final newKeys = newMap.keys.toSet();

    return MapDiff(
      newKeys: newKeys.difference(oldKeys),
      removedKeys: oldKeys.difference(newKeys),
      commonKeys: newKeys.intersection(oldKeys),
    );
  }

  bool get hasDifferences => newKeys.isNotEmpty || removedKeys.isNotEmpty;

  int get totalDifferences => newKeys.length + removedKeys.length;
}

extension MapDiffExtension<K, V> on Map<K, V> {
  MapDiff<K, V> diffWith(Map<K, V> other) {
    return MapDiff.compare(this, other);
  }
}
