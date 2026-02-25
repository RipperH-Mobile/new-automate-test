import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/put_contact_without_txn_use_case.dart';

// Mock classes
class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

// Fake class for ContactEntity
class FakeContactEntity extends Fake implements ContactEntity {}

void main() {
  late PutContactWithoutTxnUseCase useCase;
  late MockContactLocalRepository mockContactLocalRepository;

  setUpAll(() {
    registerFallbackValue(FakeContactEntity());
  });

  setUp(() {
    mockContactLocalRepository = MockContactLocalRepository();
    useCase = PutContactWithoutTxnUseCase(
      contactLocalRepository: mockContactLocalRepository,
    );
  });

  group('PutContactWithoutTxnUseCase', () {
    final tContact = ContactEntity(
      id: '1',
      displayName: 'Alice',
      email: 'alice@example.com',
      phoneNumber: '1234567890',
    );

    test(
      'Given repository successfully puts a contact, When use case is called, Then returns the ContactEntity',
      () async {
        // Given
        when(() => mockContactLocalRepository.putContactWithoutTxn(any()))
            .thenAnswer((_) async => tContact);

        // When
        final result = await useCase(tContact);

        // Then
        expect(result, equals(tContact));
        verify(() => mockContactLocalRepository.putContactWithoutTxn(tContact)).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given repository puts a contact and returns null, When use case is called, Then returns null',
      () async {
        // Given
        when(() => mockContactLocalRepository.putContactWithoutTxn(any()))
            .thenAnswer((_) async => null);

        // When
        final result = await useCase(tContact);

        // Then
        expect(result, isNull);
        verify(() => mockContactLocalRepository.putContactWithoutTxn(tContact)).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given repository throws an exception, When use case is called, Then rethrows the exception',
      () async {
        // Given
        final tException = Exception('Database write error');
        when(() => mockContactLocalRepository.putContactWithoutTxn(any()))
            .thenThrow(tException);

        // When
        final call = useCase(tContact);

        // Then
        await expectLater(call, throwsA(tException));
        verify(() => mockContactLocalRepository.putContactWithoutTxn(tContact)).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );
  });
}