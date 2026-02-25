import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/params/update_contact_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/put_or_update_contact_use_case.dart';

// Mock classes
class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

// Fake classes (for registerFallbackValue)
class FakeContactEntity extends Fake implements ContactEntity {}
class FakeUpdateContactParams extends Fake implements UpdateContactParams {}

void main() {
  late PutOrUpdateContactUseCase putOrUpdateContactUseCase;
  late MockContactLocalRepository mockContactLocalRepository;

  setUpAll(() {
    registerFallbackValue(FakeContactEntity());
    registerFallbackValue(FakeUpdateContactParams());
  });

  setUp(() {
    mockContactLocalRepository = MockContactLocalRepository();
    putOrUpdateContactUseCase = PutOrUpdateContactUseCase(
      contactLocalRepository: mockContactLocalRepository,
    );
  });

  group('PutOrUpdateContactUseCase', () {
    final tContact = ContactEntity(id: '1', displayName: 'John Doe', email: 'john@example.com');
    final tUpdateContactParams = UpdateContactParams(contact: tContact);

    test(
      'Given PutOrUpdateContactUseCase is called, When putOrUpdateContact returns a ContactEntity, Then it should return the ContactEntity',
      () async {
        // Given
        when(() => mockContactLocalRepository.putOrUpdateContact(any()))
            .thenAnswer((_) async => tContact);

        // When
        final result = await putOrUpdateContactUseCase(tUpdateContactParams);

        // Then
        expect(result, equals(tContact));
        verify(() => mockContactLocalRepository.putOrUpdateContact(tContact)).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given PutOrUpdateContactUseCase is called, When putOrUpdateContact returns null, Then it should return null',
      () async {
        // Given
        when(() => mockContactLocalRepository.putOrUpdateContact(any()))
            .thenAnswer((_) async => null);

        // When
        final result = await putOrUpdateContactUseCase(tUpdateContactParams);

        // Then
        expect(result, isNull);
        verify(() => mockContactLocalRepository.putOrUpdateContact(tContact)).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given PutOrUpdateContactUseCase is called, When putOrUpdateContact throws an exception, Then it should rethrow the exception',
      () async {
        // Given
        final tException = Exception('Failed to put or update contact');
        when(() => mockContactLocalRepository.putOrUpdateContact(any()))
            .thenThrow(tException);

        // When
        final call = putOrUpdateContactUseCase(tUpdateContactParams);

        // Then
        await expectLater(call, throwsA(equals(tException)));
        verify(() => mockContactLocalRepository.putOrUpdateContact(tContact)).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );
  });
}