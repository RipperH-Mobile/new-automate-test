import 'package:flutter/foundation.dart';

@immutable
class GetSessionsListResponse {
  final String? sessionId;
  final String? deviceModel;
  final String? deviceOS;
  final String? loginLocation;
  final DateTime? lastLoginAt;

  const GetSessionsListResponse({
    this.sessionId,
    this.deviceModel,
    this.deviceOS,
    this.loginLocation,
    this.lastLoginAt,
  });

  factory GetSessionsListResponse.fromMap(Map<String, dynamic> json) {
    return GetSessionsListResponse(
      sessionId: json['_id'] ?? '',
      deviceModel: json['meta']?['device']?['name'] ?? json['meta']?['device']?['model'] ?? '',
      deviceOS: json['meta']?['device']?['os'] ?? '',
      loginLocation: json['meta']?['locationName'] ?? '',
      lastLoginAt: DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now().toUtc(),
    );
  }

  @override
  String toString() {
    return 'GetSessionsListResponse(sessionId: $sessionId, deviceModel: $deviceModel, deviceOS: $deviceOS, loginLocation: $loginLocation, lastLoginAt: $lastLoginAt)';
  }
}
