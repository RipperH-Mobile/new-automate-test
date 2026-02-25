import 'package:uchat/entities/models/bookmark_package_with_items_model.dart';

class BookmarkPackageWithItemsResponse {
  final List<BookmarkPackageWithItemsModel> packages;

  BookmarkPackageWithItemsResponse({
    required this.packages,
  });

  factory BookmarkPackageWithItemsResponse.fromMap(Map<String, dynamic> json) =>
      BookmarkPackageWithItemsResponse(
        packages:
            List<BookmarkPackageWithItemsModel>.from(json['rows'].map((x) => BookmarkPackageWithItemsModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'rows': List<dynamic>.from(packages.map((x) => x.toMap())),
      };
}
