import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/requests/check_user_exist_with_password_request.dart';

void main() {
  group('CheckUserExistWithPasswordRequest', () {
    test('Given parameters, When creating CheckUserExistWithPasswordRequest, Then fields should be set correctly', () {
      // When
      final request = CheckUserExistWithPasswordRequest(
        phoneOrEmail: 'test@example.com',
        password: 'password123',
        isSignUp: true,
        isDesktop: true,
      );

      // Then
      expect(request.phoneOrEmail, 'test@example.com');
      expect(request.password, 'password123');
      expect(request.isSignUp, true);
      expect(request.isDesktop, true);
    });

    test('Given CheckUserExistWithPasswordRequest, When calling toMap, Then should return correct map', () {
      // Given
      final request = CheckUserExistWithPasswordRequest(
        phoneOrEmail: 'test@example.com',
        password: 'password123',
        isSignUp: true,
        isDesktop: true,
      );

      // When
      final map = request.toMap();

      // Then
      expect(map, {
        'phoneOrEmail': 'test@example.com',
        'password': 'password123',
        'isSignUp': true,
        'isDesktop': true,
      });
    });
  });
}