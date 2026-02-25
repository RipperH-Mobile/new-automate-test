import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/entities/models/contact_model.dart';
import 'package:uchat/features/chat_room/domain/chat_room_domain.dart';

class MockRoomMemberLocalRepository extends Mock implements RoomMemberLocalRepository {}

class MockChatRoomLocalCompatRepository extends Mock implements ChatRoomLocalCompatRepository {}

class FakeRoomEntity extends Fake implements RoomEntity {}

void main() {
  late ExpireAllSecretChatWithAccountIdUseCase useCase;
  late MockRoomMemberLocalRepository mockRoomMemberLocalRepository;
  late MockChatRoomLocalCompatRepository mockChatRoomLocalRepository;

  setUpAll(() {
    registerFallbackValue(FakeRoomEntity());
  });

  setUp(() {
    mockRoomMemberLocalRepository = MockRoomMemberLocalRepository();
    mockChatRoomLocalRepository = MockChatRoomLocalCompatRepository();
    useCase = ExpireAllSecretChatWithAccountIdUseCase(
      roomMemberLocalRepository: mockRoomMemberLocalRepository,
      chatRoomLocalRepository: mockChatRoomLocalRepository,
    );
  });

  group('ExpireAllSecretChatWithAccountIdUseCase', () {
    const testAccountId = 'test-account-id';
    const testParams = ExpireAllSecretChatWithAccountIdParams(accountId: testAccountId);

    group('call', () {
      test('Given no members found, When call is executed, Then no rooms are updated', () async {
        // Given
        when(() => mockRoomMemberLocalRepository.getMemberWithIdInSecretChat(testAccountId))
            .thenAnswer((_) async => <RoomMemberEntity>[]);

        // When
        await useCase.call(testParams);

        // Then
        verify(() => mockRoomMemberLocalRepository.getMemberWithIdInSecretChat(testAccountId)).called(1);
        verifyNever(() => mockChatRoomLocalRepository.getRoom(any()));
        verifyNever(() => mockChatRoomLocalRepository.putOrUpdateRoom(any()));
      });

      test('Given members with null roomId, When call is executed, Then throws exception', () async {
        // Given
        final memberWithNullRoomId = RoomMemberEntity(
          account: ContactModel(id: testAccountId),
          roomId: '1',
          roomType: RoomType.directSecret,
        );
        when(() => mockRoomMemberLocalRepository.getMemberWithIdInSecretChat(testAccountId))
            .thenAnswer((_) async => [memberWithNullRoomId]);

        // When & Then
        expect(() => useCase.call(testParams), throwsA(isA<TypeError>()));
        verify(() => mockRoomMemberLocalRepository.getMemberWithIdInSecretChat(testAccountId)).called(1);
      });

      test('Given members with valid roomId but room not found, When call is executed, Then no room is updated',
          () async {
        // Given
        const roomId = 'test-room-id';
        final member = RoomMemberEntity(
          account: ContactModel(id: testAccountId),
          roomId: roomId,
          roomType: RoomType.directSecret,
        );
        when(() => mockRoomMemberLocalRepository.getMemberWithIdInSecretChat(testAccountId))
            .thenAnswer((_) async => [member]);
        when(() => mockChatRoomLocalRepository.getRoom(roomId)).thenAnswer((_) async => null);

        // When
        await useCase.call(testParams);

        // Then
        verify(() => mockRoomMemberLocalRepository.getMemberWithIdInSecretChat(testAccountId)).called(1);
        verify(() => mockChatRoomLocalRepository.getRoom(roomId)).called(1);
        verifyNever(() => mockChatRoomLocalRepository.putOrUpdateRoom(any()));
      });

      test(
          'Given members with valid roomId and room found, When call is executed, Then room expireAt is updated to 1998',
          () async {
        // Given
        const roomId = 'test-room-id';
        final member = RoomMemberEntity(
          account: ContactModel(id: testAccountId),
          roomId: roomId,
          roomType: RoomType.directSecret,
        );
        final originalRoom = RoomEntity(
          id: roomId,
          roomType: RoomType.directSecret,
          expireAt: DateTime.now().add(const Duration(days: 7)),
        );
        final expectedUpdatedRoom = originalRoom.copyWith(
          expireAt: DateTime(1998),
        );

        when(() => mockRoomMemberLocalRepository.getMemberWithIdInSecretChat(testAccountId))
            .thenAnswer((_) async => [member]);
        when(() => mockChatRoomLocalRepository.getRoom(roomId)).thenAnswer((_) async => originalRoom);
        when(() => mockChatRoomLocalRepository.putOrUpdateRoom(any())).thenAnswer((_) async {});

        // When
        await useCase.call(testParams);

        // Then
        verify(() => mockRoomMemberLocalRepository.getMemberWithIdInSecretChat(testAccountId)).called(1);
        verify(() => mockChatRoomLocalRepository.getRoom(roomId)).called(1);

        final captured = verify(() => mockChatRoomLocalRepository.putOrUpdateRoom(captureAny())).captured;
        expect(captured.length, equals(1));
        final updatedRoom = captured.first as RoomEntity;
        expect(updatedRoom.id, equals(expectedUpdatedRoom.id));
        expect(updatedRoom.roomType, equals(expectedUpdatedRoom.roomType));
        expect(updatedRoom.expireAt, equals(DateTime(1998)));
      });

      test('Given multiple members with different rooms, When call is executed, Then all valid rooms are updated',
          () async {
        // Given
        const roomId1 = 'test-room-id-1';
        const roomId2 = 'test-room-id-2';
        const roomId3 = 'test-room-id-3';

        final member1 = RoomMemberEntity(
          account: ContactModel(id: testAccountId),
          roomId: roomId1,
          roomType: RoomType.directSecret,
        );
        final member2 = RoomMemberEntity(
          account: ContactModel(id: testAccountId),
          roomId: roomId2,
          roomType: RoomType.directSecret,
        );
        final member3 = RoomMemberEntity(
          account: ContactModel(id: testAccountId),
          roomId: roomId3,
          roomType: RoomType.directSecret,
        );

        final room1 = RoomEntity(
          id: roomId1,
          roomType: RoomType.directSecret,
          expireAt: DateTime.now().add(const Duration(days: 7)),
        );
        final room2 = RoomEntity(
          id: roomId2,
          roomType: RoomType.directSecret,
          expireAt: DateTime.now().add(const Duration(days: 14)),
        );

        when(() => mockRoomMemberLocalRepository.getMemberWithIdInSecretChat(testAccountId))
            .thenAnswer((_) async => [member1, member2, member3]);
        when(() => mockChatRoomLocalRepository.getRoom(roomId1)).thenAnswer((_) async => room1);
        when(() => mockChatRoomLocalRepository.getRoom(roomId2)).thenAnswer((_) async => room2);
        when(() => mockChatRoomLocalRepository.getRoom(roomId3)).thenAnswer((_) async => null); // Room not found
        when(() => mockChatRoomLocalRepository.putOrUpdateRoom(any())).thenAnswer((_) async {});

        // When
        await useCase.call(testParams);

        // Then
        verify(() => mockRoomMemberLocalRepository.getMemberWithIdInSecretChat(testAccountId)).called(1);
        verify(() => mockChatRoomLocalRepository.getRoom(roomId1)).called(1);
        verify(() => mockChatRoomLocalRepository.getRoom(roomId2)).called(1);
        verify(() => mockChatRoomLocalRepository.getRoom(roomId3)).called(1);

        final captured = verify(() => mockChatRoomLocalRepository.putOrUpdateRoom(captureAny())).captured;
        expect(captured.length, equals(2)); // Only room1 and room2 should be updated

        final updatedRoom1 = captured[0] as RoomEntity;
        final updatedRoom2 = captured[1] as RoomEntity;

        expect(updatedRoom1.id, equals(roomId1));
        expect(updatedRoom1.expireAt, equals(DateTime(1998)));
        expect(updatedRoom2.id, equals(roomId2));
        expect(updatedRoom2.expireAt, equals(DateTime(1998)));
      });

      test('Given getMemberWithIdInSecretChat throws exception, When call is executed, Then exception is propagated',
          () async {
        // Given
        final exception = Exception('Database error');
        when(() => mockRoomMemberLocalRepository.getMemberWithIdInSecretChat(testAccountId)).thenThrow(exception);

        // When & Then
        await expectLater(() => useCase.call(testParams), throwsA(equals(exception)));
        verify(() => mockRoomMemberLocalRepository.getMemberWithIdInSecretChat(testAccountId)).called(1);
        verifyNever(() => mockChatRoomLocalRepository.getRoom(any()));
        verifyNever(() => mockChatRoomLocalRepository.putOrUpdateRoom(any()));
      });

      test('Given getRoom throws exception, When call is executed, Then exception is propagated', () async {
        // Given
        const roomId = 'test-room-id';
        final member = RoomMemberEntity(
          account: ContactModel(id: testAccountId),
          roomId: roomId,
          roomType: RoomType.directSecret,
        );
        final exception = Exception('Room fetch error');

        when(() => mockRoomMemberLocalRepository.getMemberWithIdInSecretChat(testAccountId))
            .thenAnswer((_) async => [member]);
        when(() => mockChatRoomLocalRepository.getRoom(roomId)).thenThrow(exception);

        // When & Then
        await expectLater(() => useCase.call(testParams), throwsA(equals(exception)));
        verify(() => mockRoomMemberLocalRepository.getMemberWithIdInSecretChat(testAccountId)).called(1);
        verify(() => mockChatRoomLocalRepository.getRoom(roomId)).called(1);
        verifyNever(() => mockChatRoomLocalRepository.putOrUpdateRoom(any()));
      });

      test('Given putOrUpdateRoom throws exception, When call is executed, Then exception is propagated', () async {
        // Given
        const roomId = 'test-room-id';
        final member = RoomMemberEntity(
          account: ContactModel(id: testAccountId),
          roomId: roomId,
          roomType: RoomType.directSecret,
        );
        final room = RoomEntity(
          id: roomId,
          roomType: RoomType.directSecret,
          expireAt: DateTime.now().add(const Duration(days: 7)),
        );
        final exception = Exception('Room update error');

        when(() => mockRoomMemberLocalRepository.getMemberWithIdInSecretChat(testAccountId))
            .thenAnswer((_) async => [member]);
        when(() => mockChatRoomLocalRepository.getRoom(roomId)).thenAnswer((_) async => room);
        when(() => mockChatRoomLocalRepository.putOrUpdateRoom(any())).thenThrow(exception);

        // When & Then
        await expectLater(() => useCase.call(testParams), throwsA(equals(exception)));
        verify(() => mockRoomMemberLocalRepository.getMemberWithIdInSecretChat(testAccountId)).called(1);
        verify(() => mockChatRoomLocalRepository.getRoom(roomId)).called(1);
        verify(() => mockChatRoomLocalRepository.putOrUpdateRoom(any())).called(1);
      });

      test('Given room with existing expireAt, When call is executed, Then expireAt is overwritten to 1998', () async {
        // Given
        const roomId = 'test-room-id';
        final member = RoomMemberEntity(
          account: ContactModel(id: testAccountId),
          roomId: roomId,
          roomType: RoomType.directSecret,
        );
        final originalExpireAt = DateTime(2025, 12, 31);
        final originalRoom = RoomEntity(
          id: roomId,
          roomType: RoomType.directSecret,
          roomName: 'Secret Chat',
          expireAt: originalExpireAt,
          expireIn: 604800, // 7 days in seconds
        );

        when(() => mockRoomMemberLocalRepository.getMemberWithIdInSecretChat(testAccountId))
            .thenAnswer((_) async => [member]);
        when(() => mockChatRoomLocalRepository.getRoom(roomId)).thenAnswer((_) async => originalRoom);
        when(() => mockChatRoomLocalRepository.putOrUpdateRoom(any())).thenAnswer((_) async {});

        // When
        await useCase.call(testParams);

        // Then
        verify(() => mockRoomMemberLocalRepository.getMemberWithIdInSecretChat(testAccountId)).called(1);
        verify(() => mockChatRoomLocalRepository.getRoom(roomId)).called(1);

        final captured = verify(() => mockChatRoomLocalRepository.putOrUpdateRoom(captureAny())).captured;
        expect(captured.length, equals(1));
        final updatedRoom = captured.first as RoomEntity;

        // Verify that all other properties remain unchanged
        expect(updatedRoom.id, equals(originalRoom.id));
        expect(updatedRoom.roomType, equals(originalRoom.roomType));
        expect(updatedRoom.roomName, equals(originalRoom.roomName));
        expect(updatedRoom.expireIn, equals(originalRoom.expireIn));

        // Verify that expireAt is updated to 1998
        expect(updatedRoom.expireAt, equals(DateTime(1998)));
        expect(updatedRoom.expireAt, isNot(equals(originalExpireAt)));
      });

      test('Given room with null expireAt, When call is executed, Then expireAt is set to 1998', () async {
        // Given
        const roomId = 'test-room-id';
        final member = RoomMemberEntity(
          account: ContactModel(id: testAccountId),
          roomId: roomId,
          roomType: RoomType.directSecret,
        );
        const originalRoom = RoomEntity(
          id: roomId,
          roomType: RoomType.directSecret,
          expireAt: null, // No expiration set
        );

        when(() => mockRoomMemberLocalRepository.getMemberWithIdInSecretChat(testAccountId))
            .thenAnswer((_) async => [member]);
        when(() => mockChatRoomLocalRepository.getRoom(roomId)).thenAnswer((_) async => originalRoom);
        when(() => mockChatRoomLocalRepository.putOrUpdateRoom(any())).thenAnswer((_) async {});

        // When
        await useCase.call(testParams);

        // Then
        verify(() => mockRoomMemberLocalRepository.getMemberWithIdInSecretChat(testAccountId)).called(1);
        verify(() => mockChatRoomLocalRepository.getRoom(roomId)).called(1);

        final captured = verify(() => mockChatRoomLocalRepository.putOrUpdateRoom(captureAny())).captured;
        expect(captured.length, equals(1));
        final updatedRoom = captured.first as RoomEntity;

        expect(updatedRoom.id, equals(originalRoom.id));
        expect(updatedRoom.roomType, equals(originalRoom.roomType));
        expect(updatedRoom.expireAt, equals(DateTime(1998)));
      });
    });
  });
}
