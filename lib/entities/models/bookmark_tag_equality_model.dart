class BookmarkTagEqualityModel {
  final bool isEqual;
  final String? newTagId;
  final String? removeTagId;

  BookmarkTagEqualityModel({
    required this.isEqual,
    this.newTagId,
    this.removeTagId,
  });
}
