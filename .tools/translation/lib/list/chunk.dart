class ListChunker<T> {
  static List<List<T>> chunk<T>(List<T> list, int size) {
    final result = <List<T>>[];

    for (var i = 0; i < list.length; i += size) {
      final end = (i + size < list.length) ? i + size : list.length;
      result.add(list.sublist(i, end));
    }

    return result;
  }

  static List<List<T>> splitIntoGroups<T>(List<T> list, int numberOfGroups) {
    if (numberOfGroups <= 0) return [list];

    final groupSize = (list.length / numberOfGroups).ceil();
    return chunk(list, groupSize);
  }
}

extension ListChunkExtension<T> on List<T> {
  List<List<T>> chunks(int size) {
    return ListChunker.chunk(this, size);
  }
}