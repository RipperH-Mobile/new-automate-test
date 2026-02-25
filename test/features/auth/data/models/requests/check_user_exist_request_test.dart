import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/requests/check_user_exist_request.dart';

void main() {
  group('CheckUserExistRequest', () {
    test('Given parameters, When creating CheckUserExistRequest, Then fields should be set correctly', () {
      // When
      final request = CheckUserExistRequest(
        phoneOrEmail: 'test@example.com',
        isSignUp: true,
      );

      // Then
      expect(request.phoneOrEmail, 'test@example.com');
      expect(request.isSignUp, true);
    });

    test('Given CheckUserExistRequest, When calling toMap, Then should return correct map', () {
      // Given
      final request = CheckUserExistRequest(
        phoneOrEmail: 'test@example.com',
        isSignUp: true,
      );

      // When
      final map = request.toMap();

      // Then
      expect(map, {
        'phoneOrEmail': 'test@example.com',
        'isSignUp': true,
      });
    });
  });
}