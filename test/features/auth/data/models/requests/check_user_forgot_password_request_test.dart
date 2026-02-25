import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/requests/check_user_forgot_password_request.dart';

void main() {
  group('CheckUserForgotPasswordRequest', () {
    test('Given parameters, When creating CheckUserForgotPasswordRequest, Then fields should be set correctly', () {
      // When
      final request = CheckUserForgotPasswordRequest(
        phoneOrEmail: 'test@example.com',
        isForgotPassword: true,
      );

      // Then
      expect(request.phoneOrEmail, 'test@example.com');
      expect(request.isForgotPassword, true);
    });

    test('Given CheckUserForgotPasswordRequest, When calling toMap, Then should return correct map', () {
      // Given
      final request = CheckUserForgotPasswordRequest(
        phoneOrEmail: 'test@example.com',
        isForgotPassword: true,
      );

      // When
      final map = request.toMap();

      // Then
      expect(map, {
        'phoneOrEmail': 'test@example.com',
        'isForgotPassword': true,
      });
    });
  });
}