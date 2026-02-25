import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/domain/entities/room_capability_entity.dart';
import 'package:uchat/features/chat_room/presentation/bindings/message_binding.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_image_v2_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_video_v2_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/base_message_actions.dart';

class MessageActions with BaseMessageActions {
  final MessageCollection message;
  final Rxn<RoomSubscriptionCollection> roomSub;
  final RoomCapabilityEntity roomCapability;
  final bool isAbleToDeleteOtherMessages;
  final bool isAbleToPinMessages;
  final VoidCallback? onReply;
  final VoidCallback? onCopy;
  final VoidCallback? onPin;
  final VoidCallback? onUnPin;
  final VoidCallback? onEdit;
  final VoidCallback? onShare;
  final VoidCallback? onShareOtherApp;
  final VoidCallback? onUnsent;
  final VoidCallback? onDelete;
  final VoidCallback? onDeleteOtherMsg;
  final VoidCallback? onReport;
  final VoidCallback? onRemoveFailedMessage;
  final VoidCallback? onResendFailedMessage;
  final VoidCallback? onAddToAlbum;

  MessageActions({
    required this.message,
    required this.roomSub,
    required this.roomCapability,
    this.isAbleToDeleteOtherMessages = false,
    this.isAbleToPinMessages = false,
    this.onReply,
    this.onCopy,
    this.onPin,
    this.onUnPin,
    this.onEdit,
    this.onShare,
    this.onShareOtherApp,
    this.onUnsent,
    this.onDelete,
    this.onDeleteOtherMsg,
    this.onReport,
    this.onRemoveFailedMessage,
    this.onResendFailedMessage,
    this.onAddToAlbum,
  });

  bool get _allowReply => !roomCapability.disableReplyMessage;

  bool get _allowEdit => !roomCapability.disableEditMessage;

  bool get _allowUnsent => !roomCapability.disableUnsendMessage;

  bool get _allowDelete => !roomCapability.disableDeleteMessage;

  bool get _allowDeleteOtherMsg => roomSub.value?.isGroup == true && isAbleToDeleteOtherMessages;

  bool get _allowReport => !roomCapability.disableReportMessage;

  bool get _allowAddToAlbum => !roomCapability.disableAlbumMenu;

  bool get canUnsent => DateTime.now().difference(message.createdAt!).inHours < 24;

  /// Check if the failed message file exist
  ///
  /// Return true if the failed message file exist, otherwise return false
  bool get isFailedMessageFileExist {
    // Check if the message is image or video
    // If the message is image or video, check if the file exist

    if (message.type == MessageType.image) {
      final messageTypeImageCtlTag = MessageBinding.getMessageTypeTag(message);
      if (Get.isRegistered<MessageTypeImageV2Controller>(tag: messageTypeImageCtlTag)) {
        final messageTypeImageCtl = Get.find<MessageTypeImageV2Controller>(tag: messageTypeImageCtlTag);
        return messageTypeImageCtl.isFileExist(message.file?.refFile);
      }
    }

    if (message.type == MessageType.video) {
      final messageTypeVideoCtlTag = MessageBinding.getMessageTypeTag(message);
      if (Get.isRegistered<MessageTypeVideoV2Controller>(tag: messageTypeVideoCtlTag)) {
        final messageTypeVideoCtl = Get.find<MessageTypeVideoV2Controller>(tag: messageTypeVideoCtlTag);
        return messageTypeVideoCtl.isFileExist.value;
      }
    }

    return true;
  }

  List<Widget> actions() {
    if (message.isSendFailed == true) {
      return [
        if (isFailedMessageFileExist) buildResendFailedMessage(onResendFailedMessage: onResendFailedMessage),
        buildRemoveFailedMessage(onRemoveFailedMessage: onRemoveFailedMessage),
      ];
    }

    return _getActionsForMessageType();
  }

  List<Widget> _getActionsForMessageType() {
    switch (message.type) {
      case null:
      case MessageType.remove:
      case MessageType.removeOthers:
      case MessageType.system:
      case MessageType.unsent:
      case MessageType.edit:
      case MessageType.callMsg:
      case MessageType.stickerGift:
        return [];

      case MessageType.text:
        return _buildTextActions();

      case MessageType.gif:
      case MessageType.sticker:
        return _buildMediaActions(includeShare: false);

      case MessageType.stickerSharing:
        return _buildStickerSharingActions();

      case MessageType.image:
        return _buildImageActions();

      case MessageType.file:
      case MessageType.audio:
      case MessageType.video:
        return _buildFileActions();

      case MessageType.album:
        return _buildAlbumActions();

      case MessageType.location:
        return _buildLocationActions();

      case MessageType.contact:
      case MessageType.mobileContact:
        return _buildContactActions();
    }
  }

  List<Widget> buildPinTextActions() {
    return [
      if (onCopy != null) buildCopy(onCopy: onCopy),
      if (onUnPin != null) buildUnpin(onUnPin: onUnPin),
      if (onShare != null) buildShare(onShare: onShare),
    ];
  }

  List<Widget> _buildTextActions() {
    return [
      ..._buildReplyAction(),
      if (onCopy != null) buildCopy(onCopy: onCopy),
      if (isAbleToPinMessages) ..._buildPinAction(),
      if (_allowEdit &&
          !_isDirectChatBlocked &&
          message.canEditMessage &&
          !roomCapability.disableEditMessage &&
          onEdit != null)
        buildEdit(
          onEdit: () {
            if (roomSub()?.isDirectChatBlocked == true) return;
            onEdit?.call();
          },
        ),
      if (onShare != null) buildShare(onShare: onShare),
      if (!message.mine && _allowReport && onReport != null) buildReport(onReport: onReport),
      if (_allowUnsent && canUnsent && message.mine && onUnsent != null) buildUnsent(onUnsent: onUnsent),
      if (_allowDelete && !_isDirectChatBlocked && onDelete != null)
        buildDelete(
          onDelete: () {
            if (roomSub()?.isDirectChatBlocked == true) return;
            onDelete?.call();
          },
        ),
      if (_allowDeleteOtherMsg && onDeleteOtherMsg != null) buildDeleteOtherMsg(onDeleteOtherMsg: onDeleteOtherMsg),
    ];
  }

  List<Widget> _buildMediaActions({bool includeShare = true}) {
    return [
      ..._buildReplyAction(),
      if (includeShare && onShare != null) buildShare(onShare: onShare),
      if (!message.mine && _allowReport && onReport != null) buildReport(onReport: onReport),
      if (_allowUnsent && canUnsent && message.mine && onUnsent != null) buildUnsent(onUnsent: onUnsent),
      if (!_isDirectChatBlocked && onDelete != null)
        buildDelete(
          onDelete: () {
            if (roomSub()?.isDirectChatBlocked == true) return;
            onDelete?.call();
          },
        ),
      if (_allowDeleteOtherMsg && onDeleteOtherMsg != null)
        buildDeleteOtherMsg(
          onDeleteOtherMsg: () {
            onDeleteOtherMsg?.call();
          },
        ),
    ];
  }

  List<Widget> _buildStickerSharingActions() {
    return [
      ..._buildReplyAction(),
      if (onCopy != null) buildCopy(onCopy: onCopy),
      if (onShare != null) buildShare(onShare: onShare),
      if (!message.mine && _allowReport && onReport != null) buildReport(onReport: onReport),
      if (_allowUnsent && canUnsent && message.mine && onUnsent != null) buildUnsent(onUnsent: onUnsent),
      if (!_isDirectChatBlocked && onDelete != null)
        buildDelete(
          onDelete: () {
            if (roomSub()?.isDirectChatBlocked == true) return;
            onDelete?.call();
          },
        ),
      if (_allowDeleteOtherMsg && onDeleteOtherMsg != null)
        buildDeleteOtherMsg(
          onDeleteOtherMsg: () {
            onDeleteOtherMsg?.call();
          },
        ),
    ];
  }

  List<Widget> _buildImageActions() {
    return [
      ..._buildReplyAction(),
      if (!_isDirectChatBlocked && _allowAddToAlbum)
        buildAddToAlbum(
          onAddToAlbum: () {
            if (roomSub()?.isDirectChatBlocked == true) return;
            onAddToAlbum?.call();
          },
        ),
      if (onShare != null) buildShare(onShare: onShare),
      if (!message.mine && _allowReport && onReport != null) buildReport(onReport: onReport),
      if (_allowUnsent && canUnsent && message.mine && onUnsent != null) buildUnsent(onUnsent: onUnsent),
      if (!_isDirectChatBlocked && onDelete != null)
        buildDelete(
          onDelete: () {
            if (roomSub()?.isDirectChatBlocked == true) return;
            onDelete?.call();
          },
        ),
      if (_allowDeleteOtherMsg && onDeleteOtherMsg != null)
        buildDeleteOtherMsg(
          onDeleteOtherMsg: () {
            onDeleteOtherMsg?.call();
          },
        ),
    ];
  }

  List<Widget> _buildFileActions() {
    return [
      ..._buildReplyAction(),
      if (onShare != null) buildShare(onShare: onShare),
      if (!message.mine && _allowReport && onReport != null) buildReport(onReport: onReport),
      if (_allowUnsent && canUnsent && message.mine && onUnsent != null) buildUnsent(onUnsent: onUnsent),
      if (!_isDirectChatBlocked && onDelete != null)
        buildDelete(
          onDelete: () {
            if (roomSub()?.isDirectChatBlocked == true) return;
            onDelete?.call();
          },
        ),
      if (_allowDeleteOtherMsg && onDeleteOtherMsg != null)
        buildDeleteOtherMsg(
          onDeleteOtherMsg: () {
            onDeleteOtherMsg?.call();
          },
        ),
    ];
  }

  List<Widget> _buildAlbumActions() {
    return [
      ..._buildReplyAction(),
      if (!message.mine && _allowReport && onReport != null) buildReport(onReport: onReport),
      if (_allowUnsent && canUnsent && message.mine && onUnsent != null) buildUnsent(onUnsent: onUnsent),
      if (!_isDirectChatBlocked && onDelete != null)
        buildDelete(
          onDelete: () {
            if (roomSub()?.isDirectChatBlocked == true) return;
            onDelete?.call();
          },
        ),
      if (_allowDeleteOtherMsg && onDeleteOtherMsg != null)
        buildDeleteOtherMsg(
          onDeleteOtherMsg: () {
            onDeleteOtherMsg?.call();
          },
        ),
    ];
  }

  List<Widget> _buildLocationActions() {
    return [
      ..._buildReplyAction(),
      if (onShare != null) buildShare(onShare: onShare),
      if (!message.mine && _allowReport && onReport != null) buildReport(onReport: onReport),
      if (_allowUnsent && canUnsent && message.mine && onUnsent != null) buildUnsent(onUnsent: onUnsent),
      if (!_isDirectChatBlocked && onDelete != null)
        buildDelete(
          onDelete: () {
            if (roomSub()?.isDirectChatBlocked == true) return;
            onDelete?.call();
          },
        ),
      if (_allowDeleteOtherMsg && onDeleteOtherMsg != null)
        buildDeleteOtherMsg(
          onDeleteOtherMsg: () {
            onDeleteOtherMsg?.call();
          },
        ),
    ];
  }

  List<Widget> _buildContactActions() {
    return [
      if (onShare != null) buildShare(onShare: onShare),
      if (!message.mine && _allowReport && onReport != null) buildReport(onReport: onReport),
      if (_allowUnsent && canUnsent && message.mine && onUnsent != null) buildUnsent(onUnsent: onUnsent),
      if (!_isDirectChatBlocked && onDelete != null)
        buildDelete(
          onDelete: () {
            if (roomSub()?.isDirectChatBlocked == true) return;
            onDelete?.call();
          },
        ),
      if (_allowDeleteOtherMsg && onDeleteOtherMsg != null)
        buildDeleteOtherMsg(
          onDeleteOtherMsg: () {
            onDeleteOtherMsg?.call();
          },
        ),
    ];
  }

  List<Widget> _buildPinAction() {
    if (message.isPinned == true) {
      return onUnPin != null ? [buildUnpin(onUnPin: onUnPin)] : [];
    } else {
      return onPin != null ? [buildPin(onPin: onPin)] : [];
    }
  }

  List<Widget> _buildReplyAction() {
    if (_allowReply && !_isDirectChatBlocked && onReply != null) {
      return [
        buildReply(
          onReply: () {
            if (roomSub()?.isDirectChatBlocked == true) return;
            onReply?.call();
          },
        ),
      ];
    }
    return [];
  }

  bool get _isDirectChatBlocked => roomSub()?.isDirectChatBlocked == true;
}
