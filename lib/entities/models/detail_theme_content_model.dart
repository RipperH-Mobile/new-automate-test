import 'package:isar_community/isar.dart';
import 'package:uchat/entities/models/premium_package_language_model.dart';

part 'detail_theme_content_model.g.dart';

@embedded
class DetailThemeContentModel {
  PremiumPackageLanguageModel? description;
  PremiumPackageLanguageModel? title;
  String? linkUrl;
  int? order;

  DetailThemeContentModel({
    this.description,
    this.title,
    this.linkUrl,
    this.order,
  });

  static DetailThemeContentModel fromMap(Map<String, dynamic> json) {
    return DetailThemeContentModel(
      description: json['description'] != null ? PremiumPackageLanguageModel.fromMap(json['description']) : null,
      title: json['title'] != null ? PremiumPackageLanguageModel.fromMap(json['title']) : null,
      linkUrl: json['linkUrl'],
      order: json['order'],
    );
  }

  @override
  String toString() => 'DetailThemeContentModel(description: $description, title: $title, linkUrl: $linkUrl)';
}
