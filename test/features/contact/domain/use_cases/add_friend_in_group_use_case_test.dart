import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/contact/data/models/requests/add_friend_in_group_request.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_server_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/add_friend_in_group_use_case.dart';

// Mock classes
class MockContactServerRepository extends Mock implements ContactServerRepository {}

// Fake classes
class FakeAddFriendInGroupRequest extends Fake implements AddFriendInGroupRequest {}
class FakeContactEntity extends Fake implements ContactEntity {}

void main() {
  late AddFriendInGroupUseCase addFriendInGroupUseCase;
  late MockContactServerRepository mockContactServerRepository;

  setUpAll(() {
    registerFallbackValue(FakeAddFriendInGroupRequest());
    registerFallbackValue(FakeContactEntity());
  });

  setUp(() {
    mockContactServerRepository = MockContactServerRepository();
    addFriendInGroupUseCase = AddFriendInGroupUseCase(
      contactServerRepository: mockContactServerRepository,
    );
  });

  group('AddFriendInGroupUseCase', () {
    final tFriendAccountId = 'friend123';
    final tRoomId = 'room456';
    final tAddFriendInGroupRequest = AddFriendInGroupRequest(
      friendAccountId: tFriendAccountId,
      roomId: tRoomId,
    );

    final tContactEntity = ContactEntity(
      id: tFriendAccountId,
      displayName: 'Added Friend',
      email: 'added@example.com',
      phoneNumber: '9876543210',
      username: 'added_friend',
      originalIsFriend: true,
      isTyping: false,
    );

    test('Given friend is successfully added to group, When call is made, Then returns ContactEntity', () async {
      // Given
      when(() => mockContactServerRepository.addFriendInGroup(any()))
          .thenAnswer((_) async => tContactEntity);

      // When
      final result = await addFriendInGroupUseCase(tAddFriendInGroupRequest);

      // Then
      expect(result, equals(tContactEntity));
      verify(() => mockContactServerRepository.addFriendInGroup(tAddFriendInGroupRequest)).called(1);
      verifyNoMoreInteractions(mockContactServerRepository);
    });

    test('Given repository throws exception, When call is made, Then rethrows exception', () async {
      // Given
      final tException = Exception('Failed to add friend to group');
      when(() => mockContactServerRepository.addFriendInGroup(any()))
          .thenThrow(tException);

      // When
      final call = addFriendInGroupUseCase(tAddFriendInGroupRequest);

      // Then
      await expectLater(call, throwsA(tException));
      verify(() => mockContactServerRepository.addFriendInGroup(tAddFriendInGroupRequest)).called(1);
      verifyNoMoreInteractions(mockContactServerRepository);
    });
  });
}