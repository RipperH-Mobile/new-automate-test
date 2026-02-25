import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/get_friend_contact_list_use_case.dart';

// Mock classes
class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

// Fake classes (for registerFallbackValue)
class FakeContactEntity extends Fake implements ContactEntity {}

void main() {
  late GetFriendContactListUseCase getFriendContactListUseCase;
  late MockContactLocalRepository mockContactLocalRepository;

  setUpAll(() {
    registerFallbackValue(FakeContactEntity());
  });

  setUp(() {
    mockContactLocalRepository = MockContactLocalRepository();
    getFriendContactListUseCase = GetFriendContactListUseCase(
      contactLocalRepository: mockContactLocalRepository,
    );
  });

  group('GetFriendContactListUseCase', () {
    final tContactList = [
      ContactEntity(id: '1', displayName: 'John Doe', email: 'john@example.com'),
      ContactEntity(id: '2', displayName: 'Jane Smith', email: 'jane@example.com'),
    ];

    test(
      'Given GetFriendContactListUseCase is called, When getFriendContacts returns a list of contacts, Then it should return the list of ContactEntity',
      () async {
        // Given
        when(() => mockContactLocalRepository.getFriendContacts())
            .thenAnswer((_) async => tContactList);

        // When
        final result = await getFriendContactListUseCase(NoParams());

        // Then
        expect(result, equals(tContactList));
        verify(() => mockContactLocalRepository.getFriendContacts()).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given GetFriendContactListUseCase is called, When getFriendContacts returns an empty list, Then it should return an empty list',
      () async {
        // Given
        when(() => mockContactLocalRepository.getFriendContacts())
            .thenAnswer((_) async => []);

        // When
        final result = await getFriendContactListUseCase(NoParams());

        // Then
        expect(result, isEmpty);
        verify(() => mockContactLocalRepository.getFriendContacts()).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given GetFriendContactListUseCase is called, When getFriendContacts throws an exception, Then it should rethrow the exception',
      () async {
        // Given
        final tException = Exception('Failed to get friend contacts');
        when(() => mockContactLocalRepository.getFriendContacts())
            .thenThrow(tException);

        // When
        final call = getFriendContactListUseCase(NoParams());

        // Then
        await expectLater(call, throwsA(equals(tException)));
        verify(() => mockContactLocalRepository.getFriendContacts()).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );
  });
}