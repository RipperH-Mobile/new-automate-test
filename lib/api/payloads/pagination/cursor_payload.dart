class CursorPayload<T> {
  Iterable<T>? data;
  bool hasMore;
  int totalFound;
  String? nextCursor;

  CursorPayload({
    required this.hasMore,
    required this.totalFound,
    this.nextCursor,
    this.data,
  });

  @Deprecated('Use [fromMapV3] instead')
  factory CursorPayload.fromMap(
    Map<String, dynamic> json, {
    Iterable<T> Function(List items)? listMapper,
  }) {
    return CursorPayload<T>(
      data: listMapper != null ? listMapper(json['rows'] as List) : json['rows'] as Iterable<T>,
      hasMore: json['hasMore'] ?? false,
      totalFound: json['totalFound'] ?? 0,
      nextCursor: json['nextCursor'] as String?,
    );
  }

  factory CursorPayload.fromMapV3(
    Map<String, dynamic> json, {
    Iterable<T> Function(List items)? listMapper,
  }) {
    return CursorPayload<T>(
      data: listMapper != null ? listMapper(json['data'] as List) : json['data'] as Iterable<T>,
      hasMore: json['cursorPagination']['hasMore'] ?? false,
      totalFound: json['cursorPagination']['totalFound'] ?? 0,
      nextCursor: json['cursorPagination']['nextCursor'] as String?,
    );
  }

  CursorPayload<R> toEntity<R>(Iterable<R> Function(List<T> models) listMapper) {
    return CursorPayload<R>(
      data: listMapper(data?.toList() ?? []),
      hasMore: hasMore,
      totalFound: totalFound,
      nextCursor: nextCursor,
    );
  }
}
