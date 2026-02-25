class SetDefaultBookmarkTagRequest {
  final List<String> defaultBookmarkEmojiTags;

  SetDefaultBookmarkTagRequest({
    required this.defaultBookmarkEmojiTags,
  });

  factory SetDefaultBookmarkTagRequest.fromMap(Map<String, dynamic> json) => SetDefaultBookmarkTagRequest(
        defaultBookmarkEmojiTags: List<String>.from(
          json['defaultBookmarkEmojiTags'].map((x) => x),
        ),
      );

  Map<String, dynamic> toMap() => {
        'defaultBookmarkEmojiTags': List<dynamic>.from(
          defaultBookmarkEmojiTags.map((x) => x),
        ),
      };
}
