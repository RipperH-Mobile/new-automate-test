import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/requests/get_otp_forgot_password_request.dart';

void main() {
  group('GetOtpForgotPasswordRequest', () {
    test('Given parameters, When creating GetOtpForgotPasswordRequest, Then fields should be set correctly', () {
      // When
      final request = GetOtpForgotPasswordRequest(
        phoneOrEmail: 'test@example.com',
        isPhoneNumber: true,
        isEmail: false,
        isForgotPassword: true,
      );

      // Then
      expect(request.phoneOrEmail, 'test@example.com');
      expect(request.isPhoneNumber, true);
      expect(request.isEmail, false);
      expect(request.isForgotPassword, true);
    });

    test('Given GetOtpForgotPasswordRequest, When calling toJson, Then should return correct map', () {
      // Given
      final request = GetOtpForgotPasswordRequest(
        phoneOrEmail: 'test@example.com',
        isPhoneNumber: true,
        isEmail: false,
        isForgotPassword: true,
      );

      // When
      final json = request.toJson();

      // Then
      expect(json, {
        'phoneOrEmail': 'test@example.com',
        'isPhoneNumber': true,
        'isEmail': false,
        'isForgotPassword': true,
      });
    });
  });
}