extension MapExt<T, U> on Map<T, U> {
  Map<T, U> sortedBy(Comparable Function(U u) value, {bool isAsc = true}) {
    final entries = this.entries.toList();
    isAsc
        ? entries.sort((a, b) => value(a.value).compareTo(value(b.value)))
        : entries.sort((b, a) => value(a.value).compareTo(value(b.value)));
    return Map<T, U>.fromEntries(entries);
  }
}
