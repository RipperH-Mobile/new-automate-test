import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/requests/get_otp_two_fa_login_request.dart';

void main() {
  group('GetOtpTwoFaLoginRequest', () {
    group('constructor', () {
      test(
          'Given all parameters provided, When creating GetOtpTwoFaLoginRequest, Then creates instance with correct values',
          () {
        // Given
        const phoneOrEmail = 'test@example.com';
        const isPhoneNumber = false;
        const isEmail = true;

        // When
        final request = GetOtpTwoFaLoginRequest(
          phoneOrEmail: phoneOrEmail,
          isPhoneNumber: isPhoneNumber,
          isEmail: isEmail,
        );

        // Then
        expect(request.phoneOrEmail, equals(phoneOrEmail));
        expect(request.isPhoneNumber, equals(isPhoneNumber));
        expect(request.isEmail, equals(isEmail));
      });

      test(
          'Given only required parameter, When creating GetOtpTwoFaLoginRequest, Then creates instance with null optional values',
          () {
        // Given
        const phoneOrEmail = '+1234567890';

        // When
        final request = GetOtpTwoFaLoginRequest(
          phoneOrEmail: phoneOrEmail,
        );

        // Then
        expect(request.phoneOrEmail, equals(phoneOrEmail));
        expect(request.isPhoneNumber, isNull);
        expect(request.isEmail, isNull);
      });

      test(
          'Given phone number scenario, When creating GetOtpTwoFaLoginRequest, Then creates instance with isPhoneNumber true',
          () {
        // Given
        const phoneOrEmail = '+1234567890';
        const isPhoneNumber = true;
        const isEmail = false;

        // When
        final request = GetOtpTwoFaLoginRequest(
          phoneOrEmail: phoneOrEmail,
          isPhoneNumber: isPhoneNumber,
          isEmail: isEmail,
        );

        // Then
        expect(request.phoneOrEmail, equals(phoneOrEmail));
        expect(request.isPhoneNumber, equals(isPhoneNumber));
        expect(request.isEmail, equals(isEmail));
      });

      test('Given email scenario, When creating GetOtpTwoFaLoginRequest, Then creates instance with isEmail true', () {
        // Given
        const phoneOrEmail = 'user@example.com';
        const isPhoneNumber = false;
        const isEmail = true;

        // When
        final request = GetOtpTwoFaLoginRequest(
          phoneOrEmail: phoneOrEmail,
          isPhoneNumber: isPhoneNumber,
          isEmail: isEmail,
        );

        // Then
        expect(request.phoneOrEmail, equals(phoneOrEmail));
        expect(request.isPhoneNumber, equals(isPhoneNumber));
        expect(request.isEmail, equals(isEmail));
      });

      test(
          'Given explicit null values for optional parameters, When creating GetOtpTwoFaLoginRequest, Then creates instance with null values',
          () {
        // Given
        const phoneOrEmail = 'test@example.com';
        const bool? isPhoneNumber = null;
        const bool? isEmail = null;

        // When
        final request = GetOtpTwoFaLoginRequest(
          phoneOrEmail: phoneOrEmail,
          isPhoneNumber: isPhoneNumber,
          isEmail: isEmail,
        );

        // Then
        expect(request.phoneOrEmail, equals(phoneOrEmail));
        expect(request.isPhoneNumber, isNull);
        expect(request.isEmail, isNull);
      });
    });

    group('toJson', () {
      test('Given request with all parameters, When toJson is called, Then returns complete JSON map', () {
        // Given
        final request = GetOtpTwoFaLoginRequest(
          phoneOrEmail: 'test@example.com',
          isPhoneNumber: false,
          isEmail: true,
        );
        final expectedJson = <String, dynamic>{
          'phoneOrEmail': 'test@example.com',
          'isPhoneNumber': false,
          'isEmail': true,
        };

        // When
        final result = request.toJson();

        // Then
        expect(result, equals(expectedJson));
        expect(result['phoneOrEmail'], equals('test@example.com'));
        expect(result['isPhoneNumber'], equals(false));
        expect(result['isEmail'], equals(true));
      });

      test(
          'Given request with only required parameter, When toJson is called, Then returns JSON with null optional values',
          () {
        // Given
        final request = GetOtpTwoFaLoginRequest(
          phoneOrEmail: '+1234567890',
        );
        final expectedJson = <String, dynamic>{
          'phoneOrEmail': '+1234567890',
          'isPhoneNumber': null,
          'isEmail': null,
        };

        // When
        final result = request.toJson();

        // Then
        expect(result, equals(expectedJson));
        expect(result['phoneOrEmail'], equals('+1234567890'));
        expect(result['isPhoneNumber'], isNull);
        expect(result['isEmail'], isNull);
      });

      test('Given request with phone number scenario, When toJson is called, Then returns JSON with isPhoneNumber true',
          () {
        // Given
        final request = GetOtpTwoFaLoginRequest(
          phoneOrEmail: '+1234567890',
          isPhoneNumber: true,
          isEmail: false,
        );
        final expectedJson = <String, dynamic>{
          'phoneOrEmail': '+1234567890',
          'isPhoneNumber': true,
          'isEmail': false,
        };

        // When
        final result = request.toJson();

        // Then
        expect(result, equals(expectedJson));
        expect(result['phoneOrEmail'], equals('+1234567890'));
        expect(result['isPhoneNumber'], equals(true));
        expect(result['isEmail'], equals(false));
      });

      test('Given request with email scenario, When toJson is called, Then returns JSON with isEmail true', () {
        // Given
        final request = GetOtpTwoFaLoginRequest(
          phoneOrEmail: 'user@domain.com',
          isPhoneNumber: false,
          isEmail: true,
        );
        final expectedJson = <String, dynamic>{
          'phoneOrEmail': 'user@domain.com',
          'isPhoneNumber': false,
          'isEmail': true,
        };

        // When
        final result = request.toJson();

        // Then
        expect(result, equals(expectedJson));
        expect(result['phoneOrEmail'], equals('user@domain.com'));
        expect(result['isPhoneNumber'], equals(false));
        expect(result['isEmail'], equals(true));
      });

      test('Given request with empty string phoneOrEmail, When toJson is called, Then returns JSON with empty string',
          () {
        // Given
        final request = GetOtpTwoFaLoginRequest(
          phoneOrEmail: '',
          isPhoneNumber: null,
          isEmail: null,
        );
        final expectedJson = <String, dynamic>{
          'phoneOrEmail': '',
          'isPhoneNumber': null,
          'isEmail': null,
        };

        // When
        final result = request.toJson();

        // Then
        expect(result, equals(expectedJson));
        expect(result['phoneOrEmail'], equals(''));
        expect(result['isPhoneNumber'], isNull);
        expect(result['isEmail'], isNull);
      });

      test(
          'Given request with special characters in phoneOrEmail, When toJson is called, Then returns JSON with special characters preserved',
          () {
        // Given
        const specialPhoneOrEmail = 'test+user@sub-domain.co.uk';
        final request = GetOtpTwoFaLoginRequest(
          phoneOrEmail: specialPhoneOrEmail,
          isPhoneNumber: false,
          isEmail: true,
        );
        final expectedJson = <String, dynamic>{
          'phoneOrEmail': specialPhoneOrEmail,
          'isPhoneNumber': false,
          'isEmail': true,
        };

        // When
        final result = request.toJson();

        // Then
        expect(result, equals(expectedJson));
        expect(result['phoneOrEmail'], equals(specialPhoneOrEmail));
        expect(result['isPhoneNumber'], equals(false));
        expect(result['isEmail'], equals(true));
      });
    });
  });
}
