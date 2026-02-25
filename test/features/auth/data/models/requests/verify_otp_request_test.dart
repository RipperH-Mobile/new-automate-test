import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/requests/verify_otp_request.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';

void main() {
  group('VerifyOTPRequest', () {
    final actionType = AuthenticationActionType.signin;

    test('Given parameters, When creating VerifyOTPRequest, Then fields should be set correctly', () {
      // When
      final request = VerifyOTPRequest(
        token: 'token123',
        otp: '123456',
        phoneOrEmail: 'test@example.com',
        actionName: actionType,
        isPhoneNumber: true,
        isEmail: false,
      );

      // Then
      expect(request.token, 'token123');
      expect(request.otp, '123456');
      expect(request.phoneOrEmail, 'test@example.com');
      expect(request.actionName.value, 'SIGN_IN');
      expect(request.isPhoneNumber, true);
      expect(request.isEmail, false);
    });

    test('Given VerifyOTPRequest, When calling toMap, Then should return correct map', () {
      // Given
      final request = VerifyOTPRequest(
        token: 'token123',
        otp: '123456',
        phoneOrEmail: 'test@example.com',
        actionName: actionType,
        isPhoneNumber: true,
        isEmail: false,
      );

      // When
      final map = request.toMap();

      // Then
      expect(map, {
        'token': 'token123',
        'otp': '123456',
        'phoneOrEmail': 'test@example.com',
        'actionName': 'SIGN_IN',
        'isPhoneNumber': true,
        'isEmail': false,
      });
    });

    test('Given JSON map, When calling fromJson, Then should create correct VerifyOTPRequest', () {
      // Given
      final json = {
        'token': 'token123',
        'otp': '123456',
        'phoneOrEmail': 'test@example.com',
        'actionName': 'SIGN_IN',
        'isPhoneNumber': true,
        'isEmail': false,
      };

      // When
      final request = VerifyOTPRequest.fromJson(json);

      // Then
      expect(request.token, 'token123');
      expect(request.otp, '123456');
      expect(request.phoneOrEmail, 'test@example.com');
      expect(request.actionName.value, 'SIGN_IN');
      expect(request.isPhoneNumber, true);
      expect(request.isEmail, false);
    });
  });
}