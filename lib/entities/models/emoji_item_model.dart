class EmojiItemModel {
  final String? id;
  final String? fileId;
  final String? name;
  final List<String>? tags;
  final String? emoji;
  final String? emojiPackageId;
  final bool? isDefault;

  EmojiItemModel({
    this.id,
    this.fileId,
    this.name,
    this.tags,
    this.emoji,
    this.emojiPackageId,
    this.isDefault,
  });

  factory EmojiItemModel.fromMap(Map<String, dynamic> json) => EmojiItemModel(
        id: json['_id'],
        fileId: json['fileId'],
        name: json['name'],
        tags: json['tags'] == null ? [] : List<String>.from(json['tags']!.map((x) => x)),
        emoji: json['emoji'],
        emojiPackageId: json['emojiPackageId'],
        isDefault: json['isDefault'],
      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'fileId': fileId,
        'name': name,
        'tags': tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        'emoji': emoji,
        'emojiPackageId': emojiPackageId,
        'isDefault': isDefault,
      };
}
