import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/presentation/bindings/message_binding.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_image_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reaction/message_reaction.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reply/reply_message_widget.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class FriendMessage extends StatelessWidget {
  final MessageCollection message;
  final MessageCollection? previousMessage;
  final String userName;
  final bool isGroup;
  final double checkBoxSize;
  final AnimationController? animationCtl;
  final Duration animationDelay;
  final Duration animationDuration;
  final Curve animationCurve;
  final double animationShakeHz;
  final List<MessageCollection>? selectedMsg;
  final OnImageItemSelected? onImageItemSelected;
  final bool isAllowSelection;
  final void Function()? onReplyTap;
  final void Function(String accountId)? onTapToMention;
  final bool enableReactionModal;
  final bool showReaction;
  final String? messageTypeTag;
  final Widget? status;
  final Widget messageItem;
  final Widget? avatar;

  const FriendMessage({
    super.key,
    this.animationCtl,
    this.animationDelay = const Duration(milliseconds: 0),
    this.animationDuration = const Duration(milliseconds: 600),
    this.animationCurve = Curves.easeOut,
    this.animationShakeHz = 2.0,
    required this.message,
    this.previousMessage,
    required this.userName,
    required this.checkBoxSize,
    this.selectedMsg,
    this.isGroup = false,
    this.onImageItemSelected,
    this.isAllowSelection = false,
    this.onReplyTap,
    this.onTapToMention,
    this.enableReactionModal = false,
    this.showReaction = true,
    this.messageTypeTag,
    this.status,
    required this.messageItem,
    this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    final tag = messageTypeTag ?? MessageBinding.getMessageTypeTag(message);

    return AnimatedContainer(
      padding: EdgeInsets.fromLTRB(
        AppSpace.space3,
        0,
        (checkBoxSize / 2) + AppSpace.space1,
        0,
      ),
      transform: Matrix4.translation(
        math.Vector3(
          selectedMsg != null ? AppSpace.space2 : -(checkBoxSize - AppSpace.space1),
          0,
          0,
        ),
      ),
      curve: Curves.fastOutSlowIn,
      duration: UChatConstant.messageSelectionAnimateDuration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message.replyMessage != null || (message.isParentDeleted == true && message.replyMessage == null))
            Container(
              margin: EdgeInsets.only(left: checkBoxSize + AppSpace.space2),
              child: GestureDetector(
                onTap: onReplyTap,
                child: ReplyMessageWidget(
                  repliedMessage: message.replyMessage,
                  message: message.toModel(),
                  isMyMessage: false,
                  onReplyTap: onReplyTap,
                ),
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (avatar != null)
                avatar!
              else
                const SizedBox(
                  width: AppSize.size4 * 2,
                  height: AppSize.size4 * 2,
                ),
              AppSpace.space2.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isGroup && avatar != null)
                      GestureDetector(
                        onTap: () {
                          if (message.account?.isDeleted == true) return;

                          onTapToMention?.call('@[__${message.accountId}__](__${userName}__)');
                        },
                        child: Container(
                          height: AppSize.size6.spMin,
                          padding: EdgeInsets.only(right: 20.spMin),
                          child: AppText.caption2Bold(
                            userName,
                            context: context,
                            color: context.theme.appColors.textDark,
                            maxLines: 1,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
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
                        if (message.type != MessageType.text && status != null) ...[
                          AppSpace.space2.horizontalSpace,
                          status!,
                        ]
                      ],
                    ),
                    if (message.canReact && showReaction)
                      MessageReaction(
                        messageTag: tag,
                        enableReactionModal: enableReactionModal,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
