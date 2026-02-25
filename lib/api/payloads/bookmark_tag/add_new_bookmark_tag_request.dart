class AddNewBookmarkTagRequest {
  final String emojiTagId;
  final String name;

  AddNewBookmarkTagRequest({
    required this.emojiTagId,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'emojiTagId': emojiTagId,
      'name': name,
    };
  }
}
