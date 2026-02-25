import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/widgets/input/no_emoji_text_input_formatter.dart';

void main() {
  group('NoEmojiTextInputFormatter', () {
    late NoEmojiTextInputFormatter formatter;

    setUp(() {
      formatter = NoEmojiTextInputFormatter();
    });

    test('removes emojis from input text', () {
      const oldValue = TextEditingValue(
        text: 'Hello',
        selection: TextSelection.collapsed(offset: 5),
      );
      const newValue = TextEditingValue(
        text: 'Hello😀',
        selection: TextSelection.collapsed(offset: 6),
      );

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, 'Hello');
      expect(result.selection, const TextSelection.collapsed(offset: 5));
    });

    test('does not modify text without emojis', () {
      const oldValue = TextEditingValue(
        text: 'Hello',
        selection: TextSelection.collapsed(offset: 5),
      );
      const newValue = TextEditingValue(
        text: 'Hello',
        selection: TextSelection.collapsed(offset: 5),
      );

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, 'Hello');
      expect(result.selection, const TextSelection.collapsed(offset: 5));
    });

    test('removes multiple emojis from input text', () {
      const oldValue = TextEditingValue(
        text: 'Hello',
        selection: TextSelection.collapsed(offset: 5),
      );
      const newValue = TextEditingValue(
        text: 'Hello😀🤦🏾‍♀️',
        selection: TextSelection.collapsed(offset: 11),
      );

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, 'Hello');
      expect(result.selection, const TextSelection.collapsed(offset: 5));
    });

    test('handles empty input gracefully', () {
      const oldValue = TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
      const newValue = TextEditingValue(
        text: '😀',
        selection: TextSelection.collapsed(offset: 1),
      );

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, '');
      expect(result.selection, const TextSelection.collapsed(offset: 0));
    });
  });
}
