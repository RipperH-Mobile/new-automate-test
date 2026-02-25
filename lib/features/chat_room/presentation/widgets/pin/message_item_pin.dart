import 'package:flutter/material.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_actions_pin.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_text_v2.dart';

class MessageItemPin extends StatelessWidget {
  final MessageCollection message;
  final Widget? status;
  final String messageTag;
  final MessageActionsPin? messageActionsPin;

  const MessageItemPin({
    super.key,
    required this.message,
    this.status,
    required this.messageTag,
    this.messageActionsPin,
  });

  @override
  Widget build(BuildContext context) {
    if (message.type != MessageType.text) return const SizedBox.shrink();

    return MessageTypeTextV2(
      messageTag: messageTag,
      status: status,
      actions: messageActionsPin?.actions(),
    );
  }
}
