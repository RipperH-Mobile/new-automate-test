import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/data/models/requests/unpin_all_messages_request.dart';
import 'package:uchat/features/chat_room/domain/repositories/pin_message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/pin_message_server_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/unpin_all_messages_in_room_use_case.dart';

class MockPinMessageLocalRepository extends Mock implements PinMessageLocalRepository {}

class MockPinMessageServerRepository extends Mock implements PinMessageServerRepository {}

// Fake class for UnpinAllMessagesRequest
class FakeUnpinAllMessagesRequest extends Fake implements UnpinAllMessagesRequest {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeUnpinAllMessagesRequest());
  });
  late UnpinAllMessagesInRoomUseCase useCase;
  late MockPinMessageLocalRepository mockPinMessageLocalRepository;
  late MockPinMessageServerRepository mockPinMessageServerRepository;

  setUp(() {
    mockPinMessageLocalRepository = MockPinMessageLocalRepository();
    mockPinMessageServerRepository = MockPinMessageServerRepository();

    useCase = UnpinAllMessagesInRoomUseCase(
      pinMessageLocalRepository: mockPinMessageLocalRepository,
      pinMessageServerRepository: mockPinMessageServerRepository,
    );
  });

  tearDown(() {
    reset(mockPinMessageLocalRepository);
    reset(mockPinMessageServerRepository);
  });

  group('UnpinAllMessagesInRoomUseCase', () {
    group('call', () {
      test('Given valid request, When call is invoked, Then unpins all messages on server and local repository',
          () async {
        // Given
        final request = UnpinAllMessagesRequest(roomId: 'test-room-id');

        when(() => mockPinMessageServerRepository.unpinAllMessages(any())).thenAnswer((_) async {});

        when(() => mockPinMessageLocalRepository.unpinAllMessagesInRoom(any())).thenAnswer((_) async {});

        // When
        await useCase.call(request);

        // Then
        verify(() => mockPinMessageServerRepository.unpinAllMessages(any())).called(1);
        verify(() => mockPinMessageLocalRepository.unpinAllMessagesInRoom(any())).called(1);

        verifyNoMoreInteractions(mockPinMessageServerRepository);
        verifyNoMoreInteractions(mockPinMessageLocalRepository);
      });

      test(
          'Given server repository throws exception, When call is invoked, Then exception is propagated and local repository is not called',
          () async {
        // Given
        final request = UnpinAllMessagesRequest(roomId: 'test-room-id');
        final testException = Exception('Server error');

        when(() => mockPinMessageServerRepository.unpinAllMessages(any())).thenThrow(testException);

        // When
        Future<void> call() => useCase.call(request);

        // Then
        await expectLater(call, throwsA(isA<Exception>()));

        verify(() => mockPinMessageServerRepository.unpinAllMessages(any())).called(1);
        verifyZeroInteractions(mockPinMessageLocalRepository);
      });

      test('Given local repository throws exception, When call is invoked, Then exception is propagated', () async {
        // Given
        final request = UnpinAllMessagesRequest(roomId: 'test-room-id');
        final testException = Exception('Local repository error');

        when(() => mockPinMessageServerRepository.unpinAllMessages(any())).thenAnswer((_) async {});

        when(() => mockPinMessageLocalRepository.unpinAllMessagesInRoom(any())).thenThrow(testException);

        // When
        Future<void> call() => useCase.call(request);

        // Then
        await expectLater(call, throwsA(isA<Exception>()));

        verify(() => mockPinMessageServerRepository.unpinAllMessages(any())).called(1);
        verify(() => mockPinMessageLocalRepository.unpinAllMessagesInRoom(any())).called(1);
      });

      test('Given empty room ID, When call is invoked, Then processes correctly with empty room ID', () async {
        // Given
        final request = UnpinAllMessagesRequest(roomId: '');

        when(() => mockPinMessageServerRepository.unpinAllMessages(any())).thenAnswer((_) async {});

        when(() => mockPinMessageLocalRepository.unpinAllMessagesInRoom(any())).thenAnswer((_) async {});

        // When
        await useCase.call(request);

        // Then
        verify(() => mockPinMessageServerRepository.unpinAllMessages(any())).called(1);
        verify(() => mockPinMessageLocalRepository.unpinAllMessagesInRoom(any())).called(1);

        verifyNoMoreInteractions(mockPinMessageServerRepository);
        verifyNoMoreInteractions(mockPinMessageLocalRepository);
      });

      test('Given long room ID, When call is invoked, Then processes correctly', () async {
        // Given
        final longRoomId = 'a' * 1000; // Very long room ID
        final request = UnpinAllMessagesRequest(roomId: longRoomId);

        when(() => mockPinMessageServerRepository.unpinAllMessages(any())).thenAnswer((_) async {});

        when(() => mockPinMessageLocalRepository.unpinAllMessagesInRoom(any())).thenAnswer((_) async {});

        // When
        await useCase.call(request);

        // Then
        verify(() => mockPinMessageServerRepository.unpinAllMessages(any())).called(1);
        verify(() => mockPinMessageLocalRepository.unpinAllMessagesInRoom(any())).called(1);

        verifyNoMoreInteractions(mockPinMessageServerRepository);
        verifyNoMoreInteractions(mockPinMessageLocalRepository);
      });

      test(
          'Given server succeeds but local fails, When call is invoked, Then server operation completes first before local failure',
          () async {
        // Given
        final request = UnpinAllMessagesRequest(roomId: 'test-room-id');
        final testException = Exception('Local repository error');
        var serverCalled = false;

        when(() => mockPinMessageServerRepository.unpinAllMessages(any())).thenAnswer((_) async {
          serverCalled = true;
        });

        when(() => mockPinMessageLocalRepository.unpinAllMessagesInRoom(any())).thenAnswer((_) async {
          if (!serverCalled) {
            fail('Local repository called before server repository');
          }
          throw testException;
        });

        // When
        Future<void> call() => useCase.call(request);

        // Then
        await expectLater(call, throwsA(isA<Exception>()));

        verify(() => mockPinMessageServerRepository.unpinAllMessages(any())).called(1);
        verify(() => mockPinMessageLocalRepository.unpinAllMessagesInRoom(any())).called(1);
      });
    });
  });
}
