import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/requests/validate_new_password_request.dart';

void main() {
  group('ValidateNewPasswordRequest', () {
    const tNewPassword = 'TestNewPassword123!';

    test(
        'Given a newPassword, When ValidateNewPasswordRequest is instantiated, Then properties are set correctly',
        () {
      // Given
      // Value is defined above

      // When
      final request = ValidateNewPasswordRequest(
        newPassword: tNewPassword,
      );

      // Then
      expect(request.newPassword, equals(tNewPassword),
          reason: 'newPassword should match the provided value');
    });

    test(
        'Given a ValidateNewPasswordRequest instance, When toJson is called, Then returns a correct JSON map',
        () {
      // Given
      final request = ValidateNewPasswordRequest(
        newPassword: tNewPassword,
      );
      final expectedJson = {
        'newPassword': tNewPassword,
      };

      // When
      final resultJson = request.toJson();

      // Then
      expect(resultJson, equals(expectedJson),
          reason: 'toJson should return a map with correct key-value pairs');
    });
  });
}