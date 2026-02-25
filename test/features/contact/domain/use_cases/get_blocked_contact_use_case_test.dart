import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/get_blocked_contact_use_case.dart';

// Mock classes
class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

// Fake classes (for registerFallbackValue)
class FakeContactEntity extends Fake implements ContactEntity {}

void main() {
  late GetBlockedContactUseCase getBlockedContactUseCase;
  late MockContactLocalRepository mockContactLocalRepository;

  setUpAll(() {
    registerFallbackValue(FakeContactEntity());
  });

  setUp(() {
    mockContactLocalRepository = MockContactLocalRepository();
    getBlockedContactUseCase = GetBlockedContactUseCase(
      contactLocalRepository: mockContactLocalRepository,
    );
  });

  group('GetBlockedContactUseCase', () {
    final tContactList = [
      ContactEntity(id: '1', displayName: 'John Doe', email: 'john@example.com'),
      ContactEntity(id: '2', displayName: 'Jane Smith', email: 'jane@example.com'),
    ];

    test(
      'Given GetBlockedContactUseCase is called, When getBlockedContact returns a list of contacts, Then it should return the list of ContactEntity',
      () async {
        // Given
        when(() => mockContactLocalRepository.getBlockedContact())
            .thenAnswer((_) async => tContactList);

        // When
        final result = await getBlockedContactUseCase(NoParams());

        // Then
        expect(result, equals(tContactList));
        verify(() => mockContactLocalRepository.getBlockedContact()).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given GetBlockedContactUseCase is called, When getBlockedContact returns an empty list, Then it should return an empty list',
      () async {
        // Given
        when(() => mockContactLocalRepository.getBlockedContact())
            .thenAnswer((_) async => []);

        // When
        final result = await getBlockedContactUseCase(NoParams());

        // Then
        expect(result, isEmpty);
        verify(() => mockContactLocalRepository.getBlockedContact()).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given GetBlockedContactUseCase is called, When getBlockedContact throws an exception, Then it should rethrow the exception',
      () async {
        // Given
        final tException = Exception('Failed to get blocked contacts');
        when(() => mockContactLocalRepository.getBlockedContact())
            .thenThrow(tException);

        // When
        final call = getBlockedContactUseCase(NoParams());

        // Then
        await expectLater(call, throwsA(equals(tException)));
        verify(() => mockContactLocalRepository.getBlockedContact()).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );
  });
}