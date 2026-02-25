import 'package:uchat/entities/models/bookmark_tag_package_model.dart';

class BookmarkTagPackageResponse {
  final List<BookmarkTagPackageModel> emojiPackages;
  final int total;
  final int page;
  final int pageSize;
  final int totalPages;

  BookmarkTagPackageResponse({
    required this.emojiPackages,
    required this.total,
    required this.page,
    required this.pageSize,
    required this.totalPages,
  });

  factory BookmarkTagPackageResponse.fromMap(Map<String, dynamic> json) => BookmarkTagPackageResponse(
        emojiPackages: List<BookmarkTagPackageModel>.from(json['rows'].map((x) => BookmarkTagPackageModel.fromMap(x))),
        total: json['total'],
        page: json['page'],
        pageSize: json['pageSize'],
        totalPages: json['totalPages'],
      );

  Map<String, dynamic> toMap() => {
        'rows': List<dynamic>.from(emojiPackages.map((x) => x.toMap())),
        'total': total,
        'page': page,
        'pageSize': pageSize,
        'totalPages': totalPages,
      };
}
