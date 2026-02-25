import 'package:isar_community/isar.dart';

part 'notification_settings_model.g.dart';

@embedded
class NotificationSettingsModel {
  final bool? enabled;
  final bool? hiddenMessage;

  NotificationSettingsModel({
    this.enabled,
    this.hiddenMessage,
  });

  factory NotificationSettingsModel.fromMap(Map<String, dynamic> data) {
    return NotificationSettingsModel(
      enabled: data['enabled'],
      hiddenMessage: data['hiddenMessage'],
    );
  }

  NotificationSettingsModel copyWith({
    bool? enabled,
    bool? hiddenMessage,
  }) {
    return NotificationSettingsModel(
      enabled: enabled,
      hiddenMessage: hiddenMessage,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};

    if (enabled != null) {
      data['enabled'] = enabled;
    }

    if (hiddenMessage != null) {
      data['hiddenMessage'] = hiddenMessage;
    }

    return data;
  }
}
