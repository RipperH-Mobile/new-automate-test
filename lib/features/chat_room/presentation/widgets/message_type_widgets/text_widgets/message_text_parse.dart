import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_text_parse_mention.dart';
import 'package:uchat/utils/extension/extension_string.dart';

class MessageTextParse extends StatelessWidget {
  final MessageCollection message;
  final bool isMinimizeText;
  final bool isLengthOverLimit;
  final int limitedLength;
  final void Function() onReadMorePressed;

  const MessageTextParse({
    super.key,
    required this.message,
    required this.isMinimizeText,
    required this.isLengthOverLimit,
    required this.limitedLength,
    required this.onReadMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = message.mine ? context.theme.appColors.textPrimaryInverse : context.theme.appColors.textDarkest;

    return GestureDetector(
      onTap: onReadMorePressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space3, vertical: AppSpace.space2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
          color: message.mine
              ? context.theme.appColors.backgroundChatSender
              : context.theme.appColors.backgroundChatReceiver,
        ),
        child: MentionTextParse(
          room: message.room,
          isMe: message.mine,
          isChatMessage: true,
          message: isMinimizeText && isLengthOverLimit ? message.message?.subStr(limitedLength) : message.message,
          style: context.theme.appTexts.body2.copyWith(color: textColor),
          styleMatch: context.theme.appTexts.body2Bold.copyWith(color: textColor),
          // RegexPattern, To using parse text
          // Read more, Read less (WidgetSpan, RichText is not working)
          overflowStr: isLengthOverLimit
              ? isMinimizeText
                  ? '#[__1__](__... ${'Read more'.tr}__)'
                  : '#[__1__](__${'Read less'.tr}__)'
              : null,
          styleOverflowStr: context.theme.appTexts.body2Bold.copyWith(
            color: message.mine ? context.theme.appColors.textPrimaryInverse : context.theme.appColors.textPrimary,
          ),
          overflowStrToggle: onReadMorePressed,
        ),
      ),
    );
  }
}
