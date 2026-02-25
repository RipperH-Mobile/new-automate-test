import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/responses/check_user_forgot_password_response.dart';

void main() {
  group('CheckUserForgotPasswordResponse', () {
    test('Given email and phoneNumber, When instantiated, Then fields are assigned', () {
      // Given email and phoneNumber
      final response = CheckUserForgotPasswordResponse(
        email: 'test@example.com',
        phoneNumber: '1234567890',
      );

      expect(response.email, 'test@example.com');
      expect(response.phoneNumber, '1234567890');
    });

    test('Given JSON with email and phoneNumber, When fromJson called, Then returns correct instance', () {
      // Given JSON with email and phoneNumber
      final json = {
        'email': 'test@example.com',
        'phoneNumber': '1234567890',
      };

      // When fromJson is called
      final response = CheckUserForgotPasswordResponse.fromJson(json);

      // Then the fields should be assigned correctly
      expect(response.email, 'test@example.com');
      expect(response.phoneNumber, '1234567890');
    });

    test('Given JSON with null email, When fromJson called, Then handles null email', () {
      final json = {
        'email': null,
        'phoneNumber': '1234567890',
      };

      // When fromJson is called
      final response = CheckUserForgotPasswordResponse.fromJson(json);

      // Then the fields should be assigned correctly
      expect(response.email, null);
      expect(response.phoneNumber, '1234567890');
    });
  });
}