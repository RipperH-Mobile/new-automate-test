import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/entities/collections/user_collection.dart';
import 'package:uchat/features/auth/data/models/responses/check_password_response.dart';
import 'package:uchat/features/auth/domain/entities/check_password_entity.dart';

// Mock classes
class MockUserCollection extends Mock implements UserCollection {}

class MockUserEntity extends Mock implements UserEntity {}

void main() {
  group('CheckPasswordResponseUnableTwoFa', () {
    group('constructor', () {
      test('Given null token and account, When constructor is called, Then creates instance with null values', () {
        // Given & When
        final response = CheckPasswordResponseUnableTwoFa(
          token: null,
          account: null,
        );

        // Then
        expect(response.token, isNull);
        expect(response.account, isNull);
      });

      test('Given valid token and account, When constructor is called, Then creates instance with provided values', () {
        // Given
        const token = 'test_token';
        final account = MockUserCollection();

        // When
        final response = CheckPasswordResponseUnableTwoFa(
          token: token,
          account: account,
        );

        // Then
        expect(response.token, equals(token));
        expect(response.account, equals(account));
      });
    });

    group('fromJson', () {
      test(
          'Given JSON with token and account, When fromJson is called, Then returns correct CheckPasswordResponseUnableTwoFa instance',
          () {
        // Given
        final accountMap = {'id': '123', 'name': 'Test User'};
        final json = {
          'token': 'test_token',
          'account': accountMap,
        };

        // When
        final response = CheckPasswordResponseUnableTwoFa.fromJson(json);

        // Then
        expect(response.token, equals('test_token'));
        expect(response.account, isNotNull);
      });

      test('Given JSON with null token, When fromJson is called, Then returns instance with null token', () {
        // Given
        final json = {
          'token': null,
          'account': {'id': '123'},
        };

        // When
        final response = CheckPasswordResponseUnableTwoFa.fromJson(json);

        // Then
        expect(response.token, isNull);
        expect(response.account, isNotNull);
      });

      test('Given JSON with null account, When fromJson is called, Then returns instance with null account', () {
        // Given
        final json = {
          'token': 'test_token',
          'account': null,
        };

        // When
        final response = CheckPasswordResponseUnableTwoFa.fromJson(json);

        // Then
        expect(response.token, equals('test_token'));
        expect(response.account, isNull);
      });

      test('Given JSON with missing token field, When fromJson is called, Then returns instance with null token', () {
        // Given
        final json = {
          'account': {'id': '123'},
        };

        // When
        final response = CheckPasswordResponseUnableTwoFa.fromJson(json);

        // Then
        expect(response.token, isNull);
        expect(response.account, isNotNull);
      });

      test('Given JSON with missing account field, When fromJson is called, Then returns instance with null account',
          () {
        // Given
        final json = {
          'token': 'test_token',
        };

        // When
        final response = CheckPasswordResponseUnableTwoFa.fromJson(json);

        // Then
        expect(response.token, equals('test_token'));
        expect(response.account, isNull);
      });
    });

    group('toEntity', () {
      test(
          'Given response with token and account, When toEntity is called, Then returns CheckPasswordEntityUnableTwoFa with converted values',
          () {
        // Given
        final mockUserCollection = MockUserCollection();
        final mockUserEntity = MockUserEntity();
        when(() => mockUserCollection.toEntity()).thenReturn(mockUserEntity);

        final response = CheckPasswordResponseUnableTwoFa(
          token: 'test_token',
          account: mockUserCollection,
        );

        // When
        final entity = response.toEntity();

        // Then
        expect(entity, isA<CheckPasswordEntityUnableTwoFa>());
        expect(entity.token, equals('test_token'));
        expect(entity.account, equals(mockUserEntity));
        verify(() => mockUserCollection.toEntity()).called(1);
      });

      test(
          'Given response with null token and account, When toEntity is called, Then returns CheckPasswordEntityUnableTwoFa with null values',
          () {
        // Given
        final response = CheckPasswordResponseUnableTwoFa(
          token: null,
          account: null,
        );

        // When
        final entity = response.toEntity();

        // Then
        expect(entity, isA<CheckPasswordEntityUnableTwoFa>());
        expect(entity.token, isNull);
        expect(entity.account, isNull);
      });

      test(
          'Given response with token but null account, When toEntity is called, Then returns CheckPasswordEntityUnableTwoFa with token and null account',
          () {
        // Given
        final response = CheckPasswordResponseUnableTwoFa(
          token: 'test_token',
          account: null,
        );

        // When
        final entity = response.toEntity();

        // Then
        expect(entity, isA<CheckPasswordEntityUnableTwoFa>());
        expect(entity.token, equals('test_token'));
        expect(entity.account, isNull);
      });
    });
  });

  group('CheckPasswordResponseEnableTwoFa', () {
    group('constructor', () {
      test('Given phoneNumber and email, When constructor is called, Then creates instance with provided values', () {
        // Given
        const phoneNumber = '+1234567890';
        const email = 'test@example.com';

        // When
        final response = CheckPasswordResponseEnableTwoFa(
          phoneNumber: phoneNumber,
          email: email,
        );

        // Then
        expect(response.phoneNumber, equals(phoneNumber));
        expect(response.email, equals(email));
      });
    });

    group('fromJson', () {
      test(
          'Given JSON with phoneNumber and email, When fromJson is called, Then returns correct CheckPasswordResponseEnableTwoFa instance',
          () {
        // Given
        final json = {
          'phoneNumber': '+1234567890',
          'email': 'test@example.com',
        };

        // When
        final response = CheckPasswordResponseEnableTwoFa.fromJson(json);

        // Then
        expect(response.phoneNumber, equals('+1234567890'));
        expect(response.email, equals('test@example.com'));
      });

      test(
          'Given JSON with null phoneNumber, When fromJson is called, Then returns instance with empty string phoneNumber',
          () {
        // Given
        final json = {
          'phoneNumber': null,
          'email': 'test@example.com',
        };

        // When
        final response = CheckPasswordResponseEnableTwoFa.fromJson(json);

        // Then
        expect(response.phoneNumber, equals(''));
        expect(response.email, equals('test@example.com'));
      });

      test('Given JSON with null email, When fromJson is called, Then returns instance with empty string email', () {
        // Given
        final json = {
          'phoneNumber': '+1234567890',
          'email': null,
        };

        // When
        final response = CheckPasswordResponseEnableTwoFa.fromJson(json);

        // Then
        expect(response.phoneNumber, equals('+1234567890'));
        expect(response.email, equals(''));
      });

      test(
          'Given JSON with missing phoneNumber field, When fromJson is called, Then returns instance with empty string phoneNumber',
          () {
        // Given
        final json = {
          'email': 'test@example.com',
        };

        // When
        final response = CheckPasswordResponseEnableTwoFa.fromJson(json);

        // Then
        expect(response.phoneNumber, equals(''));
        expect(response.email, equals('test@example.com'));
      });

      test(
          'Given JSON with missing email field, When fromJson is called, Then returns instance with empty string email',
          () {
        // Given
        final json = {
          'phoneNumber': '+1234567890',
        };

        // When
        final response = CheckPasswordResponseEnableTwoFa.fromJson(json);

        // Then
        expect(response.phoneNumber, equals('+1234567890'));
        expect(response.email, equals(''));
      });

      test('Given empty JSON, When fromJson is called, Then returns instance with empty string values', () {
        // Given
        final json = <String, dynamic>{};

        // When
        final response = CheckPasswordResponseEnableTwoFa.fromJson(json);

        // Then
        expect(response.phoneNumber, equals(''));
        expect(response.email, equals(''));
      });
    });

    group('toEntity', () {
      test(
          'Given response with phoneNumber and email, When toEntity is called, Then returns CheckPasswordEntityEnableTwoFa with same values',
          () {
        // Given
        const phoneNumber = '+1234567890';
        const email = 'test@example.com';
        final response = CheckPasswordResponseEnableTwoFa(
          phoneNumber: phoneNumber,
          email: email,
        );

        // When
        final entity = response.toEntity();

        // Then
        expect(entity, isA<CheckPasswordEntityEnableTwoFa>());
        expect(entity.phoneNumber, equals(phoneNumber));
        expect(entity.email, equals(email));
      });

      test(
          'Given response with empty string values, When toEntity is called, Then returns CheckPasswordEntityEnableTwoFa with empty string values',
          () {
        // Given
        final response = CheckPasswordResponseEnableTwoFa(
          phoneNumber: '',
          email: '',
        );

        // When
        final entity = response.toEntity();

        // Then
        expect(entity, isA<CheckPasswordEntityEnableTwoFa>());
        expect(entity.phoneNumber, equals(''));
        expect(entity.email, equals(''));
      });
    });
  });
}
