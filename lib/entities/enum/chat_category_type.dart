import 'package:get/get.dart';

enum ChatCategoryType {
  all('ALL'),
  friend('FRIEND'),
  group('GROUP'),
  oa('OA');

  final String value;

  const ChatCategoryType(this.value);

  factory ChatCategoryType.fromString(String stateName) {
    return values.firstWhere((e) => e.value == stateName);
  }

  String get displayName {
    switch (this) {
      case ChatCategoryType.all:
        return 'All'.tr;
      case ChatCategoryType.friend:
        return 'Friends'.tr;
      case ChatCategoryType.group:
        return 'Groups'.tr;
      case ChatCategoryType.oa:
        return 'Official Accounts'.tr;
    }
  }
}
