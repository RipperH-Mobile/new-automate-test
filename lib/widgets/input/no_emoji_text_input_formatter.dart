import 'package:flutter/services.dart';

class NoEmojiTextInputFormatter extends TextInputFormatter {
  /// Old Flutter version use [formatEditUpdate]
  /// New Flutter version use [formatEditingValue]

  // Regular expression pattern that defines allowed characters
  // Allows: a-z, A-Z, 0-9, whitespace, and special characters: !@#$%^&*()_+-=[]{};:"\\|,.<>/?
  final RegExp _allowedPattern = RegExp(r'[a-zA-Z0-9\s!@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?]');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // Previous text field state before user input
    TextEditingValue newValue, // New text field state after user input
  ) {
    // Filter the new text to keep only allowed characters
    // Steps:
    // 1. Split text into individual characters
    // 2. Check each character against the allowed pattern
    // 3. Keep only characters that match the pattern
    // 4. Join the filtered characters back into a string
    final filteredText = newValue.text
        .split('') // Convert string to list of characters
        .where((char) => _allowedPattern.hasMatch(char)) // Keep only allowed characters
        .join(''); // Combine characters back into a string

    // If the filtered text is the same as the new text,
    // it means no invalid characters were entered
    // Return the new value without any changes
    if (filteredText == newValue.text) {
      return newValue; // No changes needed
    }

    // Calculate the new cursor position after removing invalid characters
    // Get the current cursor position from the new value
    int offset = newValue.selection.baseOffset;

    // Count how many invalid characters were removed before the cursor position
    int removedChars = 0;

    // Loop through each character up to the cursor position
    for (int i = 0; i < offset && i < newValue.text.length; i++) {
      // If the character doesn't match the allowed pattern, increment counter
      if (!_allowedPattern.hasMatch(newValue.text[i])) {
        removedChars++;
      }
    }

    // Calculate the new cursor offset by subtracting removed characters
    // Use clamp to ensure the offset stays within valid range (0 to text length)
    final newOffset = (offset - removedChars).clamp(0, filteredText.length);

    // Return a new TextEditingValue with:
    // - The filtered text (without invalid characters)
    // - The corrected cursor position
    return TextEditingValue(
      text: filteredText, // The cleaned text
      selection: TextSelection.collapsed(offset: newOffset), // New cursor position
    );
  }
}
