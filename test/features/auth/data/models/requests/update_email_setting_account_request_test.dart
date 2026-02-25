import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/requests/update_email_setting_account_request.dart';

void main() {
  group('UpdateEmailSettingAccountRequest', () {
    const actionToken = 'testActionToken';
    const newEmail = 'test@example.com';

    test(
        'Given actionToken and newEmail are provided, When UpdateEmailSettingAccountRequest is instantiated, Then properties are set correctly',
        () {
      // Arrange & Act
      final request = UpdateEmailSettingAccountRequest(
        actionToken: actionToken,
        newEmail: newEmail,
      );

      // Assert
      expect(request.actionToken, equals(actionToken));
      expect(request.newEmail, equals(newEmail));
    });

    test('Given an UpdateEmailSettingAccountRequest instance, When toJson is called, Then returns correct map', () {
      // Arrange
      final request = UpdateEmailSettingAccountRequest(
        actionToken: actionToken,
        newEmail: newEmail,
      );
      final expectedMap = {
        'actionToken': actionToken,
        'newEmail': newEmail,
      };

      // Act
      final result = request.toJson();

      // Assert
      expect(result, equals(expectedMap));
    });

    test(
        'Given JSON contains actionToken and newEmail, When fromJson is called, Then returns a valid model with correct properties',
        () {
      // Arrange
      final Map<String, dynamic> jsonMap = {
        'actionToken': actionToken,
        'newEmail': newEmail,
      };

      // Act
      final result = UpdateEmailSettingAccountRequest.fromJson(jsonMap);

      // Assert
      expect(result.actionToken, equals(actionToken));
      expect(result.newEmail, equals(newEmail));
    });
  });
}
