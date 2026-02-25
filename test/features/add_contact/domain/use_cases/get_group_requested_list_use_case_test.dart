import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/entities/enum/group_request_type.dart';
import 'package:uchat/features/add_contact/data/model/add_contact_group_requested_model.dart';
import 'package:uchat/features/add_contact/data/model/requested_list_request.dart';
import 'package:uchat/features/add_contact/domain/entities/add_contact_group_requested_entity.dart';
import 'package:uchat/features/add_contact/domain/repositories/add_contact_server_repository.dart';
import 'package:uchat/features/add_contact/domain/use_cases/get_group_requested_list_use_case.dart';

// Mock Definitions
class MockAddContactServerRepository extends Mock implements AddContactServerRepository {}

// Fake Definitions for custom types used with any()
class FakeGetRequestedListRequest extends Fake implements GetRequestedListRequest {}

class FakeAddContactGroupRequestedModel extends Fake
    implements AddContactGroupRequestedModel {}

class FakePaginationPayload extends Fake implements PaginationPayload {}

void main() {
  late GetGroupRequestedListUseCase useCase;
  late MockAddContactServerRepository mockRepository;
  late GetRequestedListRequest testRequest;
  late PaginationPayload<AddContactGroupRequestedModel> testPaginationPayload;
  late List<AddContactGroupRequestedModel> testModels;
  late List<AddContactGroupRequestedEntity> testEntities;

  setUpAll(() {
    // Register fallback values for custom types used with any()
    registerFallbackValue(FakeGetRequestedListRequest());
    registerFallbackValue(FakeAddContactGroupRequestedModel());
    registerFallbackValue(FakePaginationPayload());
  });

  setUp(() {
    // Initialize mocks and test data
    mockRepository = MockAddContactServerRepository();
    useCase = GetGroupRequestedListUseCase();
    testRequest = GetRequestedListRequest(
      page: 1,
      pageSize: 20,
      roomId: 'room123',
      keyword: 'test',
    );

    // Create test models
    testModels = [
      AddContactGroupRequestedModel(
        requestId: 'req1',
        roomId: 'room1',
        roomName: 'Test Room 1',
        roomType: 'group',
        accessType: 'private',
        photoId: 'photo1',
        accountId: 'user1',
        username: 'user1',
        displayName: 'User One',
        avatarId: 'avatar1',
        avatarBlurhash: 'blur1',
        onlineStatus: 'online',
        statusMessage: 'Available',
        requestedAt: DateTime(2024, 1, 1),
        type: GroupRequestType.newRequest,
      ),
      AddContactGroupRequestedModel(
        requestId: 'req2',
        roomId: 'room2',
        roomName: 'Test Room 2',
        roomType: 'channel',
        accessType: 'public',
        photoId: 'photo2',
        accountId: 'user2',
        username: 'user2',
        displayName: 'User Two',
        avatarId: 'avatar2',
        avatarBlurhash: 'blur2',
        onlineStatus: 'offline',
        statusMessage: 'Busy',
        requestedAt: DateTime(2024, 1, 2),
        type: GroupRequestType.newRequest,
      ),
    ];

    // Create expected entities
    testEntities = testModels.map((model) => model.toEntity()).toList();

    // Create pagination payload
    testPaginationPayload = PaginationPayload<AddContactGroupRequestedModel>(
      total: 2,
      page: 1,
      pageSize: 20,
      totalPages: 1,
      data: testModels,
    );

    // Register mock repository with GetIt
    GetIt.I.registerSingleton<AddContactServerRepository>(mockRepository);
    reset(mockRepository);
  });

  tearDown(() {
    // Reset GetIt to avoid state leakage between tests
    GetIt.I.reset();
  });

  group('GetGroupRequestedListUseCase', () {
    group('call', () {
      test(
        'Given repository returns PaginationPayload with models, When call is invoked, Then returns the mapped entity payload',
        () async {
          // Given
          when(() => mockRepository.getGroupRequestedList(any()))
              .thenAnswer((_) async => testPaginationPayload);

          // When
          final result = await useCase.call(testRequest);

          // Then
          expect(result, isNotNull);
          expect(result, isA<PaginationPayload<AddContactGroupRequestedEntity>>());
          expect(result!.total, equals(testPaginationPayload.total));
          expect(result.page, equals(testPaginationPayload.page));
          expect(result.pageSize, equals(testPaginationPayload.pageSize));
          expect(result.totalPages, equals(testPaginationPayload.totalPages));
          expect(result.data, isNotNull);
          expect(result.data!.length, equals(testEntities.length));

          // Verify each entity is correctly mapped
          for (int i = 0; i < testEntities.length; i++) {
            expect(result.data!.elementAt(i).requestId,
                equals(testEntities[i].requestId));
            expect(result.data!.elementAt(i).roomId,
                equals(testEntities[i].roomId));
            expect(result.data!.elementAt(i).roomName,
                equals(testEntities[i].roomName));
            expect(result.data!.elementAt(i).roomType,
                equals(testEntities[i].roomType));
            expect(result.data!.elementAt(i).accessType,
                equals(testEntities[i].accessType));
            expect(result.data!.elementAt(i).photoId,
                equals(testEntities[i].photoId));
            expect(result.data!.elementAt(i).accountId,
                equals(testEntities[i].accountId));
            expect(result.data!.elementAt(i).username,
                equals(testEntities[i].username));
            expect(result.data!.elementAt(i).displayName,
                equals(testEntities[i].displayName));
            expect(result.data!.elementAt(i).avatarId,
                equals(testEntities[i].avatarId));
            expect(result.data!.elementAt(i).avatarBlurhash,
                equals(testEntities[i].avatarBlurhash));
            expect(result.data!.elementAt(i).onlineStatus,
                equals(testEntities[i].onlineStatus));
            expect(result.data!.elementAt(i).statusMessage,
                equals(testEntities[i].statusMessage));
            expect(result.data!.elementAt(i).requestedAt,
                equals(testEntities[i].requestedAt));
            expect(result.data!.elementAt(i).type,
                equals(testEntities[i].type));
          }

          verify(() => mockRepository.getGroupRequestedList(testRequest)).called(1);
          verifyNoMoreInteractions(mockRepository);
        },
      );

      test(
        'Given repository returns null, When call is invoked, Then returns null',
        () async {
          // Given
          when(() => mockRepository.getGroupRequestedList(any()))
              .thenAnswer((_) async => null);

          // When
          final result = await useCase.call(testRequest);

          // Then
          expect(result, isNull);
          verify(() => mockRepository.getGroupRequestedList(testRequest)).called(1);
          verifyNoMoreInteractions(mockRepository);
        },
      );

      test(
        'Given repository returns PaginationPayload with empty list, When call is invoked, Then returns entity payload with empty list',
        () async {
          // Given
          final emptyPayload = PaginationPayload<AddContactGroupRequestedModel>(
            total: 0,
            page: 1,
            pageSize: 20,
            totalPages: 0,
            data: [],
          );
          when(() => mockRepository.getGroupRequestedList(any()))
              .thenAnswer((_) async => emptyPayload);

          // When
          final result = await useCase.call(testRequest);

          // Then
          expect(result, isNotNull);
          expect(result, isA<PaginationPayload<AddContactGroupRequestedEntity>>());
          expect(result!.total, equals(0));
          expect(result.page, equals(1));
          expect(result.pageSize, equals(20));
          expect(result.totalPages, equals(0));
          expect(result.data, isNotNull);
          expect(result.data!.isEmpty, isTrue);
          verify(() => mockRepository.getGroupRequestedList(testRequest)).called(1);
          verifyNoMoreInteractions(mockRepository);
        },
      );

      test(
        'Given repository returns PaginationPayload with single model, When call is invoked, Then returns entity payload with single entity',
        () async {
          // Given
          final singleModel = testModels.first;
          final singlePayload = PaginationPayload<AddContactGroupRequestedModel>(
            total: 1,
            page: 1,
            pageSize: 20,
            totalPages: 1,
            data: [singleModel],
          );
          when(() => mockRepository.getGroupRequestedList(any()))
              .thenAnswer((_) async => singlePayload);

          // When
          final result = await useCase.call(testRequest);

          // Then
          expect(result, isNotNull);
          expect(result, isA<PaginationPayload<AddContactGroupRequestedEntity>>());
          expect(result!.total, equals(1));
          expect(result.page, equals(1));
          expect(result.pageSize, equals(20));
          expect(result.totalPages, equals(1));
          expect(result.data, isNotNull);
          expect(result.data!.length, equals(1));
          expect(result.data!.first.requestId, equals(singleModel.requestId));
          expect(result.data!.first.roomId, equals(singleModel.roomId));
          expect(result.data!.first.roomName, equals(singleModel.roomName));
          verify(() => mockRepository.getGroupRequestedList(testRequest)).called(1);
          verifyNoMoreInteractions(mockRepository);
        },
      );

      test(
        'Given repository returns PaginationPayload with null data, When call is invoked, Then returns entity payload with empty list',
        () async {
          // Given
          final payloadWithNullData = PaginationPayload<AddContactGroupRequestedModel>(
            total: 0,
            page: 1,
            pageSize: 20,
            totalPages: 0,
            data: null,
          );
          when(() => mockRepository.getGroupRequestedList(any()))
              .thenAnswer((_) async => payloadWithNullData);

          // When
          final result = await useCase.call(testRequest);

          // Then
          expect(result, isNotNull);
          expect(result, isA<PaginationPayload<AddContactGroupRequestedEntity>>());
          expect(result!.total, equals(0));
          expect(result.page, equals(1));
          expect(result.pageSize, equals(20));
          expect(result.totalPages, equals(0));
          expect(result.data, isNotNull);
          expect(result.data!.isEmpty, isTrue);
          verify(() => mockRepository.getGroupRequestedList(testRequest)).called(1);
          verifyNoMoreInteractions(mockRepository);
        },
      );

      test(
        'Given request with minimal parameters, When call is invoked, Then calls repository with correct request',
        () async {
          // Given
          final minimalRequest = GetRequestedListRequest(
            page: 1,
            pageSize: 10,
          );
          when(() => mockRepository.getGroupRequestedList(any()))
              .thenAnswer((_) async => testPaginationPayload);

          // When
          await useCase.call(minimalRequest);

          // Then
          verify(() => mockRepository.getGroupRequestedList(minimalRequest))
              .called(1);
          verifyNoMoreInteractions(mockRepository);
        },
      );

      test(
        'Given repository returns PaginationPayload with pagination metadata, When call is invoked, Then preserves pagination metadata in result',
        () async {
          // Given
          final paginatedPayload = PaginationPayload<AddContactGroupRequestedModel>(
            total: 100,
            page: 3,
            pageSize: 25,
            totalPages: 4,
            data: testModels,
          );
          when(() => mockRepository.getGroupRequestedList(any()))
              .thenAnswer((_) async => paginatedPayload);

          // When
          final result = await useCase.call(testRequest);

          // Then
          expect(result, isNotNull);
          expect(result!.total, equals(100));
          expect(result.page, equals(3));
          expect(result.pageSize, equals(25));
          expect(result.totalPages, equals(4));
          verify(() => mockRepository.getGroupRequestedList(testRequest)).called(1);
          verifyNoMoreInteractions(mockRepository);
        },
      );
    });

    group('addContactServerRepository getter', () {
      test(
        'Given GetIt has registered AddContactServerRepository, When getter is accessed, Then returns the registered repository',
        () {
          // Given
          // The repository is already registered in setUp, so we just verify it's retrieved correctly

          // When
          final retrievedRepository = useCase.addContactServerRepository;

          // Then
          expect(retrievedRepository, equals(mockRepository));
          expect(retrievedRepository, isA<AddContactServerRepository>());
        },
      );
    });
  });
}
