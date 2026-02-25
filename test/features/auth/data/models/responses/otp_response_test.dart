import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/responses/otp_response.dart';

void main() {
  group('OtpResponse', () {
    test('Given JSON with all fields, When fromJson called, Then returns correct instance', () {
      // Given JSON with all fields
      final now = DateTime.now();
      final json = {
        'token': 'token123',
        'ref': 'ref123',
        'type': 'sms',
        'firstGet': now.toIso8601String(),
        'timeout': now.add(const Duration(minutes: 1)).toIso8601String(),
        'actionToken': 'action123',
      };

      final response = OtpResponse.fromJson(json);

      expect(response.token, 'token123');
      expect(response.ref, 'ref123');
      expect(response.type, 'sms');
      expect(response.firstGet?.toIso8601String(), now.toIso8601String());
      expect(response.timeout?.toIso8601String(), now.add(const Duration(minutes: 1)).toIso8601String());
      expect(response.actionToken, 'action123');
    });

    test('Given JSON with null dates, When fromJson called, Then uses default dates', () {
      // Given JSON with null dates
      final json = {
        'firstGet': null,
        'timeout': null,
      };

      // When fromJson is called
      // When fromJson is called
      final response = OtpResponse.fromJson(json);

      // Then the fields should be correct
      expect(response.firstGet, isA<DateTime>());
      expect(response.timeout, isA<DateTime>());
    });

    test('Given JSON string, When fromStringJson called, Then returns correct instance', () {
      // Given JSON string
      final jsonString = '{"token":"token123","ref":"ref123","type":"sms","firstGet":null,"timeout":null,"actionToken":"action123"}';

      // When fromStringJson is called
      final response = OtpResponse.fromStringJson(jsonString);

      // Then the fields should be correct
      // Then the fields should be correct
      expect(response.token, 'token123');
      expect(response.ref, 'ref123');
      expect(response.type, 'sms');
      expect(response.actionToken, 'action123');
    });

    test('Given OtpResponse, When toJson called, Then returns correct map', () {
      // Given an OtpResponse instance
      final now = DateTime.now();
      final response = OtpResponse(
        token: 'token123',
        ref: 'ref123',
        type: 'sms',
        firstGet: now,
        timeout: now.add(const Duration(minutes: 1)),
        actionToken: 'action123',
      );

      // When toJson is called
      final json = response.toJson();

      // Then the output should be correct
      expect(json['token'], 'token123');
      expect(json['ref'], 'ref123');
      expect(json['type'], 'sms');
      expect(json['firstGet'], now.toIso8601String());
      expect(json['timeout'], now.add(const Duration(minutes: 1)).toIso8601String());
      expect(json['actionToken'], 'action123');
    });

    test('Given OtpResponse, When toStringJson called, Then returns valid JSON string', () {
      // Given an OtpResponse instance
      final response = OtpResponse(token: 'token123');
      // When toStringJson is called
      final jsonString = response.toStringJson();

      // Then the output should be correct
      expect(jsonString, contains('"token":"token123"'));
    });
  });
}