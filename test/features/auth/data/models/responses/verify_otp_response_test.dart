import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/responses/verify_otp_response.dart';

void main() {
  group('VerifyOtpResponse', () {
    test('Given actionToken and actionName, When instantiated, Then fields are assigned', () {
      final response = VerifyOtpResponse(
        actionToken: 'token123',
        actionName: 'verify',
        accountId: 'account123',
      );

      // Then the fields should be correct
      expect(response.actionToken, 'token123');
      expect(response.actionName, 'verify');
    });

    test('Given map, When fromMap called, Then returns correct instance', () {
      // Given a map with actionToken and actionName
      final map = {
        'actionToken': 'token123',
        'actionName': 'verify',
      };

      // When fromMap is called
      final response = VerifyOtpResponse.fromMap(map);

      // Then the fields should be correct
      expect(response.actionToken, 'token123');
      expect(response.actionName, 'verify');
    });

    test('Given VerifyOtpResponse, When toJson called, Then returns correct map', () {
      // Given actionToken and actionName
      final response = VerifyOtpResponse(
        actionToken: 'token123',
        actionName: 'verify',
        accountId: 'account123',
      );

      // When toJson is called
      final json = response.toJson();

      // Then the output should be correct
      expect(json['actionToken'], 'token123');
      expect(json['actionName'], 'verify');
    });
  });
}