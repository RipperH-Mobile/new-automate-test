import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/requests/check_phone_or_email_request.dart';

void main() {
  group('CheckUserPhoneOrEmailRequest', () {
    test('Given parameters, When creating CheckUserPhoneOrEmailRequest, Then fields should be set correctly', () {
      // When
      final request = CheckUserPhoneOrEmailRequest(
        phoneOrEmail: 'test@example.com',
        isForgotPassword: true,
      );

      // Then
      expect(request.phoneOrEmail, 'test@example.com');
      expect(request.isForgotPassword, true);
    });

    test('Given CheckUserPhoneOrEmailRequest, When calling toMap, Then should return correct map', () {
      // Given
      final request = CheckUserPhoneOrEmailRequest(
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

  group('CheckUserPhoneOrEmailResponse', () {
    test('Given map, When calling fromMap, Then should create correct response', () {
      // Given
      final map = {
        'phoneNumber': '1234567890',
        'email': 'test@example.com',
      };

      // When
      final response = CheckUserPhoneOrEmailResponse.fromMap(map);

      // Then
      expect(response.phoneNumber, '1234567890');
      expect(response.email, 'test@example.com');
    });
  });
}