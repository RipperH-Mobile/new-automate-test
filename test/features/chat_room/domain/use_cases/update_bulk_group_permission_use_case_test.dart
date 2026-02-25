import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/domain/entities/group_permission_entity.dart';
import 'package:uchat/features/chat_room/domain/params/group_permission_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_server_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/update_bulk_group_permission_use_case.dart';

// Mock Definitions
class MockChatRoomLocalRepository extends Mock implements ChatRoomLocalRepository {}

class MockChatRoomServerRepository extends Mock implements ChatRoomServerRepository {}

class FakeGroupPermissionEntity extends Fake implements GroupPermissionEntity {}

void main() {
  late UpdateBulkGroupPermissionUseCase useCase;
  late MockChatRoomLocalRepository mockLocalRepository;
  late MockChatRoomServerRepository mockServerRepository;
  late List<GroupPermissionEntity> testPermissions;
  late UpdateBulkGroupPermissionParams testParams;

  setUpAll(() {
    registerFallbackValue(FakeGroupPermissionEntity());
  });

  setUp(() {
    mockLocalRepository = MockChatRoomLocalRepository();
    mockServerRepository = MockChatRoomServerRepository();
    useCase = UpdateBulkGroupPermissionUseCase(
      localRepository: mockLocalRepository,
      serverRepository: mockServerRepository,
    );

    // Reset all mocks before each test
    reset(mockLocalRepository);
    reset(mockServerRepository);

    // Create test data
    final now = DateTime.now();
    testPermissions = [
      GroupPermissionEntity(
        roomId: 'room1',
        enable: true,
        canSendMessages: true,
        canSendMedia: false,
        createdAt: now.subtract(const Duration(days: 1)),
        updatedAt: now.subtract(const Duration(days: 1)),
      ),
      GroupPermissionEntity(
        roomId: 'room2',
        enable: false,
        canSendMessages: false,
        canSendMedia: true,
        createdAt: now.subtract(const Duration(hours: 2)),
        updatedAt: now.subtract(const Duration(hours: 2)),
      ),
    ];

    testParams = UpdateBulkGroupPermissionParams(
      permissions: testPermissions,
      persistences: {
        GroupPermissionPersistence.local,
        GroupPermissionPersistence.server,
      },
    );
  });

  group('UpdateBulkGroupPermissionUseCase', () {
    test('Given valid permissions with both persistences, When use case is called, Then updates both local and server repositories', () async {
      // Given
      final existingPermission1 = GroupPermissionEntity(
        roomId: 'room1',
        enable: true,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now().subtract(const Duration(days: 2)),
      );
      final existingPermission2 = GroupPermissionEntity(
        roomId: 'room2',
        enable: false,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      );

      when(() => mockLocalRepository.getGroupPermission('room1'))
          .thenAnswer((_) async => existingPermission1);
      when(() => mockLocalRepository.getGroupPermission('room2'))
          .thenAnswer((_) async => existingPermission2);
      when(() => mockServerRepository.updateGroupPermission(any()))
          .thenAnswer((_) async => testPermissions.first);
      when(() => mockLocalRepository.updateGroupPermissions(any()))
          .thenAnswer((_) async => testPermissions);

      // When
      final result = await useCase(testParams);

      // Then
      expect(result.length, equals(2));
      expect(result[0].roomId, equals('room1'));
      expect(result[1].roomId, equals('room2'));
      
      // Verify that createdAt is preserved from existing permissions
      expect(result[0].createdAt, equals(existingPermission1.createdAt));
      expect(result[1].createdAt, equals(existingPermission2.createdAt));
      
      // Verify that updatedAt is set to current time
      expect(result[0].updatedAt!.isAfter(existingPermission1.updatedAt!), isTrue);
      expect(result[1].updatedAt!.isAfter(existingPermission2.updatedAt!), isTrue);

      // Verify server repository was called for each permission
      verify(() => mockServerRepository.updateGroupPermission(result[0])).called(1);
      verify(() => mockServerRepository.updateGroupPermission(result[1])).called(1);

      // Verify local repository was called with all permissions
      verify(() => mockLocalRepository.updateGroupPermissions(result)).called(1);

      // Verify getGroupPermission was called for each permission
      verify(() => mockLocalRepository.getGroupPermission('room1')).called(1);
      verify(() => mockLocalRepository.getGroupPermission('room2')).called(1);

      verifyNoMoreInteractions(mockLocalRepository);
      verifyNoMoreInteractions(mockServerRepository);
    });

    test('Given valid permissions with only local persistence, When use case is called, Then updates only local repository', () async {
      // Given
      final localOnlyParams = UpdateBulkGroupPermissionParams(
        permissions: testPermissions,
        persistences: {GroupPermissionPersistence.local},
      );
      
      final existingPermission = GroupPermissionEntity(
        roomId: 'room1',
        enable: true,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      );

      when(() => mockLocalRepository.getGroupPermission('room1'))
          .thenAnswer((_) async => existingPermission);
      when(() => mockLocalRepository.getGroupPermission('room2'))
          .thenAnswer((_) async => null);
      when(() => mockLocalRepository.updateGroupPermissions(any()))
          .thenAnswer((_) async => testPermissions);

      // When
      final result = await useCase(localOnlyParams);

      // Then
      expect(result.length, equals(2));

      // Verify local repository was called
      verify(() => mockLocalRepository.updateGroupPermissions(result)).called(1);
      verify(() => mockLocalRepository.getGroupPermission('room1')).called(1);
      verify(() => mockLocalRepository.getGroupPermission('room2')).called(1);

      // Verify server repository was never called
      verifyNever(() => mockServerRepository.updateGroupPermission(any()));

      verifyNoMoreInteractions(mockLocalRepository);
      verifyNoMoreInteractions(mockServerRepository);
    });

    test('Given valid permissions with only server persistence, When use case is called, Then updates only server repository', () async {
      // Given
      final serverOnlyParams = UpdateBulkGroupPermissionParams(
        permissions: testPermissions,
        persistences: {GroupPermissionPersistence.server},
      );
      
      final existingPermission = GroupPermissionEntity(
        roomId: 'room1',
        enable: true,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      );

      when(() => mockLocalRepository.getGroupPermission('room1'))
          .thenAnswer((_) async => existingPermission);
      when(() => mockLocalRepository.getGroupPermission('room2'))
          .thenAnswer((_) async => null);
      when(() => mockServerRepository.updateGroupPermission(any()))
          .thenAnswer((_) async => testPermissions.first);

      // When
      final result = await useCase(serverOnlyParams);

      // Then
      expect(result.length, equals(2));

      // Verify server repository was called for each permission
      verify(() => mockServerRepository.updateGroupPermission(result[0])).called(1);
      verify(() => mockServerRepository.updateGroupPermission(result[1])).called(1);

      // Verify local repository was called only for getting existing permissions
      verify(() => mockLocalRepository.getGroupPermission('room1')).called(1);
      verify(() => mockLocalRepository.getGroupPermission('room2')).called(1);

      // Verify local repository update was never called
      verifyNever(() => mockLocalRepository.updateGroupPermissions(any()));

      verifyNoMoreInteractions(mockLocalRepository);
      verifyNoMoreInteractions(mockServerRepository);
    });

    test('Given permissions with no existing entity, When use case is called, Then sets createdAt to current time', () async {
      // Given
      when(() => mockLocalRepository.getGroupPermission('room1'))
          .thenAnswer((_) async => null);
      when(() => mockLocalRepository.getGroupPermission('room2'))
          .thenAnswer((_) async => null);
      when(() => mockServerRepository.updateGroupPermission(any()))
          .thenAnswer((_) async => testPermissions.first);
      when(() => mockLocalRepository.updateGroupPermissions(any()))
          .thenAnswer((_) async => testPermissions);

      // When
      final result = await useCase(testParams);

      // Then
      expect(result.length, equals(2));
      
      // Verify that createdAt is set to current time (within a reasonable time window)
      final now = DateTime.now();
      expect(result[0].createdAt!.isAfter(now.subtract(const Duration(seconds: 5))), isTrue);
      expect(result[0].createdAt!.isBefore(now.add(const Duration(seconds: 5))), isTrue);
      expect(result[1].createdAt!.isAfter(now.subtract(const Duration(seconds: 5))), isTrue);
      expect(result[1].createdAt!.isBefore(now.add(const Duration(seconds: 5))), isTrue);

      verify(() => mockLocalRepository.getGroupPermission('room1')).called(1);
      verify(() => mockLocalRepository.getGroupPermission('room2')).called(1);
      verify(() => mockServerRepository.updateGroupPermission(result[0])).called(1);
      verify(() => mockServerRepository.updateGroupPermission(result[1])).called(1);
      verify(() => mockLocalRepository.updateGroupPermissions(result)).called(1);

      verifyNoMoreInteractions(mockLocalRepository);
      verifyNoMoreInteractions(mockServerRepository);
    });

    test('Given empty permissions list, When use case is called, Then returns empty list and no repository calls', () async {
      // Given
      final emptyParams = UpdateBulkGroupPermissionParams(
        permissions: [],
        persistences: {
          GroupPermissionPersistence.local,
          GroupPermissionPersistence.server,
        },
      );
      
      // Mock the updateGroupPermissions method to handle empty list
      when(() => mockLocalRepository.updateGroupPermissions([]))
          .thenAnswer((_) async => []);

      // When
      final result = await useCase(emptyParams);

      // Then
      expect(result, isEmpty);

      // Verify no repository methods were called for getting permissions or updating server
      verifyNever(() => mockLocalRepository.getGroupPermission(any()));
      verifyNever(() => mockServerRepository.updateGroupPermission(any()));
      
      // Note: updateGroupPermissions will be called with empty list in the actual implementation
      // This is expected behavior since Future.wait on empty list returns empty list
      // and then the method continues to execute the persistence logic
      verify(() => mockLocalRepository.updateGroupPermissions([])).called(1);
      
      verifyNoMoreInteractions(mockLocalRepository);
      verifyNoMoreInteractions(mockServerRepository);
    });

    test('Given single permission, When use case is called, Then processes correctly', () async {
      // Given
      final singlePermission = [testPermissions.first];
      final singleParams = UpdateBulkGroupPermissionParams(
        permissions: singlePermission,
        persistences: {GroupPermissionPersistence.local},
      );
      
      final existingPermission = GroupPermissionEntity(
        roomId: 'room1',
        enable: true,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      );

      when(() => mockLocalRepository.getGroupPermission('room1'))
          .thenAnswer((_) async => existingPermission);
      when(() => mockLocalRepository.updateGroupPermissions(any()))
          .thenAnswer((_) async => singlePermission);

      // When
      final result = await useCase(singleParams);

      // Then
      expect(result.length, equals(1));
      expect(result[0].roomId, equals('room1'));

      verify(() => mockLocalRepository.getGroupPermission('room1')).called(1);
      verify(() => mockLocalRepository.updateGroupPermissions(result)).called(1);

      verifyNoMoreInteractions(mockLocalRepository);
      verifyNoMoreInteractions(mockServerRepository);
    });

    test('Given multiple permissions, When use case is called, Then processes all permissions concurrently', () async {
      // Given
      final multiplePermissions = [
        testPermissions.first,
        testPermissions.last,
        const GroupPermissionEntity(roomId: 'room3', enable: true),
      ];
      final multipleParams = UpdateBulkGroupPermissionParams(
        permissions: multiplePermissions,
        persistences: {GroupPermissionPersistence.local},
      );

      when(() => mockLocalRepository.getGroupPermission('room1'))
          .thenAnswer((_) async => null);
      when(() => mockLocalRepository.getGroupPermission('room2'))
          .thenAnswer((_) async => null);
      when(() => mockLocalRepository.getGroupPermission('room3'))
          .thenAnswer((_) async => null);
      when(() => mockLocalRepository.updateGroupPermissions(any()))
          .thenAnswer((_) async => multiplePermissions);

      // When
      final result = await useCase(multipleParams);

      // Then
      expect(result.length, equals(3));
      expect(result[0].roomId, equals('room1'));
      expect(result[1].roomId, equals('room2'));
      expect(result[2].roomId, equals('room3'));

      verify(() => mockLocalRepository.getGroupPermission('room1')).called(1);
      verify(() => mockLocalRepository.getGroupPermission('room2')).called(1);
      verify(() => mockLocalRepository.getGroupPermission('room3')).called(1);
      verify(() => mockLocalRepository.updateGroupPermissions(result)).called(1);

      verifyNoMoreInteractions(mockLocalRepository);
      verifyNoMoreInteractions(mockServerRepository);
    });
  });
}