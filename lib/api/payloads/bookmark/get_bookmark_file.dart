import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';

class BookmarkFileRequest {
  final String categoryType; // IMAGE_AND_VIDEO | FILE | AUDIO
  final String? keyword;
  final String? sequence;
  final int? pageSize;

  BookmarkFileRequest({
    required this.categoryType,
    this.keyword,
    this.sequence,
    this.pageSize,
  });

  Map<String, dynamic> toMap() {
    return {
      'categoryType': categoryType,
      if (keyword != null && keyword!.isNotEmpty) 'keyword': keyword,
      if (sequence != null && sequence!.isNotEmpty) 'sequence': sequence,
      if (pageSize != null) 'pageSize': pageSize,
    };
  }
}

class BookmarkFileResponse {
  final List<MessageFileModel> files;
  final int total;
  final int page;
  final int pageSize;
  final int totalPages;

  BookmarkFileResponse({
    required this.files,
    required this.total,
    required this.page,
    required this.pageSize,
    required this.totalPages,
  });

  factory BookmarkFileResponse.fromMap(Map<String, dynamic> json) {
    List<MessageFileModel> files = [];
    final List<dynamic> fileRows = json['rows'] ?? [];

    for (final fileRow in fileRows) {
      files.add(MessageFileModel.fromMap(fileRow));
    }

    return BookmarkFileResponse(
      files: files,
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      pageSize: json['pageSize'] ?? 10,
      totalPages: json['totalPages'] ?? 1,
    );
  }
}
