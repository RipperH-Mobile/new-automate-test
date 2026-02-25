import 'package:flutter/material.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/extension/extension_string.dart';

import '../entities/tap_to_mention_entity.dart';
import '../params/tap_to_mention_params.dart';

class TapToMentionUseCase extends SimpleUseCaseSync<TapToMentionEntity, TapToMentionParams> {
  @override
  TapToMentionEntity call(TapToMentionParams params) {
    String text = params.inputText;
    int cursorPos = params.cursorPos;
    String mentionText = params.mentionText.displayMention(getDisplay: true);

    /// If [cursorPos] is -1, that means the TextField is not focused
    if (cursorPos == -1) {
      /// Set [cursorPos] to the end of the [text]
      cursorPos = text.length;
    }

    // Add mention to the end of the message
    if (cursorPos == text.length) {
      if (text.isEmpty || cursorPos > 0 && text[cursorPos - 1] == ' ') {
        // If the message is empty or there is space before cursor, do not insert a new space before insert mention
        text += mentionText;
      } else {
        // If there is no space before cursor, insert a new space before insert mention
        text += ' $mentionText';
      }

      // textFieldController.text = '$text ';
      return TapToMentionEntity(text: '$text ');
    }
    // Insert mention to the message but not at the end
    else {
      final insertText = cursorPos == 0 ? '$mentionText ' : ' $mentionText ';

      // Insert mention where the cursor is
      final newText = text.replaceRange(cursorPos, cursorPos, insertText);
      // Ans set cursor position behind inserted mention
      final newCursorPos = TextSelection.fromPosition(
        TextPosition(offset: cursorPos + insertText.length),
      );

      return TapToMentionEntity(text: newText, cursorPos: newCursorPos);
    }
  }
}
