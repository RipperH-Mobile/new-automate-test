import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

///
/// RegisterVoipRequest
/// For registering VoIP token to OneSignal
///
class RegisterVoipRequest {
  final String voipToken;
  final int testType;

  RegisterVoipRequest({
    required this.voipToken,
    this.testType = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'voipToken': voipToken,
      'testType': testType,
    };
  }
}

///
/// RegisterVoipResponse
/// The response from the server after registering the VoIP token
///
class RegisterVoipResponse {
  //
  // OneSignal ID
  // The field must be available all time
  //
  final String oneSignalId;

  //
  // Timestamp of the first active time
  // The field available when the user has registered the VoIP token (not first time)
  //
  final int? firstActive;

  RegisterVoipResponse({
    required this.oneSignalId,
    this.firstActive,
  });

  factory RegisterVoipResponse.fromMap(Map<String, dynamic> map) {
    useLogger().d('RegisterVoipResponse.fromMap: $map');

    return RegisterVoipResponse(
      oneSignalId: map['identity']['onesignal_id'] as String,
      firstActive: map['properties']['first_active'] as int?,
    );
  }
}
