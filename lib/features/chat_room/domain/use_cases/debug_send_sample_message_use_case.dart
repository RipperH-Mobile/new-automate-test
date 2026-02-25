import 'dart:async';
import 'dart:math';

import 'package:emoji_extension/emoji_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/features/chat_room/data/models/models/message_link_model.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/extension/extension_string.dart';

enum SampleMessageType {
  text,
  emoji;
}

@immutable
class DebugSendSampleMessageParams {
  final int delay;
  final int characterAmount;
  final int loopCount;
  final SampleMessageType sampleType;
  final FutureOr<void> Function({required String message, List<MessageLinkModel> links, int loopCount}) onSendText;

  const DebugSendSampleMessageParams({
    required this.onSendText,
    this.delay = 100,
    this.characterAmount = 100,
    this.loopCount = 100,
    this.sampleType = SampleMessageType.text,
  });
}

class DebugSendSampleMessageUseCase extends SimpleUseCase<void, DebugSendSampleMessageParams> {
  static const _charText = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ';

  @override
  Future<void> call(DebugSendSampleMessageParams params) async {
    final delay = params.delay;
    final characterAmount = params.characterAmount;
    final loopCount = params.loopCount;
    final sampleType = params.sampleType;

    if (characterAmount > UChatConstant.maxMessageInputLength) {
      throw Exception('Character amount exceeds limit of ${UChatConstant.maxMessageInputLength}');
    }

    if (loopCount > 1000) {
      throw Exception('Loop count exceeds limit of 1000');
    }

    String mockMessage;

    switch (sampleType) {
      case SampleMessageType.text:
        mockMessage = _charText.random(amount: characterAmount);
        break;
      case SampleMessageType.emoji:
        final random = Random();
        final buffer = StringBuffer();
        final emojiUnicodeList = Emojis.all.unicodes;

        for (int i = 0; i < characterAmount; i++) {
          final randomIndex = random.nextInt(emojiUnicodeList.length);
          buffer.write(Emojis.getOne(emojiUnicodeList[randomIndex]).value);
        }
        mockMessage = buffer.toString();
        break;
    }

    for (int i = 0; i < loopCount; i++) {
      if (sampleType == SampleMessageType.text) {
        params.onSendText(message: '${i + 1} - $mockMessage', loopCount: loopCount);
      } else {
        params.onSendText(message: mockMessage, loopCount: loopCount);
      }
      await Future.delayed(Duration(milliseconds: delay));
    }
  }
}
