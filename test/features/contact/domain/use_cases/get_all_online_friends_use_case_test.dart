import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/get_all_online_friends_use_case.dart';
import 'package:uchat/entities/enum/online_status.dart';

// Mock classes
class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

// Fake classes (for registerFallbackValue)
class FakeContactEntity extends Fake implements ContactEntity {}

void main() {
  late GetAllOnlineFriendsUseCase getAllOnlineFriendsUseCase;
  late MockContactLocalRepository mockContactLocalRepository;

  setUpAll(() {
    registerFallbackValue(FakeContactEntity());
  });

  setUp(() {
    mockContactLocalRepository = MockContactLocalRepository();
    getAllOnlineFriendsUseCase = GetAllOnlineFriendsUseCase(
      contactLocalRepository: mockContactLocalRepository,
    );
  });

  group('GetAllOnlineFriendsUseCase', () {
    final tContactList = [
      ContactEntity(
        id: '1',
        displayName: 'John Doe',
        email: 'john@example.com',
        onlineStatus: OnlineStatus.online,
      ),
      ContactEntity(
        id: '2',
        displayName: 'Jane Smith',
        email: 'jane@example.com',
        onlineStatus: OnlineStatus.online,
      ),
    ];

    test(
      'Given GetAllOnlineFriendsUseCase is called, When getAllOnlineFriends returns a list of online friends, Then it should return the list of ContactEntity',
      () async {
        // Given
        when(() => mockContactLocalRepository.getAllOnlineFriends())
            .thenAnswer((_) async => tContactList);

        // When
        final result = await getAllOnlineFriendsUseCase(NoParams());

        // Then
        expect(result, equals(tContactList));
        verify(() => mockContactLocalRepository.getAllOnlineFriends()).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given GetAllOnlineFriendsUseCase is called, When getAllOnlineFriends returns an empty list, Then it should return an empty list',
      () async {
        // Given
        when(() => mockContactLocalRepository.getAllOnlineFriends())
            .thenAnswer((_) async => []);

        // When
        final result = await getAllOnlineFriendsUseCase(NoParams());

        // Then
        expect(result, isEmpty);
        verify(() => mockContactLocalRepository.getAllOnlineFriends()).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given GetAllOnlineFriendsUseCase is called, When getAllOnlineFriends throws an exception, Then it should rethrow the exception',
      () async {
        // Given
        final tException = Exception('Failed to get all online friends');
        when(() => mockContactLocalRepository.getAllOnlineFriends())
            .thenThrow(tException);

        // When
        final call = getAllOnlineFriendsUseCase(NoParams());

        // Then
        await expectLater(call, throwsA(equals(tException)));
        verify(() => mockContactLocalRepository.getAllOnlineFriends()).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );
  });
}