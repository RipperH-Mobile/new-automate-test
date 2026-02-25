import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/requests/save_otp_response_request.dart';
import 'package:uchat/features/auth/domain/entities/otp_entity.dart';

void main() {
  group('SaveOtpResponseRequest', () {
    late OtpEntity otpEntity;
    late String phoneOrEmail;
    late DateTime firstGet;
    late DateTime timeout;

    setUp(() {
      firstGet = DateTime.parse('2025-01-01T12:00:00');
      timeout = DateTime.parse('2025-01-01T12:05:00');
      otpEntity = OtpEntity(
        token: 'token123',
        ref: 'ref123',
        type: 'type123',
        firstGet: firstGet,
        timeout: timeout,
        actionToken: 'action123',
      );
      phoneOrEmail = 'test@example.com';
    });

    test('Given valid OtpEntity and phoneOrEmail, When constructed, Then fields match', () {
      // Given in setUp

      // When
      final request = SaveOtpResponseRequest(
        otpEntity: otpEntity,
        phoneOrEmail: phoneOrEmail,
      );

      // Then
      expect(request.otpEntity, equals(otpEntity));
      expect(request.phoneOrEmail, equals(phoneOrEmail));
    });

    test('equality and hashCode default behavior', () {
      // Given
      final request1 = SaveOtpResponseRequest(
        otpEntity: otpEntity,
        phoneOrEmail: phoneOrEmail,
      );
      final request2 = SaveOtpResponseRequest(
        otpEntity: otpEntity,
        phoneOrEmail: phoneOrEmail,
      );

      // When & Then
      expect(request1 == request2, isFalse);
      expect(request1.hashCode, isNot(equals(request2.hashCode)));
    });

    test('toString returns class name', () {
      // Given
      final request = SaveOtpResponseRequest(
        otpEntity: otpEntity,
        phoneOrEmail: phoneOrEmail,
      );

      // When
      final description = request.toString();

      // Then
      expect(description, contains('SaveOtpResponseRequest'));
    });
  });
}