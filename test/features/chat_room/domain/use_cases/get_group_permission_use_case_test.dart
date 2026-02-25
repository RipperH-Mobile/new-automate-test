import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/domain/entities/group_permission_entity.dart';
import 'package:uchat/features/chat_room/domain/params/group_permission_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_server_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_group_permission_use_case.dart';

class MockChatRoomServerRepository extends Mock implements ChatRoomServerRepository {}

class MockChatRoomLocalRepository extends Mock implements ChatRoomLocalRepository {}

void main() {
  late MockChatRoomServerRepository serverRepository;
  late MockChatRoomLocalRepository localRepository;
  late GetGroupPermissionUseCase systemUnderTest;

  setUp(() {
    serverRepository = MockChatRoomServerRepository();
    localRepository = MockChatRoomLocalRepository();
    systemUnderTest = GetGroupPermissionUseCase(
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

  group('GetGroupPermissionUseCase', () {
    test(
        'Given persistences includes server and server returns valid permission, When call is executed, Then updates local and returns server permission',
        () async {
      // Given
      const roomId = 'test_room';
      final params = GetGroupPermissionParams(
        roomId: roomId,
        persistences: {GroupPermissionPersistence.server, GroupPermissionPersistence.local},
      );
      final expectedPermission = const GroupPermissionEntity(roomId: roomId, enable: false);
      when(() => serverRepository.getGroupPermission(roomId)).thenAnswer((_) async => expectedPermission);
      when(() => localRepository.updateGroupPermission(expectedPermission)).thenAnswer((_) async => expectedPermission);

      // When
      final result = await systemUnderTest.call(params);

      // Then
      expect(result, equals(expectedPermission));
      verify(() => serverRepository.getGroupPermission(roomId)).called(1);
      verify(() => localRepository.updateGroupPermission(expectedPermission)).called(1);
    });

    test(
        'Given persistences includes server and server returns null, When call is executed, Then updates local with default permission and returns it',
        () async {
      // Given
      const roomId = 'test_room';
      final params = GetGroupPermissionParams(
        roomId: roomId,
        persistences: {GroupPermissionPersistence.server, GroupPermissionPersistence.local},
      );
      const defaultPermission = GroupPermissionEntity(roomId: roomId);
      when(() => serverRepository.getGroupPermission(roomId)).thenAnswer((_) async => null);
      when(() => localRepository.updateGroupPermission(defaultPermission)).thenAnswer((_) async => defaultPermission);

      // When
      final result = await systemUnderTest.call(params);

      // Then
      expect(result?.roomId, equals(roomId));
      expect(result?.enable, equals(false));
      verify(() => serverRepository.getGroupPermission(roomId)).called(1);
      verify(() => localRepository.updateGroupPermission(defaultPermission)).called(1);
    });

    test(
        'Given persistences includes server and server throws exception, When call is executed, Then returns local permission',
        () async {
      // Given
      const roomId = 'test_room';
      final params = GetGroupPermissionParams(
        roomId: roomId,
        persistences: {GroupPermissionPersistence.server, GroupPermissionPersistence.local},
      );
      const localPermission = GroupPermissionEntity(roomId: roomId, canSendMessages: false);
      when(() => serverRepository.getGroupPermission(roomId)).thenThrow(Exception('Server error'));
      when(() => localRepository.getGroupPermission(roomId)).thenAnswer((_) async => localPermission);

      // When
      final result = await systemUnderTest.call(params);

      // Then
      expect(result, equals(localPermission));
      verify(() => serverRepository.getGroupPermission(roomId)).called(1);
      verifyNever(() => localRepository.updateGroupPermission(any()));
      verify(() => localRepository.getGroupPermission(roomId)).called(1);
    });

    test(
        'Given persistences includes server and server throws exception and local returns null, When call is executed, Then returns null',
        () async {
      // Given
      const roomId = 'test_room';
      final params = GetGroupPermissionParams(
        roomId: roomId,
        persistences: {GroupPermissionPersistence.server, GroupPermissionPersistence.local},
      );
      when(() => serverRepository.getGroupPermission(roomId)).thenThrow(Exception('Server error'));
      when(() => localRepository.getGroupPermission(roomId)).thenAnswer((_) async => null);

      // When
      final result = await systemUnderTest.call(params);

      // Then
      expect(result, isNull);
      verify(() => serverRepository.getGroupPermission(roomId)).called(1);
      verifyNever(() => localRepository.updateGroupPermission(any()));
      verify(() => localRepository.getGroupPermission(roomId)).called(1);
    });

    test(
        'Given persistences excludes server, When call is executed, Then returns local permission without calling server',
        () async {
      // Given
      const roomId = 'test_room';
      final params = GetGroupPermissionParams(
        roomId: roomId,
        persistences: {GroupPermissionPersistence.local}, // Default value, excludes server
      );
      const localPermission = GroupPermissionEntity(roomId: roomId, enable: false);
      when(() => localRepository.getGroupPermission(roomId)).thenAnswer((_) async => localPermission);

      // When
      final result = await systemUnderTest.call(params);

      // Then
      expect(result, equals(localPermission));
      verifyNever(() => serverRepository.getGroupPermission(roomId));
      verifyNever(() => localRepository.updateGroupPermission(any()));
      verify(() => localRepository.getGroupPermission(roomId)).called(1);
    });
  });
}