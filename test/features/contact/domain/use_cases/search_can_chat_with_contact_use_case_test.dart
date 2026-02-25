import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/search_can_chat_with_contact_use_case.dart';

// Mock classes
class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

// Fake classes (for registerFallbackValue)
class FakeContactEntity extends Fake implements ContactEntity {}

void main() {
  late SearchCanChatWithContactUseCase searchCanChatWithContactUseCase;
  late MockContactLocalRepository mockContactLocalRepository;

  setUpAll(() {
    registerFallbackValue(FakeContactEntity());
  });

  setUp(() {
    mockContactLocalRepository = MockContactLocalRepository();
    searchCanChatWithContactUseCase = SearchCanChatWithContactUseCase(
      contactLocalRepository: mockContactLocalRepository,
    );
  });

  group('SearchCanChatWithContactUseCase', () {
    const tQuery = 'John';
    final tContactList = [
      ContactEntity(id: '1', displayName: 'John Doe', email: 'john@example.com'),
      ContactEntity(id: '3', displayName: 'Johnny Bravo', email: 'johnny@example.com'),
    ];

    test(
      'Given SearchCanChatWithContactUseCase is called, When searchCanChatWithContact returns a list of contacts, Then it should return the list of ContactEntity',
      () async {
        // Given
        when(() => mockContactLocalRepository.searchCanChatWithContact(any()))
            .thenAnswer((_) async => tContactList);

        // When
        final result = await searchCanChatWithContactUseCase(tQuery);

        // Then
        expect(result, equals(tContactList));
        verify(() => mockContactLocalRepository.searchCanChatWithContact(tQuery)).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given SearchCanChatWithContactUseCase is called, When searchCanChatWithContact returns an empty list, Then it should return an empty list',
      () async {
        // Given
        when(() => mockContactLocalRepository.searchCanChatWithContact(any()))
            .thenAnswer((_) async => []);

        // When
        final result = await searchCanChatWithContactUseCase(tQuery);

        // Then
        expect(result, isEmpty);
        verify(() => mockContactLocalRepository.searchCanChatWithContact(tQuery)).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given SearchCanChatWithContactUseCase is called, When searchCanChatWithContact throws an exception, Then it should rethrow the exception',
      () async {
        // Given
        final tException = Exception('Failed to search can chat with contacts');
        when(() => mockContactLocalRepository.searchCanChatWithContact(any()))
            .thenThrow(tException);

        // When
        final call = searchCanChatWithContactUseCase(tQuery);

        // Then
        await expectLater(call, throwsA(equals(tException)));
        verify(() => mockContactLocalRepository.searchCanChatWithContact(tQuery)).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );
  });
}