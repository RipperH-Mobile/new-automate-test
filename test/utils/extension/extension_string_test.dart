import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/utils/extension/extension_string.dart';

void main() {
  group('StringExtension', () {
    group('isHex', () {
      test('Given a valid hex string with exactly 34 characters, When isHex is called, Then returns true', () {
        // Given
        const hexString = '1234567890abcdef1234567890abcdef12';

        // When
        final result = hexString.isHex;

        // Then
        expect(result, isTrue, reason: 'Expected valid 34-character hex string to return true');
      });

      test('Given a valid hex string with more than 34 characters, When isHex is called, Then returns true', () {
        // Given
        const hexString = '1234567890abcdef1234567890abcdef123456789';

        // When
        final result = hexString.isHex;

        // Then
        expect(result, isTrue, reason: 'Expected valid hex string with more than 34 characters to return true');
      });

      test('Given a valid hex string with exactly 50 characters, When isHex is called, Then returns true', () {
        // Given
        const hexString = '1234567890abcdef1234567890abcdef1234567890abcdef12';

        // When
        final result = hexString.isHex;

        // Then
        expect(result, isTrue, reason: 'Expected valid 50-character hex string to return true');
      });

      test('Given a hex string with less than 34 characters, When isHex is called, Then returns false', () {
        // Given
        const hexString = '1234567890abcdef1234567890abcdef1';

        // When
        final result = hexString.isHex;

        // Then
        expect(result, isFalse, reason: 'Expected hex string with less than 34 characters to return false');
      });

      test('Given a string with exactly 33 characters, When isHex is called, Then returns false', () {
        // Given
        const hexString = '1234567890abcdef1234567890abcdef1';

        // When
        final result = hexString.isHex;

        // Then
        expect(result, isFalse, reason: 'Expected 33-character string to return false');
      });

      test('Given a string containing uppercase hex characters, When isHex is called, Then returns false', () {
        // Given
        const hexString = '1234567890ABCDEF1234567890abcdef12';

        // When
        final result = hexString.isHex;

        // Then
        expect(result, isFalse, reason: 'Expected string with uppercase hex characters to return false');
      });

      test('Given a string containing invalid hex characters, When isHex is called, Then returns false', () {
        // Given
        const hexString = '1234567890abcdefg234567890abcdef12';

        // When
        final result = hexString.isHex;

        // Then
        expect(result, isFalse, reason: 'Expected string with invalid hex character "g" to return false');
      });

      test('Given a string containing special characters, When isHex is called, Then returns false', () {
        // Given
        const hexString = '1234567890abcdef!234567890abcdef12';

        // When
        final result = hexString.isHex;

        // Then
        expect(result, isFalse, reason: 'Expected string with special character "!" to return false');
      });

      test('Given a string containing spaces, When isHex is called, Then returns false', () {
        // Given
        const hexString = '1234567890abcdef 234567890abcdef12';

        // When
        final result = hexString.isHex;

        // Then
        expect(result, isFalse, reason: 'Expected string with space character to return false');
      });

      test('Given an empty string, When isHex is called, Then returns false', () {
        // Given
        const hexString = '';

        // When
        final result = hexString.isHex;

        // Then
        expect(result, isFalse, reason: 'Expected empty string to return false');
      });

      test('Given a string with only numbers and exactly 34 characters, When isHex is called, Then returns true', () {
        // Given
        const hexString = '1234567890123456789012345678901234';

        // When
        final result = hexString.isHex;

        // Then
        expect(result, isTrue, reason: 'Expected valid numeric hex string with 34 characters to return true');
      });

      test('Given a string with only lowercase letters a-f and exactly 34 characters, When isHex is called, Then returns true', () {
        // Given
        const hexString = 'abcdefabcdefabcdefabcdefabcdefabcd';

        // When
        final result = hexString.isHex;

        // Then
        expect(result, isTrue, reason: 'Expected valid alphabetic hex string with 34 characters to return true');
      });

      test('Given a string starting with 0x prefix, When isHex is called, Then returns false', () {
        // Given
        const hexString = '0x1234567890abcdef1234567890abcdef12';

        // When
        final result = hexString.isHex;

        // Then
        expect(result, isFalse, reason: 'Expected string with 0x prefix to return false');
      });

      test('Given a string with newline character, When isHex is called, Then returns false', () {
        // Given
        const hexString = '1234567890abcdef\n234567890abcdef12';

        // When
        final result = hexString.isHex;

        // Then
        expect(result, isFalse, reason: 'Expected string with newline character to return false');
      });

      test('Given a string with tab character, When isHex is called, Then returns false', () {
        // Given
        const hexString = '1234567890abcdef\t234567890abcdef12';

        // When
        final result = hexString.isHex;

        // Then
        expect(result, isFalse, reason: 'Expected string with tab character to return false');
      });
    });
  });
}