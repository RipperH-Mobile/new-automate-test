import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/params/contact_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/get_friend_contact_by_id_use_case.dart';

// Mock classes
class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

void main() {
  late GetFriendContactByIdUseCase useCase;
  late MockContactLocalRepository mockContactLocalRepository;

  setUpAll(() {
    // Register fallback values for any complex types that might be used as arguments
    registerFallbackValue(const ContactParams(accountId: 'any'));
  });

  setUp(() {
    mockContactLocalRepository = MockContactLocalRepository();
    useCase = GetFriendContactByIdUseCase(
      contactLocalRepository: mockContactLocalRepository,
    );
  });

  group('GetFriendContactByIdUseCase', () {
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
      () async {
        // Given
        when(() => mockContactLocalRepository.getFriendContactById(any()))
            .thenAnswer((_) async => tContact);

        // When
        final result = await useCase(tParams);

        // Then
        expect(result, equals(tContact));
        verify(() => mockContactLocalRepository.getFriendContactById(tAccountId)).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given repository returns null, When use case is called, Then returns null',
      () async {
        // Given
        when(() => mockContactLocalRepository.getFriendContactById(any()))
            .thenAnswer((_) async => null);

        // When
        final result = await useCase(tParams);

        // Then
        expect(result, isNull);
        verify(() => mockContactLocalRepository.getFriendContactById(tAccountId)).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given repository throws an exception, When use case is called, Then rethrows the exception',
      () async {
        // Given
        final tException = Exception('Database error');
        when(() => mockContactLocalRepository.getFriendContactById(any()))
            .thenThrow(tException);

        // When
        final call = useCase(tParams);

        // Then
        await expectLater(call, throwsA(tException));
        verify(() => mockContactLocalRepository.getFriendContactById(tAccountId)).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );
  });
}