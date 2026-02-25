import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/requests/forgot_password_request.dart';

void main() {
  group('ForgotPasswordRequest', () {
    test('Given parameters, When creating ForgotPasswordRequest, Then fields should be set correctly', () {
      // When
      final request = ForgotPasswordRequest(
        actionToken: 'token',
        phoneOrEmail: 'test@example.com',
        password: 'password123',
      );

      // Then
      expect(request.actionToken, 'token');
      expect(request.phoneOrEmail, 'test@example.com');
      expect(request.password, 'password123');
    });

    test('Given ForgotPasswordRequest, When calling toMap, Then should return correct map', () {
      // Given
      final request = ForgotPasswordRequest(
        actionToken: 'token',
        phoneOrEmail: 'test@example.com',
        password: 'password123',
      );

      // When
      final map = request.toMap();

      // Then
      expect(map, {
        'actionToken': 'token',
        'phoneOrEmail': 'test@example.com',
        'password': 'password123',
      });
    });
  });
}