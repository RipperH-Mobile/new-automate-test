import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/requests/link_email_verify_otp_request.dart';

void main() {
  group('LinkEmailVerifyOtpRequest', () {
    test('Given token and otp, When creating LinkEmailVerifyOtpRequest, Then fields should be set correctly', () {
      // When
      final request = LinkEmailVerifyOtpRequest(token: 'token123', otp: '123456');

      // Then
      expect(request.token, 'token123');
      expect(request.otp, '123456');
    });

    test('Given LinkEmailVerifyOtpRequest, When calling toJson, Then should return correct map', () {
      // Given
      final request = LinkEmailVerifyOtpRequest(token: 'token123', otp: '123456');

      // When
      final json = request.toJson();

      // Then
      expect(json, {'token': 'token123', 'otp': '123456'});
    });
  });
}