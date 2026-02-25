import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/params/contact_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_use_case.dart';

// Mock classes
class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

class FakeContactEntity extends Fake implements ContactEntity {}
class FakeContactParams extends Fake implements ContactParams {}

void main() {
  late GetContactUseCase getContactUseCase;
  late MockContactLocalRepository mockContactLocalRepository;

  setUpAll(() {
    registerFallbackValue(FakeContactEntity());
    registerFallbackValue(FakeContactParams());
  });

  setUp(() {
    mockContactLocalRepository = MockContactLocalRepository();
    getContactUseCase = GetContactUseCase(
      contactLocalRepository: mockContactLocalRepository,
    );
  });

  group('GetContactUseCase', () {
    final tAccountId = 'testAccountId';
    final tContactParams = ContactParams(accountId: tAccountId);
    final tContactEntity = ContactEntity(
      id: tAccountId,
      displayName: 'Test Contact',
      email: 'test@example.com',
      phoneNumber: '1234567890',
      username: 'test_contact',
      originalIsFriend: true,
      isTyping: false,
    );

    test('Given contact exists, When call is made, Then returns ContactEntity', () async {
      // Given
      when(() => mockContactLocalRepository.getContact(any()))
          .thenAnswer((_) async => tContactEntity);

      // When
      final result = await getContactUseCase(tContactParams);

      // Then
      expect(result, equals(tContactEntity));
      verify(() => mockContactLocalRepository.getContact(tAccountId)).called(1);
      verifyNoMoreInteractions(mockContactLocalRepository);
    });

    test('Given contact does not exist, When call is made, Then returns null', () async {
      // Given
      when(() => mockContactLocalRepository.getContact(any()))
          .thenAnswer((_) async => null);

      // When
      final result = await getContactUseCase(tContactParams);

      // Then
      expect(result, isNull);
      verify(() => mockContactLocalRepository.getContact(tAccountId)).called(1);
      verifyNoMoreInteractions(mockContactLocalRepository);
    });

    test('Given repository throws exception, When call is made, Then rethrows exception', () async {
      // Given
      final tException = Exception('Something went wrong');
      when(() => mockContactLocalRepository.getContact(any()))
          .thenThrow(tException);

      // When
      final call = getContactUseCase(tContactParams);

      // Then
      await expectLater(call, throwsA(tException));
      verify(() => mockContactLocalRepository.getContact(tAccountId)).called(1);
      verifyNoMoreInteractions(mockContactLocalRepository);
    });
  });
}