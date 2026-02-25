import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/params/contact_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/get_friend_contact_by_id_sync_use_case.dart';

// Mock classes
class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

void main() {
  late GetFriendContactByIdSyncUseCase useCase;
  late MockContactLocalRepository mockContactLocalRepository;

  setUpAll(() {
    // Register fallback values for any complex types that might be used as arguments
    registerFallbackValue(const ContactParams(accountId: 'any'));
  });

  setUp(() {
    mockContactLocalRepository = MockContactLocalRepository();
    useCase = GetFriendContactByIdSyncUseCase(
      contactLocalRepository: mockContactLocalRepository,
    );
  });

  group('GetFriendContactByIdSyncUseCase', () {
    final tAccountId = 'test-account-id';
    final tContact = ContactEntity(
      id: tAccountId,
      displayName: 'Test User',
      email: 'test@example.com',
      phoneNumber: '1234567890',
    );
    final tParams = ContactParams(accountId: tAccountId);

    test(
      'Given repository returns a ContactEntity, When use case is called, Then returns the ContactEntity',
      () {
        // Given
        when(() => mockContactLocalRepository.getFriendContactByIdSync(any()))
            .thenReturn(tContact);

        // When
        final result = useCase(tParams);

        // Then
        expect(result, equals(tContact));
        verify(() => mockContactLocalRepository.getFriendContactByIdSync(tAccountId)).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given repository returns null, When use case is called, Then returns null',
      () {
        // Given
        when(() => mockContactLocalRepository.getFriendContactByIdSync(any()))
            .thenReturn(null);

        // When
        final result = useCase(tParams);

        // Then
        expect(result, isNull);
        verify(() => mockContactLocalRepository.getFriendContactByIdSync(tAccountId)).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given repository throws an exception, When use case is called, Then rethrows the exception',
      () {
        // Given
        final tException = Exception('Database error');
        when(() => mockContactLocalRepository.getFriendContactByIdSync(any()))
            .thenThrow(tException);

        // When
        call() => useCase(tParams);

        // Then
        expect(call, throwsA(tException));
        verify(() => mockContactLocalRepository.getFriendContactByIdSync(tAccountId)).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );
  });
}