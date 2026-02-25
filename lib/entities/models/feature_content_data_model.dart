import 'package:isar_community/isar.dart';
import 'package:uchat/utils/datetime.dart';

part 'feature_content_data_model.g.dart';

@embedded
class FeatureContentDataModel {
  String? iconPath;
  int? order;
  String? description;
  String? title;
  DateTime? createdAt;
  DateTime? updateAt;

  FeatureContentDataModel({
    this.iconPath,
    this.order,
    this.description,
    this.title,
    this.createdAt,
    this.updateAt,
  });

  static FeatureContentDataModel fromMap(Map<String, dynamic> json) {
    return FeatureContentDataModel(
      iconPath: json['iconPath'],
      order: json['order'],
      description: json['description'],
      title: json['title'],
      createdAt: strToDateTime(json['createdAt']),
      updateAt: strToDateTime(json['updateAt']),
    );
  }

  @override
  String toString() =>
      'FeatureContentDataModel(iconPath: $iconPath, order: $order,description: $description,title: $title,createdAt: $createdAt,updateAt: $updateAt)';
}
