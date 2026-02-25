import 'package:isar_community/isar.dart';
import 'package:uchat/entities/models/apple_account_model.dart';
import 'package:uchat/entities/models/facebook_account_model.dart';
import 'package:uchat/entities/models/google_account_model.dart';

part 'link_accounts_model.g.dart';

@embedded
class LinkAccountsModel {
  final GoogleAccountModel? google;
  final AppleAccountModel? apple;
  final FacebookAccountModel? facebook;

  LinkAccountsModel({
    this.google,
    this.apple,
    this.facebook,
  });

  factory LinkAccountsModel.fromJson(Map<String, dynamic> json) => LinkAccountsModel(
        google: json['google'] == null ? null : GoogleAccountModel.fromJson(json['google']),
        apple: json['apple'] == null ? null : AppleAccountModel.fromJson(json['apple']),
        facebook: json['facebook'] == null ? null : FacebookAccountModel.fromJson(json['facebook']),
      );

  Map<String, dynamic> toJson() => {
        'google': google?.toJson(),
        'apple': apple?.toJson(),
        'facebook': apple?.toJson(),
      };
}
