import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';

import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_mapper_extensions.dart';
import 'package:uchat/features/chat_room/domain/chat_room_domain.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_list_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_actions.dart';
import 'package:uchat/features/report/data/models/enum/report_type.dart';
import 'package:uchat/features/report/presentation/controller/main_dialog_controller.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/extension/extension_string.dart';
import 'package:uchat/utils/vibrate.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class MessageTypeController extends GetxController {
  final _log = useLogger();

  final MessageCollection initMessage;

  MessageTypeController({
    required this.initMessage,
  });

  ChatRoomController get chatRoomDirectController {
    if (!Get.isRegistered<ChatRoomController>()) {
      return Get.put<ChatRoomController>(
          ChatRoomController(
            tag: initMessage.roomId ?? '',
            messageLocalRepository: GetIt.I<MessageLocalRepository>(),
          ),
          tag: initMessage.roomId ?? '');
    }

    return Get.find<ChatRoomController>(tag: initMessage.roomId ?? '');
  }

  bool get canReact =>
      initMessage.canReact &&
      UserController.instance.enableReactMessage &&
      !chatRoomDirectController.roomCapability.value.disableEmojiReaction;

  MessageListController get messageListController {
    return Get.find<MessageListController>(tag: 'chat-room-${initMessage.roomId ?? ''}');
  }

  bool get isDisableAlbumMenu {
    return chatRoomDirectController.roomCapability.value.disableAlbumMenu;
  }

  void closeKeyboardWhenTapImageOrVideo() {
    chatRoomDirectController.onImageOrVideoSendCloseKeyboard();
  }

  List<Widget> actions(MessageCollection? message) {
    if (message == null) return [];

    if (message.isSending == true || message.isSendFailed == true) {
      return [];
    }

    return MessageActions(
      roomCapability: chatRoomDirectController.roomCapability.value,
      message: message,
      roomSub: chatRoomDirectController.roomSub,
      onCopy: handleCopy,
      onPin: handlePin,
      onUnPin: handleUnPin,
      onEdit: handleEdit,
      onShare: handleShare,
      onShareOtherApp: handleShareOtherApp,
      onUnsent: handleUnsent,
      onDelete: handleDelete,
      onDeleteOtherMsg: handleDeleteOtherMsg,
      onReply: handleReply,
      onReport: handleReport,
      onResendFailedMessage: handleResendFailedMessage,
      onRemoveFailedMessage: handleDeleteFailedMessage,
      onAddToAlbum: handleAddToAlbum,
      isAbleToDeleteOtherMessages: chatRoomDirectController.isAbleToDeleteOtherMessages,
      isAbleToPinMessages: chatRoomDirectController.isAbleToPinMessages,
    ).actions();
  }

  void fireEventTracking(String action, MessageType? messageType) {
    String mediaType = 'unknown';
    if (messageType != null) {
      mediaType = EventProperty.getMessageTypeForEventParams(messageType);
    }
    GetIt.I<TaxonomyService>().sendEvent(EventName.longpressActionChatroom,
        eventProperties: EventProperty.longPressActionChatRoom(action, mediaType));
  }

  Future<void> handleCopy() async {
    GetIt.I<VibrateUtil>().vibrateSelection();
    Get.back();
    fireEventTracking('copy', initMessage.type);
    await Clipboard.setData(
      ClipboardData(
        text: (initMessage.message ?? '').displayMention(getDisplay: true),
      ),
    );
    GetIt.I<TaxonomyService>().sendEvent(EventName.messageCopied);
    AppToast.showToast(
      context: Get.context!,
      message: 'Copied message to clipboard'.tr,
      icon: Assets.vectors.contentCopy.svg(
        color: Get.context!.theme.appColors.iconPrimaryInverse,
      ),
      sbMargin: const EdgeInsets.only(bottom: 42), // chat input height
    );
  }

  Future<void> handlePin() async {
    GetIt.I<VibrateUtil>().vibrateSelection();
    Get.back();
    fireEventTracking('pin', initMessage.type);
    chatRoomDirectController.pinMessage(initMessage);
  }

  Future<void> handleUnPin() async {
    GetIt.I<VibrateUtil>().vibrateSelection();
    Get.back();
    fireEventTracking('unpin', initMessage.type);
    final ref = initMessage.ref;
    if (ref != null) {
      chatRoomDirectController.unpinMessage(ref);
    }
  }

  Future<void> handleEdit() async {
    GetIt.I<VibrateUtil>().vibrateSelection();
    Get.back();
    fireEventTracking('edit', initMessage.type);

    final messageEntity = MessageEntity(
      id: initMessage.id!,
      isEncrypted: initMessage.isEncrypted == true,
      message: initMessage.message,
    );

    chatRoomDirectController.chatRoomInputCtl.setEditingMessage(messageEntity);
  }

  Future<void> handleShare() async {
    GetIt.I<VibrateUtil>().vibrateSelection();
    Get.back();
    fireEventTracking('share', initMessage.type);
    chatRoomDirectController.chatRoomInputCtl.onKeyboardClose();
    chatRoomDirectController.chatRoomInputCtl.closeCustomInput(isOpenKeyboard: false);

    await Future.delayed(const Duration(milliseconds: 250)); // do toggle function after context menu animation end.
    chatRoomDirectController.toggleSelectionInitial(SelectType.share, initMsg: initMessage);
  }

  Future<void> handleShareOtherApp() async {}

  Future<void> handleUnsent() async {
    GetIt.I<VibrateUtil>().vibrateSelection();
    Get.back();
    fireEventTracking('unsent', initMessage.type);
    chatRoomDirectController.chatRoomInputCtl.onKeyboardClose();
    chatRoomDirectController.chatRoomInputCtl.closeCustomInput(isOpenKeyboard: false);

    await Future.delayed(const Duration(milliseconds: 250)); // do toggle function after context menu animation end.
    chatRoomDirectController.toggleSelectionInitial(SelectType.unsend, initMsg: initMessage);
  }

  Future<void> handleDelete() async {
    GetIt.I<VibrateUtil>().vibrateSelection();
    Get.back();
    fireEventTracking('delete', initMessage.type);
    chatRoomDirectController.chatRoomInputCtl.onKeyboardClose();
    chatRoomDirectController.chatRoomInputCtl.closeCustomInput(isOpenKeyboard: false);

    await Future.delayed(const Duration(milliseconds: 250)); // do toggle function after context menu animation end.
    chatRoomDirectController.toggleSelectionInitial(SelectType.delete, initMsg: initMessage);
  }

  Future<void> handleDeleteOtherMsg() async {
    GetIt.I<VibrateUtil>().vibrateSelection();
    Get.back();
    fireEventTracking('deleteOtherMessage', initMessage.type);

    chatRoomDirectController.chatRoomInputCtl.onKeyboardClose();
    chatRoomDirectController.chatRoomInputCtl.closeCustomInput(isOpenKeyboard: false);

    await Future.delayed(const Duration(milliseconds: 250)); // do toggle function after context menu animation end.
    chatRoomDirectController.toggleSelectionInitial(SelectType.deleteOtherMessage, initMsg: initMessage);
  }

  Future<void> handleReply() async {
    //NOTE. optimized this too when edit message finish
    // roomCtl.handleCancelEditMessage();
    Get.back();
    fireEventTracking('reply', initMessage.type);
    if (initMessage.canReply) {
      GetIt.I<VibrateUtil>().vibrateSuccess();
      chatRoomDirectController.setRepliedMessage(initMessage);
    }
  }

  Future<void> handleReport() async {
    Get.back();
    fireEventTracking('report', initMessage.type);
    chatRoomDirectController.chatRoomInputCtl.onKeyboardClose();
    chatRoomDirectController.chatRoomInputCtl.closeCustomInput(isOpenKeyboard: false);

    if (initMessage.roomId != null) {
      final roomEntity = await GetIt.I<GetRoomByIdUseCase>().call(ChatRoomParams(roomId: initMessage.roomId!));
      final room = roomEntity?.toCollection();

      MainDialogController.handleOpenDialog(
        context: Get.context!,
        reportType: ReportType.reportMessage,
        displayName: initMessage.displayName,
        messageId: initMessage.id,
        roomId: initMessage.roomId,
        userId: room?.firstOtherInRoom?.account?.id,
      );
    }
  }

  Future<void> handleResendFailedMessage() async {
    try {
      Get.back();
      await Future.delayed(const Duration(milliseconds: 250), () async {
        await messageListController.onResendMessage(initMessage);
      }); // do toggle function after context menu animation end.
    } catch (e, stackTrace) {
      _log.e(
        UChatLogMessage(
          message: 'Resend failed message error.',
          error: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<void> handleDeleteFailedMessage() async {
    try {
      Get.back();
      await Future.delayed(const Duration(milliseconds: 250), () async {
        await messageListController.onRemoveFailedMessage(initMessage);
      }); // do toggle function after context menu animation end.
    } catch (e, stackTrace) {
      _log.e(
        UChatLogMessage(
          message: 'Delete failed message error.',
          error: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<void> handleAddToAlbum() async {
    Get.back();
    GetIt.I<VibrateUtil>().vibrateSelection();

    if (isDisableAlbumMenu == true) {
      await UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      return;
    }

    fireEventTracking('album', initMessage.type);
    chatRoomDirectController.chatRoomInputCtl.onKeyboardClose();
    chatRoomDirectController.chatRoomInputCtl.closeCustomInput(isOpenKeyboard: false);
    await Future.delayed(const Duration(milliseconds: 250)); // do toggle function after context menu animation end.
    chatRoomDirectController.toggleSelectionInitial(SelectType.addToAlbum, initMsg: initMessage);
  }
}
