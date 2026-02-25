import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/core/data/models/enums/api_exception_type.dart';
import 'package:uchat/core/domain/entities/share_bottom_sheet_data_entity.dart';
import 'package:uchat/core/domain/entities/share_message_selection_entity.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/services/sharing/sharing_service.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/features/chat_room/data/models/requests/unpin_all_messages_request.dart';
import 'package:uchat/features/chat_room/domain/entities/pin_message_entity.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_message_by_ref_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/unpin_all_messages_in_room_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/unpin_message_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/watch_pin_messages_in_room_use_case.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/presentation/bindings/pin_message_binding.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_name_use_case.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/utils/extension/extension_string.dart';

import 'dart:async';

import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class PinMessagesController extends GetxController {
  final PaginationPayload<PinMessageEntity> initialMessages;
  final String roomId;
  final bool isAbleToPinMessages;
  final GetContactNameUseCase getContactNameUseCase;
  final UnpinMessageUseCase unpinMessageUseCase;
  final UnpinAllMessagesInRoomUseCase unpinAllMessagesInRoomUseCase;
  final WatchPinMessagesInRoomUseCase watchPinMessagesInRoomUseCase;
  final GetMessageByRefUseCase getMessageByRefUseCase;
  final LoggerService log;

  PinMessagesController({
    required this.initialMessages,
    required this.roomId,
    required this.isAbleToPinMessages,
    required this.getContactNameUseCase,
    required this.unpinMessageUseCase,
    required this.unpinAllMessagesInRoomUseCase,
    required this.watchPinMessagesInRoomUseCase,
    required this.getMessageByRefUseCase,
    required this.log,
  });

  var isLoadingMessage = true.obs;
  final messages = <PinMessageEntity>[].obs;
  final totalMessages = 0.obs;
  StreamSubscription? _pinMessagesSubscription;

  @override
  void onInit() {
    super.onInit();
    appendMessageToState();
    _startWatchingPinMessages();
  }

  @override
  void onClose() {
    _pinMessagesSubscription?.cancel();
    onCloseMessageController();
    super.onClose();
  }

  void _startWatchingPinMessages() {
    final params = WatchPinMessagesInRoomParams(roomId: roomId);
    _pinMessagesSubscription = watchPinMessagesInRoomUseCase.call(params).listen(
      (pinMessageEntities) {
        try {
          messages.clear();

          for (final pinEntity in pinMessageEntities.data!.toList()) {
            if (pinEntity.message != null && pinEntity.id != null) {
              final messageEntity = pinEntity.message!;
              PinMessageBinding.put(messageEntity.toCollection());
              messages.add(pinEntity);
            }
          }
          totalMessages.value = pinMessageEntities.total;
        } catch (e, stackTrace) {
          log.e('Error converting pin messages to collections', e, stackTrace);
        }
      },
      onError: (error, stackTrace) {
        log.e('Error in pin messages stream', error, stackTrace);
      },
    );
  }

  Future<void> appendMessageToState() async {
    for (final pinMessageEntity in initialMessages.data!.toList()) {
      try {
        if (pinMessageEntity.message != null && pinMessageEntity.id != null) {
          final messageEntity = pinMessageEntity.message!;

          PinMessageBinding.put(
            messageEntity.toCollection(),
          );

          messages.add(pinMessageEntity);
        }
        totalMessages.value = initialMessages.total;
      } catch (e, stackTrace) {
        log.e('appendMessageToState error.', e, stackTrace);
      }
    }
    isLoadingMessage.value = false;
  }

  Future<void> unpinAllMessages() async {
    try {
      await unpinAllMessagesInRoomUseCase.call(
        UnpinAllMessagesRequest(
          roomId: roomId,
        ),
      );
      await onCloseMessageController();
      messages.clear();
      Get.back();
    } on ApiException catch (e, stackTrace) {
      if (e.exceptionType == ApiExceptionType.permissionDenied) {
        UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      } else {
        log.e('Failed to unpin all messages', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    } catch (e, stackTrace) {
      log.e('Failed to unpin all messages', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
    }
  }

  /// Close message controller
  ///
  /// This function will close all message in the message list.
  ///
  /// This function will be called when the controller is closed.
  Future<void> onCloseMessageController() async {
    for (final pinMessage in messages) {
      if (pinMessage.message != null) {
        PinMessageBinding.close(
          pinMessage.message!.toCollection(),
        );
      }
    }
  }

  void onJumpToMessage(PinMessageEntity pinMessage) async {
    if (pinMessage.message == null) return;

    final ref = pinMessage.message?.ref;
    if (ref == null) return;

    // message?.isParentDeleted
    final message = await getMessageByRefUseCase.call(
      GetMessageByRefParams(
        ref: ref,
      ),
    );

    if (message != null &&
        (message.isParentDeleted == true ||
            message.type == MessageType.system ||
            message.type == MessageType.removeOthers ||
            message.type == MessageType.remove)) {
      UChatNewDialog.showJumpMessageUnavailableDialog(context: Get.context!);
      return;
    }

    final messageTarget = message ?? pinMessage.message;
    if (messageTarget == null) return;

    Get.until((route) {
      return route.settings.name == Routes.chatRoomDirect.replaceFirst(':id', roomId);
    });

    eventBus.fire(
      JumpToMessageEvent(
        message: messageTarget.toCollection(),
        roomId: roomId,
        shakeMessage: true,
      ),
    );
  }

  void onCopyMessage(PinMessageEntity pinMessage) async {
    if (pinMessage.message == null) return;

    await Clipboard.setData(
      ClipboardData(
        text: (pinMessage.message!.message ?? '').displayMention(getDisplay: true),
      ),
    );

    AppToast.showToast(
      context: Get.context!,
      message: 'Copied message to clipboard'.tr,
      icon: Assets.vectors.contentCopy.svg(
        colorFilter: ColorFilter.mode(
          Get.context!.theme.appColors.iconPrimaryInverse,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  void onUnPinMessage(PinMessageEntity pinMessage) async {
    try {
      final pinId = pinMessage.id;
      if (pinId == null) return;
      await unpinMessageUseCase.call(
        UnpinMessageParams(
          pinId: pinId,
          roomId: roomId,
        ),
      );

      messages.removeWhere((element) => element.id == pinMessage.id);
      if (messages.isEmpty) {
        await onCloseMessageController();
        Get.back();
      }
    } on ApiException catch (e, stackTrace) {
      if (e.exceptionType == ApiExceptionType.permissionDenied) {
        UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      } else {
        log.e('Failed to unpin message', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    } catch (e, stackTrace) {
      log.e('Failed to unpin message', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
    }
  }

  void onShareMessage(PinMessageEntity pinMessage) async {
    if (pinMessage.message == null) return;

    await GetIt.I<SharingService>().share(
      data: ShareBottomSheetDataEntity(
        messageList: [
          ShareMessageSelectionEntity(
            message: pinMessage.message!.toCollection(),
          ),
        ],
      ),
    );
  }
}
