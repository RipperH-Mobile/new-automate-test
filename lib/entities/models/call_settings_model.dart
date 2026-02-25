import 'package:isar_community/isar.dart';

part 'call_settings_model.g.dart';

@embedded
class CallSettingsModel {
  final bool? enabled;
  final bool? allowCallKit;
  final bool? allowIncomingCall;

  CallSettingsModel({
    this.enabled,
    this.allowCallKit,
    this.allowIncomingCall,
  });

  factory CallSettingsModel.fromMap(Map<String, dynamic> data) {
    return CallSettingsModel(
      enabled: data['enabled'],
      allowCallKit: data['allowCallKit'],
      allowIncomingCall: data['allowIncomingCall'],
    );
  }

  CallSettingsModel copyWith({
    bool? enabled,
    bool? allowCallKit,
    bool? allowIncomingCall,
  }) {
    return CallSettingsModel(
      enabled: enabled,
      allowCallKit: allowCallKit,
      allowIncomingCall: allowIncomingCall,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};

    if (enabled != null) {
      data['enabled'] = enabled;
    }

    if (allowCallKit != null) {
      data['allowCallKit'] = allowCallKit;
    }

    if (allowIncomingCall != null) {
      data['allowIncomingCall'] = allowIncomingCall;
    }

    return data;
  }
}
