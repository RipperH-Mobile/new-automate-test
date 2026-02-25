class UpdateBookmarkTagRequest {
  final String accountEmojiTagId;
  final String? name;
  final String? emojiTagId;
  final bool? isSetNameToDefault;

  UpdateBookmarkTagRequest({
    required this.accountEmojiTagId,
    this.name,
    this.emojiTagId,
    this.isSetNameToDefault,
  });

  Map<String, dynamic> toMap() {
    return {
      'accountEmojiTagId': accountEmojiTagId,
      'name': name,
      'emojiTagId': emojiTagId,
      'isSetNameToDefault': isSetNameToDefault,
    };
  }
}
