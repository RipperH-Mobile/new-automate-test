import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/requests/link_email_otp_request.dart';

void main() {
  group('LinkEmailOtpRequest', () {
    test('Given email, When creating LinkEmailOtpRequest, Then field should be set correctly', () {
      // When
      final request = LinkEmailOtpRequest(email: 'test@example.com');

      // Then
      expect(request.email, 'test@example.com');
    });

    test('Given LinkEmailOtpRequest, When calling toJson, Then should return correct map', () {
      // Given
      final request = LinkEmailOtpRequest(email: 'test@example.com');

      // When
      final json = request.toJson();

      // Then
      expect(json, {'email': 'test@example.com'});
    });
  });
}