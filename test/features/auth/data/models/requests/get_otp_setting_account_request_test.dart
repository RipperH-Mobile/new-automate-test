import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/requests/get_otp_setting_account_request.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart'; // For AuthenticationActionType

void main() {
  group('GetOtpTwoFaRequest', () {
    const tPhoneNumber = '1234567890';
    const tEmail = 'test@example.com';
    const tActionType = AuthenticationActionType.signin;
    const tActionTypeValue = 'SIGN_IN'; // from AuthenticationActionType.signin.value

    test(
        'Given all parameters are provided, When GetOtpTwoFaRequest is instantiated, Then properties are set correctly',
        () {
      // Arrange
      final request = GetOtpSettingAccountRequest(
        phoneNumber: tPhoneNumber,
        email: tEmail,
        actionName: tActionType,
      );

      // Assert
      expect(request.phoneNumber, equals(tPhoneNumber));
      expect(request.email, equals(tEmail));
      expect(request.actionName, equals(tActionType));
    });

    test('Given only phoneNumber and actionName, When GetOtpTwoFaRequest is instantiated, Then email is null', () {
      // Arrange
      final request = GetOtpSettingAccountRequest(
        phoneNumber: tPhoneNumber,
        actionName: tActionType,
      );

      // Assert
      expect(request.phoneNumber, equals(tPhoneNumber));
      expect(request.email, isNull);
      expect(request.actionName, equals(tActionType));
    });

    test('Given only email and actionName, When GetOtpTwoFaRequest is instantiated, Then phoneNumber is null', () {
      // Arrange
      final request = GetOtpSettingAccountRequest(
        email: tEmail,
        actionName: tActionType,
      );

      // Assert
      expect(request.phoneNumber, isNull);
      expect(request.email, equals(tEmail));
      expect(request.actionName, equals(tActionType));
    });

    test('Given only actionName, When GetOtpTwoFaRequest is instantiated, Then phoneNumber and email are null', () {
      // Arrange
      final request = GetOtpSettingAccountRequest(
        actionName: tActionType,
      );

      // Assert
      expect(request.phoneNumber, isNull);
      expect(request.email, isNull);
      expect(request.actionName, equals(tActionType));
    });

    test('Given no parameters (all null), When GetOtpTwoFaRequest is instantiated, Then all properties are null', () {
      // Arrange
      final request = GetOtpSettingAccountRequest(
        phoneNumber: null,
        email: null,
        actionName: null,
      );

      // Assert
      expect(request.phoneNumber, isNull);
      expect(request.email, isNull);
      expect(request.actionName, isNull);
    });

    group('toJson', () {
      test('Given all parameters are provided, When toJson is called, Then returns correct map', () {
        // Arrange
        final request = GetOtpSettingAccountRequest(
          phoneNumber: tPhoneNumber,
          email: tEmail,
          actionName: tActionType,
        );
        final expectedMap = {
          'phoneNumber': tPhoneNumber,
          'email': tEmail,
          'actionName': tActionTypeValue,
        };

        // Act
        final result = request.toJson();

        // Assert
        expect(result, equals(expectedMap));
      });

      test('Given only phoneNumber and actionName, When toJson is called, Then returns map with null email', () {
        // Arrange
        final request = GetOtpSettingAccountRequest(
          phoneNumber: tPhoneNumber,
          actionName: tActionType,
        );
        final expectedMap = {
          'phoneNumber': tPhoneNumber,
          'email': null,
          'actionName': tActionTypeValue,
        };

        // Act
        final result = request.toJson();

        // Assert
        expect(result, equals(expectedMap));
      });

      test('Given only email and actionName, When toJson is called, Then returns map with null phoneNumber', () {
        // Arrange
        final request = GetOtpSettingAccountRequest(
          email: tEmail,
          actionName: tActionType,
        );
        final expectedMap = {
          'phoneNumber': null,
          'email': tEmail,
          'actionName': tActionTypeValue,
        };

        // Act
        final result = request.toJson();

        // Assert
        expect(result, equals(expectedMap));
      });

      test('Given only actionName, When toJson is called, Then returns map with null phoneNumber and email', () {
        // Arrange
        final request = GetOtpSettingAccountRequest(
          actionName: tActionType,
        );
        final expectedMap = {
          'phoneNumber': null,
          'email': null,
          'actionName': tActionTypeValue,
        };

        // Act
        final result = request.toJson();

        // Assert
        expect(result, equals(expectedMap));
      });

      test('Given actionName is null, When toJson is called, Then actionName in map is null', () {
        // Arrange
        final request = GetOtpSettingAccountRequest(
          phoneNumber: tPhoneNumber,
          email: tEmail,
          actionName: null,
        );
        final expectedMap = {
          'phoneNumber': tPhoneNumber,
          'email': tEmail,
          'actionName': null,
        };

        // Act
        final result = request.toJson();

        // Assert
        expect(result, equals(expectedMap));
      });

      test('Given all parameters are null, When toJson is called, Then returns map with all null values', () {
        // Arrange
        final request = GetOtpSettingAccountRequest(
          phoneNumber: null,
          email: null,
          actionName: null,
        );
        final expectedMap = {
          'phoneNumber': null,
          'email': null,
          'actionName': null,
        };

        // Act
        final result = request.toJson();

        // Assert
        expect(result, equals(expectedMap));
      });
    });
  });
}
