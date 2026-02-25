class PaginationPayload<T> {
  Iterable<T>? data;
  int total;
  int page;
  int pageSize;
  int totalPages;

  PaginationPayload({
    required this.total,
    required this.page,
    required this.pageSize,
    required this.totalPages,
    this.data,
  });

  @Deprecated('Use [fromMapV3] instead')
  factory PaginationPayload.fromMap(
    Map<String, dynamic> json, {
    Iterable<T> Function(List items)? listMapper,
  }) {
    return PaginationPayload<T>(
      data: listMapper != null ? listMapper(json['rows'] as List) : json['rows'] as Iterable<T>,
      total: json['total'],
      totalPages: json['totalPages'],
      page: json['page'],
      pageSize: json['pageSize'],
    );
  }

  factory PaginationPayload.fromMapV3(
    Map<String, dynamic> json, {
    Iterable<T> Function(List items)? listMapper,
  }) {
    return PaginationPayload<T>(
      data: listMapper != null ? listMapper(json['data'] as List) : json['data'] as Iterable<T>,
      total: json['pagination']['total'],
      totalPages: json['pagination']['totalPages'],
      page: json['pagination']['page'],
      pageSize: json['pagination']['pageSize'],
    );
  }

  PaginationPayload<R> toEntity<R>(Iterable<R> Function(List<T> models) listMapper) {
    return PaginationPayload<R>(
      data: listMapper(data?.toList() ?? []),
      total: total,
      totalPages: totalPages,
      page: page,
      pageSize: pageSize,
    );
  }
}
