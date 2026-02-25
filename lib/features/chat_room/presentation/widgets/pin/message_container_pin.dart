import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/domain/entities/pin_message_entity.dart';
import 'package:uchat/features/chat_room/presentation/bindings/pin_message_binding.dart';
import 'package:uchat/features/chat_room/presentation/widgets/friend_message.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_status_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_actions_pin.dart';
import 'package:uchat/features/chat_room/presentation/widgets/my_message.dart';
import 'package:uchat/features/chat_room/presentation/widgets/pin/message_item_pin.dart';
import 'package:uchat/utils/get_name.dart';
import 'package:uchat/widgets/avatar/avatar_wrapper.dart';

class MessageContainerPin extends StatelessWidget {
  final PinMessageEntity pinedMessage;
  final VoidCallback? onStatusTap;
  final MessageActionsPin? messageActionsPin;

  const MessageContainerPin({
    super.key,
    required this.pinedMessage,
    this.messageActionsPin,
    this.onStatusTap,
  });

  String get messageTypeTag {
    final message = pinedMessage.message;
    if (message == null) {
      return '';
    }
    return PinMessageBinding.getMessageTypeTagWithSuffix(message.toCollection());
  }

  @override
  Widget build(BuildContext context) {
    final message = pinedMessage.message;
    if (message == null) {
      return const SizedBox.shrink();
    }
    final messageCollection = message.toCollection();
    final contact = messageCollection.getContact();
    if (messageCollection.mine) {
      final status = GestureDetector(
        onTap: onStatusTap,
        behavior: HitTestBehavior.translucent,
        child: MessageStatusV2(
          isMyMessage: true,
          sentTime: messageCollection.sentTime,
          isShowArrow: true,
        ),
      );
      return MyMessage(
        message: messageCollection,
        checkBoxSize: 0,
        messageTypeTag: messageTypeTag,
        showReaction: false,
        status: status,
        messageItem: MessageItemPin(
          message: messageCollection,
          status: status,
          messageTag: messageTypeTag,
          messageActionsPin: messageActionsPin,
        ),
      );
    } else {
      final status = GestureDetector(
        onTap: onStatusTap,
        behavior: HitTestBehavior.translucent,
        child: MessageStatusV2(
          sentTime: messageCollection.sentTime,
          isShowArrow: true,
          isMyMessage: false,
        ),
      );

      final String userName = getNameHelper(
        id: messageCollection.accountId,
        fallback: contact?.displayName ?? 'Unknown'.tr,
      );
      return FriendMessage(
        checkBoxSize: 0,
        message: messageCollection,
        userName: userName,
        isGroup: true,
        showReaction: false,
        messageTypeTag: messageTypeTag,
        status: status,
        avatar: AvatarWrapper(
          data: contact,
          radius: AppSize.size4,
          hasBorder: false,
          showOnlineStatus: false,
        ),
        messageItem: MessageItemPin(
          message: messageCollection,
          status: status,
          messageTag: messageTypeTag,
          messageActionsPin: messageActionsPin,
        ),
      );
    }
  }
}
