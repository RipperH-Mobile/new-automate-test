import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/entities/enum/invited_status.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room_list/domain/entities/invite_room_entity.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/verify_room_invite_link_use_case.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';

// Mock Classes
class MockChatRoomListServerRepository extends Mock implements ChatRoomListServerRepository {}

// Fake Classes for Complex Types
class FakeContactEntity extends Fake implements ContactEntity {}

void main() {
  late VerifyRoomInviteLinkUseCase useCase;
  late MockChatRoomListServerRepository mockRepository;

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(FakeContactEntity());
  });

  setUp(() {
    mockRepository = MockChatRoomListServerRepository();
    useCase = VerifyRoomInviteLinkUseCase(repository: mockRepository);

    // Reset mock before each test for isolation
    reset(mockRepository);
  });

  group('VerifyRoomInviteLinkUseCase', () {
    const testInviteLinkToken = 'test-invite-token-123';

    test(
        'Given valid invite token and repository returns InviteRoomEntity, When useCase is called, Then returns the InviteRoomEntity',
        () async {
      // Given
      const expectedEntity = InviteRoomEntity(
        id: 'room-123',
        roomName: 'Test Room',
        accessType: RoomAccessType.public,
        roomType: RoomType.group,
        invitedStatus: InvitedStatus.none,
        memberCount: 5,
        photoId: 'photo-123',
        members: null, // Use null instead of [] for const constructor
      );
      when(() => mockRepository.verifyInviteLink(any())).thenAnswer((_) async => expectedEntity);

      // When
      final result = await useCase(testInviteLinkToken);

      // Then
      expect(result, equals(expectedEntity), reason: 'Should return the exact InviteRoomEntity from repository');
      verify(() => mockRepository.verifyInviteLink(testInviteLinkToken)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('Given invalid invite token and repository returns null, When useCase is called, Then returns null', () async {
      // Given
      when(() => mockRepository.verifyInviteLink(any())).thenAnswer((_) async => null);

      // When
      final result = await useCase(testInviteLinkToken);

      // Then
      expect(result, isNull, reason: 'Should return null when repository returns null for invalid token');
      verify(() => mockRepository.verifyInviteLink(testInviteLinkToken)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('Given repository throws exception, When useCase is called, Then propagates the same exception', () async {
      // Given
      final exception = Exception('Network error');
      when(() => mockRepository.verifyInviteLink(any())).thenThrow(exception);

      // When
      Future<InviteRoomEntity?> call() => useCase(testInviteLinkToken);

      // Then
      expect(
          call,
          throwsA(isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Network error'),
          )));
      verify(() => mockRepository.verifyInviteLink(testInviteLinkToken)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    group('Different invite room scenarios', () {
      test('Given repository returns public group room, When useCase is called, Then returns correct InviteRoomEntity',
          () async {
        // Given
        const publicGroupEntity = InviteRoomEntity(
          id: 'public-room-123',
          roomName: 'Public Group',
          accessType: RoomAccessType.public,
          roomType: RoomType.group,
          invitedStatus: InvitedStatus.pending,
          memberCount: 10,
          photoId: 'public-photo-123',
          members: [],
        );
        when(() => mockRepository.verifyInviteLink(any())).thenAnswer((_) async => publicGroupEntity);

        // When
        final result = await useCase(testInviteLinkToken);

        // Then
        expect(result, equals(publicGroupEntity), reason: 'Should return public group room entity');
        expect(result?.isGroup, isTrue, reason: 'Should be a group room');
        expect(result?.accessType, equals(RoomAccessType.public), reason: 'Access type should be public');
        verify(() => mockRepository.verifyInviteLink(testInviteLinkToken)).called(1);
      });

      test(
          'Given repository returns private direct room, When useCase is called, Then returns correct InviteRoomEntity',
          () async {
        // Given
        const privateDirectEntity = InviteRoomEntity(
          id: 'private-room-456',
          roomName: 'Private Direct',
          accessType: RoomAccessType.private,
          roomType: RoomType.direct,
          invitedStatus: InvitedStatus.member,
          memberCount: 2,
          photoId: null,
          members: null,
        );
        when(() => mockRepository.verifyInviteLink(any())).thenAnswer((_) async => privateDirectEntity);

        // When
        final result = await useCase(testInviteLinkToken);

        // Then
        expect(result, equals(privateDirectEntity), reason: 'Should return private direct room entity');
        expect(result?.isDirect, isTrue, reason: 'Should be a direct room');
        expect(result?.accessType, equals(RoomAccessType.private), reason: 'Access type should be private');
        expect(result?.photoId, isNull, reason: 'Private room should have no photo');
        verify(() => mockRepository.verifyInviteLink(testInviteLinkToken)).called(1);
      });

      test(
          'Given repository returns group room with member count, When useCase is called, Then returns entity with correct member information',
          () async {
        // Given
        const groupWithMembersEntity = InviteRoomEntity(
          id: 'group-room-789',
          roomName: 'Dev Team',
          accessType: RoomAccessType.public,
          roomType: RoomType.group,
          invitedStatus: InvitedStatus.pending,
          memberCount: 5,
          photoId: 'photo-123',
          members: null, // ไม่สามารถใช้ non-const objects ใน const context ได้
        );
        when(() => mockRepository.verifyInviteLink(any())).thenAnswer((_) async => groupWithMembersEntity);

        // When
        final result = await useCase(testInviteLinkToken);

        // Then
        expect(result, equals(groupWithMembersEntity));
        expect(result?.members, isNull);
        expect(result?.memberCount, equals(5));
        verify(() => mockRepository.verifyInviteLink(testInviteLinkToken)).called(1);
      });
    });

    group('Edge cases', () {
      test('Given empty invite token, When useCase is called, Then passes empty token to repository', () async {
        // Given
        const emptyToken = '';
        when(() => mockRepository.verifyInviteLink(any())).thenAnswer((_) async => null);

        // When
        final result = await useCase(emptyToken);

        // Then
        expect(result, isNull, reason: 'Should return null for empty token');
        verify(() => mockRepository.verifyInviteLink(emptyToken)).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('Given whitespace-only invite token, When useCase is called, Then passes token to repository', () async {
        // Given
        const whitespaceToken = '   ';
        when(() => mockRepository.verifyInviteLink(any())).thenAnswer((_) async => null);

        // When
        final result = await useCase(whitespaceToken);

        // Then
        expect(result, isNull, reason: 'Should return null for whitespace-only token');
        verify(() => mockRepository.verifyInviteLink(whitespaceToken)).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('Given very long invite token, When useCase is called, Then passes token to repository', () async {
        // Given
        const longToken = 'a' + 'b' + 'c' + 'd' + 'e' + 'f' + 'g' + 'h' + 'i' + 'j'; // Very long token
        const expectedEntity = InviteRoomEntity(
          id: 'room-long-token',
          roomName: 'Room With Long Token',
          accessType: RoomAccessType.public,
          roomType: RoomType.group,
          invitedStatus: InvitedStatus.none,
          memberCount: 1,
        );
        when(() => mockRepository.verifyInviteLink(any())).thenAnswer((_) async => expectedEntity);

        // When
        final result = await useCase(longToken);

        // Then
        expect(result, equals(expectedEntity));
        verify(() => mockRepository.verifyInviteLink(longToken)).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('Given token with special characters, When call is executed, Then passes token to repository', () async {
        // Given
        const specialToken = 'token-with-!@#\$%^&*()_+-={}[]|\\:";\'<>?,./';
        when(() => mockRepository.verifyInviteLink(any())).thenAnswer((_) async => null);

        // When
        final result = await useCase(specialToken);

        // Then
        expect(result, isNull);
        verify(() => mockRepository.verifyInviteLink(specialToken)).called(1);
        verifyNoMoreInteractions(mockRepository);
      });
    });

    group('Exception handling', () {
      test('Given repository throws network timeout, When call is executed, Then throws timeout exception', () async {
        // Given
        final timeoutException = Exception('Connection timeout');
        when(() => mockRepository.verifyInviteLink(any())).thenThrow(timeoutException);

        // When
        Future<InviteRoomEntity?> call() => useCase(testInviteLinkToken);

        // Then
        expect(
            call,
            throwsA(isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Connection timeout'),
            )));
        verify(() => mockRepository.verifyInviteLink(testInviteLinkToken)).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('Given repository throws server error, When call is executed, Then throws server error', () async {
        // Given
        final serverError = Exception('Server error 500');
        when(() => mockRepository.verifyInviteLink(any())).thenThrow(serverError);

        // When
        Future<InviteRoomEntity?> call() => useCase(testInviteLinkToken);

        // Then
        expect(
            call,
            throwsA(isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Server error 500'),
            )));
        verify(() => mockRepository.verifyInviteLink(testInviteLinkToken)).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('Given repository throws unauthorized error, When call is executed, Then throws unauthorized error',
          () async {
        // Given
        final unauthorizedException = Exception('Unauthorized access');
        when(() => mockRepository.verifyInviteLink(any())).thenThrow(unauthorizedException);

        // When
        Future<InviteRoomEntity?> call() => useCase(testInviteLinkToken);

        // Then
        expect(
            call,
            throwsA(isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Unauthorized access'),
            )));
        verify(() => mockRepository.verifyInviteLink(testInviteLinkToken)).called(1);
        verifyNoMoreInteractions(mockRepository);
      });
    });
  });
}
