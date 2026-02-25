extension MapSort<K, V> on Map<K, V> {
  Map<K, V> sortedByKey() {
    final List<K> keys = this.keys.toList()..sort();

    return Map.fromEntries(
      keys.map((key) => MapEntry(key, this[key] as V)),
    );
  }
}
