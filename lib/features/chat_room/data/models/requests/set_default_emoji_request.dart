class UpdateDefaultEmojiRequest {
  final List<String> defaultEmojiItems;

  UpdateDefaultEmojiRequest({
    required this.defaultEmojiItems,
  });

  factory UpdateDefaultEmojiRequest.fromMap(Map<String, dynamic> json) => UpdateDefaultEmojiRequest(
        defaultEmojiItems: List<String>.from(
          json['defaultEmojiItems'].map((x) => x),
        ),
      );

  Map<String, dynamic> toMap() => {
        'defaultEmojiItems': List<dynamic>.from(
          defaultEmojiItems.map((x) => x),
        ),
      };
}
