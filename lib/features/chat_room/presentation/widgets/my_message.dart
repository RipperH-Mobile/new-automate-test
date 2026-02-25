import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/presentation/bindings/message_binding.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_image_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reaction/message_reaction.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reply/reply_message_widget.dart';

class MyMessage extends StatelessWidget {
  final MessageCollection message;
  final double checkBoxSize;
  final List<MessageCollection>? selectedMsg;
  final OnImageItemSelected? onImageItemSelected;
  final bool isAllowSelection;
  final bool isRead;
  final List<String>? readIds;
  final void Function()? onReplyTap;
  final void Function()? onResendTap;
  final AnimationController? animationCtl;
  final Duration animationDelay;
  final Duration animationDuration;
  final Curve animationCurve;
  final double animationShakeHz;
  final bool enableReactionModal;
  final String? messageTypeTag;
  final bool showReaction;
  final Widget? status;
  final Widget messageItem;

  const MyMessage({
    super.key,
    required this.message,
    required this.checkBoxSize,
    required this.messageItem,
    this.selectedMsg,
    this.onImageItemSelected,
    this.isAllowSelection = false,
    this.isRead = false,
    this.readIds,
    this.onReplyTap,
    this.onResendTap,
    this.animationCtl,
    this.animationDelay = const Duration(milliseconds: 0),
    this.animationDuration = const Duration(milliseconds: 600),
    this.animationCurve = Curves.easeOut,
    this.animationShakeHz = 2.0,
    this.enableReactionModal = false,
    this.messageTypeTag,
    this.showReaction = true,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    final tag = messageTypeTag ?? MessageBinding.getMessageTypeTag(message);

    return AnimatedContainer(
      padding: EdgeInsets.fromLTRB(
        (checkBoxSize / 2) + AppSpace.space1,
        0,
        AppSpace.space4,
        0,
      ),
      curve: Curves.fastOutSlowIn,
      duration: UChatConstant.messageSelectionAnimateDuration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (message.replyMessage != null || (message.isParentDeleted == true && message.replyMessage == null))
            GestureDetector(
              onTap: onReplyTap,
              child: ReplyMessageWidget(
                repliedMessage: message.replyMessage,
                message: message.toModel(),
                isMyMessage: true,
                onReplyTap: onReplyTap,
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (message.type != MessageType.text && status != null) ...[
                      status!,
                      AppSpace.space2.horizontalSpace,
                    ],
                    Flexible(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: UChatConstant.maxMessageWidthFactor.sw,
                        ),
                        child: messageItem
                            .animate(
                              controller: animationCtl,
                              autoPlay: false,
                            )
                            .shakeX(
                              delay: animationDelay,
                              duration: animationDuration,
                              hz: animationShakeHz,
                              curve: animationCurve,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (message.canReact && showReaction)
            MessageReaction(
              messageTag: tag,
              enableReactionModal: enableReactionModal,
            ),
        ],
      ),
    );
  }
}
