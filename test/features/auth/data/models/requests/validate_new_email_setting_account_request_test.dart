import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/requests/validate_new_email_setting_account_request.dart';

void main() {
  group('ValidateNewEmailSettingAccountRequest', () {
    const newEmail = 'test@example.com';

    test(
        'Given newEmail is provided, When ValidateNewEmailSettingAccountRequest is instantiated, Then properties are set correctly',
        () {
      // Arrange & Act
      final request = ValidateNewEmailSettingAccountRequest(newEmail: newEmail);

      // Assert
      expect(request.newEmail, equals(newEmail));
    });

    test('Given a ValidateNewEmailSettingAccountRequest instance, When toJson is called, Then returns correct map', () {
      // Arrange
      final request = ValidateNewEmailSettingAccountRequest(newEmail: newEmail);
      final expectedMap = {'newEmail': newEmail};

      // Act
      final result = request.toJson();

      // Assert
      expect(result, equals(expectedMap));
    });

    test('Given JSON contains newEmail, When fromJson is called, Then returns a valid model with correct properties',
        () {
      // Arrange
      final Map<String, dynamic> jsonMap = {'email': newEmail};

      // Act
      final result = ValidateNewEmailSettingAccountRequest.fromJson(jsonMap);

      // Assert
      expect(result.newEmail, equals(newEmail));
    });
  });
}
