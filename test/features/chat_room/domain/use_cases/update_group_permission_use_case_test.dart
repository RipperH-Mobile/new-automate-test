import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/domain/entities/group_permission_entity.dart';
import 'package:uchat/features/chat_room/domain/params/group_permission_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_server_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/update_group_permission_use_case.dart';

class MockChatRoomServerRepository extends Mock implements ChatRoomServerRepository {}

class MockChatRoomLocalRepository extends Mock implements ChatRoomLocalRepository {}

void main() {
  late MockChatRoomServerRepository serverRepository;
  late MockChatRoomLocalRepository localRepository;
  late UpdateGroupPermissionUseCase systemUnderTest;

  setUp(() {
    serverRepository = MockChatRoomServerRepository();
    localRepository = MockChatRoomLocalRepository();
    systemUnderTest = UpdateGroupPermissionUseCase(
      localRepository: localRepository,
      serverRepository: serverRepository,
    );
  });

  setUpAll(() {
    registerFallbackValue(const GroupPermissionEntity(roomId: 'fallback'));
  });

  tearDown(() {
    reset(serverRepository);
    reset(localRepository);
  });

  group('UpdateGroupPermissionUseCase', () {
    const roomId = 'test_room';
    final updatedPermission = GroupPermissionEntity(
      roomId: roomId,
      enable: false,
      updatedAt: DateTime(2023, 5, 2, 10),
    );

    test(
        'Given local exists and persisting to both server and local, When call is executed, Then updates both and returns permission with timestamps',
        () async {
      // Given
      final localPermission = GroupPermissionEntity(roomId: roomId, createdAt: DateTime(2023, 5, 1, 10));
      final params = UpdateGroupPermissionParams(
        permission: updatedPermission,
        persistences: {
          GroupPermissionPersistence.local,
          GroupPermissionPersistence.server,
        },
      );
      when(() => localRepository.getGroupPermission(roomId)).thenAnswer((_) async => localPermission);
      when(() => serverRepository.updateGroupPermission(any())).thenAnswer((_) async => const GroupPermissionEntity(roomId: 'return'));
      when(() => localRepository.updateGroupPermission(any())).thenAnswer((_) async => const GroupPermissionEntity(roomId: 'return'));

      // When
      final result = await systemUnderTest.call(params);

      // Then
      expect(result.roomId, equals(roomId));
      expect(result.enable, equals(updatedPermission.enable));
      expect(result.createdAt, equals(localPermission.createdAt));
      expect(result.updatedAt, isNotNull);
      verify(() => serverRepository.updateGroupPermission(any())).called(1);
      verify(() => localRepository.updateGroupPermission(any())).called(1);
    });

    test(
        'Given local exists and persisting only to server, When call is executed, Then updates server and returns permission with timestamps',
        () async {
      // Given
      final localPermission = GroupPermissionEntity(roomId: roomId, createdAt: DateTime(2023, 5, 1, 10));
      final params = UpdateGroupPermissionParams(
        permission: updatedPermission,
        persistences: {GroupPermissionPersistence.server},
      );
      when(() => localRepository.getGroupPermission(roomId)).thenAnswer((_) async => localPermission);
      when(() => serverRepository.updateGroupPermission(any())).thenAnswer((_) async => const GroupPermissionEntity(roomId: 'return'));

      // When
      final result = await systemUnderTest.call(params);

      // Then
      expect(result.createdAt, equals(localPermission.createdAt));
      verify(() => serverRepository.updateGroupPermission(any())).called(1);
      verifyNever(() => localRepository.updateGroupPermission(any()));
    });

    test(
        'Given local exists and persisting only to local, When call is executed, Then updates local and returns permission with timestamps',
        () async {
      // Given
      final localPermission = GroupPermissionEntity(roomId: roomId, createdAt: DateTime(2023, 5, 1, 10));
      final params = UpdateGroupPermissionParams(
        permission: updatedPermission,
        persistences: {GroupPermissionPersistence.local},
      );
      when(() => localRepository.getGroupPermission(roomId)).thenAnswer((_) async => localPermission);
      when(() => localRepository.updateGroupPermission(any())).thenAnswer((_) async => const GroupPermissionEntity(roomId: 'return'));

      // When
      final result = await systemUnderTest.call(params);

      // Then
      expect(result.createdAt, equals(localPermission.createdAt));
      verifyNever(() => serverRepository.updateGroupPermission(any()));
      verify(() => localRepository.updateGroupPermission(any())).called(1);
    });

    test(
        'Given local returns null, When call is executed, Then sets createdAt to now and persists as configured',
        () async {
      // Given
      final params = UpdateGroupPermissionParams(
        permission: updatedPermission,
        persistences: {GroupPermissionPersistence.server},
      );
      when(() => localRepository.getGroupPermission(roomId)).thenAnswer((_) async => null);
      when(() => serverRepository.updateGroupPermission(any())).thenAnswer((_) async => const GroupPermissionEntity(roomId: 'return'));

      // When
      final result = await systemUnderTest.call(params);

      // Then
      expect(result.createdAt, isNotNull);
      expect(result.updatedAt, isNotNull);
      expect(result.createdAt!.isAfter(DateTime.now().subtract(const Duration(seconds: 1))), isTrue);
      verify(() => serverRepository.updateGroupPermission(any())).called(1);
    });

    test(
        'Given empty persistences, When call is executed, Then only returns permission with timestamps, no persists',
        () async {
      // Given
      final localPermission = GroupPermissionEntity(roomId: roomId, createdAt: DateTime(2023, 5, 1, 10));
      final params = UpdateGroupPermissionParams(
        permission: updatedPermission,
        persistences: {},
      );
      when(() => localRepository.getGroupPermission(roomId)).thenAnswer((_) async => localPermission);

      // When
      final result = await systemUnderTest.call(params);

      // Then
      expect(result.createdAt, equals(localPermission.createdAt));
      verifyNever(() => serverRepository.updateGroupPermission(any()));
      verifyNever(() => localRepository.updateGroupPermission(any()));
    });
  });
}