import 'dart:async';

import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_local_message_reactions_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_message_reactions_from_server_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/react_message_use_case.dart';
import 'package:uchat/features/chat_room/presentation/controllers/reaction/message_reaction_bottom_sheet_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reaction/message_reaction_bottom_sheet.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class MessageReactionController extends GetxController {
  final MessageCollection initMessage;
  final ReactMessageUseCase reactMessageUseCase;
  final LoggerService log;

  MessageReactionController({
    required this.initMessage,
    required this.reactMessageUseCase,
    required this.log,
  }) {
    message.value = initMessage.toEntity();
  }

  final message = Rxn<MessageEntity>();

  StreamSubscription? _reactionSubscription;
  StreamSubscription? _messageUpdateSubscription;

  final emojiIdAnimates = <String>[].obs;
  final emojiAnimationStates = <String, Timer>{}.obs;

  @override
  onInit() async {
    _reactionSubscription = eventBus.on<MessageReactionEvent>().listen((event) {
      if (event.msgId == message()?.id) {
        if (event.accountId == UserController.instance.currentUser.value?.id) {
          EasyThrottle.throttle(
            'updateReactionCategoriesList',
            const Duration(milliseconds: 500),
            () {
              updateReactionCategoriesList(event);
            },
          );
        } else {
          updateReactionCategoriesList(event);
        }
        final emojiId = event.lastEmojis.firstOrNull?.emojiId;
        if (event.removeEmojiId == null && emojiId?.isNotEmpty == true) {
          _triggerEmojiAnimation(emojiId!);
        }
      }
    });
    _messageUpdateSubscription = eventBus.on<MessageUpdateEvent>().listen(
      (event) async {
        final isSameMessage = message.value?.id == event.message.id || message.value?.ref == event.message.ref;
        if (message.value?.roomId == event.message.roomId && isSameMessage) {
          message(event.message.toEntity());
        }
      },
    );

    super.onInit();
  }

  @override
  onClose() async {
    await _reactionSubscription?.cancel();
    await _messageUpdateSubscription?.cancel();
    // Cancel all pending animation timers
    for (final timer in emojiAnimationStates.values) {
      timer.cancel();
    }
    emojiAnimationStates.clear();
    super.onClose();
  }

  void _triggerEmojiAnimation(String emojiId) {
    // Cancel existing timer if any
    emojiAnimationStates[emojiId]?.cancel();

    // Add to animation list if not already present
    if (!emojiIdAnimates.contains(emojiId)) {
      emojiIdAnimates.add(emojiId);
    }

    // Set up timer to remove animation after completion
    // Give extra time to ensure animation completes smoothly
    emojiAnimationStates[emojiId] = Timer(const Duration(milliseconds: 2000), () {
      emojiIdAnimates.remove(emojiId);
      emojiAnimationStates.remove(emojiId);
    });
  }

  void updateReactionCategoriesList(MessageReactionEvent event) async {
    final lastEmojis = event.lastEmojis;

    lastEmojis.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt ?? DateTime.now()));

    lastEmojis.sort(
      (a, b) => b.updatedAt!.compareTo(
        a.updatedAt ?? DateTime.now(),
      ),
    );

    if (lastEmojis.length < (message.value?.lastEmojis?.length ?? 0) && event.removeEmojiId != null) {
      lastEmojis.removeWhere((e) => e.emojiId == event.removeEmojiId);
    }

    final updatedMessage = message.value?.copyWith(
      lastEmojis: lastEmojis,
      emojiAmount: event.emojiAmount,
      selectedReactionList: event.selectedReactionList,
    );
    // Force assignment with new reference
    message(updatedMessage);
    message.refresh();
  }

  void selectEmoji(String emojiId) async {
    final message = this.message.value;

    if (message == null) return;

    try {
      await reactMessageUseCase.call(
        ReactMessageParams(
          message: message,
          emojiId: emojiId,
        ),
      );
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(
        context: Get.context!,
      );
    } on ApiException catch (e, stackTrace) {
      if (e.type == 'ERR_PERMISSION_DENIED') {
        UChatNewDialog.showPermissionDeniedDialog(
          context: Get.context!,
        );
      } else {
        log.e('Error in selectEmoji', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    } catch (e, stackTrace) {
      log.e('Error in selectEmoji', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
    }
  }

  void showMsgReactionModal(BuildContext context) async {
    try {
      if (message.value == null) return;

      Widget child = GetBuilder<MessageReactionBottomSheetController>(
        init: MessageReactionBottomSheetController(
          message: message.value!,
          getLocalMessageReactionsUseCase: GetIt.I<GetLocalMessageReactionsUseCase>(),
          reactMessageUseCase: GetIt.I<ReactMessageUseCase>(),
          getMessageReactionsFromServerUseCase: GetIt.I<GetMessageReactionsFromServerUseCase>(),
          log: GetIt.I<LoggerService>(),
        ),
        builder: (ctl) {
          return const MessageReactionBottomSheet();
        },
      );

      Get.bottomSheet(
        child,
        ignoreSafeArea: false,
        isScrollControlled: true,
      );
    } catch (e, stackTrace) {
      if (e is FailedHostLookupException) {
        UChatNewDialog.showYouAreOfflineDialog(
          context: Get.context!,
        );
      } else {
        log.e('Error showMsgReactionModal', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    }
  }
}
