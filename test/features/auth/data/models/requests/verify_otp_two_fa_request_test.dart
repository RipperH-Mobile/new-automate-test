import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/requests/verify_otp_setting_account_request.dart';

void main() {
  group('VerifyOtpTwoFaRequest', () {
    const tToken = 'test_token';
    const tOtp = '123456';
    const tPhoneNumber = '1234567890';
    const tEmail = 'test@example.com';

    // Test constructor and properties
    test(
        'Given all parameters are provided, When VerifyOtpTwoFaRequest is instantiated, Then properties are set correctly',
        () {
      // Arrange
      final request = VerifyOtpSettingAccountRequest(
        token: tToken,
        otp: tOtp,
        phoneNumber: tPhoneNumber,
        email: tEmail,
      );

      // Assert
      expect(request.token, equals(tToken));
      expect(request.otp, equals(tOtp));
      expect(request.phoneNumber, equals(tPhoneNumber));
      expect(request.email, equals(tEmail));
    });

    test(
        'Given only required parameters, When VerifyOtpTwoFaRequest is instantiated, Then optional properties are null',
        () {
      // Arrange
      final request = VerifyOtpSettingAccountRequest(
        token: tToken,
        otp: tOtp,
      );

      // Assert
      expect(request.token, equals(tToken));
      expect(request.otp, equals(tOtp));
      expect(request.phoneNumber, isNull);
      expect(request.email, isNull);
    });

    // Test toJson method
    group('toJson', () {
      test('Given all parameters are provided, When toJson is called, Then returns correct map', () {
        // Arrange
        final request = VerifyOtpSettingAccountRequest(
          token: tToken,
          otp: tOtp,
          phoneNumber: tPhoneNumber,
          email: tEmail,
        );
        final expectedMap = {
          'token': tToken,
          'otp': tOtp,
          'phoneNumber': tPhoneNumber,
          'email': tEmail,
        };

        // Act
        final result = request.toJson();

        // Assert
        expect(result, equals(expectedMap));
      });

      test('Given only required parameters, When toJson is called, Then returns map with null for optional fields', () {
        // Arrange
        final request = VerifyOtpSettingAccountRequest(
          token: tToken,
          otp: tOtp,
        );
        final expectedMap = {
          'token': tToken,
          'otp': tOtp,
          'phoneNumber': null,
          'email': null,
        };

        // Act
        final result = request.toJson();

        // Assert
        expect(result, equals(expectedMap));
      });
    });

    // Test fromJson factory method
    group('fromJson', () {
      test(
          'Given a valid map with all fields, When fromJson is called, Then returns correct VerifyOtpTwoFaRequest object',
          () {
        // Arrange
        final jsonMap = {
          'token': tToken,
          'otp': tOtp,
          'phoneNumber': tPhoneNumber,
          'email': tEmail,
        };

        // Act
        final result = VerifyOtpSettingAccountRequest.fromJson(jsonMap);

        // Assert
        expect(result.token, equals(tToken));
        expect(result.otp, equals(tOtp));
        expect(result.phoneNumber, equals(tPhoneNumber));
        expect(result.email, equals(tEmail));
      });

      test(
          'Given a valid map with only required fields, When fromJson is called, Then returns object with null optional fields',
          () {
        // Arrange
        final jsonMap = {
          'token': tToken,
          'otp': tOtp,
          'phoneNumber': null, // Explicitly null
          'email': null, // Explicitly null
        };

        // Act
        final result = VerifyOtpSettingAccountRequest.fromJson(jsonMap);

        // Assert
        expect(result.token, equals(tToken));
        expect(result.otp, equals(tOtp));
        expect(result.phoneNumber, isNull);
        expect(result.email, isNull);
      });

      test(
          'Given a map missing optional fields, When fromJson is called, Then returns object with null optional fields',
          () {
        // Arrange
        final jsonMap = {
          'token': tToken,
          'otp': tOtp,
        }; // phoneNumber and email are absent

        // Act
        final result = VerifyOtpSettingAccountRequest.fromJson(jsonMap);

        // Assert
        expect(result.token, equals(tToken));
        expect(result.otp, equals(tOtp));
        expect(result.phoneNumber, isNull);
        expect(result.email, isNull);
      });

      test(
          'Given a map with incorrect type for optional field (e.g. int for string), When fromJson is called, Then it should handle type cast error gracefully or as per expectation',
          () {
        // Arrange
        final jsonMapWithInt = {
          'token': tToken,
          'otp': tOtp,
          'phoneNumber': 12345, // Incorrect type
          'email': tEmail,
        };

        // Assert
        expect(() => VerifyOtpSettingAccountRequest.fromJson(jsonMapWithInt), throwsA(isA<TypeError>()));
      });
    });
  });
}
