import 'package:get/utils.dart';
import 'package:isar_community/isar.dart';

part 'deleted_by_account_model.g.dart';

@embedded
class DeletedByAccountModel {
  final String? accountId;
  final String? displayName;
  final String? role;

  DeletedByAccountModel({
    this.accountId,
    this.displayName,
    this.role,
  });

  factory DeletedByAccountModel.fromMap(Map<String, dynamic> json) {
    return DeletedByAccountModel(
      accountId: json['accountId'],
      displayName: json['displayName'],
      role: getRegularForm(json['role'] as String?),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountId': accountId,
      'displayName': displayName,
      'role': role,
    };
  }

  static String getRegularForm(String? role) {
    switch (role) {
      case 'OWNER':
        return 'Owner'.tr;
      case 'ADMIN':
        return 'Admin'.tr;
      default:
        return 'UNKNOWN'.tr;
    }
  }
}
