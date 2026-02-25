import 'package:isar_community/isar.dart';

part 'facebook_account_model.g.dart';

@embedded
class FacebookAccountModel {
  FacebookAccountModel({
    this.email,
    this.sub,
    this.lastEditAt,
  });

  final String? email;
  final String? sub;
  final DateTime? lastEditAt;

  factory FacebookAccountModel.fromJson(Map<String, dynamic> json) => FacebookAccountModel(
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
