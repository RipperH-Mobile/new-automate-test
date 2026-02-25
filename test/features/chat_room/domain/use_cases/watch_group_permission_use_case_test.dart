import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/domain/entities/group_permission_entity.dart';
import 'package:uchat/features/chat_room/domain/params/group_permission_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/watch_group_permission_use_case.dart';

class MockChatRoomLocalRepository extends Mock implements ChatRoomLocalRepository {}

void main() {
  late MockChatRoomLocalRepository localRepository;
  late WatchGroupPermissionUseCase systemUnderTest;

  setUp(() {
    localRepository = MockChatRoomLocalRepository();
    systemUnderTest = WatchGroupPermissionUseCase(
      localRepository: localRepository,
    );
  });

  setUpAll(() {
    registerFallbackValue(const GroupPermissionEntity(roomId: 'fallback'));
  });

  tearDown(() {
    reset(localRepository);
  });

  group('WatchGroupPermissionUseCase', () {
    test(
        'Given params with roomId, When call is executed, Then returns stream from localRepository',
        () async {
      // Given
      const roomId = 'test_room';
      final params = WatchGroupPermissionParams(roomId: roomId);
      final expectedPermissions = [
        const GroupPermissionEntity(roomId: roomId, enable: true),
        const GroupPermissionEntity(roomId: roomId, enable: false),
      ];
      final expectedStream = Stream.fromIterable(expectedPermissions);
      when(() => localRepository.watchGroupPermission(roomId)).thenAnswer((_) => expectedStream);

      // When
      final result = systemUnderTest.call(params);

      // Then
      expect(result, emitsInOrder(expectedPermissions));
      verify(() => localRepository.watchGroupPermission(roomId)).called(1);
    });

    test(
        'Given params with different roomId, When call is executed, Then calls repository with correct roomId',
        () async {
      // Given
      const roomId = 'different_room';
      final params = WatchGroupPermissionParams(roomId: roomId);
      final expectedPermissions = [
        const GroupPermissionEntity(roomId: roomId),
      ];
      final expectedStream = Stream.fromIterable(expectedPermissions);
      when(() => localRepository.watchGroupPermission(roomId)).thenAnswer((_) => expectedStream);

      // When
      final result = systemUnderTest.call(params);

      // Then
      expect(result, emitsInOrder(expectedPermissions));
      verify(() => localRepository.watchGroupPermission(roomId)).called(1);
    });
  });
}