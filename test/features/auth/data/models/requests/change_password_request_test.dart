import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/requests/change_password_request.dart';

void main() {
  group('ChangePasswordRequest', () {
    test('Given all parameters, When creating ChangePasswordRequest, Then fields should be set correctly', () {
      // When
      final request = ChangePasswordRequest(
        actionToken: 'token',
        password: 'oldPass',
        newPassword: 'newPass',
      );

      // Then
      expect(request.actionToken, 'token');
      expect(request.password, 'oldPass');
      expect(request.newPassword, 'newPass');
    });

    test('Given ChangePasswordRequest, When calling toMap, Then should return correct map', () {
      // Given
      final request = ChangePasswordRequest(
        actionToken: 'token',
        password: 'oldPass',
        newPassword: 'newPass',
      );

      // When
      final map = request.toMap();

      // Then
      expect(map, {
        'actionToken': 'token',
        'password': 'oldPass',
        'newPassword': 'newPass',
      });
    });
  });
}