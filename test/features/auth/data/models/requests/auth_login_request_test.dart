import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/requests/auth_login_request.dart';

void main() {
  group('AuthLoginRequest', () {
    test('Given username and password, When creating AuthLoginRequest, Then fields should be set correctly', () {
      // Given
      const username = 'user';
      const password = 'pass';

      // When
      final request = AuthLoginRequest(username: username, password: password);

      // Then
      expect(request.username, username);
      expect(request.password, password);
    });

    test('Given AuthLoginRequest, When calling toMap, Then it should return correct map', () {
      // Given
      final request = AuthLoginRequest(username: 'user', password: 'pass');

      // When
      final map = request.toMap();

      // Then
      expect(map, {'username': 'user', 'password': 'pass'});
    });
  });
}