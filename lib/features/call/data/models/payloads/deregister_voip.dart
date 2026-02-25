///
/// DeregisterVoipResponse
/// This api has only response, not have the request payload.
///
class DeregisterVoipResponse {
  //
  // OneSignal ID
  // The field must be available all time
  //
  final String oneSignalId;

  DeregisterVoipResponse({
    required this.oneSignalId,
  });

  factory DeregisterVoipResponse.fromMap(Map<String, dynamic> map) {
    return DeregisterVoipResponse(
      oneSignalId: map['identity']['onesignal_id'] as String,
    );
  }
}
