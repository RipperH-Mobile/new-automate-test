import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/contact/data/models/requests/search_official_account_contact_request.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/params/search_official_account_contact_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/search_official_account_contact_use_case.dart';
import 'package:uchat/entities/enum/online_status.dart';

// Mock classes
class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

// Fake classes for fallback values
class FakeSearchOfficialAccountContactRequest extends Fake implements SearchOfficialAccountContactRequest {}

void main() {
  late SearchOfficialAccountContactUseCase searchOfficialAccountContactUseCase;
  late MockContactLocalRepository mockContactLocalRepository;

  setUpAll(() {
    registerFallbackValue(FakeSearchOfficialAccountContactRequest());
  });

  setUp(() {
    mockContactLocalRepository = MockContactLocalRepository();
    searchOfficialAccountContactUseCase = SearchOfficialAccountContactUseCase(
      contactLocalRepository: mockContactLocalRepository,
    );
  });

  group('SearchOfficialAccountContactUseCase', () {
    final tContactEntity = ContactEntity(
      id: 'official-123',
      displayName: 'Official Account',
      email: 'official@example.com',
      phoneNumber: '0987654321',
      onlineStatus: OnlineStatus.online,
      lastSeenAt: DateTime.now(),
      avatarId: 'http://example.com/official_pic.jpg',
      originalStatusMessage: 'Official greetings!',
    );

    final tContactList = [tContactEntity];

    final tParams = SearchOfficialAccountContactParams(
      keyword: 'official',
      limit: 5,
    );

    test(
        'Given a successful search, When call is invoked, Then it should return a list of ContactEntity',
        () async {
      // Given
      when(() => mockContactLocalRepository.searchOfficialAccountContact(any()))
          .thenAnswer((_) async => tContactList);

      // When
      final result = await searchOfficialAccountContactUseCase(tParams);

      // Then
      expect(result, equals(tContactList));
      verify(() => mockContactLocalRepository.searchOfficialAccountContact(
            any(that: isA<SearchOfficialAccountContactRequest>()),
          )).called(1);
    });

    test(
        'Given an empty search result, When call is invoked, Then it should return an empty list',
        () async {
      // Given
      when(() => mockContactLocalRepository.searchOfficialAccountContact(any()))
          .thenAnswer((_) async => []);

      // When
      final result = await searchOfficialAccountContactUseCase(tParams);

      // Then
      expect(result, isEmpty);
      verify(() => mockContactLocalRepository.searchOfficialAccountContact(
            any(that: isA<SearchOfficialAccountContactRequest>()),
          )).called(1);
    });

    test(
        'Given repository throws an exception, When call is invoked, Then it should rethrow the exception',
        () async {
      // Given
      final tException = Exception('Official account search failed');
      when(() => mockContactLocalRepository.searchOfficialAccountContact(any()))
          .thenThrow(tException);

      // When
      final call = searchOfficialAccountContactUseCase(tParams);

      // Then
      await expectLater(() => call, throwsA(tException));
      verify(() => mockContactLocalRepository.searchOfficialAccountContact(
            any(that: isA<SearchOfficialAccountContactRequest>()),
          )).called(1);
    });

    test(
        'Given null limit, When call is invoked, Then it should pass null limit to repository',
        () async {
      // Given
      final paramsWithNullLimit = SearchOfficialAccountContactParams(
        keyword: 'official',
        limit: null,
      );
      when(() => mockContactLocalRepository.searchOfficialAccountContact(any()))
          .thenAnswer((_) async => tContactList);

      // When
      await searchOfficialAccountContactUseCase(paramsWithNullLimit);

      // Then
      verify(() => mockContactLocalRepository.searchOfficialAccountContact(
            any(that: isA<SearchOfficialAccountContactRequest>()),
          )).called(1);
    });
  });
}