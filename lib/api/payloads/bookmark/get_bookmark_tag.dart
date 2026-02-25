import 'package:uchat/features/chat_room/data/models/models/bookmark_tag_model.dart';

class GetBookmarkTagsRequest {
  final int page;
  final int pageSize;
  final String? keyword;
  final DateTime? lastSyncAt;

  GetBookmarkTagsRequest({
    required this.page,
    required this.pageSize,
    this.keyword,
    this.lastSyncAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'pageSize': pageSize,
      if (keyword != null) 'keyword': keyword,
      if (lastSyncAt != null) 'lastSyncAt': lastSyncAt!.toIso8601String(),
    };
  }
}

class GetBookmarkTagsResponse {
  final List<BookmarkTagModel> rows;
  final int total;
  final int page;
  final int pageSize;
  final int totalPages;

  GetBookmarkTagsResponse({
    required this.rows,
    required this.total,
    required this.page,
    required this.pageSize,
    required this.totalPages,
  });

  factory GetBookmarkTagsResponse.fromMap(Map<String, dynamic> json) {
    return GetBookmarkTagsResponse(
      rows: (json['rows'] as List<dynamic>).map((item) => BookmarkTagModel.fromMap(item)).toList(),
      total: json['total'],
      page: json['page'],
      pageSize: json['pageSize'],
      totalPages: json['totalPages'],
    );
  }
}
