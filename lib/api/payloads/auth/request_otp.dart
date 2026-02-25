import 'dart:convert';

import 'package:uchat/entities/collections/user_collection.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';

class RequestOTPResponse {
  String? token;
  String? ref;
  String? type;
  DateTime? firstGet;
  DateTime? timeout;
  String? phoneNumber;
  String? email;
  bool? passwordRequired;
  String? actionToken;
  UserCollection? account;

  /// This variable doesn't come from server. This is used to save, check and reuse response from local db only.
  SelectedOtpType? selectedOtpType;

  RequestOTPResponse({
    this.token,
    this.ref,
    this.type,
    this.firstGet,
    this.timeout,
    this.phoneNumber,
    this.email,
    this.passwordRequired,
    this.actionToken,
    this.selectedOtpType,
    this.account,
  });

  factory RequestOTPResponse.fromMap(Map<String, dynamic> json) {
    final timeout = json['timeout'] ?? DateTime.now().add(const Duration(minutes: 1)).toString();
    SelectedOtpType? selectedOtpType;
    if (json['selectedOtpType'] != null) {
      selectedOtpType = SelectedOtpType.from(json['selectedOtpType']);
    }

    return RequestOTPResponse(
      token: json['token'],
      ref: json['ref'],
      type: json['type'],
      firstGet: DateTime.parse(json['firstGet'] ?? DateTime.now().toString()),
      timeout: DateTime.parse(timeout),
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      passwordRequired: json['passwordRequired'],
      actionToken: json['actionToken'],
      selectedOtpType: selectedOtpType,
      account: json['account'] != null ? UserCollection.fromMap(json['account']) : null,
    );
  }

  String toStringJson({SelectedOtpType? selectedOtpType}) {
    final data = {
      'token': token,
      'ref': ref,
      'type': type,
      'firstGet': firstGet?.toIso8601String(),
      'timeout': timeout?.toIso8601String(),
      'phoneNumber': phoneNumber,
      'email': email,
      'passwordRequired': passwordRequired,
      'actionToken': actionToken,
      'selectedOtpType': selectedOtpType?.value ?? SelectedOtpType.phone.value,
    };

    return json.encode(data);
  }

  @override
  String toString() {
    return '[RequestOTPResponse] token: $token,'
        'ref: $ref,'
        'type: $type,'
        'firstGet: $firstGet,'
        'timeout: $timeout,'
        'phoneNumber: $phoneNumber,'
        'email: $email,'
        'passwordRequired: $passwordRequired,'
        'actionToken: $actionToken,'
        'selectedOtpType: $selectedOtpType';
  }
}
