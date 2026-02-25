import 'package:isar_community/isar.dart';

part 'profile_settings_model.g.dart';

@embedded
class ProfileSettingsModel {
  final bool? enabled;
  final bool? hiddenPhoneNumber;

  ProfileSettingsModel({
    this.enabled,
    this.hiddenPhoneNumber,
  });

  factory ProfileSettingsModel.fromMap(Map<String, dynamic> data) {
    return ProfileSettingsModel(
      enabled: data['enabled'],
      hiddenPhoneNumber: data['hiddenPhoneNumber'],
    );
  }

  ProfileSettingsModel copyWith({
    bool? enabled,
    bool? hiddenPhoneNumber,
  }) {
    return ProfileSettingsModel(
      enabled: enabled,
      hiddenPhoneNumber: hiddenPhoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};

    if (enabled != null) {
      data['enabled'] = enabled;
    }

    if (hiddenPhoneNumber != null) {
      data['hiddenPhoneNumber'] = hiddenPhoneNumber;
    }

    return data;
  }
}
