import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/auth/data/models/enum/link_account_type.dart';

void main() {
  group('LinkAccountType enum', () {
    test('Given enum LinkAccountType, When checking values, Then it should contain all expected values', () {
      // Given enum LinkAccountType

      // When getting all enum values
      final values = LinkAccountType.values;

      // Then it should contain all expected values
      expect(values.length, 4);
      expect(values, containsAll([
        LinkAccountType.email,
        LinkAccountType.google,
        LinkAccountType.facebook,
        LinkAccountType.apple,
      ]));
    });

    test('Given enum LinkAccountType, When checking index, Then each value should have correct index', () {
      // Given enum LinkAccountType

      // When checking index of each enum value

      // Then each value should have correct index
      expect(LinkAccountType.email.index, 0);
      expect(LinkAccountType.google.index, 1);
      expect(LinkAccountType.facebook.index, 2);
      expect(LinkAccountType.apple.index, 3);
    });

    test('Given enum LinkAccountType, When calling toString, Then it should return correct string representation', () {
      // Given enum LinkAccountType

      // When calling toString on each enum value

      // Then it should return correct string representation
      expect(LinkAccountType.email.toString(), 'LinkAccountType.email');
      expect(LinkAccountType.google.toString(), 'LinkAccountType.google');
      expect(LinkAccountType.facebook.toString(), 'LinkAccountType.facebook');
      expect(LinkAccountType.apple.toString(), 'LinkAccountType.apple');
    });
  });
}