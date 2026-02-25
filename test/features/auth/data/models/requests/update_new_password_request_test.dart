import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/requests/update_new_password_request.dart';

void main() {
  group('UpdateNewPasswordRequest', () {
    const tActionToken = 'test_action_token';
    const tNewPassword = 'TestNewPassword123!';

    test(
        'Given valid actionToken and newPassword, When UpdateNewPasswordRequest is instantiated, Then properties are set correctly',
        () {
      // Given
      // Values are defined above

      // When
      final request = UpdateNewPasswordRequest(
        actionToken: tActionToken,
        newPassword: tNewPassword,
      );

      // Then
      expect(request.actionToken, equals(tActionToken),
          reason: 'actionToken should match the provided value');
      expect(request.newPassword, equals(tNewPassword),
          reason: 'newPassword should match the provided value');
    });

    test(
        'Given an UpdateNewPasswordRequest instance, When toJson is called, Then returns a correct JSON map',
        () {
      // Given
      final request = UpdateNewPasswordRequest(
        actionToken: tActionToken,
        newPassword: tNewPassword,
      );
      final expectedJson = {
        'actionToken': tActionToken,
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