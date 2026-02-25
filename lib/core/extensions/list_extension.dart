extension ListChunkExtension<T> on List<T> {
  /// Splits the list into sub-lists of at most [size] elements.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4, 5].chunks(2) // [[1, 2], [3, 4], [5]]
  /// ```
  List<List<T>> chunks(int size) {
    assert(size > 0, 'Chunk size must be greater than 0');
    if (isEmpty) return [];
    final result = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      result.add(sublist(i, (i + size).clamp(0, length)));
    }
    return result;
  }
}
