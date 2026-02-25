import 'package:isar_community/isar.dart';

part 'default_bookmark_tag_item_model.g.dart';

@embedded
class DefaultBookmarkTagItemModel {
  final String? emojiTagId;
  final String? fileId;

  DefaultBookmarkTagItemModel({
    this.emojiTagId,
    this.fileId,
  });

  factory DefaultBookmarkTagItemModel.fromMap(Map<String, dynamic> json) {
    return DefaultBookmarkTagItemModel(
      emojiTagId: json['emojiTagId'],
      fileId: json['fileId'],
    );
  }

  Map<String, dynamic> toMap() => {
        'emojiTagId': emojiTagId,
        'fileId': fileId,
      };
}
