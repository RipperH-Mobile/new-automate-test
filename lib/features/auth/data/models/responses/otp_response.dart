import 'dart:convert';

import 'package:uchat/features/auth/domain/entities/otp_entity.dart';

class OtpResponse {
  final String? token;
  final String? ref;
  final String? type;
  final DateTime? firstGet;
  final DateTime? timeout;
  final String? actionToken;

  OtpResponse({
    this.token,
    this.ref,
    this.type,
    this.firstGet,
    this.timeout,
    this.actionToken,
  });

  // from json
  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      token: json['token'],
      ref: json['ref'],
      type: json['type'],
      firstGet: DateTime.parse(json['firstGet'] ?? DateTime.now().toString()),
      timeout: DateTime.parse(json['timeout'] ?? DateTime.now().add(const Duration(minutes: 1)).toString()),
      actionToken: json['actionToken'],
    );
  }

  // from String json
  factory OtpResponse.fromStringJson(String source) => OtpResponse.fromJson(
        json.decode(source) as Map<String, dynamic>,
      );

  factory OtpResponse.fromEntity(OtpEntity entity) {
    return OtpResponse(
      token: entity.token,
      ref: entity.ref,
      type: entity.type,
      firstGet: entity.firstGet,
      timeout: entity.timeout,
      actionToken: entity.actionToken,
    );
  }

  // to json
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'ref': ref,
      'type': type,
      'firstGet': firstGet?.toIso8601String(),
      'timeout': timeout?.toIso8601String(),
      'actionToken': actionToken,
    };
  }

  // to String json
  String toStringJson() {
    return json.encode(toJson());
  }

  OtpEntity toEntity() {
    return OtpEntity(
      token: token,
      ref: ref,
      type: type,
      firstGet: firstGet,
      timeout: timeout,
      actionToken: actionToken,
    );
  }


}
