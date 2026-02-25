import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_container_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_list_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/friend_message.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_item_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_status_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_image_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/my_message.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/avatar/avatar_wrapper.dart';
import 'package:uchat/widgets/checkbox/round_checkbox.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class MessageContainerV2 extends GetView<MessageContainerController> {
  /// The message collection
  ///
  /// This value is used to determine the message data
  final MessageCollection message;
  final MessageCollection? previousMessage;
  final List<MessageCollection>? selectedMsg;
  final OnImageItemSelected? onImageItemSelected;

  final bool isMyMessage;
  final bool hideAvatar;
  final bool isGroup;

  /// The read status of the message
  final bool isRead;

  /// Message owner's name
  final String userName;
  final List<String>? readIds;

  /// The room type of the message
  ///
  /// Default is `RoomType.direct`
  final RoomType roomType;

  final MessageSelectionCallback? onSelectionTap;
  final SelectType? selectionType;

  final DateTime? lastReadAt;
  final void Function()? onReplyTap;
  final void Function()? onResendTap;
  final void Function()? onTapAvatar;
  final Function(String accountId)? onTapToMention;

  const MessageContainerV2({
    super.key,
    required this.message,
    required this.hideAvatar,
    required this.isGroup,
    this.isMyMessage = false,
    this.onSelectionTap,
    this.previousMessage,
    this.selectedMsg,
    this.selectionType,
    this.onImageItemSelected,
    this.lastReadAt,
    this.isRead = false,
    required this.userName,
    this.readIds,
    this.roomType = RoomType.direct,
    this.onReplyTap,
    this.onResendTap,
    required this.onTapAvatar,
    this.onTapToMention,
  });

  void handleSelectionToggle() {
    final c1 = message.files?.length ?? 0;
    final c2 = selectedMsg?.where((e) => e.id == message.id).length ?? 0;
    final c3 = c1 - c2;
    if (c3 + (selectedMsg?.length ?? 0) > UChatConstant.maxSelectedMessage) {
      return;
    }
    onSelectionTap?.call(message);
  }

  bool get isAllowSelection {
    switch (selectionType) {
      case SelectType.share:
        return UChatConstant.canShareTypeList.contains(message.type);
      case SelectType.delete:
        return UChatConstant.canDeleteTypeList.contains(message.type);
      case SelectType.deleteOtherMessage:
        return UChatConstant.canUnsentTypeList.contains(message.type);
      case SelectType.unsend:
        return UChatConstant.canUnsentTypeList.contains(message.type) &&
            message.mine &&
            DateTime.now().difference(message.createdAt!).inDays <= 1;
      case SelectType.addToAlbum:
        return message.type == MessageType.image;
      default:
        return false;
    }
  }

  bool get isSelectionFull => (selectedMsg?.length ?? 0) >= UChatConstant.maxSelectedMessage;

  bool get isSelectionActive => selectedMsg != null;

  double _getOpacity() {
    if (isSelectionActive) {
      if (selectedMsg?.contains(message) == true) {
        return 1.0;
      }
      if (!isAllowSelection || isSelectionFull) {
        return 0.5;
      }
    }
    return 1.0;
  }

  bool _toggleSelectMsgState() {
    if (isSelectionActive && isAllowSelection) {
      if (selectedMsg?.contains(message) == true) {
        return true;
      }
      if (isSelectionFull) {
        return false;
      }
      return true;
    }

    return false;
  }

  @override
  String get tag => 'message_container_v2-${message.ref}';

  @override
  Widget build(BuildContext context) {
    if (_isSystemMessage()) {
      return _buildSystemMessage();
    }
    return _buildGeneralMessage(context);
  }

  bool _isSystemMessage() {
    if (message.type == MessageType.removeOthers) {
      return true;
    } else if (message.type == MessageType.system) {
      return true;
    } else if (message.type == MessageType.callMsg) {
      return [MessageCallType.join, MessageCallType.leave].contains(message.callMessage?.type);
    }
    return false;
  }

  Widget _buildSystemMessage() {
    return MessageItemV2(
      message: message,
      messageType: message.type,
    );
  }

  Widget _buildGeneralMessage(BuildContext context) {
    final checkBoxSize = AppSpace.space8;

    return GestureDetector(
      behavior: isSelectionActive ? HitTestBehavior.translucent : null,
      onTap: _toggleSelectMsgState() ? handleSelectionToggle : null,
      child: Opacity(
        opacity: _getOpacity(),
        child: IgnorePointer(
          ignoring: isSelectionActive && message.type != MessageType.image,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: _getCrossAxisAlignment(),
            children: [
              _buildCheckBox(checkBoxSize, _calculateIsCheck(), context),
              Expanded(child: _buildMessageContent(checkBoxSize)),
            ],
          ),
        ),
      ),
    );
  }

  bool _calculateIsCheck() {
    if (message.type == MessageType.image) {
      return selectedMsg?.where((e) => e.ref == message.ref).length == message.files?.length;
    } else {
      return selectedMsg?.any((e) => e.ref == message.ref) ?? false;
    }
  }

  CrossAxisAlignment _getCrossAxisAlignment() {
    return (hideAvatar || message.mine) ? CrossAxisAlignment.center : CrossAxisAlignment.start;
  }

  Widget _buildCheckBox(double checkBoxSize, bool isCheck, BuildContext context) {
    return AnimatedContainer(
      curve: Curves.fastOutSlowIn,
      duration: UChatConstant.messageSelectionAnimateDuration,
      transform: Matrix4.translation(
        math.Vector3(
          isSelectionActive ? AppSpace.space2 : -(checkBoxSize - AppSpace.space2),
          0,
          0,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 1000),
            opacity: isSelectionActive ? 1 : 0,
            child: SizedBox(
              width: checkBoxSize,
              height: checkBoxSize,
              child: Padding(
                padding: const EdgeInsets.all(AppSpace.space05),
                child: UChatRoundCheckBox(
                  animationDuration: Duration.zero,
                  checkedWidget: Padding(
                    padding: const EdgeInsets.all(AppSpace.space1),
                    child: ZoomIn(
                      from: 1.0,
                      duration: const Duration(milliseconds: 500),
                      child: Assets.vectors.check12.svg(
                        colorFilter: ColorFilter.mode(
                          context.theme.appColors.iconPrimaryInverse,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  isChecked: isCheck,
                  borderColor: context.theme.appColors.border,
                  uncheckedColor: context.theme.appColors.backgroundNeutralLighterPressed,
                  checkedColor: context.theme.appColors.backgroundPrimary,
                  onTap: (_) => handleSelectionToggle.call(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageContent(double checkBoxSize) {
    if (isMyMessage) {
      final status = Obx(() {
        return MessageStatusV2(
          isMyMessage: isMyMessage,
          sentTime: message.sentTime,
          isSending: message.isSending == true,
          isRead: isRead,
          isEdited: message.isEdited,
          isResend: message.isSendFailed ?? false,
          readMembers:
              controller.chatRoomDirectController.members.where((e) => readIds?.contains(e.accountId) == true).toList(),
          isGroup: roomType == RoomType.group,
          onResendTap: onResendTap,
          isPinned: message.isPinned ?? false,
          isAbleToShowReadByMembers: controller.whoReadEnable,
        );
      });
      return MyMessage(
        onResendTap: onResendTap,
        message: message,
        checkBoxSize: checkBoxSize,
        selectedMsg: selectedMsg,
        onImageItemSelected: _toggleSelectMsgState() ? onImageItemSelected : null,
        isAllowSelection: isAllowSelection,
        isRead: isRead,
        readIds: readIds,
        onReplyTap: onReplyTap,
        animationCtl: controller.animationCtl,
        enableReactionModal: controller.enableReactionModal,
        status: status,
        messageItem: MessageItemV2(
          message: message,
          messageType: message.type,
          isMyMessage: true,
          status: status,
          selectedMsg: selectedMsg,
          onImageItemSelected: onImageItemSelected,
          isAllowSelection: isAllowSelection,
        ),
      );
    } else {
      final status = MessageStatusV2(
        sentTime: message.sentTime,
        isRead: message.mine,
        isEdited: message.isEdited,
        isMyMessage: false,
        isPinned: message.isPinned ?? false,
      );
      return FriendMessage(
        checkBoxSize: checkBoxSize,
        previousMessage: previousMessage,
        isGroup: isGroup,
        message: message,
        userName: userName,
        selectedMsg: selectedMsg,
        onImageItemSelected: _toggleSelectMsgState() ? onImageItemSelected : null,
        isAllowSelection: isAllowSelection,
        onReplyTap: onReplyTap,
        onTapToMention: onTapToMention,
        animationCtl: controller.animationCtl,
        enableReactionModal: controller.enableReactionModal,
        status: status,
        avatar: hideAvatar
            ? null
            : GestureDetector(
                onTap: onTapAvatar,
                child: AvatarWrapper(
                  data: message.getContact(),
                  radius: AppSize.size4,
                  hasBorder: false,
                  showOnlineStatus: false,
                ),
              ),
        messageItem: MessageItemV2(
          message: message,
          messageType: message.type,
          isMyMessage: false,
          status: status,
          selectedMsg: selectedMsg,
          onImageItemSelected: onImageItemSelected,
          isAllowSelection: isAllowSelection,
        ),
      );
    }
  }
}
