import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/params/search_friend_contact_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/search_friend_contact_use_case.dart';
import 'package:uchat/entities/enum/online_status.dart';

class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

void main() {
  late SearchFriendContactUseCase searchFriendContactUseCase;
  late MockContactLocalRepository mockContactLocalRepository;

  setUp(() {
    mockContactLocalRepository = MockContactLocalRepository();
    searchFriendContactUseCase = SearchFriendContactUseCase(
      contactLocalRepository: mockContactLocalRepository,
    );
  });

  group('SearchFriendContactUseCase', () {
    final tContactEntity = ContactEntity(
      id: '123',
      displayName: 'Test User',
      email: 'test@example.com',
      phoneNumber: '1234567890',
      onlineStatus: OnlineStatus.online,
      lastSeenAt: DateTime.now(),
      avatarId: 'http://example.com/pic.jpg', // Assuming profilePicture maps to avatarId
      originalStatusMessage: 'Hello',
    );

    final tContactList = [tContactEntity];

    final tParams = SearchFriendContactParams(
      keyword: 'test',
      limit: 10,
      includePhoneNumber: true,
    );

    test('Given repository returns contacts, When use case is called, Then returns the same contact list', () async {
      // Given
      when(() => mockContactLocalRepository.searchFriendContact(tParams)).thenAnswer((_) async => tContactList);

      // When
      final result = await searchFriendContactUseCase(tParams);

      // Then
      expect(result, equals(tContactList));
      verify(() => mockContactLocalRepository.searchFriendContact(tParams)).called(1);
      verifyNoMoreInteractions(mockContactLocalRepository);
    });

    test('Given repository throws exception, When use case is called, Then rethrows the same exception', () async {
      // Given
      final tException = Exception('Something went wrong');
      when(() => mockContactLocalRepository.searchFriendContact(tParams)).thenThrow(tException);

      // When
      final call = searchFriendContactUseCase(tParams);

      // Then
      await expectLater(call, throwsA(same(tException)));
      verify(() => mockContactLocalRepository.searchFriendContact(tParams)).called(1);
      verifyNoMoreInteractions(mockContactLocalRepository);
    });
  });
}
