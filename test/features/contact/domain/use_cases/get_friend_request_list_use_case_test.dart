import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/contact/data/models/requests/get_friend_request_request.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_server_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/get_friend_request_list_use_case.dart';

// Mock classes
class MockContactServerRepository extends Mock implements ContactServerRepository {}

// Fake classes
class FakeGetFriendRequestRequest extends Fake implements GetFriendRequestRequest {}
class FakePaginationPayload<T> extends Fake implements PaginationPayload<T> {}
class FakeContactEntity extends Fake implements ContactEntity {}

void main() {
  late GetFriendRequestListUseCase getFriendRequestListUseCase;
  late MockContactServerRepository mockContactServerRepository;

  setUpAll(() {
    registerFallbackValue(FakeGetFriendRequestRequest());
    registerFallbackValue(FakePaginationPayload<ContactEntity>());
    registerFallbackValue(FakeContactEntity());
  });

  setUp(() {
    mockContactServerRepository = MockContactServerRepository();
    getFriendRequestListUseCase = GetFriendRequestListUseCase(
      contactServerRepository: mockContactServerRepository,
    );
  });

  group('GetFriendRequestListUseCase', () {
    final tPage = 1;
    final tPageSize = 10;
    final tGetFriendRequestRequest = GetFriendRequestRequest(page: tPage, pageSize: tPageSize);

    final tContactEntity1 = ContactEntity(
      id: 'id1',
      displayName: 'Contact 1',
      email: 'contact1@example.com',
      phoneNumber: '1111111111',
      username: 'contact1',
      originalIsFriend: false,
      isTyping: false,
    );
    final tContactEntity2 = ContactEntity(
      id: 'id2',
      displayName: 'Contact 2',
      email: 'contact2@example.com',
      phoneNumber: '2222222222',
      username: 'contact2',
      originalIsFriend: false,
      isTyping: false,
    );

    final tFriendRequestList = [tContactEntity1, tContactEntity2];
    final tPaginationPayloadWithData = PaginationPayload<ContactEntity>(
      data: tFriendRequestList,
      total: 2,
      page: tPage,
      pageSize: tPageSize,
      totalPages: 1,
    );

    final tPaginationPayloadNoData = PaginationPayload<ContactEntity>(
      data: [],
      total: 0,
      page: tPage,
      pageSize: tPageSize,
      totalPages: 0,
    );

    test('Given friend requests exist, When getFriendRequestList is called, Then returns PaginationPayload with data', () async {
      // Given
      when(() => mockContactServerRepository.getFriendRequestList(any()))
          .thenAnswer((_) async => tPaginationPayloadWithData);

      // When
      final result = await getFriendRequestListUseCase(tGetFriendRequestRequest);

      // Then
      expect(result, equals(tPaginationPayloadWithData));
      expect(result?.data, equals(tFriendRequestList));
      verify(() => mockContactServerRepository.getFriendRequestList(tGetFriendRequestRequest)).called(1);
      verifyNoMoreInteractions(mockContactServerRepository);
    });

    test('Given no friend requests exist, When getFriendRequestList is called, Then returns PaginationPayload with empty data', () async {
      // Given
      when(() => mockContactServerRepository.getFriendRequestList(any()))
          .thenAnswer((_) async => tPaginationPayloadNoData);

      // When
      final result = await getFriendRequestListUseCase(tGetFriendRequestRequest);

      // Then
      expect(result, equals(tPaginationPayloadNoData));
      expect(result?.data, isEmpty);
      verify(() => mockContactServerRepository.getFriendRequestList(tGetFriendRequestRequest)).called(1);
      verifyNoMoreInteractions(mockContactServerRepository);
    });

    test('Given repository throws exception, When getFriendRequestList is called, Then rethrows exception', () async {
      // Given
      final tException = Exception('Server error');
      when(() => mockContactServerRepository.getFriendRequestList(any()))
          .thenThrow(tException);

      // When
      final call = getFriendRequestListUseCase(tGetFriendRequestRequest);

      // Then
      await expectLater(call, throwsA(tException));
      verify(() => mockContactServerRepository.getFriendRequestList(tGetFriendRequestRequest)).called(1);
      verifyNoMoreInteractions(mockContactServerRepository);
    });
  });
}