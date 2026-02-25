import 'dart:async';

import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_local_message_reactions_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_message_react_request.dart';
import 'package:uchat/features/chat_room/domain/entities/last_emoji_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/message_reaction_entity.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_local_message_reactions_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_message_reactions_from_server_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/react_message_use_case.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class MessageReactionBottomSheetController extends GetxController {
  final MessageEntity message;
  final GetLocalMessageReactionsUseCase getLocalMessageReactionsUseCase;
  final GetMessageReactionsFromServerUseCase getMessageReactionsFromServerUseCase;
  final ReactMessageUseCase reactMessageUseCase;
  final LoggerService log;

  MessageReactionBottomSheetController({
    required this.message,
    required this.getLocalMessageReactionsUseCase,
    required this.getMessageReactionsFromServerUseCase,
    required this.reactMessageUseCase,
    required this.log,
  });

  // Observable state
  final allReactionList = <MessageReactionEntity>[].obs;
  final isFetchingForMsgReact = false.obs;
  final selectedId = 'All'.obs;
  final emojiCategoriesList = <LastEmojiEntity>[].obs;
  final totalReactions = 0.obs;

  // State variables

  StreamSubscription? _reactionSubscription;
  ScrollController scrollController = ScrollController();

  // Getters
  String get messageId => message.id ?? '';

  String get roomId => message.roomId ?? '';

  String get currentUserId => UserController.instance.currentUser()?.id ?? '';

  bool get hasMoreReactions => allReactionList.length < totalReactions.value;

  bool get isOffline => ConnectivityController.instance.isOffline;

  bool get canReact => message.canReact && UserController.instance.enableReactMessage;

  bool get hasEmptyNameOrAvatar {
    return allReactionList.any((reaction) => (reaction.displayName == null) || (reaction.avatarPath == null));
  }

  @override
  void onInit() async {
    await _initializeReactionModal();
    _subscribeToReactionEvents();
    super.onInit();
  }

  @override
  void onClose() {
    _reactionSubscription?.cancel();
    super.onClose();
  }

  /// Initialize the reaction modal with initial data
  Future<void> _initializeReactionModal() async {
    _setInitialState();
    await _loadLocalReactions();
    await _fetchReactionsFromServer();
    await _sortReactionsByCurrentUser();
  }

  /// Set initial state from message data
  void _setInitialState() {
    totalReactions.value = message.emojiAmount ?? 0;
    emojiCategoriesList(message.lastEmojis ?? []);
  }

  /// Load reactions from local storage
  Future<void> _loadLocalReactions() async {
    final localReactions = await getLocalMessageReactionsUseCase.call(
      GetLocalMessageReactionsRequest(
        roomId: roomId,
        msgId: messageId,
      ),
    );
    allReactionList(localReactions);
  }

  /// Subscribe to reaction events for real-time updates
  void _subscribeToReactionEvents() {
    _reactionSubscription = eventBus.on<MessageReactionEvent>().listen((event) async {
      if (event.msgId == messageId) {
        if (event.accountId == UserController.instance.currentUser.value?.id) {
          EasyThrottle.throttle(
            'updateReactionBottomSheet',
            const Duration(milliseconds: 500),
            () {
              _handleReactionEvent(event);
            },
          );
        } else {
          _handleReactionEvent(event);
        }
      }
    });
  }

  /// Handle incoming reaction events
  Future<void> _handleReactionEvent(MessageReactionEvent event) async {
    final updatedReactions = await getLocalMessageReactionsUseCase.call(
      GetLocalMessageReactionsRequest(
        roomId: roomId,
        msgId: messageId,
      ),
    );
    totalReactions.value = event.emojiAmount;

    await _sortReactionsByCurrentUser(reactionList: updatedReactions);
    emojiCategoriesList(event.lastEmojis);
  }

  /// Fetch all reactions from server with pagination
  Future<void> _fetchReactionsFromServer() async {
    try {
      if ((!hasMoreReactions || isOffline) && !hasEmptyNameOrAvatar) return;

      isFetchingForMsgReact(true);

      // Fetch first page
      await _getReactionsPage(1);

      // Fetch remaining pages
      int currentPage = 2;
      while (hasMoreReactions) {
        await _getReactionsPage(currentPage);
        currentPage++;
      }
    } catch (e, stackTrace) {
      _log.e('UpdateReactions error', e, stackTrace);
      Get.back();
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
    } finally {
      isFetchingForMsgReact(false);
    }
  }

  /// Fetch a specific page of reactions
  Future<void> _getReactionsPage(int page, {int pageSize = 10}) async {
    final result = await getMessageReactionsFromServerUseCase.call(
      GetMessageReactRequest(
        msgId: messageId,
        roomId: roomId,
        page: page,
        pageSize: pageSize,
      ),
    );

    totalReactions.value = result.total;
    _updateReactionList(result.data!.toList());
  }

  /// Update reaction list with new reactions
  void _updateReactionList(List<MessageReactionEntity> newReactions) {
    for (final reaction in newReactions) {
      final existingIndex = allReactionList.indexWhere(
        (existing) => existing.accountId == reaction.accountId,
      );

      if (existingIndex == -1) {
        allReactionList.add(reaction);
      } else {
        allReactionList[existingIndex] = allReactionList[existingIndex].copyWith(
          createdAt: reaction.createdAt,
          displayName: reaction.displayName,
          avatarPath: reaction.avatarPath,
        );
      }
    }
  }

  /// Sort reactions with current user's reaction at the top
  Future<void> _sortReactionsByCurrentUser({
    List<MessageReactionEntity>? reactionList,
  }) async {
    try {
      if (reactionList != null) {
        allReactionList(reactionList);
      }

      if (allReactionList.isEmpty) {
        // close the modal if there are no reactions
        Get.back();
        return;
      }

      // Sort by creation date (newest first)
      allReactionList.sort((a, b) => b.createdAt!.compareTo(a.createdAt ?? DateTime.now()));

      // Move current user's reaction to top
      _moveCurrentUserReactionToTop();
    } catch (e, stackTrace) {
      _log.e('sortAndUpdateMessageReactionList error', e, stackTrace);
    }
  }

  /// Move current user's reaction to the top of the list
  void _moveCurrentUserReactionToTop() {
    final currentUserReactionIndex = allReactionList.indexWhere(
      (reaction) => reaction.accountId == currentUserId,
    );

    if (currentUserReactionIndex != -1) {
      final userReaction = allReactionList.removeAt(currentUserReactionIndex);
      allReactionList.insert(0, userReaction);
    }
  }

  /// Handle category selection
  void onSelectCategory(String emojiId) {
    selectedId(emojiId);
  }

  /// Handle reaction removal
  Future<void> onRemove({
    required String emojiId,
    required String accountId,
    required int length,
  }) async {
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
        log.e('Error in onRemove', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    } catch (e, stackTrace) {
      log.e('Error in onRemove', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
    }
  }
}
