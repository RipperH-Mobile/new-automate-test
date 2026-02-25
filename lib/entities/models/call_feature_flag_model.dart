import 'package:isar_community/isar.dart';
import 'package:uchat/entities/models/feature_flag_base.dart';

part 'call_feature_flag_model.g.dart';

@embedded
class CallFeatureFlagModel implements FeatureFlagInterface {
  @override
  bool? enabled;
  bool? isTest;

  CallFeatureFlagModel({
    this.enabled,
    this.isTest,
  });

  static CallFeatureFlagModel fromMap(Map<String, dynamic> json) {
    return CallFeatureFlagModel(
      enabled: json['enabled'],
      isTest: json['isTest'],
    );
  }

  @override
  String toString() {
    return '[CallFeatureFlagModel] enabled: $enabled'
        ' isTest: $isTest';
  }
}
