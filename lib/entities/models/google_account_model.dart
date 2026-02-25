import 'package:isar_community/isar.dart';

part 'google_account_model.g.dart';

@embedded
class GoogleAccountModel {
  GoogleAccountModel({
    this.email,
    this.sub,
    this.lastEditAt,
  });

  final String? email;
  final String? sub;
  final DateTime? lastEditAt;

  factory GoogleAccountModel.fromJson(Map<String, dynamic> json) => GoogleAccountModel(
        email: json['email'],
        sub: json['sub'],
        lastEditAt: json['lastEditAt'] == null ? DateTime.now() : DateTime.parse(json['lastEditAt']),
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'sub': sub,
        'lastEditAt': lastEditAt?.toIso8601String(),
      };
}
