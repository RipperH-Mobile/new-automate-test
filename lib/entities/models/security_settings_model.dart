import 'package:isar_community/isar.dart';

part 'security_settings_model.g.dart';

@embedded
class SecuritySettingsModel {
  final bool? enabled;
  final bool? allowMultiFactor;

  SecuritySettingsModel({
    this.enabled,
    this.allowMultiFactor,
  });

  factory SecuritySettingsModel.fromMap(Map<String, dynamic> data) {
    return SecuritySettingsModel(
      enabled: data['enabled'],
      allowMultiFactor: data['allowMultiFactor'],
    );
  }

  SecuritySettingsModel copyWith({
    bool? enabled,
    bool? allowMultiFactor,
  }) {
    return SecuritySettingsModel(
      enabled: enabled,
      allowMultiFactor: allowMultiFactor,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};

    if (enabled != null) {
      data['enabled'] = enabled;
    }

    if (allowMultiFactor != null) {
      data['allowMultiFactor'] = allowMultiFactor;
    }

    return {
      'enabled': enabled,
      'allowMultiFactor': allowMultiFactor,
    };
  }
}
