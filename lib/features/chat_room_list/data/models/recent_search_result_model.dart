import 'package:uchat/entities/enum/recent_search_type.dart';
import 'package:uchat/utils/datetime.dart';

class RecentSearchResultModel {
  final String? id;
  final String? value;
  final RecentSearchType? type;
  final DateTime? createdAt;

  const RecentSearchResultModel({
    this.id,
    this.value,
    this.type,
    this.createdAt,
  });

  factory RecentSearchResultModel.fromJson(Map<String, dynamic> data) {
    return RecentSearchResultModel(
      id: data['_id'] as String,
      value: data['value'] as String,
      type: RecentSearchType.from(data['type'] as String),
      createdAt: strToDateTime(data['createdAt']) ?? DateTime.now(),
    );
  }
}
