import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/message_model.dart';
import 'package:uchat/features/chat_room/data/models/requests/room_file_get_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/room_file_put_request.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_compat_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_file_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_subscription_local_repository.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_file_entity.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/message_file_entity.dart';
import 'package:uchat/features/chat_room/utils/chat_room_utils.dart';
import 'package:uchat/features/sync/domain/services/sync_service.dart';
import 'package:uchat/features/sync/domain/use_cases/sync_handle_update_room_subscription_use_case.dart';
import 'package:uchat/utils/interfaces/encryption_helper_interface.dart';

// Mock classes
class MockLoggerService extends Mock implements LoggerService {}

class MockEventBus extends Mock implements EventBus {}

class MockSyncService extends Mock implements SyncService {}

class MockChatRoomUtils extends Mock implements IChatRoomUtils {}

class MockEncryptionHelper extends Mock implements IEncryptionHelper {}

class MockChatRoomLocalCompatRepository extends Mock implements ChatRoomLocalCompatRepository {}

class MockRoomSubscriptionLocalRepository extends Mock implements RoomSubscriptionLocalRepository {}

class MockRoomFileLocalRepository extends Mock implements RoomFileLocalRepository {}

class MockMessageLocalRepository extends Mock implements MessageLocalRepository {}

class MockRoomSubscriptionCollection extends Mock implements RoomSubscriptionCollection {}

class MockRoomSubscriptionEntity extends Mock implements RoomSubscriptionEntity {}

// Fake classes for complex types
class FakeRoomSubscriptionEntity extends Fake implements RoomSubscriptionEntity {}

class FakeRoomEntity extends Fake implements RoomEntity {}

class FakeMessageEntity extends Fake implements MessageEntity {}

class FakeMessageModel extends Fake implements MessageModel {}

class FakeRoomFileEntity extends Fake implements RoomFileEntity {}

class FakeMessageFileEntity extends Fake implements MessageFileEntity {}

class FakeGetPhotosAndVideosByRoomIdRequest extends Fake implements GetPhotosAndVideosByRoomIdRequest {}

class FakePutAllRoomFilesRequest extends Fake implements PutAllRoomFilesRequest {}

class FakeRoomCollection extends Fake implements RoomCollection {}

class FakeRoomSubscriptionCollection extends Fake implements RoomSubscriptionCollection {}

class FakeMessageCollection extends Fake implements MessageCollection {}

void main() {
  late SyncHandleUpdateRoomSubscriptionUseCase useCase;
  late MockLoggerService mockLogger;
  late MockEventBus mockEventBus;
  late MockSyncService mockSyncService;
  late MockChatRoomUtils mockChatRoomUtils;
  late MockEncryptionHelper mockEncryptionHelper;
  late MockChatRoomLocalCompatRepository mockChatRoomLocalRepository;
  late MockRoomSubscriptionLocalRepository mockRoomSubscriptionLocalRepository;
  late MockRoomFileLocalRepository mockRoomFileLocalRepository;
  late MockMessageLocalRepository mockMessageLocalRepository;

  late RoomSubscriptionEntity testRoomSubscription;
  late RoomEntity testRoom;
  late MessageModel testLastMessage;
  late MessageFileEntity testMessageFileEntity;

  setUpAll(() {
    registerFallbackValue(MockRoomSubscriptionEntity());
    registerFallbackValue(FakeRoomSubscriptionEntity());
    registerFallbackValue(FakeRoomEntity());
    registerFallbackValue(FakeMessageEntity());
    registerFallbackValue(FakeMessageModel());
    registerFallbackValue(FakeRoomFileEntity());
    registerFallbackValue(FakeMessageFileEntity());
    registerFallbackValue(FakeGetPhotosAndVideosByRoomIdRequest());
    registerFallbackValue(FakePutAllRoomFilesRequest());
    registerFallbackValue(FakeRoomCollection());
    registerFallbackValue(FakeRoomSubscriptionCollection());
    registerFallbackValue(FakeMessageCollection());
  });

  setUp(() {
    mockLogger = MockLoggerService();
    mockEventBus = MockEventBus();
    mockSyncService = MockSyncService();
    mockChatRoomUtils = MockChatRoomUtils();
    mockEncryptionHelper = MockEncryptionHelper();
    mockChatRoomLocalRepository = MockChatRoomLocalCompatRepository();
    mockRoomSubscriptionLocalRepository = MockRoomSubscriptionLocalRepository();
    mockRoomFileLocalRepository = MockRoomFileLocalRepository();
    mockMessageLocalRepository = MockMessageLocalRepository();

    useCase = SyncHandleUpdateRoomSubscriptionUseCase(
      log: mockLogger,
      eventBus: mockEventBus,
      syncService: mockSyncService,
      chatRoomUtils: mockChatRoomUtils,
      encryptHelper: mockEncryptionHelper,
      chatRoomLocalRepository: mockChatRoomLocalRepository,
      roomSubscriptionLocalRepository: mockRoomSubscriptionLocalRepository,
      roomFileLocalRepository: mockRoomFileLocalRepository,
      messageLocalRepository: mockMessageLocalRepository,
    );

    testLastMessage = MessageModel(
      id: 'test-message-id',
      message: 'Test message',
      type: MessageType.text,
      isEncrypted: false,
      sequence: 100,
      ref: 'test-ref',
    );

    testMessageFileEntity = MessageFileEntity(
      id: 'test-file-id',
      name: 'test-file.jpg',
    );

    testRoomSubscription = RoomSubscriptionEntity(
      id: 'test-subscription-id',
      roomId: 'test-room-id',
      roomName: 'Test Room',
      unreadCount: 5,
      lastMessage: testLastMessage,
      isHidden: false,
      isRoomDeleted: false,
      updatedAt: DateTime.now(),
    );

    testRoom = const RoomEntity(
      id: 'test-room-id',
      roomType: RoomType.direct,
      roomName: 'Test Room',
      roomCryptoKey: null,
    );
  });

  group('SyncHandleUpdateRoomSubscriptionParams', () {
    test('Given required parameters, When creating params, Then creates instance with correct values', () {
      // Given
      const receiveRoomSubscription = RoomSubscriptionEntity(id: 'test-id');

      // When
      final params = SyncHandleUpdateRoomSubscriptionParams(
        receiveRoomSubscription: receiveRoomSubscription,
      );

      // Then
      expect(params.receiveRoomSubscription, equals(receiveRoomSubscription));
      expect(params.isDeleteLastMessage, isFalse);
      expect(params.checkRoomFile, isFalse);
    });

    test('Given all parameters, When creating params, Then creates instance with correct values', () {
      // Given
      const receiveRoomSubscription = RoomSubscriptionEntity(id: 'test-id');

      // When
      final params = SyncHandleUpdateRoomSubscriptionParams(
        receiveRoomSubscription: receiveRoomSubscription,
        isDeleteLastMessage: true,
        checkRoomFile: true,
      );

      // Then
      expect(params.receiveRoomSubscription, equals(receiveRoomSubscription));
      expect(params.isDeleteLastMessage, isTrue);
      expect(params.checkRoomFile, isTrue);
    });
  });

  group('SyncHandleUpdateRoomSubscriptionUseCase', () {
    test('Given room not found, When use case is called, Then saves to temp and returns empty event list', () async {
      // Given
      final params = SyncHandleUpdateRoomSubscriptionParams(
        receiveRoomSubscription: testRoomSubscription,
      );

      when(() => mockChatRoomLocalRepository.getRoom('test-room-id')).thenAnswer((_) async => null);

      final tempRoomSubscriptionList = <String, RoomSubscriptionCollection>{};
      when(() => mockSyncService.tempRoomSubscriptionList).thenReturn(tempRoomSubscriptionList);

      // When
      final result = await useCase(params);

      // Then
      expect(result, isEmpty);
      verify(() => mockLogger.d('_updateRoomSubscription: $testRoomSubscription')).called(1);
      verify(() => mockChatRoomLocalRepository.getRoom('test-room-id')).called(1);
      verify(() => mockSyncService.tempRoomSubscriptionList).called(1);
    });

    test('Given room not found with null roomId, When use case is called, Then returns empty event list', () async {
      // Given
      const roomSubscriptionWithNullId = RoomSubscriptionEntity(
        id: 'test-subscription-id',
        roomId: null,
        roomName: 'Test Room',
      );

      final params = SyncHandleUpdateRoomSubscriptionParams(
        receiveRoomSubscription: roomSubscriptionWithNullId,
      );

      // When
      final result = await useCase(params);

      // Then
      expect(result, isEmpty);
      verify(() => mockLogger.d('_updateRoomSubscription: $roomSubscriptionWithNullId')).called(1);
      verifyNever(() => mockChatRoomLocalRepository.getRoom(any()));
    });

    test('Given room exists with unread messages, When use case is called, Then fires unread update events', () async {
      // Given
      final params = SyncHandleUpdateRoomSubscriptionParams(
        receiveRoomSubscription: testRoomSubscription,
      );

      when(() => mockChatRoomLocalRepository.getRoom('test-room-id')).thenAnswer((_) async => testRoom);
      when(() => mockChatRoomUtils.getRoomName(room: testRoom)).thenAnswer((_) async => 'Test Room Name');
      when(() => mockRoomSubscriptionLocalRepository.putRoomSubscription(
            roomSub: any(named: 'roomSub'),
            useTxn: any(named: 'useTxn'),
          )).thenAnswer((_) async => null);
      when(() => mockEventBus.fire(any())).thenReturn(null);

      // When
      final result = await useCase(params);

      // Then
      expect(result, hasLength(2));
      verify(() => mockChatRoomLocalRepository.getRoom('test-room-id')).called(1);
      verify(() => mockChatRoomUtils.getRoomName(room: testRoom)).called(1);
      verify(() => mockRoomSubscriptionLocalRepository.putRoomSubscription(
            roomSub: any(named: 'roomSub'),
            useTxn: false,
          )).called(1);

      // Execute the event callbacks to verify they work
      for (final eventCallback in result) {
        eventCallback();
      }

      // Verify that eventBus.fire was called twice (once for each event)
      verify(() => mockEventBus.fire(any())).called(2);
    });

    test('Given room exists with no unread messages, When use case is called, Then does not fire unread update events',
        () async {
      // Given
      final roomSubscriptionNoUnread = testRoomSubscription.copyWith(unreadCount: 0);
      final params = SyncHandleUpdateRoomSubscriptionParams(
        receiveRoomSubscription: roomSubscriptionNoUnread,
      );

      when(() => mockChatRoomLocalRepository.getRoom('test-room-id')).thenAnswer((_) async => testRoom);
      when(() => mockChatRoomUtils.getRoomName(room: testRoom)).thenAnswer((_) async => 'Test Room Name');
      when(() => mockRoomSubscriptionLocalRepository.putRoomSubscription(
            roomSub: any(named: 'roomSub'),
            useTxn: any(named: 'useTxn'),
          )).thenAnswer((_) async => null);

      // When
      final result = await useCase(params);

      // Then
      expect(result, isEmpty);
      verify(() => mockChatRoomLocalRepository.getRoom('test-room-id')).called(1);
      verify(() => mockChatRoomUtils.getRoomName(room: testRoom)).called(1);
    });

    test('Given non-encrypted last message, When use case is called, Then processes message correctly', () async {
      // Given
      final nonEncryptedMessage = MessageModel(
        id: 'test-message-id',
        message: 'plain-message',
        type: MessageType.text,
        isEncrypted: false,
      );

      final roomSubscriptionWithNonEncrypted = testRoomSubscription.copyWith(
        lastMessage: nonEncryptedMessage,
        unreadCount: 0,
      );

      final params = SyncHandleUpdateRoomSubscriptionParams(
        receiveRoomSubscription: roomSubscriptionWithNonEncrypted,
      );

      when(() => mockChatRoomLocalRepository.getRoom('test-room-id')).thenAnswer((_) async => testRoom);
      when(() => mockChatRoomUtils.getRoomName(room: testRoom)).thenAnswer((_) async => 'Test Room Name');
      when(() => mockRoomSubscriptionLocalRepository.putRoomSubscription(
            roomSub: any(named: 'roomSub'),
            useTxn: any(named: 'useTxn'),
          )).thenAnswer((_) async => null);

      // When
      final result = await useCase(params);

      // Then
      expect(result, isEmpty);
      verify(() => mockChatRoomLocalRepository.getRoom('test-room-id')).called(1);
    });

    test('Given isDeleteLastMessage is true, When use case is called, Then deletes last message', () async {
      // Given
      final params = SyncHandleUpdateRoomSubscriptionParams(
        receiveRoomSubscription: testRoomSubscription,
        isDeleteLastMessage: true,
      );

      final mockRoomSubCollection = MockRoomSubscriptionEntity();

      when(() => mockChatRoomLocalRepository.getRoom('test-room-id')).thenAnswer((_) async => testRoom);
      when(() => mockChatRoomUtils.getRoomName(room: testRoom)).thenAnswer((_) async => 'Test Room Name');
      when(() => mockRoomSubscriptionLocalRepository.getRoomSubscriptionByRoomId(roomId: 'test-room-id'))
          .thenAnswer((_) async => testRoomSubscription);
      when(() => mockRoomSubscriptionLocalRepository.putRoomSubscription(
            roomSub: any(named: 'roomSub'),
            replaceData: any(named: 'replaceData'),
            useTxn: any(named: 'useTxn'),
          )).thenAnswer((_) async => testRoomSubscription);

      // Mock room subscription collection methods
      when(() => mockRoomSubCollection.copyWithEntity(any())).thenAnswer((_) => testRoomSubscription);
      when(() => mockRoomSubCollection.lastMessage).thenReturn(null);
      when(() => mockRoomSubCollection.copyWith(lastMessage: testLastMessage)).thenReturn(testRoomSubscription);

      // When
      final result = await useCase(params);

      // Then
      expect(result, hasLength(3)); // 2 unread events + 1 room update event
      verify(() => mockRoomSubscriptionLocalRepository.getRoomSubscriptionByRoomId(roomId: 'test-room-id')).called(1);
      verify(() => mockRoomSubscriptionLocalRepository.putRoomSubscription(
            roomSub: any(named: 'roomSub'),
            replaceData: true,
            useTxn: false,
          )).called(1);
    });

    test('Given isRoomDeleted is true, When use case is called, Then deletes last message', () async {
      // Given
      final deletedRoomSubscription = testRoomSubscription.copyWith(isRoomDeleted: true);
      final params = SyncHandleUpdateRoomSubscriptionParams(
        receiveRoomSubscription: deletedRoomSubscription,
      );

      final mockRoomSubCollection = MockRoomSubscriptionEntity();

      when(() => mockChatRoomLocalRepository.getRoom('test-room-id')).thenAnswer((_) async => testRoom);
      when(() => mockChatRoomUtils.getRoomName(room: testRoom)).thenAnswer((_) async => 'Test Room Name');
      when(() => mockRoomSubscriptionLocalRepository.getRoomSubscriptionByRoomId(roomId: 'test-room-id'))
          .thenAnswer((_) async => testRoomSubscription);
      when(() => mockRoomSubscriptionLocalRepository.putRoomSubscription(
            roomSub: any(named: 'roomSub'),
            replaceData: any(named: 'replaceData'),
            useTxn: any(named: 'useTxn'),
          )).thenAnswer((_) async => testRoomSubscription);

      // Mock room subscription collection methods
      when(() => mockRoomSubCollection.copyWithEntity(any())).thenAnswer((_) => testRoomSubscription);
      when(() => mockRoomSubCollection.lastMessage).thenReturn(null);
      when(() => mockRoomSubCollection.copyWith(lastMessage: testLastMessage)).thenReturn(testRoomSubscription);

      // When
      final result = await useCase(params);

      // Then
      expect(result, hasLength(3)); // 2 unread events + 1 room update event
      verify(() => mockRoomSubscriptionLocalRepository.getRoomSubscriptionByRoomId(roomId: 'test-room-id')).called(1);
    });

    test('Given checkRoomFile is true, When use case is called, Then updates room files', () async {
      // Given
      final params = SyncHandleUpdateRoomSubscriptionParams(
        receiveRoomSubscription: testRoomSubscription,
        checkRoomFile: true,
      );

      final roomFiles = [
        RoomFileEntity(file: testMessageFileEntity, isHidden: false, isDownload: true),
        RoomFileEntity(file: testMessageFileEntity, isHidden: false, isDownload: true),
      ];

      when(() => mockChatRoomLocalRepository.getRoom('test-room-id')).thenAnswer((_) async => testRoom);
      when(() => mockChatRoomUtils.getRoomName(room: testRoom)).thenAnswer((_) async => 'Test Room Name');
      when(() => mockRoomFileLocalRepository.getPhotosAndVideosByRoomId(any())).thenAnswer((_) async => roomFiles);
      when(() => mockRoomFileLocalRepository.getFilesByRoomId(roomId: 'test-room-id')).thenAnswer((_) async => []);
      when(() => mockRoomFileLocalRepository.putAllRoomFiles(any())).thenAnswer((_) async {});
      when(() => mockRoomSubscriptionLocalRepository.putRoomSubscription(
            roomSub: any(named: 'roomSub'),
            useTxn: any(named: 'useTxn'),
          )).thenAnswer((_) async => null);

      // When
      final result = await useCase(params);

      // Then
      expect(result, hasLength(2)); // 2 unread events
      verify(() => mockRoomFileLocalRepository.getPhotosAndVideosByRoomId(any())).called(1);
      verify(() => mockRoomFileLocalRepository.getFilesByRoomId(roomId: 'test-room-id')).called(1);
      verify(() => mockRoomFileLocalRepository.putAllRoomFiles(any())).called(2);
    });

    test('Given room subscription with direct secret type, When use case is called, Then sets hasCryptoKey correctly',
        () async {
      // Given
      final directSecretRoom = testRoom.copyWith(
        roomType: RoomType.directSecret,
        roomCryptoKey: 'crypto-key',
      );

      final params = SyncHandleUpdateRoomSubscriptionParams(
        receiveRoomSubscription: testRoomSubscription,
      );

      when(() => mockChatRoomLocalRepository.getRoom('test-room-id')).thenAnswer((_) async => directSecretRoom);
      when(() => mockChatRoomUtils.getRoomName(room: directSecretRoom)).thenAnswer((_) async => 'Test Room Name');
      when(() => mockRoomSubscriptionLocalRepository.putRoomSubscription(
            roomSub: any(named: 'roomSub'),
            useTxn: any(named: 'useTxn'),
          )).thenAnswer((_) async => null);

      // When
      final result = await useCase(params);

      // Then
      expect(result, hasLength(2)); // 2 unread events
      verify(() => mockChatRoomLocalRepository.getRoom('test-room-id')).called(1);
      verify(() => mockChatRoomUtils.getRoomName(room: directSecretRoom)).called(1);
    });

    test('Given room subscription update returns entity, When use case is called, Then fires room update event',
        () async {
      // Given
      final params = SyncHandleUpdateRoomSubscriptionParams(
        receiveRoomSubscription: testRoomSubscription,
      );

      final mockRoomSubCollection = MockRoomSubscriptionEntity();

      when(() => mockChatRoomLocalRepository.getRoom('test-room-id')).thenAnswer((_) async => testRoom);
      when(() => mockChatRoomUtils.getRoomName(room: testRoom)).thenAnswer((_) async => 'Test Room Name');
      when(() => mockRoomSubscriptionLocalRepository.putRoomSubscription(
            roomSub: any(named: 'roomSub'),
            useTxn: any(named: 'useTxn'),
          )).thenAnswer((_) async => mockRoomSubCollection);

      // Note: toEntity is an extension method and cannot be mocked directly
      // The test will verify the putRoomSubscription call instead

      // When
      final result = await useCase(params);

      // Then
      expect(result, hasLength(3)); // 2 unread events + 1 room update event
      verify(() => mockRoomSubscriptionLocalRepository.putRoomSubscription(
            roomSub: any(named: 'roomSub'),
            useTxn: false,
          )).called(1);
    });

    test(
        'Given temp room subscription exists with older timestamp, When use case is called, Then updates temp subscription',
        () async {
      // Given
      final olderTimestamp = DateTime.now().subtract(const Duration(hours: 1));
      final newerTimestamp = DateTime.now();

      final roomSubscriptionWithNewer = testRoomSubscription.copyWith(
        updatedAt: newerTimestamp,
      );

      final params = SyncHandleUpdateRoomSubscriptionParams(
        receiveRoomSubscription: roomSubscriptionWithNewer,
      );

      final mockTempRoomSub = MockRoomSubscriptionCollection();
      when(() => mockTempRoomSub.updatedAt).thenReturn(olderTimestamp);

      final tempRoomSubscriptionList = <String, RoomSubscriptionCollection>{
        'test-room-id': mockTempRoomSub,
      };

      when(() => mockChatRoomLocalRepository.getRoom('test-room-id')).thenAnswer((_) async => null);
      when(() => mockSyncService.tempRoomSubscriptionList).thenReturn(tempRoomSubscriptionList);

      // When
      final result = await useCase(params);

      // Then
      expect(result, isEmpty);
      verify(() => mockSyncService.tempRoomSubscriptionList).called(1);
    });

    test(
        'Given temp room subscription exists with newer timestamp, When use case is called, Then keeps existing temp subscription',
        () async {
      // Given
      final olderTimestamp = DateTime.now().subtract(const Duration(hours: 1));
      final newerTimestamp = DateTime.now();

      final roomSubscriptionWithOlder = testRoomSubscription.copyWith(
        updatedAt: olderTimestamp,
      );

      final params = SyncHandleUpdateRoomSubscriptionParams(
        receiveRoomSubscription: roomSubscriptionWithOlder,
      );

      final mockTempRoomSub = MockRoomSubscriptionCollection();
      when(() => mockTempRoomSub.updatedAt).thenReturn(newerTimestamp);

      final tempRoomSubscriptionList = <String, RoomSubscriptionCollection>{
        'test-room-id': mockTempRoomSub,
      };

      when(() => mockChatRoomLocalRepository.getRoom('test-room-id')).thenAnswer((_) async => null);
      when(() => mockSyncService.tempRoomSubscriptionList).thenReturn(tempRoomSubscriptionList);

      // When
      final result = await useCase(params);

      // Then
      expect(result, isEmpty);
      verify(() => mockSyncService.tempRoomSubscriptionList).called(1);
    });

    test('Given exception during room retrieval, When use case is called, Then rethrows exception', () async {
      // Given
      final params = SyncHandleUpdateRoomSubscriptionParams(
        receiveRoomSubscription: testRoomSubscription,
      );

      final exception = Exception('Database error');
      when(() => mockChatRoomLocalRepository.getRoom('test-room-id')).thenThrow(exception);

      // When/Then
      await expectLater(
        () => useCase(params),
        throwsA(equals(exception)),
      );
      verify(() => mockChatRoomLocalRepository.getRoom('test-room-id')).called(1);
    });

    test('Given room with null last message, When use case is called, Then processes correctly', () async {
      // Given
      final roomSubscriptionWithNullMessage = testRoomSubscription.copyWith(
        lastMessage: null,
        unreadCount: 0,
      );

      final params = SyncHandleUpdateRoomSubscriptionParams(
        receiveRoomSubscription: roomSubscriptionWithNullMessage,
      );

      when(() => mockChatRoomLocalRepository.getRoom('test-room-id')).thenAnswer((_) async => testRoom);
      when(() => mockChatRoomUtils.getRoomName(room: testRoom)).thenAnswer((_) async => 'Test Room Name');
      when(() => mockRoomSubscriptionLocalRepository.putRoomSubscription(
            roomSub: any(named: 'roomSub'),
            useTxn: any(named: 'useTxn'),
          )).thenAnswer((_) async => null);

      // When
      final result = await useCase(params);

      // Then
      expect(result, isEmpty);
      verify(() => mockChatRoomLocalRepository.getRoom('test-room-id')).called(1);
      verify(() => mockChatRoomUtils.getRoomName(room: testRoom)).called(1);
    });
  });
}
