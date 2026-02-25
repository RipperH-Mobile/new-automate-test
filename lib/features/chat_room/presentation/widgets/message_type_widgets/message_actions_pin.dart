import 'package:flutter/material.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/base_message_actions.dart';

class MessageActionsPin with BaseMessageActions {
  final bool isAbleToPinMessages;
  final VoidCallback? onCopy;
  final VoidCallback? onUnPin;
  final VoidCallback? onShare;

  MessageActionsPin({
    this.isAbleToPinMessages = false,
    this.onCopy,
    this.onUnPin,
    this.onShare,
  });

  List<Widget> actions() {
    return [
      if (onCopy != null) buildCopy(onCopy: onCopy),
      if (onUnPin != null && isAbleToPinMessages) buildUnpin(onUnPin: onUnPin),
      if (onShare != null) buildShare(onShare: onShare),
    ];
  }
}
