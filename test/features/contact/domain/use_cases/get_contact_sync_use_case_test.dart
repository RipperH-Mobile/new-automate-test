import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_sync_use_case.dart';

// Mock classes
class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

void main() {
  late GetContactSyncUseCase useCase;
  late MockContactLocalRepository mockContactLocalRepository;

  setUpAll(() {
    // Register fallback values for any complex types that might be used as arguments
    registerFallbackValue('any_id'); // For String id parameter
  });

  setUp(() {
    mockContactLocalRepository = MockContactLocalRepository();
    useCase = GetContactSyncUseCase(
      contactLocalRepository: mockContactLocalRepository,
    );
  });

  group('GetContactSyncUseCase', () {
    final tId = 'test-contact-id';
    final tContact = ContactEntity(
      id: tId,
      displayName: 'Test User',
      email: 'test@example.com',
      phoneNumber: '1234567890',
    );

    test(
      'Given repository returns a ContactEntity, When use case is called, Then returns the ContactEntity',
      () {
        // Given
        when(() => mockContactLocalRepository.getContactSync(any()))
            .thenReturn(tContact);

        // When
        final result = useCase(tId);

        // Then
        expect(result, equals(tContact));
        verify(() => mockContactLocalRepository.getContactSync(tId)).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given repository returns null, When use case is called, Then returns null',
      () {
        // Given
        when(() => mockContactLocalRepository.getContactSync(any()))
            .thenReturn(null);

        // When
        final result = useCase(tId);

        // Then
        expect(result, isNull);
        verify(() => mockContactLocalRepository.getContactSync(tId)).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given repository throws an exception, When use case is called, Then rethrows the exception',
      () {
        // Given
        final tException = Exception('Database error');
        when(() => mockContactLocalRepository.getContactSync(any()))
            .thenThrow(tException);

        // When
        call() => useCase(tId);

        // Then
        expect(call, throwsA(tException));
        verify(() => mockContactLocalRepository.getContactSync(tId)).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );
  });
}