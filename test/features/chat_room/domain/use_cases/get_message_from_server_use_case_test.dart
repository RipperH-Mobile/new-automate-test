import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/exceptions/app_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/domain/entities/get_message_from_server_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/params/get_message_from_server_param.dart';
import 'package:uchat/features/chat_room/domain/params/get_message_from_server_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_compat_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_server_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_message_from_server_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/room_sub_local_repository.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/utils/interfaces/encryption_helper_interface.dart';

// Mock classes
class MockMessageLocalRepository extends Mock implements MessageLocalRepository {}

class MockMessageServerRepository extends Mock implements MessageServerRepository {}

class MockChatRoomLocalRepository extends Mock implements ChatRoomLocalCompatRepository {}

class MockLoggerService extends Mock implements LoggerService {}

class MockEncryptionHelper extends Mock implements IEncryptionHelper {}

class MockRoomSubLocalRepository extends Mock implements RoomSubLocalRepository {}

// Fake classes for fallback values
class FakeGetMessageFromServerParams extends Fake implements GetMessageFromServerParams {}

class FakeMessageEntity extends Fake implements MessageEntity {}

class FakeRoomCollection extends Fake implements RoomCollection {}

class FakeMessageCollection extends Fake implements MessageCollection {}

class FakeRoomEntity extends Fake implements RoomEntity {}

class FakeRoomSubscriptionEntity extends Fake implements RoomSubscriptionEntity {}

void main() {
  late GetMessageFromServerUseCase useCase;
  late MockMessageLocalRepository mockMessageLocalRepository;
  late MockMessageServerRepository mockMessageServerRepository;
  late MockChatRoomLocalRepository mockChatRoomLocalRepository;
  late MockLoggerService mockLogger;
  late MockEncryptionHelper mockEncryptionHelper;
  late MockRoomSubLocalRepository mockRoomSubLocalRepository;

  late GetMessageFromServerParam testParams;
  late MessageEntity testMessageEntity;

  setUpAll(() {
    registerFallbackValue(FakeGetMessageFromServerParams());
    registerFallbackValue(FakeMessageEntity());
    registerFallbackValue(FakeRoomCollection());
    registerFallbackValue(FakeMessageCollection());
    registerFallbackValue(FakeRoomEntity());
    registerFallbackValue(FakeRoomSubscriptionEntity());
    registerFallbackValue(<MessageEntity>[]);
  });

  setUp(() {
    // Reset GetIt before each test
    GetIt.instance.reset();

    mockMessageLocalRepository = MockMessageLocalRepository();
    mockMessageServerRepository = MockMessageServerRepository();
    mockChatRoomLocalRepository = MockChatRoomLocalRepository();
    mockLogger = MockLoggerService();
    mockEncryptionHelper = MockEncryptionHelper();
    mockRoomSubLocalRepository = MockRoomSubLocalRepository();

    // Register the mock services in GetIt
    GetIt.instance.registerSingleton<LoggerService>(mockLogger);
    GetIt.instance.registerSingleton<RoomSubLocalRepository>(mockRoomSubLocalRepository);

    useCase = GetMessageFromServerUseCase(
      log: mockLogger,
      encryptHelper: mockEncryptionHelper,
      messageLocalRepository: mockMessageLocalRepository,
      messageServerRepository: mockMessageServerRepository,
      chatRoomLocalRepository: mockChatRoomLocalRepository,
    );

    testParams = GetMessageFromServerParam(
      roomId: 'test-room-id',
      pageSize: 20,
      isMyNote: false,
    );

    testMessageEntity = const MessageEntity(
      id: 'test-message-id',
      roomId: 'test-room-id',
      message: 'Test message',
      sequence: 1234567890,
      type: MessageType.text,
    );

    // Reset all mocks first
    reset(mockMessageLocalRepository);
    reset(mockMessageServerRepository);
    reset(mockChatRoomLocalRepository);
    reset(mockLogger);
    reset(mockEncryptionHelper);
    reset(mockRoomSubLocalRepository);

    // Setup logger mock to avoid null issues (after reset)
    when(() => mockLogger.i(any(), any(), any())).thenReturn(null);
    when(() => mockLogger.e(any(), any(), any())).thenReturn(null);
    when(() => mockLogger.w(any(), any(), any())).thenReturn(null);
    when(() => mockLogger.d(any(), any(), any())).thenReturn(null);
  });

  group('GetMessageFromServerUseCase', () {
    test(
      'Given response with empty messages, When use case is called, Then returns empty list',
      () async {
        // Given
        final emptyResponse = GetMessageFromServerEntity(messages: []);
        when(() => mockMessageServerRepository.getMessageInRoom(any())).thenAnswer((_) async => emptyResponse);

        // When
        final result = await useCase(testParams);

        // Then
        expect(result, isNotNull);
        expect(result?.isEmpty, isTrue);
        verify(() => mockMessageServerRepository.getMessageInRoom(any())).called(1);
        verifyNever(() => mockChatRoomLocalRepository.getRoom(any()));
        verifyNever(() => mockMessageLocalRepository.putAllMessages(messages: any(named: 'messages')));
      },
    );

    test(
      'Given response with null messages, When use case is called, Then returns null',
      () async {
        // Given
        final nullMessagesResponse = GetMessageFromServerEntity(messages: null);
        when(() => mockMessageServerRepository.getMessageInRoom(any())).thenAnswer((_) async => nullMessagesResponse);

        // When
        final result = await useCase(testParams);

        // Then
        expect(result, isEmpty);
        verify(() => mockMessageServerRepository.getMessageInRoom(any())).called(1);
        verifyNever(() => mockChatRoomLocalRepository.getRoom(any()));
        verifyNever(() => mockMessageLocalRepository.putAllMessages(messages: any(named: 'messages')));
      },
    );

    test(
      'Given server repository returns Left (error), When use case is called, Then returns null',
      () async {
        // Given
        final exception = Exception('Server error');
        when(() => mockMessageServerRepository.getMessageInRoom(any())).thenThrow((_) async => exception);

        // When/Then
        await expectLater(
          () => useCase(testParams),
          throwsA(isA<AppException>()),
        );
        verify(() => mockMessageServerRepository.getMessageInRoom(any())).called(1);
        verifyNever(() => mockMessageLocalRepository.putAllMessages(messages: any(named: 'messages')));
      },
    );

    test(
      'Given server repository returns null response, When use case is called, Then returns null',
      () async {
        // Given
        when(() => mockMessageServerRepository.getMessageInRoom(any())).thenAnswer((_) async => null);

        // When
        final result = await useCase(testParams);

        // Then
        expect(result, isEmpty);
        verify(() => mockMessageServerRepository.getMessageInRoom(any())).called(1);
        verifyNever(() => mockMessageLocalRepository.putAllMessages(messages: any(named: 'messages')));
      },
    );

    test(
      'Given server repository throws exception, When use case is called, Then logs error and throws AppException',
      () async {
        // Given
        final exception = Exception('Network error');
        when(() => mockMessageServerRepository.getMessageInRoom(any())).thenThrow(exception);

        // When/Then
        await expectLater(
          () => useCase(testParams),
          throwsA(isA<AppException>()),
        );
        verify(() => mockMessageServerRepository.getMessageInRoom(any())).called(1);
        verify(() => mockLogger.e('Get messages from server error.', exception, any())).called(1);
        verifyNever(() => mockMessageLocalRepository.putAllMessages(messages: any(named: 'messages')));
      },
    );

    test(
      'Given params with onlyAfter true, When latest message exists, Then sets afterSequence in request',
      () async {
        // Given
        final paramsWithOnlyAfter = testParams.copyWith(onlyAfter: true);
        final latestMessage = testMessageEntity.copyWith(sequence: 9876543210);
        final emptyResponse = GetMessageFromServerEntity(messages: []);

        when(() => mockMessageLocalRepository.getLastSequenceByRoom(any())).thenAnswer((_) async => latestMessage);
        when(() => mockMessageServerRepository.getMessageInRoom(any())).thenAnswer((_) async => emptyResponse);

        // When
        final result = await useCase(paramsWithOnlyAfter);

        // Then
        expect(result, isNotNull);
        expect(result?.isEmpty, isTrue);
        verify(() => mockMessageLocalRepository.getLastSequenceByRoom('test-room-id')).called(1);
        verify(() => mockMessageServerRepository.getMessageInRoom(any())).called(1);
      },
    );

    test(
      'Given params with onlyAfter true, When latest message is null, Then continues without afterSequence',
      () async {
        // Given
        final paramsWithOnlyAfter = testParams.copyWith(onlyAfter: true);
        final emptyResponse = GetMessageFromServerEntity(messages: []);

        when(() => mockMessageLocalRepository.getLastSequenceByRoom(any())).thenAnswer((_) async => null);
        when(() => mockMessageServerRepository.getMessageInRoom(any())).thenAnswer((_) async => emptyResponse);

        // When
        final result = await useCase(paramsWithOnlyAfter);

        // Then
        expect(result, isNotNull);
        expect(result?.isEmpty, isTrue);
        verify(() => mockMessageLocalRepository.getLastSequenceByRoom('test-room-id')).called(1);
        verify(() => mockMessageServerRepository.getMessageInRoom(any())).called(1);
      },
    );

    test(
      'Given params with onlyAfter true, When getLastSequenceByRoom throws exception, Then logs error and continues',
      () async {
        // Given
        final paramsWithOnlyAfter = testParams.copyWith(onlyAfter: true);
        final exception = Exception('Database error');
        final emptyResponse = GetMessageFromServerEntity(messages: []);

        when(() => mockMessageLocalRepository.getLastSequenceByRoom(any())).thenThrow(exception);
        when(() => mockMessageServerRepository.getMessageInRoom(any())).thenAnswer((_) async => emptyResponse);

        // When
        final result = await useCase(paramsWithOnlyAfter);

        // Then
        expect(result, isNotNull);
        expect(result?.isEmpty, isTrue);
        verify(() => mockMessageLocalRepository.getLastSequenceByRoom('test-room-id')).called(1);
        verify(() => mockLogger.i('Get last sequence by room error.', exception, any())).called(1);
        verify(() => mockMessageServerRepository.getMessageInRoom(any())).called(1);
      },
    );

    test(
      'Given params with onlyPrevious true, When room subscription has oldestMsgSeq, Then uses oldestMsgSeq for beforeSequence',
      () async {
        // Given
        final paramsWithOnlyPrevious = testParams.copyWith(onlyPrevious: true);
        final roomSub = const RoomSubscriptionEntity(roomId: 'test-room-id', oldestMsgSeq: 1111111111);
        final emptyResponse = GetMessageFromServerEntity(messages: []);

        when(() => mockRoomSubLocalRepository.getRoomSubscriptionWithRoomId(any())).thenAnswer((_) async => roomSub);
        when(() => mockMessageServerRepository.getMessageInRoom(any())).thenAnswer((_) async => emptyResponse);

        // When
        final result = await useCase(paramsWithOnlyPrevious);

        // Then
        expect(result, isNotNull);
        expect(result?.isEmpty, isTrue);
        verify(() => mockRoomSubLocalRepository.getRoomSubscriptionWithRoomId('test-room-id')).called(1);
        verify(() => mockMessageServerRepository.getMessageInRoom(any())).called(1);
        verifyNever(() => mockMessageLocalRepository.getFirstSequenceByRoom(any()));
      },
    );

    test(
      'Given params with onlyPrevious true, When room subscription has null oldestMsgSeq, Then gets oldest message from local',
      () async {
        // Given
        final paramsWithOnlyPrevious = testParams.copyWith(onlyPrevious: true);
        final roomSub = const RoomSubscriptionEntity(roomId: 'test-room-id', oldestMsgSeq: null);
        final oldestMessage = testMessageEntity.copyWith(sequence: 1111111111);
        final emptyResponse = GetMessageFromServerEntity(messages: []);

        when(() => mockRoomSubLocalRepository.getRoomSubscriptionWithRoomId(any())).thenAnswer((_) async => roomSub);
        when(() => mockMessageLocalRepository.getFirstSequenceByRoom(any())).thenAnswer((_) async => oldestMessage);
        when(() => mockMessageServerRepository.getMessageInRoom(any())).thenAnswer((_) async => emptyResponse);

        // When
        final result = await useCase(paramsWithOnlyPrevious);

        // Then
        expect(result, isNotNull);
        expect(result?.isEmpty, isTrue);
        verify(() => mockRoomSubLocalRepository.getRoomSubscriptionWithRoomId('test-room-id')).called(1);
        verify(() => mockMessageLocalRepository.getFirstSequenceByRoom('test-room-id')).called(1);
        verify(() => mockMessageServerRepository.getMessageInRoom(any())).called(1);
      },
    );

    test(
      'Given params with onlyPrevious true, When room subscription is null, Then gets oldest message from local',
      () async {
        // Given
        final paramsWithOnlyPrevious = testParams.copyWith(onlyPrevious: true);
        final oldestMessage = testMessageEntity.copyWith(sequence: 1111111111);
        final emptyResponse = GetMessageFromServerEntity(messages: []);

        when(() => mockRoomSubLocalRepository.getRoomSubscriptionWithRoomId(any())).thenAnswer((_) async => null);
        when(() => mockMessageLocalRepository.getFirstSequenceByRoom(any())).thenAnswer((_) async => oldestMessage);
        when(() => mockMessageServerRepository.getMessageInRoom(any())).thenAnswer((_) async => emptyResponse);

        // When
        final result = await useCase(paramsWithOnlyPrevious);

        // Then
        expect(result, isNotNull);
        expect(result?.isEmpty, isTrue);
        verify(() => mockRoomSubLocalRepository.getRoomSubscriptionWithRoomId('test-room-id')).called(1);
        verify(() => mockMessageLocalRepository.getFirstSequenceByRoom('test-room-id')).called(1);
        verify(() => mockMessageServerRepository.getMessageInRoom(any())).called(1);
      },
    );

    test(
      'Given params with onlyPrevious true, When both room subscription and oldest message are null, Then continues without beforeSequence',
      () async {
        // Given
        final paramsWithOnlyPrevious = testParams.copyWith(onlyPrevious: true);
        final emptyResponse = GetMessageFromServerEntity(messages: []);

        when(() => mockRoomSubLocalRepository.getRoomSubscriptionWithRoomId(any())).thenAnswer((_) async => null);
        when(() => mockMessageLocalRepository.getFirstSequenceByRoom(any())).thenAnswer((_) async => null);
        when(() => mockMessageServerRepository.getMessageInRoom(any())).thenAnswer((_) async => emptyResponse);

        // When
        final result = await useCase(paramsWithOnlyPrevious);

        // Then
        expect(result, isNotNull);
        expect(result?.isEmpty, isTrue);
        verify(() => mockRoomSubLocalRepository.getRoomSubscriptionWithRoomId('test-room-id')).called(1);
        verify(() => mockMessageLocalRepository.getFirstSequenceByRoom('test-room-id')).called(1);
        verify(() => mockMessageServerRepository.getMessageInRoom(any())).called(1);
      },
    );

    test(
      'Given params with onlyPrevious true, When getRoomSubscriptionWithRoomId throws exception, Then logs error and continues',
      () async {
        // Given
        final paramsWithOnlyPrevious = testParams.copyWith(onlyPrevious: true);
        final exception = Exception('Database error');
        final emptyResponse = GetMessageFromServerEntity(messages: []);

        when(() => mockRoomSubLocalRepository.getRoomSubscriptionWithRoomId(any())).thenThrow(exception);
        when(() => mockMessageServerRepository.getMessageInRoom(any())).thenAnswer((_) async => emptyResponse);

        // When
        final result = await useCase(paramsWithOnlyPrevious);

        // Then
        expect(result, isNotNull);
        expect(result?.isEmpty, isTrue);
        verify(() => mockRoomSubLocalRepository.getRoomSubscriptionWithRoomId('test-room-id')).called(1);
        verify(() => mockLogger.i('Get first sequence by room error.', exception, any())).called(1);
        verify(() => mockMessageServerRepository.getMessageInRoom(any())).called(1);
        verifyNever(() => mockMessageLocalRepository.getFirstSequenceByRoom(any()));
      },
    );

    test(
      'Given params with bookmark tag, When use case is called, Then includes bookmarkTagId in request',
      () async {
        // Given
        final paramsWithBookmark = testParams.copyWith(bookmarkTagId: 'bookmark-tag-123');
        final emptyResponse = GetMessageFromServerEntity(messages: []);
        when(() => mockMessageServerRepository.getMessageInRoom(any())).thenAnswer((_) async => emptyResponse);

        // When
        final result = await useCase(paramsWithBookmark);

        // Then
        expect(result, isNotNull);
        expect(result?.isEmpty, isTrue);
        verify(() => mockMessageServerRepository.getMessageInRoom(any())).called(1);
      },
    );

    test(
      'Given params with isMyNote true, When use case is called, Then includes isMyNote in request',
      () async {
        // Given
        final paramsWithMyNote = testParams.copyWith(isMyNote: true);
        final emptyResponse = GetMessageFromServerEntity(messages: []);
        when(() => mockMessageServerRepository.getMessageInRoom(any())).thenAnswer((_) async => emptyResponse);

        // When
        final result = await useCase(paramsWithMyNote);

        // Then
        expect(result, isNotNull);
        expect(result?.isEmpty, isTrue);
        verify(() => mockMessageServerRepository.getMessageInRoom(any())).called(1);
      },
    );

    test(
      'Given request creation with all parameters, When use case is called, Then creates request with correct values',
      () async {
        // Given
        final complexParams = GetMessageFromServerParam(
          roomId: 'complex-room-id',
          pageSize: 50,
          isMyNote: true,
          bookmarkTagId: 'bookmark-123',
          onlyAfter: false,
          onlyPrevious: false,
        );
        final emptyResponse = GetMessageFromServerEntity(messages: []);

        when(() => mockMessageServerRepository.getMessageInRoom(any())).thenAnswer((_) async => emptyResponse);

        // When
        final result = await useCase(complexParams);

        // Then
        expect(result, isNotNull);
        expect(result?.isEmpty, isTrue);
        verify(() => mockMessageServerRepository.getMessageInRoom(any())).called(1);
      },
    );

    test(
      'Given response with messages, When use case is called, Then processes messages and saves to local',
      () async {
        // Given
        final messageCollection = MessageCollection(
          id: 'msg-1',
          roomId: 'test-room-id',
          message: 'Test message',
          sequence: 1234567890,
          type: MessageType.text,
        );
        final messageEntity = messageCollection.toEntity();
        final responseWithMessages = GetMessageFromServerEntity(messages: [messageEntity]);
        final room = const RoomEntity(id: 'test-room-id', roomType: RoomType.direct);

        when(() => mockMessageServerRepository.getMessageInRoom(any())).thenAnswer((_) async => responseWithMessages);
        when(() => mockChatRoomLocalRepository.getRoom(any())).thenAnswer((_) async => room);
        when(() => mockEncryptionHelper.createRoomCryptoKey(any())).thenAnswer((_) async => null);
        when(() => mockEncryptionHelper.getCryptoKeyObj(cryptoKey: any(named: 'cryptoKey')))
            .thenAnswer((_) async => null);
        when(() => mockMessageLocalRepository.putAllMessages(messages: any(named: 'messages')))
            .thenAnswer((_) async {});

        // When
        final result = await useCase(testParams);

        // Then
        expect(result, isNotNull);
        expect(result?.length, equals(1));
        expect(result?.first.id, equals('msg-1'));
        verify(() => mockChatRoomLocalRepository.getRoom('test-room-id')).called(1);
        verify(() => mockEncryptionHelper.createRoomCryptoKey(any())).called(1);
        verify(() => mockMessageLocalRepository.putAllMessages(messages: any(named: 'messages'))).called(1);
      },
    );

    test(
      'Given response with messages and secret room, When use case is called, Then creates secret room crypto key',
      () async {
        // Given
        final messageCollection = MessageCollection(
          id: 'msg-1',
          roomId: 'test-room-id',
          message: 'Test message',
          sequence: 1234567890,
          type: MessageType.text,
        );
        final messageEntity = messageCollection.toEntity();
        final responseWithMessages = GetMessageFromServerEntity(messages: [messageEntity]);
        final secretRoom = const RoomEntity(id: 'test-room-id', roomType: RoomType.directSecret);

        when(() => mockMessageServerRepository.getMessageInRoom(any())).thenAnswer((_) async => responseWithMessages);
        when(() => mockChatRoomLocalRepository.getRoom(any())).thenAnswer((_) async => secretRoom);
        when(() => mockEncryptionHelper.createSecretRoomCryptoKey(any())).thenAnswer((_) async => null);
        when(() => mockEncryptionHelper.getCryptoKeyObj(cryptoKey: any(named: 'cryptoKey')))
            .thenAnswer((_) async => null);
        when(() => mockMessageLocalRepository.putAllMessages(messages: any(named: 'messages')))
            .thenAnswer((_) async {});

        // When
        final result = await useCase(testParams);

        // Then
        expect(result, isNotNull);
        expect(result?.length, equals(1));
        verify(() => mockEncryptionHelper.createSecretRoomCryptoKey(any())).called(1);
        verifyNever(() => mockEncryptionHelper.createRoomCryptoKey(any()));
      },
    );
  });
}
