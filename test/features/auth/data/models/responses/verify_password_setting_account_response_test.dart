import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/domain/entities/verify_password_setting_account_entity.dart';
import 'package:uchat/features/auth/data/models/responses/verify_password_setting_account_response.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';

void main() {
  group('VerifyPasswordSettingAccountResponse', () {
    const actionToken = 'testActionToken';
    const actionName = AuthenticationActionType.settingEmail;
    test(
        'Given VerifyPasswordSettingAccountResponse is a sealed class, When VerifyPasswordSettingAccountResponse is instantiated, Then it should be a subclass of VerifyPasswordSettingAccountResponse',
        () {
      // Arrange
      final response = VerifyPasswordSettingAccountUnable2faResponse(
        actionToken: actionToken,
        actionName: actionName,
      );

      // Assert
      expect(response, isA<VerifyPasswordSettingAccountResponse>());
    });

    test(
        'Given VerifyPasswordSettingAccountResponse is a sealed class, When VerifyPasswordSettingAccountResponse is instantiated, Then it should be a subclass of VerifyPasswordSettingAccountUnable2faResponse',
        () {
      // Arrange
      final response = VerifyPasswordSettingAccountUnable2faResponse(
        actionToken: actionToken,
        actionName: actionName,
      );

      // Assert
      expect(response, isA<VerifyPasswordSettingAccountUnable2faResponse>());
    });
  });
  group('VerifyPasswordSettingAccountUnable2faResponse', () {
    const actionToken = 'testActionToken';
    const actionName = AuthenticationActionType.settingEmail;
    test(
        'Given actionToken and actionName are provided, When VerifyPasswordSettingAccountUnable2faResponse is instantiated, Then properties are set correctly',
        () {
      // Arrange
      final response = VerifyPasswordSettingAccountUnable2faResponse(
        actionToken: actionToken,
        actionName: actionName,
      );

      // Assert
      expect(response.actionToken, equals(actionToken));
      expect(response.actionName, equals(actionName));
    });

    test(
        'Given JSON contains actionToken and actionName, When fromJson is called, Then returns a valid model with correct properties',
        () {
      // Arrange
      final Map<String, dynamic> jsonMap = {
        'actionToken': actionToken,
        'actionName': actionName.value,
      };

      // Act
      final result = VerifyPasswordSettingAccountUnable2faResponse.fromJson(jsonMap);

      // Assert
      expect(result.actionToken, equals(actionToken));
      expect(result.actionName, equals(actionName));
    });

    test(
        'Given a VerifyPasswordSettingAccountUnable2faResponse instance, When toJson is called, Then returns correct map',
        () {
      // Arrange
      final response = VerifyPasswordSettingAccountUnable2faResponse(
        actionToken: actionToken,
        actionName: actionName,
      );
      final expectedMap = {
        'actionToken': actionToken,
        'actionName': actionName.value,
      };

      // Act
      final result = response.toJson();

      // Assert
      expect(result, equals(expectedMap));
    });

    test(
        'Given a VerifyPasswordSettingAccountUnable2faResponse instance, When toEntity is called, Then returns a VerifyPasswordSettingAccountUnable2faEntity with the same properties',
        () {
      // Arrange
      final response = VerifyPasswordSettingAccountUnable2faResponse(
        actionToken: actionToken,
        actionName: actionName,
      );

      // Act
      final entity = response.toEntity();

      // Assert
      expect(entity, isA<VerifyPasswordSettingAccountUnable2faEntity>());
      expect(entity.actionToken, equals(actionToken));
      expect(entity.actionName, equals(actionName));
    });
  });

  group('VerifyPasswordSettingAccountEnable2faResponse', () {
    const phoneNumber = '1234567890';
    const email = 'test@example.com';
    test(
        'Given phoneNumber and email are provided, When VerifyPasswordSettingAccountEnable2faResponse is instantiated, Then properties are set correctly',
        () {
      // Arrange
      final response = VerifyPasswordSettingAccountEnable2faResponse(
        phoneNumber: phoneNumber,
        email: email,
      );

      // Assert
      expect(response.phoneNumber, equals(phoneNumber));
      expect(response.email, equals(email));
    });

    test(
        'Given JSON contains phoneNumber and email, When fromJson is called, Then returns a valid model with correct properties',
        () {
      // Arrange
      final Map<String, dynamic> jsonMap = {
        'phoneNumber': phoneNumber,
        'email': email,
      };

      // Act
      final result = VerifyPasswordSettingAccountEnable2faResponse.fromJson(jsonMap);

      // Assert
      expect(result.phoneNumber, equals('1234567890'));
      expect(result.email, equals('test@example.com'));
    });

    test(
        'Given a VerifyPasswordSettingAccountEnable2faResponse instance, When toJson is called, Then returns correct map',
        () {
      // Arrange
      final response = VerifyPasswordSettingAccountEnable2faResponse(
        phoneNumber: phoneNumber,
        email: email,
      );
      final expectedMap = {
        'phoneNumber': phoneNumber,
        'email': email,
      };

      // Act
      final result = response.toJson();

      // Assert
      expect(result, equals(expectedMap));
    });

    test(
        'Given a VerifyPasswordSettingAccountEnable2faResponse instance, When toEntity is called, Then returns a VerifyPasswordSettingAccountEnable2faEntity with the same properties',
        () {
      // Arrange
      final response = VerifyPasswordSettingAccountEnable2faResponse(
        phoneNumber: phoneNumber,
        email: email,
      );

      // Act
      final entity = response.toEntity();

      // Assert
      expect(entity, isA<VerifyPasswordSettingAccountEnable2faEntity>());
      expect(entity.phoneNumber, equals(phoneNumber));
      expect(entity.email, equals(email));
    });
  });
}
