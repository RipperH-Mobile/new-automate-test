import 'package:isar_community/isar.dart';

part 'apple_account_model.g.dart';

@embedded
class AppleAccountModel {
  AppleAccountModel({
    this.id,
    this.email,
    this.lastEditAt,
  });

  final String? id;
  final String? email;
  final DateTime? lastEditAt;

  factory AppleAccountModel.fromJson(Map<String, dynamic> json) => AppleAccountModel(
        id: json['id'],
        email: json['email'],
        lastEditAt: json['lastEditAt'] == null ? null : DateTime.parse(json['lastEditAt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'lastEditAt': lastEditAt?.toIso8601String(),
      };
}
