import 'package:isar_community/isar.dart';
import 'package:uchat/entities/models/premium_package_language_model.dart';

part 'compare_theme_content_model.g.dart';

@embedded
class CompareThemeContentModel {
  PremiumPackageLanguageModel? description;
  PremiumPackageLanguageModel? title;
  String? linkUrl;
  int? order;

  CompareThemeContentModel({
    this.description,
    this.title,
    this.linkUrl,
    this.order,
  });

  static CompareThemeContentModel fromMap(Map<String, dynamic> json) {
    return CompareThemeContentModel(
      description: json['description'] != null ? PremiumPackageLanguageModel.fromMap(json['description']) : null,
      title: json['title'] != null ? PremiumPackageLanguageModel.fromMap(json['title']) : null,
      linkUrl: json['linkUrl'],
      order: json['order'],
    );
  }

  @override
  String toString() => 'CompareThemeContentModel(description: $description, title: $title, linkUrl: $linkUrl)';
}
