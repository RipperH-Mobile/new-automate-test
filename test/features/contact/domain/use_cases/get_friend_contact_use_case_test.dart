import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/contact/data/models/requests/get_friend_contact_request.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/params/get_friend_contact_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/get_friend_contact_use_case.dart';

// Mock classes
class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

// Fake classes
class FakeGetFriendContactParams extends Fake implements GetFriendContactParams {}
class FakeGetFriendContactRequest extends Fake implements GetFriendContactRequest {}

void main() {
  late GetFriendContactUseCase useCase;
  late MockContactLocalRepository mockContactLocalRepository;

  setUpAll(() {
    registerFallbackValue(FakeGetFriendContactParams());
    registerFallbackValue(FakeGetFriendContactRequest());
  });

  setUp(() {
    mockContactLocalRepository = MockContactLocalRepository();
    useCase = GetFriendContactUseCase(
      contactLocalRepository: mockContactLocalRepository,
    );
  });

  group('GetFriendContactUseCase', () {
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
      'Given repository returns a list of contacts, When use case is called, Then returns the list of contacts',
      () async {
        // Given
        final params = GetFriendContactParams(limit: 10, notInIds: ['id1', 'id2']);
        final expectedRequest = GetFriendContactRequest(limit: 10, notInIds: ['id1', 'id2']);

        when(() => mockContactLocalRepository.getFriendContact(any()))
            .thenAnswer((_) async => tContactList);

        // When
        final result = await useCase(params);

        // Then
        expect(result, equals(tContactList));
        final captured = verify(() => mockContactLocalRepository.getFriendContact(captureAny())).captured;
        final capturedRequest = captured.last as GetFriendContactRequest;
        expect(capturedRequest.limit, equals(expectedRequest.limit));
        expect(capturedRequest.notInIds, equals(expectedRequest.notInIds));
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given repository returns an empty list, When use case is called, Then returns an empty list',
      () async {
        // Given
        final params = GetFriendContactParams(limit: 5);
        final expectedRequest = GetFriendContactRequest(limit: 5, notInIds: []);

        when(() => mockContactLocalRepository.getFriendContact(any()))
            .thenAnswer((_) async => []);

        // When
        final result = await useCase(params);

        // Then
        expect(result, isEmpty);
        final captured = verify(() => mockContactLocalRepository.getFriendContact(captureAny())).captured;
        final capturedRequest = captured.last as GetFriendContactRequest;
        expect(capturedRequest.limit, equals(expectedRequest.limit));
        expect(capturedRequest.notInIds, equals(expectedRequest.notInIds));
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );

    test(
      'Given repository throws an exception, When use case is called, Then rethrows the exception',
      () async {
        // Given
        final params = GetFriendContactParams();
        final tException = Exception('Network error');

        when(() => mockContactLocalRepository.getFriendContact(any()))
            .thenThrow(tException);

        // When
        final call = useCase(params);

        // Then
        await expectLater(call, throwsA(tException));
        final captured = verify(() => mockContactLocalRepository.getFriendContact(captureAny())).captured;
        final capturedRequest = captured.last as GetFriendContactRequest;
        expect(capturedRequest.limit, equals(null));
        expect(capturedRequest.notInIds, equals([]));
        verifyNoMoreInteractions(mockContactLocalRepository);
      },
    );
  });
}