import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/app_text.dart';

class MessageTypeRegularText extends StatelessWidget {
  final String message;
  final bool isMyMessage;

  const MessageTypeRegularText({
    super.key,
    required this.message,
    required this.isMyMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.space3, vertical: AppSpace.space2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
        color:
            isMyMessage ? context.theme.appColors.backgroundChatSender : context.theme.appColors.backgroundChatReceiver,
      ),
      child: AppText.body2(
        message,
        color: isMyMessage ? context.theme.appColors.textPrimaryInverse : context.theme.appColors.textDarkest,
        context: context,
      ),
    );
  }
}
