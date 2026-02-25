import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_groups_with_me_as_an_owner_use_case.dart';
import 'package:uchat/use_cases/use_case.dart';

// Mock classes
class MockChatRoomLocalRepository extends Mock implements ChatRoomLocalRepository {}

void main() {
  late GetGroupsWithMeAsAnOwnerUseCase useCase;
  late MockChatRoomLocalRepository mockChatRoomLocalRepository;

  setUpAll(() {
    registerFallbackValue(NoParams());
  });

  setUp(() {
    mockChatRoomLocalRepository = MockChatRoomLocalRepository();
    useCase = GetGroupsWithMeAsAnOwnerUseCase(chatRoomLocalRepository: mockChatRoomLocalRepository);
  });

  // Test data
  const tGetGroups = <RoomEntity>[];

  const tGetNull = null;

  final tException = Exception('Something went wrong');

  group('GetGroupsWithMeAsAnOwnerUseCase', () {
    test('Given ChatRoomLocalRepository returns List<RoomEntity>, Then returns List<RoomEntity>', () async {
      // Given
      when(() => mockChatRoomLocalRepository.getGroupsWithMeAsAnOwner()).thenAnswer((_) async => tGetGroups);

      // When
      final result = await useCase(NoParams());

      // Then
      expect(result, equals(tGetGroups));
      verify(() => mockChatRoomLocalRepository.getGroupsWithMeAsAnOwner()).called(1);
      verifyNoMoreInteractions(mockChatRoomLocalRepository);
    });

    test('Given ChatRoomLocalRepository returns null, Then returns null', () async {
      // Given
      when(() => mockChatRoomLocalRepository.getGroupsWithMeAsAnOwner()).thenAnswer((_) async => tGetNull);

      // When
      final result = await useCase(NoParams());

      // Then
      expect(result, equals(tGetNull));
      verify(() => mockChatRoomLocalRepository.getGroupsWithMeAsAnOwner()).called(1);
      verifyNoMoreInteractions(mockChatRoomLocalRepository);
    });

    test('Given ChatRoomLocalRepository throws an exception, When use case is called, Then throws the exception',
        () async {
      // Given
      when(() => mockChatRoomLocalRepository.getGroupsWithMeAsAnOwner()).thenThrow(tException);

      // When
      final call = useCase(NoParams());

      // Then
      await expectLater(call, throwsA(equals(tException)));
      verify(() => mockChatRoomLocalRepository.getGroupsWithMeAsAnOwner()).called(1);
      verifyNoMoreInteractions(mockChatRoomLocalRepository);
    });
  });
}
