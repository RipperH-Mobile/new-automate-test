import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/params/put_contact_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/put_contact_use_case.dart';

// Mock classes
class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

// Fake classes (for registerFallbackValue)
class FakeContactEntity extends Fake implements ContactEntity {}
class FakePutContactParams extends Fake implements PutContactParams {}

void main() {
  late PutContactUseCase putContactUseCase;
  late MockContactLocalRepository mockContactLocalRepository;

  setUpAll(() {
    registerFallbackValue(FakeContactEntity());
    registerFallbackValue(FakePutContactParams());
  });

  setUp(() {
    mockContactLocalRepository = MockContactLocalRepository();
    putContactUseCase = PutContactUseCase(
      contactLocalRepository: mockContactLocalRepository,
    );
  });

  group('PutContactUseCase', () {
    final tContact = ContactEntity(id: '1', displayName: 'John Doe', email: 'john@example.com');
    final tPutContactParams = PutContactParams(contact: tContact);

    test(
      'Given PutContactUseCase is called, When putContact is successful, Then it should complete without error',
      () async {
        // Given
        when(() => mockContactLocalRepository.putContact(any()))
            .thenAnswer((_) async {});

        // When
        await putContactUseCase(tPutContactParams);

        // Then
        verify(() => mockContactLocalRepository.putContact(tContact)).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given PutContactUseCase is called, When putContact throws an exception, Then it should rethrow the exception',
      () async {
        // Given
        final tException = Exception('Failed to put contact');
        when(() => mockContactLocalRepository.putContact(any()))
            .thenThrow(tException);

        // When
        final call = putContactUseCase(tPutContactParams);

        // Then
        await expectLater(call, throwsA(equals(tException)));
        verify(() => mockContactLocalRepository.putContact(tContact)).called(1);
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );
  });
}