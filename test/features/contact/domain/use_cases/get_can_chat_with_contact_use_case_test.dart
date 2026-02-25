import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/get_can_chat_with_contact_use_case.dart';

// Mock classes
class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

// Fake classes (for registerFallbackValue)
class FakeContactEntity extends Fake implements ContactEntity {}

void main() {
  late GetCanChatWithContactUseCase getCanChatWithContactUseCase;
  late MockContactLocalRepository mockContactLocalRepository;

  setUpAll(() {
    registerFallbackValue(FakeContactEntity());
  });

  setUp(() {
    mockContactLocalRepository = MockContactLocalRepository();
    getCanChatWithContactUseCase = GetCanChatWithContactUseCase(
      contactLocalRepository: mockContactLocalRepository,
    );
  });

  group('GetCanChatWithContactUseCase', () {
    final tContactList = [
      ContactEntity(id: '1', displayName: 'John Doe', email: 'john@example.com'),
      ContactEntity(id: '2', displayName: 'Jane Smith', email: 'jane@example.com'),
    ];

    test(
      'Given GetCanChatWithContactUseCase is called, When getCanChatWithContact returns a list of contacts, Then it should return the list of ContactEntity',
      () async {
        // Given
        when(() => mockContactLocalRepository.getCanChatWithContact())
            .thenAnswer((_) async => tContactList);

        // When
        final result = await getCanChatWithContactUseCase(NoParams());

        // Then
        expect(result, equals(tContactList));
        verify(() => mockContactLocalRepository.getCanChatWithContact()).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given GetCanChatWithContactUseCase is called, When getCanChatWithContact returns an empty list, Then it should return an empty list',
      () async {
        // Given
        when(() => mockContactLocalRepository.getCanChatWithContact())
            .thenAnswer((_) async => []);

        // When
        final result = await getCanChatWithContactUseCase(NoParams());

        // Then
        expect(result, isEmpty);
        verify(() => mockContactLocalRepository.getCanChatWithContact()).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given GetCanChatWithContactUseCase is called, When getCanChatWithContact throws an exception, Then it should rethrow the exception',
      () async {
        // Given
        final tException = Exception('Failed to get can chat with contacts');
        when(() => mockContactLocalRepository.getCanChatWithContact())
            .thenThrow(tException);

        // When
        final call = getCanChatWithContactUseCase(NoParams());

        // Then
        await expectLater(call, throwsA(equals(tException)));
        verify(() => mockContactLocalRepository.getCanChatWithContact()).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );
  });
}