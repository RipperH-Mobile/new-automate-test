import 'package:isar_community/isar.dart';
import 'package:uchat/entities/models/feature_flag_base.dart';

part 'bookmark_feature_flag_model.g.dart';

@embedded
class BookmarkFeatureFlagModel implements FeatureFlagInterface {
  @override
  bool? enabled;
  bool? emojiTag;

  BookmarkFeatureFlagModel({
    this.enabled,
    this.emojiTag,
  });

  static BookmarkFeatureFlagModel fromMap(Map<String, dynamic> json) {
    return BookmarkFeatureFlagModel(
      enabled: json['enabled'],
      emojiTag: json['emojiTag'],
    );
  }

  @override
  String toString() {
    return '[BookmarkFeatureFlagModel] enabled: $enabled, emojiTag: $emojiTag';
  }
}
