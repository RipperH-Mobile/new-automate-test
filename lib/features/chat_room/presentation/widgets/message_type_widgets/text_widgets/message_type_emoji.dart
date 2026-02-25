import 'package:flutter/material.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';

class MessageTypeEmoji extends StatelessWidget {
  final String message;
  final int msgLength;
  final bool isReplyMsg;

  const MessageTypeEmoji({
    super.key,
    required this.message,
    required this.msgLength,
    this.isReplyMsg = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSize.size2),
      child: Text(
        message,
        textAlign: TextAlign.start,
        maxLines: isReplyMsg ? 1 : null,
        overflow: isReplyMsg ? TextOverflow.ellipsis : null,
        style: TextStyle(
          fontSize: msgLength == 1 ? 64 : 40,
          height: msgLength == 1 ? 1 : 1.2,
          letterSpacing: msgLength == 1 ? 0 : AppSpace.space2,
        ),
      ),
    );
  }
}
