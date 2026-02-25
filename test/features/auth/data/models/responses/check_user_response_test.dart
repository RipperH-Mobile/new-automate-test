import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/responses/check_user_response.dart';

void main() {
  group('CheckUserOtpResponse', () {
    test('Given JSON with all fields, When fromJson called, Then returns correct instance', () {
      // Given JSON with all fields
      final now = DateTime.now();
      final json = {
        'token': 'token123',
        'ref': 'ref123',
        'type': 'sms',
        'firstGet': now.toIso8601String(),
        'timeout': now.add(const Duration(minutes: 1)).toIso8601String(),
        'phoneNumber': '1234567890',
        'email': 'test@example.com',
        'actionToken': 'action123',
      };

      final response = CheckUserOtpResponse.fromJson(json);

      // Then the fields should be assigned correctly
      expect(response.token, 'token123');
      expect(response.ref, 'ref123');
      expect(response.type, 'sms');
      expect(response.firstGet?.toIso8601String(), now.toIso8601String());
      expect(response.timeout?.toIso8601String(), now.add(const Duration(minutes: 1)).toIso8601String());
      expect(response.phoneNumber, '1234567890');
      expect(response.email, 'test@example.com');
      expect(response.actionToken, 'action123');
    });

    test('Given JSON with null dates, When fromJson called, Then uses default dates', () {
      // Given JSON with null dates
      // Given JSON with passwordRequired true
      final json = {
        'firstGet': null,
        'timeout': null,
      };

      // When fromJson is called
      // When fromJson is called
      final response = CheckUserOtpResponse.fromJson(json);

      // Then the fields should be assigned correctly
      expect(response.firstGet, isA<DateTime>());
      expect(response.timeout, isA<DateTime>());
    });
  });

  group('CheckUserPasswordResponse', () {
    test('Given JSON with passwordRequired true, When fromJson called, Then returns correct instance', () {
      // Given JSON with passwordRequired null
      final json = {
        'passwordRequired': true,
      };

      // When fromJson is called
      // When fromJson is called
      final response = CheckUserPasswordResponse.fromJson(json);

      // Then the fields should be assigned correctly
      expect(response.passwordRequired, true);
    });

    test('Given JSON with passwordRequired null, When fromJson called, Then handles null', () {
      final json = {
        'passwordRequired': null,
      };

      final response = CheckUserPasswordResponse.fromJson(json);

      // Then the fields should be assigned correctly
      expect(response.passwordRequired, null);
    });
  });
}