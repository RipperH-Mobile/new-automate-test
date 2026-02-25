import 'package:uchat/features/chat_room/data/models/models/message_model.dart';

class BookmarkMessageRequest {
  final String categoryType; // TEXT | LOCATION | LINK
  final String? keyword;
  final String? sequence;
  final int? pageSize;

  BookmarkMessageRequest({
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

class BookmarkMessageResponse {
  List<MessageModel> messages;
  int total;
  int page;
  int pageSize;
  int totalPages;

  BookmarkMessageResponse({
    required this.messages,
    required this.total,
    required this.page,
    required this.pageSize,
    required this.totalPages,
  });

  factory BookmarkMessageResponse.fromMap(Map<String, dynamic> json) {
    return BookmarkMessageResponse(
      messages: (json['rows'] as List<dynamic>).map((message) => MessageModel.fromMap(message)).toList(),
      total: json['total'],
      page: json['page'],
      pageSize: json['pageSize'],
      totalPages: json['totalPages'],
    );
  }
}
