import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/params/chat_room_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_compat_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_room_by_id_use_case.dart';

class MockChatRoomLocalCompatRepository extends Mock implements ChatRoomLocalCompatRepository {}

void main() {
  late GetRoomByIdUseCase useCase;
  late MockChatRoomLocalCompatRepository mockChatRoomLocalRepository;

  setUp(() {
    mockChatRoomLocalRepository = MockChatRoomLocalCompatRepository();
    useCase = GetRoomByIdUseCase(
      chatRoomLocalRepository: mockChatRoomLocalRepository,
    );
  });

  group('GetRoomByIdUseCase', () {
    const testRoomId = 'test-room-id';
    final testParams = ChatRoomParams(roomId: testRoomId);

    group('call', () {
      test('Given valid roomId and room exists, When call is executed, Then returns RoomEntity', () async {
        // Given
        final expectedRoom = RoomEntity(
          id: testRoomId,
          roomType: RoomType.direct,
          roomName: 'Test Room',
          createdAt: DateTime(2024, 1, 1),
          updatedAt: DateTime(2024, 1, 2),
          isJoined: true,
        );
        when(() => mockChatRoomLocalRepository.getRoom(testRoomId)).thenAnswer((_) async => expectedRoom);

        // When
        final result = await useCase.call(testParams);

        // Then
        expect(result, equals(expectedRoom));
        expect(result?.id, equals(testRoomId));
        expect(result?.roomType, equals(RoomType.direct));
        expect(result?.roomName, equals('Test Room'));
        expect(result?.isJoined, equals(true));
        verify(() => mockChatRoomLocalRepository.getRoom(testRoomId)).called(1);
      });

      test('Given valid roomId but room does not exist, When call is executed, Then returns null', () async {
        // Given
        when(() => mockChatRoomLocalRepository.getRoom(testRoomId)).thenAnswer((_) async => null);

        // When
        final result = await useCase.call(testParams);

        // Then
        expect(result, isNull);
        verify(() => mockChatRoomLocalRepository.getRoom(testRoomId)).called(1);
      });

      test('Given different roomId, When call is executed, Then calls repository with correct roomId', () async {
        // Given
        const differentRoomId = 'different-room-id';
        final differentParams = ChatRoomParams(roomId: differentRoomId);
        const expectedRoom = RoomEntity(
          id: differentRoomId,
          roomType: RoomType.group,
          roomName: 'Different Room',
        );
        when(() => mockChatRoomLocalRepository.getRoom(differentRoomId)).thenAnswer((_) async => expectedRoom);

        // When
        final result = await useCase.call(differentParams);

        // Then
        expect(result, equals(expectedRoom));
        expect(result?.id, equals(differentRoomId));
        expect(result?.roomType, equals(RoomType.group));
        verify(() => mockChatRoomLocalRepository.getRoom(differentRoomId)).called(1);
        verifyNever(() => mockChatRoomLocalRepository.getRoom(testRoomId));
      });

      test('Given repository throws exception, When call is executed, Then exception is propagated', () async {
        // Given
        final exception = Exception('Database connection error');
        when(() => mockChatRoomLocalRepository.getRoom(testRoomId)).thenThrow(exception);

        // When & Then
        await expectLater(() => useCase.call(testParams), throwsA(equals(exception)));
        verify(() => mockChatRoomLocalRepository.getRoom(testRoomId)).called(1);
      });

      test(
          'Given repository throws different exception types, When call is executed, Then correct exception is propagated',
          () async {
        // Given
        final argumentError = ArgumentError('Invalid room ID');
        when(() => mockChatRoomLocalRepository.getRoom(testRoomId)).thenThrow(argumentError);

        // When & Then
        await expectLater(() => useCase.call(testParams), throwsA(equals(argumentError)));
        verify(() => mockChatRoomLocalRepository.getRoom(testRoomId)).called(1);
      });

      test('Given room with all properties set, When call is executed, Then returns complete RoomEntity', () async {
        // Given
        final completeRoom = RoomEntity(
          id: testRoomId,
          roomType: RoomType.directSecret,
          roomName: 'Secret Chat',
          createdAt: DateTime(2024, 1, 1, 10, 30),
          updatedAt: DateTime(2024, 1, 2, 15, 45),
          deleted: false,
          photoId: 'photo-123',
          photoBlurhash: 'blurhash-abc',
          ownerId: 'owner-456',
          groupRef: 'group-ref-789',
          isJoined: true,
          isRequesting: false,
          hasFailedMessage: false,
          draftMessage: 'Draft message content',
          memberCount: 2,
          otherPublicKey: 'other-public-key',
          selfPrivateKey: 'self-private-key',
          expireIn: 3600,
          expireAt: DateTime(2024, 12, 31, 23, 59),
        );
        when(() => mockChatRoomLocalRepository.getRoom(testRoomId)).thenAnswer((_) async => completeRoom);

        // When
        final result = await useCase.call(testParams);

        // Then
        expect(result, equals(completeRoom));
        expect(result?.id, equals(testRoomId));
        expect(result?.roomType, equals(RoomType.directSecret));
        expect(result?.roomName, equals('Secret Chat'));
        expect(result?.createdAt, equals(DateTime(2024, 1, 1, 10, 30)));
        expect(result?.updatedAt, equals(DateTime(2024, 1, 2, 15, 45)));
        expect(result?.deleted, equals(false));
        expect(result?.photoId, equals('photo-123'));
        expect(result?.photoBlurhash, equals('blurhash-abc'));
        expect(result?.ownerId, equals('owner-456'));
        expect(result?.groupRef, equals('group-ref-789'));
        expect(result?.isJoined, equals(true));
        expect(result?.isRequesting, equals(false));
        expect(result?.hasFailedMessage, equals(false));
        expect(result?.draftMessage, equals('Draft message content'));
        expect(result?.memberCount, equals(2));
        expect(result?.otherPublicKey, equals('other-public-key'));
        expect(result?.selfPrivateKey, equals('self-private-key'));
        expect(result?.expireIn, equals(3600));
        expect(result?.expireAt, equals(DateTime(2024, 12, 31, 23, 59)));
        verify(() => mockChatRoomLocalRepository.getRoom(testRoomId)).called(1);
      });

      test(
          'Given room with minimal properties, When call is executed, Then returns RoomEntity with required fields only',
          () async {
        // Given
        const minimalRoom = RoomEntity(
          id: testRoomId,
          roomType: RoomType.bookmark,
        );
        when(() => mockChatRoomLocalRepository.getRoom(testRoomId)).thenAnswer((_) async => minimalRoom);

        // When
        final result = await useCase.call(testParams);

        // Then
        expect(result, equals(minimalRoom));
        expect(result?.id, equals(testRoomId));
        expect(result?.roomType, equals(RoomType.bookmark));
        expect(result?.roomName, isNull);
        expect(result?.createdAt, isNull);
        expect(result?.updatedAt, isNull);
        expect(result?.deleted, isNull);
        expect(result?.isJoined, isNull);
        verify(() => mockChatRoomLocalRepository.getRoom(testRoomId)).called(1);
      });

      test('Given empty roomId, When call is executed, Then calls repository with empty string', () async {
        // Given
        const emptyRoomId = '';
        final emptyParams = ChatRoomParams(roomId: emptyRoomId);
        when(() => mockChatRoomLocalRepository.getRoom(emptyRoomId)).thenAnswer((_) async => null);

        // When
        final result = await useCase.call(emptyParams);

        // Then
        expect(result, isNull);
        verify(() => mockChatRoomLocalRepository.getRoom(emptyRoomId)).called(1);
      });

      test('Given special characters in roomId, When call is executed, Then calls repository with exact roomId',
          () async {
        // Given
        const specialRoomId = 'room-id-with-special-chars-@#\$%^&*()';
        final specialParams = ChatRoomParams(roomId: specialRoomId);
        const expectedRoom = RoomEntity(
          id: specialRoomId,
          roomType: RoomType.group,
          roomName: 'Special Room',
        );
        when(() => mockChatRoomLocalRepository.getRoom(specialRoomId)).thenAnswer((_) async => expectedRoom);

        // When
        final result = await useCase.call(specialParams);

        // Then
        expect(result, equals(expectedRoom));
        expect(result?.id, equals(specialRoomId));
        verify(() => mockChatRoomLocalRepository.getRoom(specialRoomId)).called(1);
      });

      test(
          'Given multiple consecutive calls with same roomId, When call is executed, Then repository is called each time',
          () async {
        // Given
        const expectedRoom = RoomEntity(
          id: testRoomId,
          roomType: RoomType.direct,
          roomName: 'Test Room',
        );
        when(() => mockChatRoomLocalRepository.getRoom(testRoomId)).thenAnswer((_) async => expectedRoom);

        // When
        final result1 = await useCase.call(testParams);
        final result2 = await useCase.call(testParams);
        final result3 = await useCase.call(testParams);

        // Then
        expect(result1, equals(expectedRoom));
        expect(result2, equals(expectedRoom));
        expect(result3, equals(expectedRoom));
        verify(() => mockChatRoomLocalRepository.getRoom(testRoomId)).called(3);
      });

      test(
          'Given repository returns different results for same roomId, When call is executed multiple times, Then returns current repository result',
          () async {
        // Given
        const firstRoom = RoomEntity(
          id: testRoomId,
          roomType: RoomType.direct,
          roomName: 'First Room',
        );
        const secondRoom = RoomEntity(
          id: testRoomId,
          roomType: RoomType.group,
          roomName: 'Updated Room',
        );

        when(() => mockChatRoomLocalRepository.getRoom(testRoomId)).thenAnswer((_) async => firstRoom);

        // When - First call
        final result1 = await useCase.call(testParams);

        // Given - Change repository behavior
        when(() => mockChatRoomLocalRepository.getRoom(testRoomId)).thenAnswer((_) async => secondRoom);

        // When - Second call
        final result2 = await useCase.call(testParams);

        // Then
        expect(result1, equals(firstRoom));
        expect(result1?.roomName, equals('First Room'));
        expect(result1?.roomType, equals(RoomType.direct));

        expect(result2, equals(secondRoom));
        expect(result2?.roomName, equals('Updated Room'));
        expect(result2?.roomType, equals(RoomType.group));

        verify(() => mockChatRoomLocalRepository.getRoom(testRoomId)).called(2);
      });
    });
  });
}
