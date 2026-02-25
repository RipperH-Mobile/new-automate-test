import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/exceptions/null_response_exception.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/contact/data/models/requests/add_contact_request.dart';
import 'package:uchat/features/contact/domain/repositories/contact_server_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/add_contact_use_case.dart';

class MockContactServerRepository extends Mock implements ContactServerRepository {}

void main() {
  late MockContactServerRepository mockRepository;
  late AddContactUseCase useCase;
  late AddContactRequest request;
  late AddContactResponse response;
  late ContactCollection contact;
  late GetIt getIt;

  setUpAll(() {
    registerFallbackValue(AddContactRequest(friendAccountId: 'dummy-id'));
  });

  setUp(() {
    // Given
    mockRepository = MockContactServerRepository();
    useCase = AddContactUseCase(contactServerRepository: mockRepository);
    request = AddContactRequest(friendAccountId: 'friend-123');
    contact = ContactCollection(
      id: 'friend-123',
      displayName: 'Test Friend',
      username: 'testfriend',
      originalIsFriend: true,
    );
    response = AddContactResponse(contact: contact);
    getIt = GetIt.instance;

    if (getIt.isRegistered<ContactServerRepository>()) {
      getIt.unregister<ContactServerRepository>();
    }

    getIt.registerSingleton<ContactServerRepository>(mockRepository);

    // Reset mocks before each test
    reset(mockRepository);
  });

  group('call', () {
    test('Given valid request, When repository returns success, Then returns contact response', () async {
      // Given
      when(() => mockRepository.addContact(request)).thenAnswer((_) async => response);

      // When
      final result = await useCase(request);

      // Then
      expect(result, equals(response));
      expect(result.contact, equals(contact));
      verify(() => mockRepository.addContact(request)).called(1);
    });

    test('Given valid request, When repository throws exception, Then throws same exception', () async {
      // Given
      final exception = Exception('Network error');
      when(() => mockRepository.addContact(request)).thenThrow(exception);

      // When
      final result = useCase(request);

      // When/Then
      expect(() => result, throwsA(equals(exception)));
      verify(() => mockRepository.addContact(request)).called(1);
    });

    test('Given valid request, When repository returns null response, Then throws NullResponseException', () async {
      // Given
      final exception = NullResponseException();
      when(() => mockRepository.addContact(request)).thenThrow(exception);

      // When
      final result = useCase(request);

      // Then
      expect(result, throwsA(equals(exception)));
      verify(() => mockRepository.addContact(request)).called(1);
    });
  });
}
