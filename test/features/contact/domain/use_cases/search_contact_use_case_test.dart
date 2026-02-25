import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/contact/data/models/requests/search_contact_request.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_server_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/search_contact_use_case.dart';

// Mock classes
class MockContactServerRepository extends Mock implements ContactServerRepository {}

// Fake classes
class FakeSearchContactRequest extends Fake implements SearchContactRequest {}
class FakeSearchContactResponse extends Fake implements SearchContactResponse {}
class FakeContactEntity extends Fake implements ContactEntity {}

void main() {
  late SearchContactUseCase searchContactUseCase;
  late MockContactServerRepository mockContactServerRepository;

  setUpAll(() {
    registerFallbackValue(FakeSearchContactRequest());
    registerFallbackValue(FakeSearchContactResponse());
    registerFallbackValue(FakeContactEntity());
  });

  setUp(() {
    mockContactServerRepository = MockContactServerRepository();
    searchContactUseCase = SearchContactUseCase(
      contactServerRepository: mockContactServerRepository,
    );
  });

  group('SearchContactUseCase', () {
    final tUsername = 'testuser';
    final tType = 'USERNAME';
    final tSearchContactRequest = SearchContactRequest(username: tUsername, type: tType);
    final tContactEntity = ContactEntity(
      id: 'test-id',
      displayName: 'Test Contact',
      email: 'test@example.com',
      phoneNumber: '1234567890',
      username: 'test_contact',
      originalIsFriend: true,
      isTyping: false,
    );
    final tSearchContactResponseWithContact = SearchContactResponse(contact: tContactEntity);
    final tSearchContactResponseNoContact = SearchContactResponse(contact: null);

    test('Given contact found, When searchContact is called, Then returns SearchContactResponse with contact', () async {
      // Given
      when(() => mockContactServerRepository.searchContact(any()))
          .thenAnswer((_) async => tSearchContactResponseWithContact);

      // When
      final result = await searchContactUseCase(tSearchContactRequest);

      // Then
      expect(result, equals(tSearchContactResponseWithContact));
      verify(() => mockContactServerRepository.searchContact(tSearchContactRequest)).called(1);
      verifyNoMoreInteractions(mockContactServerRepository);
    });

    test('Given no contact found, When searchContact is called, Then returns SearchContactResponse with null contact', () async {
      // Given
      when(() => mockContactServerRepository.searchContact(any()))
          .thenAnswer((_) async => tSearchContactResponseNoContact);

      // When
      final result = await searchContactUseCase(tSearchContactRequest);

      // Then
      expect(result, equals(tSearchContactResponseNoContact));
      verify(() => mockContactServerRepository.searchContact(tSearchContactRequest)).called(1);
      verifyNoMoreInteractions(mockContactServerRepository);
    });

    test('Given repository throws exception, When searchContact is called, Then rethrows exception', () async {
      // Given
      final tException = Exception('Network error');
      when(() => mockContactServerRepository.searchContact(any()))
          .thenThrow(tException);

      // When
      final call = searchContactUseCase(tSearchContactRequest);

      // Then
      await expectLater(call, throwsA(tException));
      verify(() => mockContactServerRepository.searchContact(tSearchContactRequest)).called(1);
      verifyNoMoreInteractions(mockContactServerRepository);
    });
  });
}