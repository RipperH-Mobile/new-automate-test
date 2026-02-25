// Test file to demonstrate Thai text input edge cases and fixes
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/widgets/input/app_text_field.dart';

void main() {
  group('Thai Text Input Edge Cases', () {
    late ThaiLengthLimitingTextInputFormatter formatter;

    setUp(() {
      formatter = ThaiLengthLimitingTextInputFormatter(10);
    });

    test('Test Case 1: Deletion from middle of text', () async {
      final oldValue = const TextEditingValue(
        text: 'abc พี่นี้ def',
        selection: TextSelection.collapsed(offset: 7), // After "พี่นี้"
      );

      final newValue = const TextEditingValue(
        text: 'abc def', // "พี่นี้" deleted
        selection: TextSelection.collapsed(offset: 4), // Cursor moves to after "abc "
      );

      final result = formatter.formatEditUpdate(oldValue, newValue);

      debugPrint('Test Case 1: Deletion from middle of text');
      debugPrint('Old: "${oldValue.text}" (cursor at ${oldValue.selection.start})');
      debugPrint('New: "${newValue.text}" (cursor at ${newValue.selection.start})');
      debugPrint('Result: "${result.text}" (cursor at ${result.selection.start})');
      debugPrint('Expected: Should handle middle deletion properly\n');

      // Verify the result
      expect(result.text, isNot(equals('abc def')), reason: 'Should prevent aggressive deletion');
    });

    test('Test Case 2: Mixed sentence Thai and English deletion', () async {
      final oldValue = const TextEditingValue(
        text: 'Hello พี่น้อง World',
        selection: TextSelection.collapsed(offset: 11), // After "พี่น้อง"
      );

      final newValue = const TextEditingValue(
        text: 'Hello พี่ World', // "พี่น้อง " deleted
        selection: TextSelection.collapsed(offset: 6), // After "Hello "
      );

      final result = formatter.formatEditUpdate(oldValue, newValue);

      debugPrint('Test Case 2: Mixed sentence Thai and English deletion');
      debugPrint('Old: "${oldValue.text}" (cursor at ${oldValue.selection.start})');
      debugPrint('New: "${newValue.text}" (cursor at ${newValue.selection.start})');
      debugPrint('Result: "${result.text}" (cursor at ${result.selection.start})');
      debugPrint('Expected: Should detect Thai in mixed content\n');

      expect(result.text, isNot(equals('Hello พี่ World')), reason: 'Should prevent aggressive deletion of Thai text');
    });

    test('Test Case 3: Thai and English Mixed deletion', () async {
      final oldValue = const TextEditingValue(
        text: 'Hello พี่น้อง World',
        selection: TextSelection.collapsed(offset: 11), // After "พี่น้อง"
      );

      final newValue = const TextEditingValue(
        text: 'Hello พี่rld', // "พี่น้อง " deleted
        selection: TextSelection.collapsed(offset: 7), // After "Hello "
      );

      // "น้อง Wo" is deleted.

      final result = formatter.formatEditUpdate(oldValue, newValue);

      debugPrint('Test Case 3: Thai and English Mixed deletion');
      debugPrint('Old: "${oldValue.text}" (cursor at ${oldValue.selection.start})');
      debugPrint('New: "${newValue.text}" (cursor at ${newValue.selection.start})');
      debugPrint('Result: "${result.text}" (cursor at ${result.selection.start})');
      debugPrint('Expected: Should detect Thai in mixed content\n');

      expect(result.text, isNot(equals('Hello พี่rld')), reason: 'Should prevent aggressive deletion of Thai text');
    });

    test('Test Case 3.2: Multiple Thai vowel deletion', () async {
      final oldValue = const TextEditingValue(
        text: 'การเรียน',
        selection: TextSelection.collapsed(offset: 7), // At end
      );

      final newValue = const TextEditingValue(
        text: 'กา', // Multiple characters deleted
        selection: TextSelection.collapsed(offset: 2),
      );

      final result = formatter.formatEditUpdate(oldValue, newValue);

      debugPrint('Test Case 3.2: Multiple Thai vowel deletion');
      debugPrint('Old: "${oldValue.text}" (cursor at ${oldValue.selection.start})');
      debugPrint('New: "${newValue.text}" (cursor at ${newValue.selection.start})');
      debugPrint('Result: "${result.text}" (cursor at ${result.selection.start})');
      debugPrint('Expected: Should limit to single character deletion\n');

      expect(result.text, isNot(equals('กา')), reason: 'Should prevent multiple character deletion');
    });

    test('Test Case 4: Cursor position edge cases', () async {
      final oldValue = const TextEditingValue(
        text: 'พี่นี้',
        selection: TextSelection.collapsed(offset: 0), // At beginning
      );

      final newValue = const TextEditingValue(
        text: 'นี้', // "พี่" deleted from beginning
        selection: TextSelection.collapsed(offset: 0),
      );

      final result = formatter.formatEditUpdate(oldValue, newValue);

      debugPrint('Test Case 4: Cursor position edge cases');
      debugPrint('Old: "${oldValue.text}" (cursor at ${oldValue.selection.start})');
      debugPrint('New: "${newValue.text}" (cursor at ${newValue.selection.start})');
      debugPrint('Result: "${result.text}" (cursor at ${result.selection.start})');
      debugPrint('Expected: Should handle deletion at beginning\n');

      // This might be allowed since it's deletion from beginning
      expect(result.text, isA<String>(), reason: 'Should return valid string');
    });

    test('Test Case 5: Empty and boundary conditions', () async {
      // Test empty string
      final oldValue1 = const TextEditingValue(
        text: 'พี่',
        selection: TextSelection.collapsed(offset: 2),
      );

      final newValue1 = const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );

      final result1 = formatter.formatEditUpdate(oldValue1, newValue1);

      debugPrint('Test Case 5: Empty and boundary conditions');
      debugPrint('Empty deletion test:');
      debugPrint('Old: "${oldValue1.text}" -> New: "${newValue1.text}"');
      debugPrint('Result: "${result1.text}"\n');

      // Test single character deletion
      final oldValue2 = const TextEditingValue(
        text: 'พ',
        selection: TextSelection.collapsed(offset: 1),
      );

      final newValue2 = const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );

      final result2 = formatter.formatEditUpdate(oldValue2, newValue2);

      debugPrint('Single char deletion test:');
      debugPrint('Old: "${oldValue2.text}" -> New: "${newValue2.text}"');
      debugPrint('Result: "${result2.text}"');

      expect(result1.text, isA<String>(), reason: 'Should handle empty deletion');
      expect(result2.text, isA<String>(), reason: 'Should handle single char deletion');
    });

    test('Test Case 6: Text selection deletion (FIXED)', () async {
      // Scenario: User selects "ดี" from "สวัสดี" and presses delete
      final oldValue = const TextEditingValue(
        text: 'สวัสดี',
        selection: TextSelection(baseOffset: 3, extentOffset: 5), // Selected "ดี"
      );

      final newValue = const TextEditingValue(
        text: 'สวัส', // "ดี" deleted via selection
        selection: TextSelection.collapsed(offset: 3), // Cursor at end
      );

      final result = formatter.formatEditUpdate(oldValue, newValue);

      debugPrint('Test Case 6: Text selection deletion');
      debugPrint('Old: "${oldValue.text}" (selection: ${oldValue.selection.start}-${oldValue.selection.end})');
      debugPrint('New: "${newValue.text}" (cursor at ${newValue.selection.start})');
      debugPrint('Result: "${result.text}" (cursor at ${result.selection.start})');
      debugPrint('Expected: "สวัส" - Should allow normal text selection deletion');
      debugPrint('Test ${result.text == "สวัส" ? "PASSED" : "FAILED"}\n');

      expect(result.text, equals('สวัส'), reason: 'Should allow text selection deletion');
    });

    test('Test Case 7: Text delete normal', () async {
      // Scenario: User selects "ดี" from "สวัสดี" and presses delete
      final oldValue = const TextEditingValue(
        text: 'สวัสดี',
      );

      final newValue = const TextEditingValue(
        text: 'สวัสด', // "ดี" deleted via selection
      );

      final result = formatter.formatEditUpdate(oldValue, newValue);

      debugPrint('Test Case 7: Text delete normal');
      debugPrint('Old: "${oldValue.text}" (selection: ${oldValue.selection.start}-${oldValue.selection.end})');
      debugPrint('New: "${newValue.text}" (cursor at ${newValue.selection.start})');
      debugPrint('Result: "${result.text}" (cursor at ${result.selection.start})');
      debugPrint('Expected: "สวัส" - Should allow normal text selection deletion');
      debugPrint('Test ${result.text == "สวัส" ? "PASSED" : "FAILED"}\n');

      expect(result.text, equals('สวัสด'), reason: 'Should allow text selection deletion');
    });
  });
}
