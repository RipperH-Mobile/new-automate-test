import 'package:isar_community/isar.dart';

part 'premium_package_language_model.g.dart';

@embedded
class PremiumPackageLanguageModel {
  String? th;
  String? en;

  PremiumPackageLanguageModel({
    this.th,
    this.en,
  });

  static PremiumPackageLanguageModel fromMap(Map<String, dynamic> json) {
    return PremiumPackageLanguageModel(
      th: json['th'],
      en: json['en'],
    );
  }

  @override
  String toString() => 'PremiumPackageLanguageModel(th: $th, en: $en)';
}
