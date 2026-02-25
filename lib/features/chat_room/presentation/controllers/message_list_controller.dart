import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:async_queue/async_queue.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:scrollview_observer/scrollview_observer.dart';
import 'package:uchat/api/services.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/controllers/connectivity_controller.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/domain/services/life_cycle_service.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/event_bus/events/pin_message_event.dart';
import 'package:uchat/core/event_bus/events/unpin_all_message_event.dart';
import 'package:uchat/core/event_bus/events/unpin_message_event.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/infrastructure/notification/debug/message_state_entity.dart';
import 'package:uchat/core/infrastructure/notification/debug/notification_logger.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/interfaces/contact_interface.dart';
import 'package:uchat/entities/models/contact_model.dart';
import 'package:uchat/entities/models/file_info_model.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/chat_room/chat_room_barrel.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/models/member_typing_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_file_message_params.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_message_to_server_params.dart';
import 'package:uchat/features/chat_room/domain/use_cases/trigger_read_message_v2_use_case.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_adding_queue_monitor.dart';
import 'package:uchat/features/chat_room/presentation/controllers/utils/append_or_update_many_message_to_state.dart';
import 'package:uchat/features/chat_room/presentation/utils/chat_room_tracer.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_controller.dart';
import 'package:uchat/features/contact/domain/params/get_contact_name_params.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_name_use_case.dart';
import 'package:uchat/features/home/call_appbar.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/features/profile/service/profile_service.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

enum SelectType {
  share,
  delete,
  deleteOtherMessage,
  unsend,
  addToAlbum;

  String get buttonName {
    switch (this) {
      case SelectType.share:
        return 'Share'.tr;
      case SelectType.delete:
        return 'Delete'.tr;
      case SelectType.deleteOtherMessage:
        return 'Delete for all'.tr;
      case SelectType.unsend:
        return 'Unsend'.tr;
      case SelectType.addToAlbum:
        return 'Add'.tr;
    }
  }

  String get buttonTextColor {
    switch (this) {
      case SelectType.share:
        return 'PRIMARY';
      case SelectType.delete:
        return 'ERROR';
      case SelectType.deleteOtherMessage:
        return 'ERROR';
      case SelectType.unsend:
        return 'ERROR';
      case SelectType.addToAlbum:
        return 'PRIMARY';
    }
  }
}

class MessageListController extends GetxController {
  final _log = useLogger();

  /// The tag of the message list controller
  ///
  /// The tag is used to identify the message list controller in the GetX controller
  ///
  /// This tag should be in the format of `chat-room-{roomId}`
  final String tag;

  /// Flag to enable read message
  ///
  /// This flag is used to enable or disable the read message feature.
  final bool enableReadMessage;

  MessageListController({required this.tag, this.enableReadMessage = true});

  /// The room collection
  ///
  /// The room collection is used to store the room data and get the roomSubscription data.
  ///
  /// The room data is assigned when the controller is initialized, by passing the room data from the `arguments`.
  RoomCollection? room;

  /// The room subscription collection
  ///
  /// The room subscription collection is used to store the room subscription data.
  ///
  /// The room subscription data is assigned when the controller is initialized, by `getting the room subscription from the local database.`
  RoomSubscriptionEntity? roomSub;

  /// Scroll controller for the message list, use for listen the scroll position and load more message
  late ScrollController scrollController;
  late ListObserverController listObserverController;
  late ChatScrollObserver chatObserver;

  BuildContext? sliverListCtx;

  /// List of messages in the chat room
  final messages = <MessageCollection>[].obs;

  /// List of failed messages in the chat room
  final failedMessages = <MessageCollection>[].obs;

  /// Flag to indicate whether the message is loading or not from the server
  final isLoadingMessage = false.obs;
  final isLoadingPreviousMessage = false.obs;

  /// The duration of the animation when scrolling to the item, use for animateToItem
  final animateScrollToItemDuration = const Duration(milliseconds: 300);

  /// Typing member map
  ///
  /// This map is used to store the typing member data.
  /// The typing member data is used to display the typing member list in the message list view.
  ///
  /// The key of the map is the `accountId` of the typing member.
  ///
  /// The value of the map is the `MemberTypingModel` which contains the typing member data.
  ///
  /// Timer is also stored in the `MemberTypingModel` to handle the typing member timeout.
  final typingMemberMap = HashMap<String, MemberTypingModel>().obs;

  /// Typing member timer map
  ///
  /// This map is used to store the timer for the typing member.
  /// The timer is used to handle the typing member timeout.
  ///
  /// The key of the map is the `accountId` of the typing member.
  ///
  /// The value of the map is the `Timer` which is used to handle the typing member timeout.
  final timerTypingMap = HashMap<String, Timer?>().obs;

  // final fileService = FileService.instance;
  // final fileDownloaderService = FileDownloaderService.instance;

  /// Message queue
  ///
  /// The message queue is used to store the message that is coming from the server,
  /// and prevent the message from being added to the message list immediately.
  final messageAddingQueue = AsyncQueue.autoStart();

  /// Monitor for tracking message queue performance and health
  late MessageAddingQueueMonitor? _queueMonitor;

  /// Getter for external access to the queue monitor
  MessageAddingQueueMonitor? get queueMonitor => _queueMonitor;

  /// The flag to indicate whether the scroll to bottom floating button should be shown or not
  final showScrollToBottomFloatingButton = Rxn<bool?>(null);

  /// The reference of the last read message
  ///
  /// This variable is used to store the reference of the last read message (current user) in the message list view.
  final lastReadMessageRef = ''.obs;

  /// The index of the last read message in the message list
  ///
  /// This variable is used to store the index of the last read message (current user) in the message list view.
  /// This variable is set to -1 when the last read message is not found in the message list,
  /// and set to the index of the last read message when the last read message is found in the message list.
  final lastReadMessageIndex = (-1).obs;

  /// The message index that visible in the message list view
  ///
  /// Range start from 1 to n, where 1 is the bottom of the list and n is the top of the list
  ///
  /// Example: (1, 10) means the first visible item is 1 (bottom) and the last visible item is 10 (top)
  final visibleIndexRange = Rxn<(int, int)>();

  /// This variable is used to store the border of the visible item in the message list view
  /// The first item is the first visible item (bottom) and the second item is the last visible item (top)
  ///
  /// Example: there are 10 messages in the list, and the first visible item index is 10 and the last visible item index is 20,
  /// then the visibleItemBorder will be (messages[9], messages[19])
  final visibleItemBorder = Rxn<(MessageCollection, MessageCollection)>();

  /// The flag to indicate whether the oldest message should show the last read at message or not
  ///
  /// This flag will be true when the oldest message is the last read at message or can not find the last read at message
  final shouldShowOldestMsgAsLastReadAtMsg = false.obs;

  /// To allowed to show new message animation
  final isAllowedAnimation = false.obs;

  /// To tell that which message ref can show animation
  final animateMessageRef = Rx<String?>(null);

  /// Track if animation is currently playing to prevent overlapping animations
  final isAnimating = false.obs;

  /// Set to track message refs that have already played animation
  /// This prevents duplicate animations when message updates from server
  final animatedMessageRefs = <String>{}.obs;

  /// Queue for pending message updates during animation
  final pendingMessageUpdates = <String, MessageCollection>{}.obs;

  MessageCollection? goBackToReplyMessage;

  bool fetchingMoreMessageInJumpingToMessage = false;

  MessageCollection? targetMessage;

  StreamSubscription? _messageNewSubscription;
  StreamSubscription? _messageUpdateSubscription;
  StreamSubscription? _addingLocalMessageSubscription;
  StreamSubscription? _addingFailedMessageSubscription;
  StreamSubscription? _roomUpdateSubscription;
  StreamSubscription? _fileDownloadProgressSubscription;
  StreamSubscription? _fileDownloadStatusSubscription;
  StreamSubscription? _jumpToMessageSubscription;
  StreamSubscription? _requiredLoadNewMessageSubscription;
  StreamSubscription? _playNewMessageAnimationSubscription;
  StreamSubscription? _pinMessageEventSubscription;
  StreamSubscription? _unpinMessageEventSubscription;
  StreamSubscription? _unpinAllMessageEventSubscription;
  StreamSubscription? _removeRoomMemberSubscription;

  // Local
  StreamSubscription? _imageUpdateSubscription;

  @override
  onInit() {
    super.onInit();

    ChatRoomTracer.trace(
      name: ChatRoomTraceNames.onInit,
      initialAttributes: {
        ChatRoomAttributeNames.roomId: roomId,
      },
      body: (trace) async {
        scrollController = ScrollController();
        listObserverController = ListObserverController(controller: scrollController)..cacheJumpIndexOffset = false;
        chatObserver = ChatScrollObserver(listObserverController)..toRebuildScrollViewCallback = () {};

        if (Get.arguments is ChatRoomArguments) {
          // Get the room data from the arguments, if the arguments is ChatRoomArguments
          final args = Get.arguments as ChatRoomArguments;
          room = args.room;
          targetMessage = args.targetMessage;
        }

        // Initialize the queue monitor
        _initializeQueueMonitor();

        _requiredLoadNewMessageSubscription = eventBus.on<RequireLoadNewMessageFromDbEvent>().listen(
              onChatRoomRequiredLoadNewMessageFromDb,
            );
        _messageNewSubscription = eventBus.on<MessageNewEvent>().listen(onNewMessageComingFromServer);
        _messageUpdateSubscription = eventBus.on<MessageUpdateEvent>().listen(onMessageUpdated);
        _removeRoomMemberSubscription = eventBus.on<RemoveRoomMemberEvent>().listen(onRoomMemberDeleted);
        _addingLocalMessageSubscription = eventBus.on<AddMessageToStateEvent>().listen(onAddingLocalMessage);
        _addingFailedMessageSubscription =
            eventBus.on<AddFailedMessageToStateEvent>().listen(onAddingFailedMessageToState);
        _roomUpdateSubscription = eventBus.on<RoomUpdateSubscriptionEvent>().listen((event) {
          if (event.roomSubscription.roomId != roomId) return;
          roomSub = event.roomSubscription;
        });
        _jumpToMessageSubscription = eventBus.on<JumpToMessageEvent>().listen(
          (event) async {
            if (roomId != event.roomId) {
              return;
            }

            await jumpToMessage(
              event.message,
              shakeMessage: event.shakeMessage,
            );
          },
        );
        _imageUpdateSubscription = eventBus.on<UnsentOrRemoveImagesLocalEvent>().listen(onUnsentOrRemoveMessageLocal);

        _fileDownloadProgressSubscription = eventBus.on<FileDownloaderProgressEvent>().listen((event) {
          _log.d('file download progress: ${event.progress}');

          updateFileList(eventFileId: event.fileId);
        });

        _fileDownloadStatusSubscription = eventBus.on<FileDownloaderStatusEvent>().listen((event) {
          _log.d('file download status: ${event.status}');

          if ([
            FileDownloadStatus.waitingToStart,
            FileDownloadStatus.completed,
            FileDownloadStatus.failed,
            FileDownloadStatus.paused,
            FileDownloadStatus.canceled
          ].contains(event.status)) {
            updateFileList(eventFileId: event.fileId);
          }

          // Show error dialog when download failed
          if (event.status == FileDownloadStatus.failed || event.status == FileDownloadStatus.unknown) {
            _handleDownloadFailed();
          }
        });

        _playNewMessageAnimationSubscription =
            eventBus.on<PlayNewMessageAnimationEvent>().listen(onPlayNewMessageAnimation);

        _pinMessageEventSubscription = eventBus.on<PinMessageEvent>().listen((event) {
          if (roomId != event.pinMessage.roomId) {
            return;
          }

          final existingIndex = messages.indexWhere((msg) => msg.id == event.pinMessage.message?.id);
          if (existingIndex != -1) {
            // Update existing pin message
            messages[existingIndex].isPinned = true;
            messages.refresh();
          }
        });
        _unpinMessageEventSubscription = eventBus.on<UnpinMessageEvent>().listen((event) {
          if (roomId != event.roomId) {
            return;
          }

          final existingIndex = messages.indexWhere((msg) => msg.ref == event.messageRef);
          if (existingIndex != -1) {
            // Update existing pin message
            messages[existingIndex].isPinned = false;
            messages.refresh();
          }
        });
        _unpinAllMessageEventSubscription = eventBus.on<UnpinAllMessageEvent>().listen((event) async {
          if (roomId != event.roomId) {
            return;
          }

          for (var msg in messages) {
            if (msg.isPinned == true) {
              msg.isPinned = false;
            }
          }
          messages.refresh();
        });

        initData();
      },
    );
  }

  @override
  onClose() async {
    try {
      scrollController.dispose();
      await _requiredLoadNewMessageSubscription?.cancel();
      await _messageNewSubscription?.cancel();
      await _messageUpdateSubscription?.cancel();
      await _addingLocalMessageSubscription?.cancel();
      await _addingFailedMessageSubscription?.cancel();
      await _roomUpdateSubscription?.cancel();
      await _removeRoomMemberSubscription?.cancel();
      await _fileDownloadProgressSubscription?.cancel();
      await _fileDownloadStatusSubscription?.cancel();
      await _jumpToMessageSubscription?.cancel();
      await _imageUpdateSubscription?.cancel();
      await _playNewMessageAnimationSubscription?.cancel();
      await _pinMessageEventSubscription?.cancel();
      await _unpinMessageEventSubscription?.cancel();
      await _unpinAllMessageEventSubscription?.cancel();
      await onCloseSubscriptions();
      await onCloseMessageController();
      onCloseTypingMemberTimers();

      // Clear animated message refs
      animatedMessageRefs.clear();

      // Dispose queue monitor
      _queueMonitor?.dispose();
      _queueMonitor = null;

      messageAddingQueue.close();
    } catch (e, stackTrace) {
      _log.e('MessageListController onClose error: $e', e, stackTrace);
    }

    super.onClose();
  }

  ChatRoomController get chatRoomCtl {
    if (!Get.isRegistered<ChatRoomController>(tag: roomId)) {
      return Get.put<ChatRoomController>(
        ChatRoomController(
          tag: roomId,
          messageLocalRepository: GetIt.I<MessageLocalRepository>(),
        ),
        tag: roomId,
      );
    }
    return Get.find<ChatRoomController>(tag: roomId);
  }

  ChatRoomInputController get chatRoomInputCtl {
    return Get.find<ChatRoomInputController>(tag: 'chat-room-$roomId');
  }

  ChatRoomDetailController get chatRoomDetailCtl {
    return Get.find<ChatRoomDetailController>(tag: tag);
  }

  String get roomId => tag.replaceFirst('chat-room-', ''); // Remove chat-room- from tag to get roomId.

  /// Get the list of typing member
  ///
  /// This function will return the list of typing member from the typing member map
  List<ContactInterface> get typingMemberList {
    final List<MemberTypingModel> tempTypingList = List.from(typingMemberMap.value.values);

    /// Sort the typing member by the last type at in descending order
    tempTypingList.sort((a, b) {
      if (a.lastTypeAt == null || b.lastTypeAt == null) {
        return 0;
      }

      return b.lastTypeAt!.compareTo(a.lastTypeAt!);
    });

    return tempTypingList.map((e) => e.contact).toList();
  }

  /// Get the index of the first visible item in the message list view
  int get fromVisibleItemIndex => visibleIndexRange.value?.$1 ?? 0;

  /// Get the index of the last visible item in the message list view
  int get toVisibleItemIndex => visibleIndexRange.value?.$2 ?? 0;

  /// Get the sequence of the very first message in the room, if the room is empty, return 0
  ///
  /// The very first message is the `oldest message` in the room (an message that sent long time ago)
  int get sequenceOfVeryFirstMessageInRoom => roomSub?.firstSequence ?? 0;

  /// Get the sequence of the last message in the message list, if the message list is empty, return 0
  ///
  /// Last message is the `oldest message` in the current message list (an message that sent long time ago, the top of the list)
  int get sequenceOfTopMessage => messages.lastOrNull?.sequence ?? 0;

  /// Get the sequence of the last message in localDB that saved in room subscription
  int? get roomSubOldestMsgSeq => roomSub?.oldestMsgSeq;

  /// Get the sequence of the first message in the message list, if the message list is empty, return 0
  ///
  /// First message is the `newest message` in the current message list (an message that just sent, the bottom of the list)
  int get sequenceOfBottomMessage => messages.firstOrNull?.sequence ?? 0;

  /// Check if there is more message to load from the server
  ///
  /// If the sequence of the very first message in the room is greater than the sequence of the very first message in the message list,
  bool get hasMoreMessage => sequenceOfTopMessage > sequenceOfVeryFirstMessageInRoom;

  /// Get the first message in this group of messages, which is the first (bottom) message in the list
  MessageCollection get newestMessage => messages.first;

  /// Get the last message in this group of messages, which is the last (top) message in the list
  MessageCollection get oldestMessage => messages.last;

  /// Check if the room is group or not
  bool get isGroup => roomSub?.isGroup == true;

  /// Mock pin data
  List<MessageCollection> get pinMessages {
    return messages.where((message) => message.isPinned == true).toList();
  }

  /// Wait for ChatRoomController to initialize its unreadCount
  ///
  /// This uses a reactive approach with GetX's ever() to efficiently wait
  /// for roomSub to be initialized, instead of polling.
  ///
  /// Timeout after 5 seconds to prevent infinite waiting.
  Future<void> _waitForChatRoomControllerInit() async {
    try {
      final completer = Completer<void>();
      Worker? worker;
      Timer? timeoutTimer;

      // Set up timeout
      timeoutTimer = Timer(const Duration(seconds: 5), () {
        if (!completer.isCompleted) {
          _log.w('Timeout waiting for ChatRoomController initialization. Proceeding anyway.');
          worker?.dispose();
          completer.complete();
        }
      });

      // Check if already initialized
      if (chatRoomCtl.roomSub.value != null) {
        _log.d('ChatRoomController already initialized for room: $roomId');
        timeoutTimer.cancel();
        return;
      }

      // Use GetX's ever() to reactively wait for roomSub initialization
      worker = ever(
        chatRoomCtl.roomSub,
        (roomSub) {
          if (roomSub != null && !completer.isCompleted) {
            _log.d('ChatRoomController initialized successfully for room: $roomId');
            timeoutTimer?.cancel();
            worker?.dispose();
            completer.complete();
          }
        },
      );

      await completer.future;
    } catch (e, stackTrace) {
      _log.e('Error waiting for ChatRoomController initialization: $e', e, stackTrace);
    }
  }

  /// Initialize the controller
  ///
  /// This function will get room subscription and message from local database.
  /// If there is no room subscription, then get room subscription from server.
  /// If there is no message, then get message from server.
  /// After that, the room subscription and message will be set to the controller.
  ///
  /// This function will be called when the controller is initialized.
  Future<void> initData() async {
    ChatRoomTracer.trace(
      name: ChatRoomTraceNames.initData,
      isAutoTraceStop: false,
      initialAttributes: {
        ChatRoomAttributeNames.roomId: roomId,
        ChatRoomAttributeNames.chatType: isGroup ? 'group' : 'direct',
      },
      body: (trace) async {
        await Future.wait([
          getRoomToState(),
          getRoomSubscriptionToState(),
        ]);

        // Wait for ChatRoomController to initialize unreadCount before loading messages
        await _waitForChatRoomControllerInit();

        messageAddingQueue.addJob(
          (_) async {
            await _trackQueueJob('initData', () async {
              await getMessageToState();
              await getSendingMessageToState();
              final totalLocalMessage = await GetIt.I<MessageLocalRepository>().countMessages(roomId: roomId);

              trace.incrementMetric(ChatRoomMetricNames.totalLocalMessage, totalLocalMessage);
              trace.incrementMetric(ChatRoomMetricNames.totalUnreadMessage, roomSub?.unreadCount ?? 0);
              trace.stop();
            });
          },
          label: 'initData',
        );
      },
    );
  }

  void getJumpMessage() async {
    final localTargetMessage = targetMessage;
    if (localTargetMessage != null) {
      await jumpToMessage(localTargetMessage);
      shakeMessage(localTargetMessage.ref);
      targetMessage = null;
    }
  }

  Future<void> jumpToLatestUnreadMessage() async {
    if (lastReadMessageIndex.value > -1) {
      await scrollToMessage(lastReadMessageIndex.value);
      checkShowScrollToBottomFloatingButton();
    }
  }

  /// Close message controller
  ///
  /// This function will close all message in the message list.
  ///
  /// This function will be called when the controller is closed.
  Future<void> onCloseMessageController() async {
    for (final message in messages) {
      MessageBinding.close(message);
    }
  }

  /// Close subscriptions
  ///
  /// This function will close all subscriptions in the message list controller.
  ///
  /// This function will be called when the controller is closed.
  Future<void> onCloseSubscriptions() async {
    final futures = <Future>[];

    if (_messageNewSubscription != null) {
      futures.add(_messageNewSubscription!.cancel());
    }

    if (_messageUpdateSubscription != null) {
      futures.add(_messageUpdateSubscription!.cancel());
    }

    if (_addingLocalMessageSubscription != null) {
      futures.add(_addingLocalMessageSubscription!.cancel());
    }

    await Future.wait(futures);
  }

  /// Close typing member timers
  ///
  /// This function will close all typing member timers in the typing member map.
  void onCloseTypingMemberTimers() {
    for (final timer in timerTypingMap.value.values) {
      timer?.cancel();
    }
  }

  /// Initialize the message queue monitor
  ///
  /// This creates a new monitor instance to track queue performance and health
  void _initializeQueueMonitor() {
    try {
      _queueMonitor = MessageAddingQueueMonitor(
        queue: messageAddingQueue,
        roomId: roomId,
      );

      // Listen to state changes for logging
      _queueMonitor?.stateStream.listen((state) {
        _log.i('Queue state changed to: ${state.displayName} [Room: $roomId]');
      });

      // Listen to metrics for performance tracking
      _queueMonitor?.metricsStream.listen((metrics) {
        // Log performance warnings
        if (metrics.averageProcessingTime > 3000) {
          _log.w(
              'Queue performance warning - Avg processing time: ${metrics.averageProcessingTime.toStringAsFixed(0)}ms [Room: $roomId]');
        }
      });
    } catch (e, stackTrace) {
      _log.e('Failed to initialize queue monitor: $e', e, stackTrace);
      _queueMonitor = null;
    }
  }

  /// Get queue performance summary for debugging
  MessageQueuePerformanceSummary? getQueuePerformance() {
    return _queueMonitor?.getPerformanceSummary();
  }

  /// Get active queue jobs for debugging
  List<MessageQueueJobInfo>? getActiveQueueJobs() {
    return _queueMonitor?.getActiveJobs();
  }

  /// Get queue metrics history for analysis
  List<MessageQueueMetrics>? getQueueMetricsHistory() {
    return _queueMonitor?.getMetricsHistory();
  }

  /// Debug the current queue state - prints detailed information to console
  void debugQueueState() {
    _queueMonitor?.debugQueueState();
  }

  /// Helper method to track queue jobs with monitoring
  ///
  /// Wraps the original job function with monitoring to track performance
  Future<T> _trackQueueJob<T>(
    String jobLabel,
    Future<T> Function() jobFunction,
  ) async {
    final jobId = _queueMonitor?.trackJobStart(jobLabel);

    try {
      final result = await jobFunction();
      if (jobId != null) {
        _queueMonitor?.trackJobComplete(jobId);
      }
      return result;
    } catch (e) {
      if (jobId != null) {
        _queueMonitor?.trackJobComplete(jobId, failed: true, errorMessage: e.toString());
      }
      rethrow;
    }
  }

  /// Get the room data from the local database and set it to the [room] variable.
  ///
  /// If the room data is fetched successfully, it will set the [appBarTitle] to the room title and [appBarAvatarUrl] to the room photoId.
  Future<void> getRoomToState() async {
    try {
      if (room != null) {
        return;
      }

      final roomEntity = await GetIt.I<GetRoomByIdUseCase>().call(ChatRoomParams(roomId: roomId));
      final roomData = roomEntity?.toCollection();
      if (roomData != null) {
        room = roomData;
      }
    } catch (e, stackTrace) {
      _log.e('getRoomToState error: $e', e, stackTrace);
    }
  }

  /// Get room subscription to state
  ///
  /// This function will get room subscription from local database.
  /// If there is no room subscription, then get room subscription from server.
  /// After that, the room subscription will be saved to local database.
  /// And the room subscription will be set to `roomSub` variable.
  /// TODO: implement getRoomSubscriptionToState when room subscription is not found in the local database
  Future<void> getRoomSubscriptionToState() async {
    try {
      final roomSubData = await GetIt.I<GetRoomSubscriptionUseCase>().call(ChatRoomParams(roomId: roomId));
      if (roomSubData != null) {
        roomSub = roomSubData;
      }
    } catch (e, stackTrace) {
      _log.e('getRoomSubscriptionToState error: $e', e, stackTrace);
    }
  }

  (bool, List<String>) isRead({required MessageCollection message}) {
    return GetIt.I<IsReadMessageUseCase>().call(
      IsReadMessageParams(
        messageSequence: message.sequence ?? 0,
        memberLastReadAtMap: chatRoomCtl.memberLastReadAtMap,
        memberJoinedMap: chatRoomCtl.memberJoinedMap,
        otherLastReadAt: chatRoomCtl.otherLastReadAt,
        isGroup: isGroup,
      ),
    );
  }

  /// Convert the list of visible index to the visible range
  ///
  /// This function use to convert the list of visible index to the visible range set (int, int)
  /// - To set the visibleItemRange value
  /// - The first index is the first visible item in the list(BOTTOM) and the second index is the last visible item in the list(TOP)
  /// - If the list is empty, then set the visibleItemRange to null
  (int, int)? convertListToVisibleRange(List<int> visibleIndexList) {
    if (visibleIndexList.isEmpty) {
      return null;
    }

    return (visibleIndexList.first, visibleIndexList.last);
  }

  Future<void> listControllerListenerV2(ListViewObserveModel observeModel) async {
    final visibleIndexList = observeModel.displayingChildIndexList;
    final temp = convertListToVisibleRange(visibleIndexList);
    if (temp == null) {
      return;
    }
    final msgFirst = messages.elementAtOrNull(temp.$1);
    final msgLast = messages.elementAtOrNull(temp.$2);
    if (temp.$1 <= (visibleIndexRange.value?.$1 ?? 0) || visibleIndexRange.value == null) {
      visibleIndexRange.value = temp;
      if (msgFirst != null && msgLast != null) {
        visibleItemBorder.value = (msgFirst, msgLast);
        triggerReadMessage(borderMessage: visibleItemBorder.value);
      }
    }
  }

  /// Trigger read message
  ///
  /// This function will trigger read message to the server.
  /// If the user is at the bottom of the list, then trigger read message for all message.
  ///
  /// - If it can not reach to the internet, it will not trigger read message and do nothing,
  /// the read message will be triggered when the user is back to the internet or when the user is at the bottom of the list.
  ///
  /// `NOTE:` This function is called when user scroll to the bottom of the list only.
  Future<void> readAll() async {
    final isNotChatScreen = Get.currentRoute != '/chat-room/direct/${room?.id}';
    final isAppPaused = GetIt.I<LifeCycleService>().isPaused;
    if (enableReadMessage == false || isNotChatScreen || isAppPaused) {
      return;
    }

    try {
      await GetIt.I<TriggerReadMessageUseCase>().call(
        TriggerReadMessageParams(
          roomId: roomId,
          seenMessageAt: DateTime.now(),
        ),
      );
    } on FailedHostLookupException {
      _log.w(
          'No internet connection. readAll will be triggered when the user is back to the internet or when the user is at the bottom of the list.');
    } catch (e, stackTrace) {
      _log.e('readAll error: $e', e, stackTrace);
    }
  }

  /// Callback when the scroll position of the scroll view is changed
  bool positionListener(ScrollMetricsNotification sc) {
    if (goBackToReplyMessage != null && isAtBottom) {
      clearGoBackToReplyData();
    }
    checkShowScrollToBottomFloatingButton();

    final scrollDirection = scrollController.position.userScrollDirection;

    // Get the scroll direction of the scroll view
    if (scrollDirection == ScrollDirection.idle) {
      jumpToLatestUnreadMessage().whenComplete(() {
        final pixels = scrollController.position.pixels;
        if (pixels <= 5) {
          EasyDebounce.debounce('trigger_read_all_message', const Duration(milliseconds: 100), () async {
            readAll();
          });
        }
      });
      getJumpMessage();
      triggerReadMessage();
    }

    // If the scroll direction is forward, that means the user is scrolling down then return
    else if (scrollDirection == ScrollDirection.forward) {
      if (sc.metrics.pixels <= 5) {
        EasyDebounce.debounce('trigger_read_all_message', const Duration(milliseconds: 100), () async {
          readAll();
        });
      }
      return false;
    }

    // Maximum scroll extent of the scroll view
    final maxScrollPixel = scrollController.position.maxScrollExtent;
    final shouldLoadAtPixel = maxScrollPixel * 0.8;
    // Current scroll position of the scroll view
    final pixels = scrollController.position.pixels;

    // Check if the user is at the top of the list
    final isAtTop = pixels >= shouldLoadAtPixel;
    if (isAtTop) {
      EasyThrottle.throttle(
        'get_more_message',
        const Duration(milliseconds: 500),
        () async {
          await getMoreMessageToState();
        },
      );
    }

    return false;
  }

  bool get isAtBottom {
    if (!scrollController.hasClients) {
      return false;
    }
    return scrollController.position.pixels <= scrollController.position.minScrollExtent + 20;
  }

  void checkShowScrollToBottomFloatingButton() {
    if (isAtBottom) {
      showScrollToBottomFloatingButton.value = false;
    } else {
      // If showScrollToBottomFloatingButton is false, then set it to true
      if (showScrollToBottomFloatingButton.value != true) {
        showScrollToBottomFloatingButton.value = true;
      }
    }
  }

  /// Scroll to message
  ///
  /// This function will scroll to the message in the message list view by the sequence of the message.
  ///
  /// [sliverKey] The key of the message sliver map.
  ///
  /// [messageSequence] The sequence of the message.
  ///
  /// This function will be called when the user jump to the message.
  Future<void> scrollToMessage(
    int index, {
    double alignment = 0.5,
    bool repeat = true,
  }) async {
    if (index == -1) {
      return;
    }

    // targetIndex is the index of the message in the message list view
    // why +1? because the first item in the list is the typing widget
    final targetIndex = index + 1;

    await listObserverController.jumpTo(
      index: targetIndex,
      alignment: 0.5,
      offset: (targetOffset) {
        // Calculate position of the target message in the message list view.
        // More detail: https://miro.com/app/board/uXjVPzeh_OE=/?moveToWidget=3458764634716414654&cot=14

        // Height of text field input for typing message.
        final textFieldHeight = ChatRoomTextInput.inputHeight + Get.mediaQuery.padding.bottom;
        // Height of call duration / call status app bar at the top of the screen.
        final callAppBarHeight =
            UChatCallController.instance.isShowCallStatusOverAppbar ? CallAppBarWidget.callAppBarHeight : 0;
        // Height of everything above the message list view. Including top safe area, app bar and call app bar.
        final topScreenHeight = Get.mediaQuery.padding.top + ChatRoomAppBar.size.height + callAppBarHeight;
        // Calculate the area of message list widget by subtracting the height of the text field and the top screen height
        // from the total height of the screen.
        // If Custom input or keyboard is open (Sticker or gif), Height of the message list is reduced by the height of the keyboard.
        double messageListHeight =
            Get.height - topScreenHeight - textFieldHeight - chatRoomCtl.chatRoomInputCtl.keyboardHeight;
        // Find the height of the target widget in the message list view.
        final targetWidget = listObserverController.findChildInfo(index: targetIndex);
        final targetWidgetHeight = targetWidget?.renderObject.size.height ?? 0;

        if (targetWidgetHeight > messageListHeight) {
          // If the target widget height is greater than the message list height,
          // Calculate the scroll position to align the bottom of the target widget with the bottom of the screen.
          // targetWidgetHeight / 2 is to align the bottom of the target with the bottom of the screen.
          // textFieldHeight is to push the target widget above text field. * 2.5 is to make the target widget be above
          // the scroll to bottom button and to have some more space between the target widget and the text field.
          return targetWidgetHeight / 2 + (textFieldHeight * 2.5);
        }
        // If the target widget height is greater than the message list height,
        // Calculate scroll to align the center of the target widget with the center of the screen.
        // textFieldHeight is to push the target widget to be above the text field.
        // messageListHeight * 0.5 is to align the target widget to be at the center of the screen.
        return messageListHeight * 0.5 + textFieldHeight;
      },
    );

    // check if the target message is shown in the view
    if (visibleIndexRange.value != null && repeat) {
      final (from, to) = visibleIndexRange.value!;
      final foundTargetMessageInView = from <= targetIndex && targetIndex <= to;
      if (!foundTargetMessageInView) {
        await scrollToMessage(
          index,
          alignment: alignment,
          repeat: false,
        );
      }
    }
  }

  /// Scroll to the bottom of the message list
  ///
  /// This function will scroll to the bottom of the message list view.
  /// The bottom of the message list view is the newest message in the message list.
  /// Including the message that just sent by the user (sending, sent fail, sent).
  void scrollToBottom() {
    scrollToMessage(0);
  }

  /// Find the message should show the date header or not
  ///
  /// This function will check if the message bubble should show the date header or not.
  /// - If the message is the first message in the message list, then show the date header.
  /// - If the message is not the first message in the message list, then check the time difference between the message and the previous message.
  /// - If the current message and the previous message are not the same day, then show the date header.
  bool showDateHeader({required MessageCollection message, MessageCollection? previousMessage}) {
    if (message.isSendFailed == true) {
      return false;
    }

    if (previousMessage == null) {
      return true;
    }

    final isSameDay = message.createdAt?.toLocal().isSameDay(previousMessage.createdAt!.toLocal()) ?? false;

    return isSameDay == false;
  }

  /// Find the message bubble should show the avatar or not
  ///
  /// This function will check if the message bubble should show the avatar or not.
  /// - If the message is the first message in the message list, then show the avatar.
  /// - If the message is not the first message in the message list, then check the time difference between the message and the previous message.
  /// - If the time difference is more than 1 minute, then show the avatar.
  bool shouldShowAvatar({required MessageCollection message, MessageCollection? previousMessage}) {
    if (previousMessage == null) {
      return true;
    }

    if ([MessageType.callMsg, MessageType.system, MessageType.remove, MessageType.removeOthers, MessageType.unsent]
        .contains(previousMessage.type)) {
      return true;
    }

    if (message.accountId != previousMessage.accountId) {
      return true;
    }

    final messageDiffInMinutes = message.createdAt
        ?.difference(
          previousMessage.createdAt!,
        )
        .inMinutes
        .abs();

    if (messageDiffInMinutes == null) {
      return true;
    }

    if (messageDiffInMinutes < 1 && message.accountId != previousMessage.accountId) {
      return true;
    }

    if (messageDiffInMinutes > 1) {
      return true;
    }

    return false;
  }

  /// Append or update many message to state
  ///
  /// This function will append or update many message to the message list.
  /// - If the message is not found in the message list, then append the message to the message list.
  /// - If the message is found in the message list, then update the message in the message list.
  ///
  /// [newMessages] The list of new messages to append or update to the message list.
  Future<void> getSendingMessageToState() async {
    try {
      final getSendingMessageResult = await GetIt.I<GetSendingMessageUseCase>().call(ChatRoomParams(roomId: roomId));

      // Convert entities to collections
      final messageSending = getSendingMessageResult.$1;
      final messageSentFailed = getSendingMessageResult.$2;

      // Check if there is any failed message
      if (messageSentFailed.isNotEmpty) {
        // If there is any failed message, then set the room has failed message to true
        room?.hasFailedMessage = true;
        eventBus.fire(ToggleFailedMessageEvent(roomId: roomId, show: true));
      } else {
        // If there is no failed message, then set the room has failed message to false
        room?.hasFailedMessage = false;
        eventBus.fire(ToggleFailedMessageEvent(roomId: roomId, show: false));
      }

      await appendSendingAndFailedMessageToState(messageSending, refreshListController: false);
      await appendSendingAndFailedMessageToState(messageSentFailed, refreshListController: false);
    } catch (e, stackTrace) {
      _log.e('getSendingMessageToState error: $e', e, stackTrace);
    }
  }

  /// Get message to state
  /// This function will get message from local database.
  /// If there is no message or message is not reach limit, then get message from server.
  /// After that, the message will be saved to local database.
  /// And the message will be added to `messages` list.
  ///
  /// This function will set `isMessageLoading` to true when loading message from server.
  /// And set `isMessageLoading` to false when finish loading message from server.
  ///
  /// - This function will be called when the controller is [initialized].
  ///
  /// - This function will be called when the user scroll to the top of the message list.
  Future<void> getMessageToState() async {
    await ChatRoomTracer.trace(
      name: ChatRoomTraceNames.messageLoad,
      initialAttributes: {
        ChatRoomAttributeNames.roomId: roomId,
        ChatRoomAttributeNames.chatType: isGroup ? 'group' : 'direct',
        ChatRoomAttributeNames.dataType: 'server',
        ChatRoomAttributeNames.loadSize: UChatConstant.messageLoadLimitInitial.toString(),
      },
      body: (trace) async {
        try {
          isLoadingMessage.value = true;

          final fetchStopwatch = Stopwatch()..start();
          final newMessageEntities = await GetIt.I<GetAllSentMessageUseCase>().call(
            GetAllSentMessageParams(
              roomId: roomId,
              sequenceOfVeryFirstMessageInRoom: sequenceOfVeryFirstMessageInRoom,
              useDefaultMessageLoadLimit: false,
              limit: UChatConstant.messageLoadLimitInitial,
            ),
          );
          fetchStopwatch.stop();

          if (newMessageEntities.isNotEmpty) {
            // Convert entities to collections
            final newMessages = newMessageEntities.map((e) => e.toCollection()).toList();
            messages.value = appendOrUpdateManyMessageToState(
              newMessages,
              messages(),
              failedMessages.length,
              refreshListController: false,
              messageListController: this,
            );
            messages.refresh();
          }

          // Find the index of the last read message in the message list
          await findLastReadMessageIndex();
          _logMessageStateAfterInitialLoad();

          trace.incrementMetric(ChatRoomMetricNames.firstRenderTimeMs, fetchStopwatch.elapsedMilliseconds);
          trace.incrementMetric(ChatRoomMetricNames.fullLoadTimeMs, fetchStopwatch.elapsedMilliseconds);
          trace.incrementMetric(ChatRoomMetricNames.messageCount, newMessageEntities.length);
          trace.incrementMetric(ChatRoomMetricNames.fileSizeMb, _calculateTotalFileSizeMb(newMessageEntities));
        } catch (e, stackTrace) {
          _log.e('getMessageToState error: $e', e, stackTrace);
        } finally {
          isLoadingMessage.value = false;
        }
      },
    );
  }

  /// Get more message to state
  ///
  /// This function will get more message from local database.
  /// But if there is no more previous message in local database, then get more message from server.
  /// After that, the message will be added to `messages` list.
  /// And notify the list controller that the item has been added to update the list view.
  ///
  /// This function will set `isLoadingPreviousMessage` to true when loading more message.
  Future<void> getMoreMessageToState({bool refreshListController = true}) async {
    if (isLoadingPreviousMessage.value) {
      return;
    }

    // If the sequence of the top message is less than or equal to 0, return
    if (sequenceOfTopMessage <= 0) {
      return;
    }

    // If there is no more previous message to load, return
    if (!hasMoreMessage) {
      return;
    }

    await ChatRoomTracer.trace(
      name: ChatRoomTraceNames.olderMessageLoad,
      initialAttributes: {
        ChatRoomAttributeNames.roomId: roomId,
        ChatRoomAttributeNames.chatType: isGroup ? 'group' : 'direct',
        ChatRoomAttributeNames.dataType: 'server',
      },
      body: (trace) async {
        isLoadingPreviousMessage.value = true;

        final fetchStopwatch = Stopwatch()..start();
        final moreMessageEntities = await GetIt.I<GetAllSentMessageUseCase>().call(GetAllSentMessageParams(
          roomId: roomId,
          sequenceLessThan: sequenceOfTopMessage,
          sequenceGreaterThan: roomSubOldestMsgSeq,
          sequenceOfVeryFirstMessageInRoom: sequenceOfVeryFirstMessageInRoom,
        ));
        fetchStopwatch.stop();

        // Convert entities to collections
        final moreMessages = moreMessageEntities.map((e) => e.toCollection()).toList();
        messages.value = appendOrUpdateManyMessageToState(
          moreMessages,
          messages(),
          failedMessages.length,
          refreshListController: refreshListController,
          messageListController: this,
        );
        messages.refresh();

        isLoadingPreviousMessage.value = false;

        trace.incrementMetric(ChatRoomMetricNames.olderMessageLoadTimeMs, fetchStopwatch.elapsedMilliseconds);
        trace.incrementMetric(ChatRoomMetricNames.messageCount, moreMessageEntities.length);
        trace.incrementMetric(ChatRoomMetricNames.fileSizeMb, _calculateTotalFileSizeMb(moreMessageEntities));
      },
    );
  }

  /// Jump to the message
  ///
  /// This function will jump to the message in the message list view by the sequence of the message.
  /// If the message is not found in the list, then get more message from the server.
  /// After that, the message will be jump to the message in the message list view.
  /// If [goBackTo] is not null, displays the "Go Back to Reply" button, which, when pressed, jumps to the specified message.
  Future<void> jumpToMessage(MessageCollection message,
      {MessageCollection? goBackTo, bool shakeMessage = false}) async {
    // If the jump to message function still running, do nothing for incoming call

    if (message.isParentDeleted == true) {
      UChatNewDialog.showJumpMessageUnavailableDialog(context: Get.context!);
      return;
    }

    if (fetchingMoreMessageInJumpingToMessage == true) {
      return;
    }
    try {
      // Set that jump to message is running
      fetchingMoreMessageInJumpingToMessage = true;

      // If the message sequence is null, return
      if (message.sequence == null) {
        return;
      }

      // Get the sequence of the target message
      final targetMessageSequence = message.sequence!;
      if (targetMessageSequence <= 0) {
        return;
      }

      // If the target message is older than the very first message in the room, then show dialog and return
      if (targetMessageSequence < sequenceOfVeryFirstMessageInRoom) {
        UChatNewDialog.showJumpMessageUnavailableDialog(context: Get.context!);
        return;
      }

      // Find the index of the message in the message list by the sequence of the message
      final messageIndex = findMessageIndexBySequence(targetMessageSequence);

      // If the message is found in the current message list, then scroll to the message immediately
      // Else if the message is not found in the current message list, then get more message from the server
      if (messageIndex >= 0) {
        await scrollToMessage(messageIndex);

        if (shakeMessage) {
          this.shakeMessage(message.ref);
        }

        if (goBackTo != null) {
          saveGoBackToReplyData(goBackTo);
        }
      } else {
        chatRoomCtl.isRoomLoading.value = true;
        // Check if the target message is older than the top message in the list
        // The top message is the oldest message in the current message list
        final isTargetOlderTopSequence = targetMessageSequence < sequenceOfTopMessage;
        // Check if the target message is newer than the very first message in the room
        // The very first message is the oldest message in the room
        final isTargetNewerVeryFirstSequence = targetMessageSequence > sequenceOfVeryFirstMessageInRoom;

        int foundMessageIndex = -1;
        bool shouldLoadMoreMessage = isTargetOlderTopSequence || isTargetNewerVeryFirstSequence;
        bool foundMessage = false;

        // Get more message from the server until the target message is found
        while (!foundMessage && shouldLoadMoreMessage && fetchingMoreMessageInJumpingToMessage) {
          await getMoreMessageToState();
          foundMessageIndex = findMessageIndex(message, messages());
          if (foundMessageIndex >= 0) {
            foundMessage = true;
            await getMoreMessageToState();
            break;
          }
          if (!Get.currentRoute.startsWith(Routes.chatRoomRoot)) {
            break;
          }
          if (targetMessageSequence >= sequenceOfTopMessage) {
            // If the target message is newer than the top message, then break the loop
            break;
          }
        }

        if (foundMessageIndex != -1) {
          await scrollToMessage(foundMessageIndex);
          chatRoomCtl.isRoomLoading.value = false;

          if (shakeMessage) {
            this.shakeMessage(message.ref);
          }

          if (goBackTo != null) {
            saveGoBackToReplyData(goBackTo);
          }
        }
      }
    } catch (e, stacktrace) {
      _log.e('Error on jumpToMessage', e, stacktrace);
    } finally {
      fetchingMoreMessageInJumpingToMessage = false;
      chatRoomCtl.isRoomLoading.value = false;
    }
  }

  void saveGoBackToReplyData(MessageCollection message) {
    goBackToReplyMessage = message;
    chatRoomCtl.updateShowGoBackToReplyButton(true);
  }

  void clearGoBackToReplyData() {
    goBackToReplyMessage = null;
    chatRoomCtl.updateShowGoBackToReplyButton(false);
  }

  Future<void> goBackToReply() async {
    if (goBackToReplyMessage != null) {
      String? shakeRef = goBackToReplyMessage?.ref;
      await jumpToMessage(goBackToReplyMessage!);
      shakeMessage(shakeRef);
      clearGoBackToReplyData();
    }
  }

  /// Find message index by sequence in message map
  ///
  /// This function will find the index of the message in the message list by the sequence of the message.
  ///
  /// [sequence] The sequence of the message.
  int findMessageIndexBySequence(int sequence) {
    return messages.indexWhere((msgElement) => msgElement.sequence == sequence);
  }

  /// Find a message by its sequence number
  ///
  /// If the message is not found, return null
  ///
  /// [sequence] The sequence number of the message
  MessageCollection? findMessageBySequence(int sequence) {
    return messages.firstWhereOrNull((element) => element.sequence == sequence);
  }

  /// Find the index of the last read message in the message list
  ///
  /// This function will find the index of the last read message in the message list.
  Future<void> findLastReadMessageIndex() async {
    final unreadCountInRoom = chatRoomCtl.unreadCount.value;
    final myLastReadAt = chatRoomCtl.myLastReadAt.value;
    final currentUserId = UserController.instance.currentUser.value?.id;

    if (currentUserId == null) {
      return;
    }

    final (latestReadIndex, latestReadRef) = await GetIt.I<FindLastReadMessageIndexUseCase>().call(
      FindLastReadMessageIndexParams(
        lastReadAt: myLastReadAt,
        currentMessageList: messages,
        unreadCount: unreadCountInRoom,
        currentUserId: currentUserId,
      ),
    );

    lastReadMessageIndex.value = latestReadIndex;
    lastReadMessageRef.value = latestReadRef;
  }

  int? waitingInDebounceSeq;

  void triggerReadMessage({(MessageCollection, MessageCollection)? borderMessage}) {
    if (waitingInDebounceSeq == null) {
      waitingInDebounceSeq = borderMessage?.$1.sequence;
    } else {
      if (borderMessage?.$1.sequence != null && borderMessage!.$1.sequence! >= waitingInDebounceSeq!) {
        waitingInDebounceSeq = borderMessage.$1.sequence;
      }
      // This condition and return is to ensure that the debounce will trigger read message with the latest seq
      // even if triggerReadMessage is called multiple times in a short period of time.
      // Example : This user end group call and call screen is closed
      // - triggerReadMessage is called from function [onNewMessageComingFromServer] with borderMessage seq 100
      // - triggerReadMessage is called from function [onNewMessageComingFromServer] with borderMessage seq 101
      // - triggerReadMessage is called from [ChatRoomNavigatorObserver] with borderMessage seq 100
      // Because debounce will wait for a bit then the last call will be executed. This will make the app trigger read
      // message with seq 100, which is not the latest seq 101.
      else if (borderMessage?.$1.sequence != null && borderMessage!.$1.sequence! < waitingInDebounceSeq!) {
        return;
      }
    }
    EasyDebounce.debounce(
      'trigger_read_message_$roomId',
      const Duration(milliseconds: 100),
      () async {
        await GetIt.I<TriggerReadMessageV2UseCase>().call(
          TriggerReadParams(
            messages: messages,
            room: room,
            listObserverController: listObserverController,
            scrollController: scrollController,
            enableReadMessage: enableReadMessage,
            lastReadMessageIndex: lastReadMessageIndex.value,
            visibleItemBorder: borderMessage ?? visibleItemBorder.value,
            myLastReadAt: chatRoomCtl.myLastReadAt.value,
            visibleIndexRange: visibleIndexRange.value,
            chatRoomCtlTriggerReadMessage: (messageCreatedAt) async {
              await chatRoomCtl.triggerReadMessage(messageCreatedAt);
            },
            onLastReadMessageIndexCallback: (index) {
              lastReadMessageIndex.value = index;
            },
          ),
        );
      },
    );
  }

  Future<void> appendSendingAndFailedMessageToState(
    List<MessageCollection> incomingMessages, {
    bool refreshListController = true,
  }) async {
    incomingMessages.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
    for (final message in incomingMessages) {
      try {
        MessageBinding.put(message);
        if (message.isSendFailed == true) {
          failedMessages.insert(0, message);
        }
        messages.insert(0, message);
        messages.refresh();
      } catch (e, stackTrace) {
        _log.e('appendSendingAndFailedMessageToState error: $e', e, stackTrace);
      }
    }
  }

  ///
  /// For case tap native notification to opened chat room
  /// fix not get messages from local db
  ///
  Future<void> onChatRoomRequiredLoadNewMessageFromDb(RequireLoadNewMessageFromDbEvent event) async {
    final messageRoomId = event.roomId;

    if (roomId != messageRoomId) {
      return;
    }

    _loadLatestMessageFromDb();
  }

  ///
  /// This is method for reuse when want to load latest message from db
  ///
  void _loadLatestMessageFromDb() async {
    messageAddingQueue.addJob(
      (_) async {
        await _trackQueueJob('_loadLatestMessageFromDb', () async {
          final newMessageEntities = await GetIt.I<MessageLocalRepository>().getAllSentMessage(
            roomId: roomId,
            sequenceGreaterThan: messages.firstOrNull?.sequence,
          );

          for (final newEntity in newMessageEntities) {
            final newMessage = newEntity.toCollection();
            messages.value = appendOrUpdateMessageToState(
              newMessage,
              messages(),
              failedMessages.length,
              chatObserver: chatObserver,
              messageListController: this,
            );
          }

          messages.refresh();
          triggerReadMessage();
        });
      },
      label: '_loadLatestMessageFromDb',
    );
  }

  /// Callback when new message is coming from the server
  ///
  /// This function will be called when the new message is coming from the server.
  /// The new message will be added to the message list.
  ///
  /// This function will be called when the user is in the chat room.
  Future<void> onNewMessageComingFromServer(MessageNewEvent event) async {
    final newMessage = event.message;
    final messageRoomId = newMessage.roomId;

    if (roomId != messageRoomId) {
      return;
    }

    /// Return if [newMessage] is older than [roomSubOldestMsgSeq]
    if ((newMessage.sequence ?? 0) <= (roomSubOldestMsgSeq ?? 0)) return;

    messageAddingQueue.addJob(
      (_) async {
        await _trackQueueJob('onNewMessageComingFromServer-${newMessage.ref}', () async {
          final localMessageEntities = await GetIt.I<MessageLocalRepository>().getAllSentMessage(
            roomId: roomId,
            sequenceGreaterThan: messages.firstOrNull?.sequence,
          );

          // Convert entities to collections
          final localMessages = localMessageEntities.map((e) => e.toCollection()).toList();

          // The logic for debug to find why have missing message
          if (localMessages.length > 1) {
            useLogger().sendTroubleshootMessage(topic: 'chat_room_missing_message_rendered', data: {
              'room_id': roomId,
              'message_count': localMessages.length,
              'last_message_sequence': messages.firstOrNull?.sequence,
              'new_message_sequence': newMessage.sequence,
            });
          }

          // Add the new message to the local message list, cause expect the new message already in the local message list.
          localMessages.add(newMessage);

          for (final newMessage in localMessages) {
            messages.value = appendOrUpdateMessageToState(
              newMessage,
              messages(),
              failedMessages.length,
              chatObserver: chatObserver,
              isNewMsgFromServer: true,
              messageListController: this,
            );
          }

          messages.refresh();
          if (isAtBottom) {
            triggerReadMessage(borderMessage: (newMessage, visibleItemBorder.value?.$2 ?? newMessage));
          } else {
            triggerReadMessage();
          }
        });
      },
      label: 'onNewMessageComingFromServer-${newMessage.ref}',
    );
  }

  /// Callback when adding local message
  ///
  /// This function will be called when the local message is added to the message list.
  void onAddingLocalMessage(AddMessageToStateEvent event) {
    if (event.message.roomId != roomId) {
      return;
    }

    final newMessage = event.message;
    messageAddingQueue.addJob(
      (_) async {
        await _trackQueueJob('onAddingLocalMessage-${newMessage.ref}', () async {
          messages.value = appendOrUpdateMessageToState(
            newMessage,
            messages(),
            failedMessages.length,
            chatObserver: chatObserver,
            messageListController: this,
          );
          messages.refresh();
          if (newMessage.mine && !isAtBottom) {
            await scrollToMessage(0);
          }
        });
      },
      label: 'onAddingLocalMessage-${newMessage.ref}',
    );
  }

  /// Callback when adding failed message
  ///
  /// This function will be called when the failed message is added to the message list.
  Future<void> onAddingFailedMessageToState(AddFailedMessageToStateEvent event) async {
    if (event.message.roomId != roomId) {
      return;
    }

    final failedMessage = event.message;

    final isExist = failedMessages.any((element) => element.ref == failedMessage.ref);

    if (isExist) {
      return;
    }

    // And then add the failed message to the message list, by add it at the bottom of the list
    messages.value = appendOrUpdateMessageToState(
      failedMessage,
      messages(),
      failedMessages.length,
      chatObserver: chatObserver,
      messageListController: this,
    );
    messages.refresh();
    // If the failed message is sent failed and not sending, then add the failed message to the failed message list
    if (failedMessage.isSendFailed == true && failedMessage.isSending == false) {
      failedMessages.add(failedMessage);
    }
  }

  /// Callback when the message is updated
  ///
  /// This function will be called when the message is updated.
  void onMessageUpdated(MessageUpdateEvent event) {
    final updatedMessage = event.message;
    final messageRoomId = updatedMessage.roomId;

    if (roomId == messageRoomId) {
      messageAddingQueue.addJob((_) async {
        await _trackQueueJob('onMessageUpdated-${updatedMessage.ref}', () async {
          messages.value = appendOrUpdateMessageToState(
            updatedMessage,
            messages(),
            failedMessages.length,
            chatObserver: chatObserver,
            messageListController: this,
          );
          messages.refresh();
          triggerReadMessage();
        });
      }, label: 'onMessageUpdated-${updatedMessage.ref}');
    }
  }

  /// Callback when room member is deleted
  ///
  /// This function will be called when the room member is deleted.
  /// The function will remove account data from the message list.
  void onRoomMemberDeleted(RemoveRoomMemberEvent event) {
    final roomId = event.roomId;
    final isAccountDeleted = event.isAccountDeleted;
    if (this.roomId != roomId || isAccountDeleted == false) {
      return;
    }
    final deletedAccountIds = event.memberIds;
    bool needRefresh = false;
    for (final message in messages) {
      if (deletedAccountIds.contains(message.accountId)) {
        message.account?.isDeleted = true;
        message.account?.displayName = null;
        message.account?.nickname = null;
        needRefresh = true;
      }
    }
    if (needRefresh) {
      messages.refresh();
    }
  }

  /// Update typing member
  ///
  /// This function will update the typing member in the typing member map.
  /// - If the typing member is not found in the typing member map, then add the typing member to the typing member map.
  /// - If the typing member is found in the typing member map, then update the typing member in the typing member map.
  ///
  /// This function will be called when the user is typing in the chat room.
  Future<void> updateTypingMember(MemberTypingModel typingMember) async {
    try {
      MemberTypingModel memberTyping = typingMember;

      /// If the last type at of the typing member is null, return.
      /// Assume that the typing member is not typing
      if (memberTyping.lastTypeAt == null) {
        return;
      }

      final accountId = memberTyping.accountId;
      final member = typingMemberMap.value[accountId];

      /// Calculate the typing diff in seconds
      final typingDiffInSeconds = DateTime.now().differenceInSeconds(memberTyping.lastTypeAt!);
      int timerDurationInSeconds = (UChatConstant.typingTimeOutInSeconds - typingDiffInSeconds).ceil();

      /// If the typing diff in seconds is less than or equal to 0, then remove the typing member from the typing member map
      if (timerDurationInSeconds <= 0) {
        /// Remove typing member from the typing member map
        /// if this key is not found in the typing member map, this is not effect anything
        typingMemberMap.value.remove(accountId);
        typingMemberMap.refresh();
        return;
      }

      /// If the timer duration in seconds is greater than the typing time out in seconds, then set the timer duration to the typing time out in seconds
      /// Typing time out in seconds is the maximum time that the typing member can be shown in the typing member list
      if (timerDurationInSeconds > UChatConstant.typingTimeOutInSeconds) {
        timerDurationInSeconds = UChatConstant.typingTimeOutInSeconds;
      }

      if (member == null) {
        /// If the typing member is not found in the typing member map, then add the typing member to the typing member map
        if (typingMember.isTyping == false) {
          /// If the typing member is not typing, return
          return;
        }

        /// New typing member
        /// - Add typing member to the typing member map
        /// - Set new timer to remove the typing member from the typing member map after 8 seconds
        timerTypingMap.value[accountId] = Timer(
          Duration(seconds: timerDurationInSeconds),
          () {
            typingMemberMap.value.remove(accountId);
            typingMemberMap.refresh();
          },
        );
        typingMemberMap.value[accountId] = memberTyping;
        typingMemberMap.refresh();
      } else {
        /// If the typing member is found in the typing member map, then update the typing member in the typing member map
        if (typingMember.isTyping == false) {
          /// If the typing member is not typing, then remove the typing member from the typing member map
          timerTypingMap.value[accountId]?.cancel();
          typingMemberMap.value.remove(accountId);
          typingMemberMap.refresh();
          return;
        }

        /// Update typing member
        /// - Update the last type at of the typing member
        /// - Reset the timer to remove the typing member from the typing member map after 8 seconds
        timerTypingMap.value[accountId]?.cancel();
        timerTypingMap.value[accountId] = Timer(
          Duration(seconds: timerDurationInSeconds),
          () {
            timerTypingMap.value[accountId]?.cancel();
            typingMemberMap.value.remove(accountId);
            typingMemberMap.refresh();
          },
        );
        typingMemberMap.value[accountId] = member;
        typingMemberMap.refresh();
      }
    } catch (e, stackTrace) {
      _log.e('updateTypingMember error: $e', e, stackTrace);
    }
  }

  Future<void> updateFileList({bool init = false, required String eventFileId}) async {
    try {
      for (int i = 0; i < messages.length; i++) {
        MessageCollection message = messages[i];

        if (message.type != MessageType.file) continue;

        MessageFileModel file = message.file!;
        final fileId = file.id;

        if (fileId == null || fileId != eventFileId) {
          continue;
        }

        final msgTypeFileCtl = Get.find<MessageTypeFileV2Controller>(tag: MessageBinding.getMessageTypeTag(message));

        MessageFileModel messageFile = MessageFileModel(
          name: file.name,
          createdAt: file.createdAt,
          id: file.id,
          roomId: file.roomId,
          size: file.size,
          messageId: file.messageId,
          accountId: file.accountId,
          url: file.thumbnailFileId,
          isPasswordProtected: file.isPasswordProtected,
        );

        final fileDownloaderService = FileDownloaderService.instance;

        if (init == true) {
          await fileDownloaderService.deleteTask(fileId);
        }

        final record = await fileDownloaderService.getTaskRecordByFileId(fileId);
        if (record != null) {
          messageFile.downloadProgress = record.progress * 100;
          msgTypeFileCtl.downloadProgress.value = record.progress;
          messageFile.downloadStatus = FileDownloadStatus.fromTaskStatus(record.status);
          msgTypeFileCtl.message.value?.files = [messageFile];
          msgTypeFileCtl.message.refresh();
        }
      }

      messages.refresh();
    } catch (e, stackTrace) {
      _log.e('updateFileList error.', e, stackTrace);
    }
  }

  /// Handle download failed event
  ///
  /// This function will show appropriate dialog based on the failure reason:
  /// - If offline: Show "You are offline" dialog
  /// - Otherwise: Show general error dialog
  void _handleDownloadFailed() {
    if (Get.context == null) return;

    if (ConnectivityController.instance.isOffline) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } else {
      UChatNewDialog.showGeneralErrorDialog(context: Get.context!);
    }
  }

  Future<void> handleTapFile(MessageFileModel file) async {
    try {
      final fileService = FileService.instance;
      final fileDownloaderService = FileDownloaderService.instance;
      String filePath = '';
      bool openAfterDownloaded = true;

      filePath = await fileService.mobileFileSavePath(
        roomId: file.roomId ?? '',
        fileId: file.id ?? '',
        fileName: file.name ?? '',
      );
      final fileExist = await File(filePath).exists();
      if (fileExist) {
        await fileService.openFile(filePath);
        return;
      } else {
        if (ConnectivityController.instance.isOffline) {
          UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
          return;
        }
      }

      await fileDownloaderService.downloadFile(
        fileId: file.id!,
        url: file.apiFileUrl ?? '',
        filePath: filePath,
        fileSize: file.size!,
        openWhenCompleted: openAfterDownloaded,
      );
    } catch (e, stackTrace) {
      _log.e('handleTapFile error.', e, stackTrace);
      UChatNewDialog.showSingleButtonDialog(
        context: Get.context!,
        title: 'Unable to open File'.tr,
        description:
            'This file type is not supported. Check the supported format or try opening it with another app'.tr,
        confirmText: 'Got it'.tr,
        confirmTextColor: Get.context!.theme.appColors.textPrimary,
      );
    }
  }

  /// Remove failed message
  ///
  /// This function will remove the failed message from the failedMessages list and the message list.
  ///
  /// [message] The message that is failed to send.
  Future<void> onRemoveFailedMessage(MessageCollection message) async {
    try {
      if (message.ref != null) {
        await GetIt.I<RemoveFailedMessageUseCase>().call(RemoveFailedMessageParams(message: message));

        // remove message from failedMessages list
        if (failedMessages.isNotEmpty) {
          failedMessages.removeWhere((e) => e.ref == message.ref);
        }
        failedMessages.refresh();

        // remove message from state
        messages.value = removeMessageFromState(message, messages());
        messages.refresh();
      }

      // update room hasFailedMessage to false if failedMessages list is empty
      if (failedMessages.isEmpty && message.roomId != null) {
        eventBus.fire(ToggleFailedMessageEvent(roomId: message.roomId!, show: false));
      }
    } catch (e, stackTrace) {
      _log.e('Failed to remove message', e, stackTrace);
    }
  }

  /// Resend message
  ///
  /// This function will resend the message.
  /// - If the message is a file message, then resend the file message.
  /// - If the message is not a file message, then resend the message with the same content.
  ///
  /// [message] The message that is to send.
  /// [isFailedMessage] If the message is a failed message, then remove the message from the failed message list.
  Future<void> onResendMessage(MessageCollection message, {bool isFailedMessage = true}) async {
    // 1. Update the message's state in the UI and local DB to show it's sending.
    final updatedMessage = await _updateMessageStateForResending(message);

    // 2. Send a tracking event for the resend action.
    final String mediaType = EventProperty.getMessageTypeForEventParams(message.type!);
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.resentMessage,
      eventProperties: EventProperty.resentMessage(EventProperty.getChatTypeForEventParams(room), mediaType),
    );

    // 3. Delegate the actual sending logic based on message type.
    if ([MessageType.image, MessageType.video, MessageType.audio, MessageType.file].contains(message.type)) {
      await _resendMediaMessage(message);
    } else {
      await _resendTextMessage(updatedMessage);
    }
  }

  /// Helper to update the message state in the local database and the UI.
  /// This consolidates the logic that was repeated in both the 'if' and 'else' blocks.
  Future<MessageCollection> _updateMessageStateForResending(MessageCollection message) async {
    failedMessages.removeWhere((e) => e.ref == message.ref);

    // If there are no more failed messages, update the room state accordingly.
    // To clear failed message indicator in the UI on the chat list item, chat list screen.
    if (failedMessages.isEmpty && message.roomId != null) {
      eventBus.fire(ToggleFailedMessageEvent(roomId: message.roomId!, show: false));
    }

    // Remove the old message instance from the messages list, as it will be replaced.
    messages.value = removeMessageFromState(message, messages());
    messages.refresh();

    final msg = message.copyWith(
      isSendFailed: false,
      isSending: true,
    );
    // Update in local database
    final localDb = GetIt.I<MessageLocalRepository>();
    await localDb.putMessage(message: msg.toEntity());

    // Update in UI state
    onAddingLocalMessage(AddMessageToStateEvent(message: msg));

    // Replace the old message instance in the messages list
    final index = messages.indexOf(message);
    if (index != -1) {
      messages[index] = msg;
    }

    return msg;
  }

  /// Helper to handle the specific logic for resending media (files, images, etc.).
  Future<void> _resendMediaMessage(MessageCollection message) async {
    final files = message.files;
    if (files == null || files.isEmpty) return;

    final fileInfoList = await _prepareFileInfoList(files, message.type!);
    if (fileInfoList.isEmpty) return;

    GetIt.I<SendFileMessageToServerUseCase>().processMessages(
      fileInfoList: fileInfoList,
      params: SendFileMessageParams(
        chatRoomId: message.roomId!,
        files: fileInfoList,
        isSending: roomId == message.roomId,
        isLocked: false,
        isMyNote: false,
        enableUploadPro: UserController.instance.enableUploadPro,
        isResend: true,
        messageRef: message.ref,
      ),
      msg: message.toEntity(),
    );
  }

  /// Processes a list of MessageFile objects into FileInfoModel objects.
  /// This logic is specific to media messages and is cleanly separated.
  Future<List<FileInfoModel>> _prepareFileInfoList(List<MessageFileModel> files, MessageType type) async {
    final List<FileInfoModel> fileInfoList = [];
    for (int index = 0; index < files.length; index++) {
      final file = files.elementAtOrNull(index);
      if (file == null) continue;

      FileInfoModel fileInfo = FileInfoModel.fromMessageFile(file);
      fileInfoList.add(fileInfo);
    }
    return fileInfoList;
  }

  /// Helper to handle the specific logic for resending a standard text message.
  Future<void> _resendTextMessage(MessageCollection message) async {
    GetIt.I<SendMessageToServerUseCase>().call(
      SendMessageToServerParams(
        chatRoomId: roomId,
        isSecretRoom: room?.roomType == RoomType.directSecret,
        message: message,
        accountId: UserController.instance.currentUser.value!.id!,
        isSending: true,
        isShare: false,
        replyMessage: message.replyMessage,
        roomCryptoKey: await room?.getRoomCryptoKeyObj(),
        isResend: true,
        messageRef: message.ref,
      ),
    );
  }

  Future<void> onResendFailedMessageWithDialog(MessageCollection message) async {
    try {
      UChatNewDialog.showResendFailedMessageDialog(
        context: Get.context!,
        title: 'Sending failed'.tr,
        onResend: () async {
          await onResendMessage(message);
        },
        onDelete: () {
          onRemoveFailedMessage(message);
        },
      );
    } catch (e, stackTrace) {
      _log.e('onResendFailedMessageWithDialog error.', e, stackTrace);
    }
  }

  /// if message type image is UNSENT, REMOVED some file in message (NOT ALL), we need to update file list
  void _onUpdateMessageTypeImagesCtlList({
    required MessageCollection? message,
  }) {
    try {
      if (message == null) return;

      final ref = message.ref;
      final files = message.files;
      final type = message.type?.value ?? 'image';
      final tag = '$type-$ref';

      if (type != MessageType.image.value || !Get.isRegistered<MessageTypeImageV2Controller>(tag: tag)) return;

      final ctl2 = Get.find<MessageTypeImageV2Controller>(tag: tag);
      ctl2.messageFiles.value = files ?? [];
      ctl2.messageFiles.refresh();
    } catch (e, stackTrace) {
      _log.e('onUpdateImages error.', e, stackTrace);
    }
  }

  void onUnsentOrRemoveMessageLocal(UnsentOrRemoveImagesLocalEvent event) {
    final message = messages.firstWhereOrNull((element) => element.id == event.id);
    if (message == null) {
      return;
    }

    if (message.files?.length == event.removedFileIds.length) {
      // remove the whole message.
      return;
    }

    _onUpdateMessageTypeImagesCtlList(message: message);
  }

  Future<void> handleProfile(ContactModel contact) async {
    await GetIt.I<ProfileService>().openProfileScreen(
      contactId: contact.id!,
    );
  }

  String getContactName(MessageCollection message) {
    String? contactName;

    try {
      contactName = GetIt.I<GetContactNameUseCase>().call(ContactNameParams(
        roomId: roomId,
        accountId: message.account?.id ?? '',
        isShowFullName: true,
      ));
    } catch (e, stackTrace) {
      _log.e('getContactName error.', e, stackTrace);
    }

    return contactName ?? message.account?.shortName ?? 'UNKNOWN'.tr;
  }

  Future<void> onReplyTap(MessageCollection? message) async {
    try {
      if (message == null) return;

      if (message.replyMessage == null && message.isParentDeleted == false) return;

      if (message.isParentDeleted == true ||
          (message.replyMessage?.type == MessageType.system &&
              message.replyMessage?.systemMessage?.type == MessageSystemType.unSentMessage)) {
        UChatNewDialog.showSingleButtonDialog(
          context: Get.context!,
          title: 'Unavailable to see message'.tr,
          description: 'The message you find may no longer be available as it may have been unsent or deleted.'.tr,
          confirmText: 'Got it'.tr,
          confirmTextColor: Get.theme.appColors.textPrimary,
        );
      } else {
        final replyMsg = message.replyMessage?.toCollection();
        if (replyMsg != null) {
          String? shakeRef = replyMsg.ref;
          await jumpToMessage(replyMsg, goBackTo: message);
          shakeMessage(shakeRef);
        }
      }
    } catch (e, stackTrace) {
      _log.w('onReplyTap error.', e, stackTrace);
    }
  }

  void shakeMessage(String? messageRef) {
    if (messageRef == null) return;

    final message = messages.firstWhereOrNull((m) => m.ref == messageRef);
    if (message != null) {
      final tag = MessageBinding.getContainerTag(message);
      if (Get.isRegistered<MessageContainerController>(tag: tag)) {
        final messageContainerCtl = Get.find<MessageContainerController>(tag: tag);
        messageContainerCtl.shakeIt();
      }
    }
  }

  void onPlayNewMessageAnimation(PlayNewMessageAnimationEvent event) {
    if (roomId != event.message.roomId) return;

    // Check if animation has already been played for this message
    final messageRef = event.message.ref;
    if (messageRef == null || animatedMessageRefs.contains(messageRef)) {
      return;
    }

    // Skip animation if another animation is currently playing
    if (isAnimating.value) {
      animatedMessageRefs.add(messageRef); // Mark as processed to prevent future attempts
      return;
    }

    // Add message ref to the set to prevent duplicate animations
    animatedMessageRefs.add(messageRef);

    // Set animation state
    isAnimating.value = true;
    animateMessageRef.value = messageRef;
    isAllowedAnimation.value = true;
  }

  void onResetAnimation() {
    final currentAnimatingRef = animateMessageRef.value;

    isAllowedAnimation.value = false;
    animateMessageRef.value = null;
    isAnimating.value = false; // Reset animation state to allow new animations

    // Process any pending updates for the message that just finished animating
    if (currentAnimatingRef != null && pendingMessageUpdates.containsKey(currentAnimatingRef)) {
      final pendingUpdate = pendingMessageUpdates[currentAnimatingRef];
      pendingMessageUpdates.remove(currentAnimatingRef);

      // Find and update the message
      final messageIndex = messages.indexWhere((msg) => msg.ref == currentAnimatingRef);
      if (messageIndex != -1 && pendingUpdate != null) {
        messages[messageIndex].update(pendingUpdate);
        _onUpdateMessageTypeImagesCtlList(message: pendingUpdate);
      }
    }
  }

  Future<void> onPinMessage(MessageCollection message) async {
    await _togglePinStatus(message, isPinned: true);
  }

  Future<void> onUnpinMessage(MessageCollection message) async {
    await _togglePinStatus(message, isPinned: false);
  }

  Future<void> _togglePinStatus(MessageCollection message, {required bool isPinned}) async {
    // MOCK
    // TODO: call use case to pin/unpin message
    final index = messages.indexWhere((element) => element.id == message.id);
    if (index != -1) {
      messages[index].isPinned = isPinned;
      messages.refresh();
    }
  }

  /// Logs message state after initial message load
  /// This helps debug race conditions by comparing database state with UI state
  Future<void> _logMessageStateAfterInitialLoad() async {
    try {
      final logger = GetIt.instance<NotificationLogger>();

      if (!logger.isEnabled) {
        return;
      }

      useLogger().d('Logging message state after initial load for room: $roomId');

      // Get 10 most recent messages from database
      List<MessageCollection> databaseMessages = [];
      int totalDatabaseCount = 0;

      try {
        final allDbMessages = await GetIt.I<MessageLocalRepository>().getAllSentMessage(
          roomId: roomId,
        );
        totalDatabaseCount = allDbMessages.length;

        // Take the 20 most recent messages (newest first)
        databaseMessages = allDbMessages.take(20).map((e) => e.toCollection()).toList();
      } catch (e) {
        useLogger().e('Failed to fetch messages from database for message state logging', e);
      }

      // Get current UI messages
      List<MessageCollection> uiMessages = messages.take(20).toList();
      int totalUiCount = messages.length;

      // Create the message state log
      final messageStateLog = MessageStateEntity(
        roomId: roomId,
        timestamp: DateTime.now(),
        databaseMessages: databaseMessages,
        uiMessages: uiMessages,
        totalDatabaseMessageCount: totalDatabaseCount,
        totalUiMessageCount: totalUiCount,
        currentRoute: Get.currentRoute,
        isAppInForeground: true, // MessageListController is only active when app is in foreground
      );

      // Log the message state
      logger.logMessageState(messageStateLog);

      useLogger()
          .d('Message state logged after initial load for room: $roomId, DB: $totalDatabaseCount, UI: $totalUiCount');
    } catch (e, stackTrace) {
      useLogger().e('Failed to log message state after initial load', e, stackTrace);
    }
  }

  int _calculateTotalFileSizeMb(List<MessageEntity> messages) {
    double totalSize =
        messages.expand((message) => message.files ?? []).fold(0.0, (sum, file) => sum + (file.size ?? 0));
    final totalSizeMb = totalSize / (1024 * 1024);
    return totalSizeMb.round();
  }
}
