import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/put_all_contact_without_txn_use_case.dart';

// Mock classes
class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

// Fake class for List<ContactEntity>
class FakeContactEntityList extends Fake implements List<ContactEntity> {}

void main() {
  late PutAllContactWithoutTxnUseCase useCase;
  late MockContactLocalRepository mockContactLocalRepository;

  setUpAll(() {
    registerFallbackValue(FakeContactEntityList());
  });

  setUp(() {
    mockContactLocalRepository = MockContactLocalRepository();
    useCase = PutAllContactWithoutTxnUseCase(
      contactLocalRepository: mockContactLocalRepository,
    );
  });

  group('PutAllContactWithoutTxnUseCase', () {
    final tContactList = [
      ContactEntity(
        id: '1',
        displayName: 'Alice',
        email: 'alice@example.com',
        phoneNumber: '1234567890',
      ),
      ContactEntity(
        id: '2',
        displayName: 'Bob',
        email: 'bob@example.com',
        phoneNumber: '0987654321',
      ),
    ];

    test(
      'Given repository successfully puts all contacts, When use case is called, Then completes without error',
      () async {
        // Given
        when(() => mockContactLocalRepository.putAllContactWithoutTxn(any()))
            .thenAnswer((_) async {}); // Stubbing Future<void>

        // When
        await useCase(tContactList);

        // Then
        verify(() => mockContactLocalRepository.putAllContactWithoutTxn(tContactList)).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given repository throws an exception, When use case is called, Then rethrows the exception',
      () async {
        // Given
        final tException = Exception('Database write error');
        when(() => mockContactLocalRepository.putAllContactWithoutTxn(any()))
            .thenThrow(tException);

        // When
        final call = useCase(tContactList);

        // Then
        await expectLater(call, throwsA(tException));
        verify(() => mockContactLocalRepository.putAllContactWithoutTxn(tContactList)).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );
  });
}