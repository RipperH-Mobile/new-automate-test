import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/get_official_account_contact_use_case.dart';

// Mock classes
class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

// Fake classes (for registerFallbackValue)
class FakeContactEntity extends Fake implements ContactEntity {}

void main() {
  late GetOfficialAccountContactUseCase getOfficialAccountContactUseCase;
  late MockContactLocalRepository mockContactLocalRepository;

  setUpAll(() {
    registerFallbackValue(FakeContactEntity());
  });

  setUp(() {
    mockContactLocalRepository = MockContactLocalRepository();
    getOfficialAccountContactUseCase = GetOfficialAccountContactUseCase(
      contactLocalRepository: mockContactLocalRepository,
    );
  });

  group('GetOfficialAccountContactUseCase', () {
    final tContactList = [
      ContactEntity(id: '1', displayName: 'Official 1', email: 'official1@example.com'),
      ContactEntity(id: '2', displayName: 'Official 2', email: 'official2@example.com'),
    ];

    test(
      'Given GetOfficialAccountContactUseCase is called, When getOfficialContacts returns a list of contacts, Then it should return the list of ContactEntity',
      () async {
        // Given
        when(() => mockContactLocalRepository.getOfficialContacts())
            .thenAnswer((_) async => tContactList);

        // When
        final result = await getOfficialAccountContactUseCase(NoParams());

        // Then
        expect(result, equals(tContactList));
        verify(() => mockContactLocalRepository.getOfficialContacts()).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given GetOfficialAccountContactUseCase is called, When getOfficialContacts returns an empty list, Then it should return an empty list',
      () async {
        // Given
        when(() => mockContactLocalRepository.getOfficialContacts())
            .thenAnswer((_) async => []);

        // When
        final result = await getOfficialAccountContactUseCase(NoParams());

        // Then
        expect(result, isEmpty);
        verify(() => mockContactLocalRepository.getOfficialContacts()).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given GetOfficialAccountContactUseCase is called, When getOfficialContacts throws an exception, Then it should rethrow the exception',
      () async {
        // Given
        final tException = Exception('Failed to get official account contacts');
        when(() => mockContactLocalRepository.getOfficialContacts())
            .thenThrow(tException);

        // When
        final call = getOfficialAccountContactUseCase(NoParams());

        // Then
        await expectLater(call, throwsA(equals(tException)));
        verify(() => mockContactLocalRepository.getOfficialContacts()).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );
  });
}