import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/responses/link_account_config_key_response.dart';

void main() {
  group('LinkAccountConfigKeyResponse', () {
    test('Given key and value, When instantiated, Then fields are assigned', () {
      final response = LinkAccountConfigKeyResponse(
        key: 'configKey',
        value: 'configValue',
      );

      // Then the fields should be assigned correctly
      // Then the fields should be assigned correctly
      expect(response.key, 'configKey');
      expect(response.value, 'configValue');
    });

    test('Given key only, When instantiated, Then value is null', () {
      // Given key and value
      // Given key only
      final response = LinkAccountConfigKeyResponse(
        key: 'configKey',
      );

      expect(response.key, 'configKey');
      expect(response.value, null);
    });
  });
}