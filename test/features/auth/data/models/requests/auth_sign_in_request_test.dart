import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/requests/auth_sign_in_request.dart';

void main() {
  group('AuthSignInRequest', () {
    final request = AuthSignInRequest(
      token: 'token123',
      otp: '123456',
      phoneOrEmail: 'test@example.com',
      isPhoneNumber: false,
    );

    test('Given parameters, When creating AuthSignInRequest, Then fields should be set correctly', () {
      // Given parameters

      // When creating instance
      final req = AuthSignInRequest(
        token: 'token123',
        otp: '123456',
        phoneOrEmail: 'test@example.com',
        isPhoneNumber: false,
      );

      // Then
      expect(req.token, 'token123');
      expect(req.otp, '123456');
      expect(req.phoneOrEmail, 'test@example.com');
      expect(req.isPhoneNumber, false);
    });

    test('Given AuthSignInRequest, When calling copyWith, Then it should update specified fields', () {
      // Given existing request

      // When copying with new otp and isPhoneNumber
      final copy = request.copyWith(otp: '654321', isPhoneNumber: true);

      // Then
      expect(copy.token, 'token123');
      expect(copy.otp, '654321');
      expect(copy.phoneOrEmail, 'test@example.com');
      expect(copy.isPhoneNumber, true);
    });

    test('Given AuthSignInRequest, When calling toMap, Then it should return correct map', () {
      // When
      final map = request.toMap();

      // Then
      expect(map, {
        'token': 'token123',
        'otp': '123456',
        'phoneOrEmail': 'test@example.com',
        'isPhoneNumber': false,
      });
    });

    test('Given map, When calling fromMap, Then it should return correct AuthSignInRequest', () {
      // Given
      final map = {
        'token': 'token123',
        'otp': '123456',
        'phoneOrEmail': 'test@example.com',
        'isPhoneNumber': false,
      };

      // When
      final fromMap = AuthSignInRequest.fromMap(map);

      // Then
      expect(fromMap, request);
    });

    test('Given AuthSignInRequest, When calling toJson, Then it should return correct JSON string', () {
      // When
      final jsonStr = request.toJson();

      // Then
      expect(jsonStr, '{"token":"token123","otp":"123456","phoneOrEmail":"test@example.com","isPhoneNumber":false}');
    });

    test('Given JSON string, When calling fromJson, Then it should return correct AuthSignInRequest', () {
      // Given
      final jsonStr = '{"token":"token123","otp":"123456","phoneOrEmail":"test@example.com","isPhoneNumber":false}';

      // When
      final fromJson = AuthSignInRequest.fromJson(jsonStr);

      // Then
      expect(fromJson, request);
    });

    test('Given AuthSignInRequest, When calling toString, Then it should return correct string', () {
      // When
      final str = request.toString();

      // Then
      expect(
        str,
        'AuthSignInRequest(token: token123, otp: 123456, phoneOrEmail: test@example.com, isPhoneNumber: false)',
      );
    });

    test('Given two identical AuthSignInRequest, When comparing with ==, Then should be equal', () {
      // Given
      final other = AuthSignInRequest(
        token: 'token123',
        otp: '123456',
        phoneOrEmail: 'test@example.com',
        isPhoneNumber: false,
      );

      // Then
      expect(request, other);
    });

    test('Given two identical AuthSignInRequest, When comparing hashCode, Then should be equal', () {
      // Given
      final other = AuthSignInRequest(
        token: 'token123',
        otp: '123456',
        phoneOrEmail: 'test@example.com',
        isPhoneNumber: false,
      );

      // Then
      expect(request.hashCode, other.hashCode);
    });
  });
}