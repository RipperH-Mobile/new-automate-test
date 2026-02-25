import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/requests/verify_password_setting_account_request.dart';

void main() {
  group('VerifyPasswordSettingAccountRequest', () {
    const password = 'testPassword';

    test(
        'Given password is provided, When VerifyPasswordSettingAccountRequest is instantiated, Then properties are set correctly',
        () {
      // Arrange & Act
      final request = VerifyPasswordSettingAccountRequest(password: password);

      // Assert
      expect(request.password, equals(password));
    });

    test('Given a VerifyPasswordSettingAccountRequest instance, When toJson is called, Then returns correct map', () {
      // Arrange
      final request = VerifyPasswordSettingAccountRequest(password: password);
      final expectedMap = {'password': password};

      // Act
      final result = request.toJson();

      // Assert
      expect(result, equals(expectedMap));
    });

    test('Given JSON contains password, When fromJson is called, Then returns a valid model with correct properties',
        () {
      // Arrange
      final Map<String, dynamic> jsonMap = {'password': password};

      // Act
      final result = VerifyPasswordSettingAccountRequest.fromJson(jsonMap);

      // Assert
      expect(result.password, equals(password));
    });
  });
}
