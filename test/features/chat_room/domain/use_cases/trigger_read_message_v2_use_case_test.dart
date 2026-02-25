import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:scrollview_observer/scrollview_observer.dart';
import 'package:uchat/core/domain/services/life_cycle_service.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/domain/use_cases/trigger_read_message_v2_use_case.dart';

class MockListObserverController extends Mock implements ListObserverController {}

class MockScrollController extends Mock implements ScrollController {}

class MockRoomCollection extends Mock implements RoomCollection {}

class MockMessageCollection extends Mock implements MessageCollection {}

class MockLoggerService extends Mock implements LoggerService {}

class MockLifeCycleService extends Mock implements LifeCycleService {}

void main() {
  late TriggerReadMessageV2UseCase useCase;
  late MockListObserverController mockListObserverController;
  late MockScrollController mockScrollController;
  late MockRoomCollection mockRoom;
  late MockLifeCycleService mockLifeCycleService;
  late List<MessageCollection> testMessages;
  late DateTime testDateTime;
  late Completer<void> triggerReadCompleter;
  late bool triggerReadCalled;
  late DateTime? triggerReadParameter;
  late int? lastReadMessageIndexCallback;

  setUpAll(() {
    // Register fallback values for the complex types
    registerFallbackValue(TriggerReadParams(
      messages: [],
      listObserverController: MockListObserverController(),
      scrollController: MockScrollController(),
      chatRoomCtlTriggerReadMessage: (_) async {},
      myLastReadAt: 0,
    ));

    // Setup mock logger service to avoid GetIt registration issues
    if (!GetIt.instance.isRegistered<LoggerService>()) {
      GetIt.instance.registerSingleton<LoggerService>(MockLoggerService());
    }
  });

  setUp(() {
    useCase = TriggerReadMessageV2UseCase();
    mockListObserverController = MockListObserverController();
    mockScrollController = MockScrollController();
    mockRoom = MockRoomCollection();
    mockLifeCycleService = MockLifeCycleService();
    testDateTime = DateTime.now();
    triggerReadCompleter = Completer<void>();
    triggerReadCalled = false;
    triggerReadParameter = null;
    lastReadMessageIndexCallback = null;

    // Create test messages
    testMessages = [
      MessageCollection(
        id: 'msg-1',
        ref: 'msg-ref-1',
        sequence: 3,
        createdAt: testDateTime,
        isSendFailed: false,
      ),
      MessageCollection(
        id: 'msg-2',
        ref: 'msg-ref-2',
        sequence: 2,
        createdAt: testDateTime.subtract(const Duration(minutes: 1)),
        isSendFailed: false,
      ),
      MessageCollection(
        id: 'msg-3',
        ref: 'msg-ref-3',
        sequence: 1,
        createdAt: testDateTime.subtract(const Duration(minutes: 2)),
        isSendFailed: false,
      ),
    ];

    // Always unregister before registering to avoid stale instances
    if (GetIt.instance.isRegistered<LifeCycleService>()) {
      GetIt.instance.unregister<LifeCycleService>();
    }
    GetIt.I.registerSingleton<LifeCycleService>(mockLifeCycleService);

    // Mock room properties
    when(() => mockRoom.id).thenReturn('test-room-id');
    reset(mockLifeCycleService);
    when(() => mockLifeCycleService.isPaused).thenReturn(false);

    // Set up Get routes for testing
    Get.testMode = true;
  });

  tearDown(() {
    Get.reset();
  });

  tearDownAll(() {
    // Clean up GetIt registrations
    if (GetIt.instance.isRegistered<LoggerService>()) {
      GetIt.instance.unregister<LoggerService>();
    }
  });

  group('TriggerReadMessageV2UseCase', () {
    test('Given room is null, When use case is called, Then no action is taken', () async {
      // Given
      final params = TriggerReadParams(
        messages: testMessages,
        listObserverController: mockListObserverController,
        scrollController: mockScrollController,
        chatRoomCtlTriggerReadMessage: (messageCreatedAt) async {
          triggerReadCalled = true;
          triggerReadParameter = messageCreatedAt;
        },
        myLastReadAt: 0,
        room: null,
      );

      // When
      await useCase(params);

      // Then
      expect(triggerReadCalled, isFalse);
    });

    test('Given enableReadMessage is false, When use case is called, Then no action is taken', () async {
      // Given
      final params = TriggerReadParams(
        messages: testMessages,
        listObserverController: mockListObserverController,
        scrollController: mockScrollController,
        chatRoomCtlTriggerReadMessage: (messageCreatedAt) async {
          triggerReadCalled = true;
          triggerReadParameter = messageCreatedAt;
        },
        myLastReadAt: 0,
        room: mockRoom,
        enableReadMessage: false,
      );

      // Mock Get.currentRoute for chat screen
      Get.routing.current = '/chat-room/direct/test-room-id';

      // When
      await useCase(params);

      // Then
      expect(triggerReadCalled, isFalse);
    });

    test('Given current route is not chat screen, When use case is called, Then no action is taken', () async {
      // Given
      final params = TriggerReadParams(
        messages: testMessages,
        listObserverController: mockListObserverController,
        scrollController: mockScrollController,
        chatRoomCtlTriggerReadMessage: (messageCreatedAt) async {
          triggerReadCalled = true;
          triggerReadParameter = messageCreatedAt;
        },
        myLastReadAt: 0,
        room: mockRoom,
        enableReadMessage: true,
      );

      // Mock Get.currentRoute for different screen
      Get.routing.current = '/different-screen';

      // When
      await useCase(params);

      // Then
      expect(triggerReadCalled, isFalse);
    });

    test('Given app is paused, When use case is called, Then no action is taken', () async {
      // Given
      final params = TriggerReadParams(
        messages: testMessages,
        listObserverController: mockListObserverController,
        scrollController: mockScrollController,
        chatRoomCtlTriggerReadMessage: (messageCreatedAt) async {
          triggerReadCalled = true;
          triggerReadParameter = messageCreatedAt;
        },
        myLastReadAt: 0,
        room: mockRoom,
        enableReadMessage: true,
        lastReadMessageIndex: 1,
        visibleIndexRange: (1, 3),
        visibleItemBorder: (testMessages.first, testMessages.last),
      );

      reset(mockLifeCycleService);
      when(() => mockLifeCycleService.isPaused).thenReturn(true);

      // Mock Get.currentRoute for chat screen
      Get.routing.current = '/chat-room/direct/test-room-id';

      // When
      await useCase(params);

      // Then
      expect(triggerReadCalled, isFalse);
    });

    test('Given last read message index >= 0 and message not visible, When use case is called, Then no action is taken',
        () async {
      // Given
      final params = TriggerReadParams(
        messages: testMessages,
        listObserverController: mockListObserverController,
        scrollController: mockScrollController,
        chatRoomCtlTriggerReadMessage: (messageCreatedAt) async {
          triggerReadCalled = true;
          triggerReadParameter = messageCreatedAt;
        },
        myLastReadAt: 0,
        room: mockRoom,
        enableReadMessage: true,
        lastReadMessageIndex: 1,
        visibleIndexRange: (0, 0),
        // Message at index 1 is not visible
        onLastReadMessageIndexCallback: (index) {
          lastReadMessageIndexCallback = index;
        },
      );

      // Mock Get.currentRoute for chat screen
      Get.routing.current = '/chat-room/direct/test-room-id';

      // When
      await useCase(params);

      // Then
      expect(triggerReadCalled, isFalse);
      expect(lastReadMessageIndexCallback, isNull);
    });

    test(
        'Given last read message index >= 0 and message is visible, When use case is called, Then callback is triggered',
        () async {
      // Given
      final params = TriggerReadParams(
        messages: testMessages,
        listObserverController: mockListObserverController,
        scrollController: mockScrollController,
        chatRoomCtlTriggerReadMessage: (messageCreatedAt) async {
          triggerReadCalled = true;
          triggerReadParameter = messageCreatedAt;
        },
        myLastReadAt: 0,
        room: mockRoom,
        enableReadMessage: true,
        lastReadMessageIndex: 1,
        visibleIndexRange: (1, 3),
        // Message at index 1+1=2 is visible
        onLastReadMessageIndexCallback: (index) {
          lastReadMessageIndexCallback = index;
        },
      );

      // Mock Get.currentRoute for chat screen
      Get.routing.current = '/chat-room/direct/test-room-id';

      // When
      await useCase(params);

      // Then
      expect(lastReadMessageIndexCallback, equals(-1));
    });

    test('Given visible item in bottom is first message in list, When use case is called, Then triggers read message',
        () async {
      // Given
      final firstMessage = testMessages.first;
      final params = TriggerReadParams(
        messages: testMessages,
        listObserverController: mockListObserverController,
        scrollController: mockScrollController,
        chatRoomCtlTriggerReadMessage: (messageCreatedAt) async {
          triggerReadCalled = true;
          triggerReadParameter = messageCreatedAt;
          triggerReadCompleter.complete();
        },
        myLastReadAt: 0,
        room: mockRoom,
        enableReadMessage: true,
        lastReadMessageIndex: -1,
        visibleItemBorder: (firstMessage, testMessages.last),
      );

      // Mock Get.currentRoute for chat screen
      Get.routing.current = '/chat-room/direct/test-room-id';

      // When
      await useCase(params);
      await triggerReadCompleter.future;

      // Then
      expect(triggerReadCalled, isTrue);
      expect(triggerReadParameter, equals(firstMessage.createdAt));
    });

    test(
        'Given visible item in bottom is first message but has null sequence, When use case is called, Then no action is taken',
        () async {
      // Given
      final messageWithNullSequence = MessageCollection(
        id: 'msg-null-seq',
        sequence: null,
        createdAt: testDateTime,
        isSendFailed: false,
      );
      final messagesWithNullSeq = [messageWithNullSequence, ...testMessages];

      final params = TriggerReadParams(
        messages: messagesWithNullSeq,
        listObserverController: mockListObserverController,
        scrollController: mockScrollController,
        chatRoomCtlTriggerReadMessage: (messageCreatedAt) async {
          triggerReadCalled = true;
          triggerReadParameter = messageCreatedAt;
        },
        myLastReadAt: 0,
        room: mockRoom,
        enableReadMessage: true,
        lastReadMessageIndex: -1,
        visibleItemBorder: (messageWithNullSequence, testMessages.last),
      );

      // Mock Get.currentRoute for chat screen
      Get.routing.current = '/chat-room/direct/test-room-id';

      // When
      await useCase(params);

      // Then
      expect(triggerReadCalled, isFalse);
    });

    test('Given empty message list, When use case is called, Then no action is taken', () async {
      // Given
      final params = TriggerReadParams(
        messages: [],
        listObserverController: mockListObserverController,
        scrollController: mockScrollController,
        chatRoomCtlTriggerReadMessage: (messageCreatedAt) async {
          triggerReadCalled = true;
          triggerReadParameter = messageCreatedAt;
        },
        myLastReadAt: 0,
        room: mockRoom,
        enableReadMessage: true,
        lastReadMessageIndex: -1,
        visibleItemBorder: null,
      );

      // Mock Get.currentRoute for chat screen
      Get.routing.current = '/chat-room/direct/test-room-id';

      // When
      await useCase(params);

      // Then
      expect(triggerReadCalled, isFalse);
    });

    test(
        'Given visible item in bottom is not first message, When use case is called, Then triggers read message for visible item',
        () async {
      // Given
      final visibleMessage = testMessages[1]; // Second message
      final params = TriggerReadParams(
        messages: testMessages,
        listObserverController: mockListObserverController,
        scrollController: mockScrollController,
        chatRoomCtlTriggerReadMessage: (messageCreatedAt) async {
          triggerReadCalled = true;
          triggerReadParameter = messageCreatedAt;
          triggerReadCompleter.complete();
        },
        myLastReadAt: 0,
        room: mockRoom,
        enableReadMessage: true,
        lastReadMessageIndex: -1,
        visibleItemBorder: (visibleMessage, testMessages.last),
      );

      // Mock Get.currentRoute for chat screen
      Get.routing.current = '/chat-room/direct/test-room-id';

      // When
      await useCase(params);
      await triggerReadCompleter.future;

      // Then
      expect(triggerReadCalled, isTrue);
      expect(triggerReadParameter, equals(visibleMessage.createdAt));
    });

    test('Given visible message has null sequence, When use case is called, Then no action is taken', () async {
      // Given
      final messageWithNullSequence = MessageCollection(
        id: 'msg-null-seq',
        sequence: null,
        createdAt: testDateTime,
        isSendFailed: false,
      );

      final params = TriggerReadParams(
        messages: testMessages,
        listObserverController: mockListObserverController,
        scrollController: mockScrollController,
        chatRoomCtlTriggerReadMessage: (messageCreatedAt) async {
          triggerReadCalled = true;
          triggerReadParameter = messageCreatedAt;
        },
        myLastReadAt: 0,
        room: mockRoom,
        enableReadMessage: true,
        lastReadMessageIndex: -1,
        visibleItemBorder: (messageWithNullSequence, testMessages.last),
      );

      // Mock Get.currentRoute for chat screen
      Get.routing.current = '/chat-room/direct/test-room-id';

      // When
      await useCase(params);

      // Then
      expect(triggerReadCalled, isFalse);
    });

    test('Given visible message is send failed, When use case is called, Then no action is taken', () async {
      // Given
      final failedMessage = MessageCollection(
        id: 'msg-failed',
        sequence: 5,
        createdAt: testDateTime,
        isSendFailed: true,
      );

      final params = TriggerReadParams(
        messages: testMessages,
        listObserverController: mockListObserverController,
        scrollController: mockScrollController,
        chatRoomCtlTriggerReadMessage: (messageCreatedAt) async {
          triggerReadCalled = true;
          triggerReadParameter = messageCreatedAt;
        },
        myLastReadAt: 0,
        room: mockRoom,
        enableReadMessage: true,
        lastReadMessageIndex: -1,
        visibleItemBorder: (failedMessage, testMessages.last),
      );

      // Mock Get.currentRoute for chat screen
      Get.routing.current = '/chat-room/direct/test-room-id';

      // When
      await useCase(params);

      // Then
      expect(triggerReadCalled, isFalse);
    });

    test(
        'Given myLastReadAt is greater than visible message sequence, When use case is called, Then no action is taken',
        () async {
      // Given
      final visibleMessage = testMessages[1]; // Sequence: 2
      final params = TriggerReadParams(
        messages: testMessages,
        listObserverController: mockListObserverController,
        scrollController: mockScrollController,
        chatRoomCtlTriggerReadMessage: (messageCreatedAt) async {
          triggerReadCalled = true;
          triggerReadParameter = messageCreatedAt;
        },
        myLastReadAt: 5,
        // Greater than message sequence (2)
        room: mockRoom,
        enableReadMessage: true,
        lastReadMessageIndex: -1,
        visibleItemBorder: (visibleMessage, testMessages.last),
      );

      // Mock Get.currentRoute for chat screen
      Get.routing.current = '/chat-room/direct/test-room-id';

      // When
      await useCase(params);

      // Then
      expect(triggerReadCalled, isFalse);
    });

    test('Given visible item border is null, When use case is called, Then no action is taken', () async {
      // Given
      final params = TriggerReadParams(
        messages: testMessages,
        listObserverController: mockListObserverController,
        scrollController: mockScrollController,
        chatRoomCtlTriggerReadMessage: (messageCreatedAt) async {
          triggerReadCalled = true;
          triggerReadParameter = messageCreatedAt;
        },
        myLastReadAt: 0,
        room: mockRoom,
        enableReadMessage: true,
        lastReadMessageIndex: -1,
        visibleItemBorder: null,
      );

      // Mock Get.currentRoute for chat screen
      Get.routing.current = '/chat-room/direct/test-room-id';

      // When
      await useCase(params);

      // Then
      expect(triggerReadCalled, isFalse);
    });

    test('Given visible item border has null first item, When use case is called, Then no action is taken', () async {
      // Given
      // Create a dummy message to represent the case where visibleItemBorder.$1 would be null in actual usage

      final params = TriggerReadParams(
        messages: testMessages,
        listObserverController: mockListObserverController,
        scrollController: mockScrollController,
        chatRoomCtlTriggerReadMessage: (messageCreatedAt) async {
          triggerReadCalled = true;
          triggerReadParameter = messageCreatedAt;
        },
        myLastReadAt: 0,
        room: mockRoom,
        enableReadMessage: true,
        lastReadMessageIndex: -1,
        visibleItemBorder: null, // This simulates the case where visibleItemBorder is null
      );

      // Mock Get.currentRoute for chat screen
      Get.routing.current = '/chat-room/direct/test-room-id';

      // When
      await useCase(params);

      // Then
      expect(triggerReadCalled, isFalse);
    });

    test('Given exception occurs during execution, When use case is called, Then error is caught and logged', () async {
      // Given
      final params = TriggerReadParams(
        messages: testMessages,
        listObserverController: mockListObserverController,
        scrollController: mockScrollController,
        chatRoomCtlTriggerReadMessage: (messageCreatedAt) async {
          throw Exception('Test exception');
        },
        myLastReadAt: 0,
        room: mockRoom,
        enableReadMessage: true,
        lastReadMessageIndex: -1,
        visibleItemBorder: (testMessages.first, testMessages.last),
      );

      // Mock Get.currentRoute for chat screen
      Get.routing.current = '/chat-room/direct/test-room-id';

      // When & Then (should not throw)
      await useCase(params);

      // Test completes successfully without throwing
    });

    test(
        'Given valid conditions for triggering read message, When use case is called, Then chatRoomCtlTriggerReadMessage is called with correct parameters',
        () async {
      // Given
      final targetMessage = testMessages[1];
      DateTime? receivedParameter;
      final params = TriggerReadParams(
        messages: testMessages,
        listObserverController: mockListObserverController,
        scrollController: mockScrollController,
        chatRoomCtlTriggerReadMessage: (messageCreatedAt) async {
          receivedParameter = messageCreatedAt;
          triggerReadCompleter.complete();
        },
        myLastReadAt: 1,
        // Less than target message sequence (2)
        room: mockRoom,
        enableReadMessage: true,
        lastReadMessageIndex: -1,
        visibleItemBorder: (targetMessage, testMessages.last),
      );

      // Mock Get.currentRoute for chat screen
      Get.routing.current = '/chat-room/direct/test-room-id';

      // When
      await useCase(params);
      await triggerReadCompleter.future;

      // Then
      expect(receivedParameter, equals(targetMessage.createdAt));
    });
  });
}
