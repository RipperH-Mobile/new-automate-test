import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/data/models/requests/leave_group_request.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_file_local_repository.dart';
import 'package:uchat/features/chat_room_detail/domain/params/leave_group_params.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/leave_group_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';

class MockChatRoomListServerRepository extends Mock implements ChatRoomListServerRepository {}

class MockChatRoomLocalRepository extends Mock implements ChatRoomLocalRepository {}

class MockMessageLocalRepository extends Mock implements MessageLocalRepository {}

class MockRoomFileLocalRepository extends Mock implements RoomFileLocalRepository {}

void main() {
  late LeaveGroupUseCase useCase;
  late MockChatRoomListServerRepository mockChatRoomListServerRepository;
  late MockChatRoomLocalRepository mockChatRoomLocalRepository;
  late MockMessageLocalRepository mockMessageLocalRepository;
  late MockRoomFileLocalRepository mockRoomFileLocalRepository;

  setUpAll(() {
    registerFallbackValue(LeaveGroupRequest(roomId: 'test'));
  });

  setUp(() {
    mockChatRoomListServerRepository = MockChatRoomListServerRepository();
    mockChatRoomLocalRepository = MockChatRoomLocalRepository();
    mockMessageLocalRepository = MockMessageLocalRepository();
    mockRoomFileLocalRepository = MockRoomFileLocalRepository();

    useCase = LeaveGroupUseCase(
      chatRoomListServerRepository: mockChatRoomListServerRepository,
      chatRoomLocalRepository: mockChatRoomLocalRepository,
      messageLocalRepository: mockMessageLocalRepository,
      roomFileLocalRepository: mockRoomFileLocalRepository,
    );
  });

  group('LeaveGroupUseCase', () {
    test('Given valid params without callback, When call is executed, Then performs all operations in correct order',
        () async {
      // Given
      const roomId = 'test_room_id';
      final params = LeaveGroupParams(roomId: roomId);

      when(() => mockChatRoomListServerRepository.leaveGroup(any())).thenAnswer((_) async {
        return null;
      });
      when(() => mockChatRoomLocalRepository.deleteRoom(any())).thenAnswer((_) async {});
      when(() => mockChatRoomLocalRepository.deleteRoomSubscriptionWithRoomId(any())).thenAnswer((_) async {});
      when(() => mockChatRoomLocalRepository.deleteMemberInRoom(any())).thenAnswer((_) async {});
      when(() => mockMessageLocalRepository.deleteAllMessageInRoom(roomId: any(named: 'roomId')))
          .thenAnswer((_) async {});
      when(() => mockRoomFileLocalRepository.deleteAllFileInRoom(any())).thenAnswer((_) async {});

      // When
      await useCase.call(params);

      // Then
      verifyInOrder([
        () => mockChatRoomListServerRepository.leaveGroup(any(that: isA<LeaveGroupRequest>())),
        () => mockChatRoomLocalRepository.deleteRoom(roomId),
        () => mockChatRoomLocalRepository.deleteRoomSubscriptionWithRoomId(roomId),
        () => mockChatRoomLocalRepository.deleteMemberInRoom(roomId),
        () => mockMessageLocalRepository.deleteAllMessageInRoom(roomId: roomId),
        () => mockRoomFileLocalRepository.deleteAllFileInRoom(roomId),
      ]);
    });

    test('Given valid params with callback, When call is executed, Then executes callback with correct room ID',
        () async {
      // Given
      const roomId = 'test_room_id';
      String? callbackRoomId;
      final params = LeaveGroupParams(
        roomId: roomId,
        onRoomDeleted: (id) => callbackRoomId = id,
      );

      when(() => mockChatRoomListServerRepository.leaveGroup(any())).thenAnswer((_) async {
        return null;
      });
      when(() => mockChatRoomLocalRepository.deleteRoom(any())).thenAnswer((_) async {});
      when(() => mockChatRoomLocalRepository.deleteRoomSubscriptionWithRoomId(any())).thenAnswer((_) async {});
      when(() => mockChatRoomLocalRepository.deleteMemberInRoom(any())).thenAnswer((_) async {});
      when(() => mockMessageLocalRepository.deleteAllMessageInRoom(roomId: any(named: 'roomId')))
          .thenAnswer((_) async {});
      when(() => mockRoomFileLocalRepository.deleteAllFileInRoom(any())).thenAnswer((_) async {});

      // When
      await useCase.call(params);

      // Then
      expect(callbackRoomId, equals(roomId));
    });

    test('Given valid params, When call is executed, Then passes correct LeaveGroupRequest to server repository',
        () async {
      // Given
      const roomId = 'test_room_id';
      final params = LeaveGroupParams(roomId: roomId);

      when(() => mockChatRoomListServerRepository.leaveGroup(any())).thenAnswer((_) async {
        return null;
      });
      when(() => mockChatRoomLocalRepository.deleteRoom(any())).thenAnswer((_) async {});
      when(() => mockChatRoomLocalRepository.deleteRoomSubscriptionWithRoomId(any())).thenAnswer((_) async {});
      when(() => mockChatRoomLocalRepository.deleteMemberInRoom(any())).thenAnswer((_) async {});
      when(() => mockMessageLocalRepository.deleteAllMessageInRoom(roomId: any(named: 'roomId')))
          .thenAnswer((_) async {});
      when(() => mockRoomFileLocalRepository.deleteAllFileInRoom(any())).thenAnswer((_) async {});

      // When
      await useCase.call(params);

      // Then
      final captured = verify(() => mockChatRoomListServerRepository.leaveGroup(captureAny())).captured;
      final request = captured.single as LeaveGroupRequest;
      expect(request.roomId, equals(roomId));
    });

    test('Given server repository throws exception, When call is executed, Then propagates exception', () async {
      // Given
      const roomId = 'test_room_id';
      final params = LeaveGroupParams(roomId: roomId);
      final exception = Exception('Server error');

      when(() => mockChatRoomListServerRepository.leaveGroup(any())).thenThrow(exception);

      // When & Then
      expect(() => useCase.call(params), throwsA(exception));
    });

    test('Given local repository throws exception, When call is executed, Then propagates exception', () async {
      // Given
      const roomId = 'test_room_id';
      final params = LeaveGroupParams(roomId: roomId);
      final exception = Exception('Local error');

      when(() => mockChatRoomListServerRepository.leaveGroup(any())).thenAnswer((_) async {
        return null;
      });
      when(() => mockChatRoomLocalRepository.deleteRoom(any())).thenThrow(exception);

      // When & Then
      expect(() => useCase.call(params), throwsA(exception));
    });

    test('Given message repository throws exception, When call is executed, Then propagates exception', () async {
      // Given
      const roomId = 'test_room_id';
      final params = LeaveGroupParams(roomId: roomId);
      final exception = Exception('Message error');

      when(() => mockChatRoomListServerRepository.leaveGroup(any())).thenAnswer((_) async {
        return null;
      });
      when(() => mockChatRoomLocalRepository.deleteRoom(any())).thenAnswer((_) async {});
      when(() => mockChatRoomLocalRepository.deleteRoomSubscriptionWithRoomId(any())).thenAnswer((_) async {});
      when(() => mockChatRoomLocalRepository.deleteMemberInRoom(any())).thenAnswer((_) async {});
      when(() => mockMessageLocalRepository.deleteAllMessageInRoom(roomId: any(named: 'roomId'))).thenThrow(exception);

      // When & Then
      expect(() => useCase.call(params), throwsA(exception));
    });

    test('Given room file repository throws exception, When call is executed, Then propagates exception', () async {
      // Given
      const roomId = 'test_room_id';
      final params = LeaveGroupParams(roomId: roomId);
      final exception = Exception('File error');

      when(() => mockChatRoomListServerRepository.leaveGroup(any())).thenAnswer((_) async {
        return null;
      });
      when(() => mockChatRoomLocalRepository.deleteRoom(any())).thenAnswer((_) async {});
      when(() => mockChatRoomLocalRepository.deleteRoomSubscriptionWithRoomId(any())).thenAnswer((_) async {});
      when(() => mockChatRoomLocalRepository.deleteMemberInRoom(any())).thenAnswer((_) async {});
      when(() => mockMessageLocalRepository.deleteAllMessageInRoom(roomId: any(named: 'roomId')))
          .thenAnswer((_) async {});
      when(() => mockRoomFileLocalRepository.deleteAllFileInRoom(any())).thenThrow(exception);

      // When & Then
      expect(() => useCase.call(params), throwsA(exception));
    });

    test('Given empty room ID, When call is executed, Then passes empty string to all repositories', () async {
      // Given
      const roomId = '';
      final params = LeaveGroupParams(roomId: roomId);

      when(() => mockChatRoomListServerRepository.leaveGroup(any())).thenAnswer((_) async {
        return null;
      });
      when(() => mockChatRoomLocalRepository.deleteRoom(any())).thenAnswer((_) async {});
      when(() => mockChatRoomLocalRepository.deleteRoomSubscriptionWithRoomId(any())).thenAnswer((_) async {});
      when(() => mockChatRoomLocalRepository.deleteMemberInRoom(any())).thenAnswer((_) async {});
      when(() => mockMessageLocalRepository.deleteAllMessageInRoom(roomId: any(named: 'roomId')))
          .thenAnswer((_) async {});
      when(() => mockRoomFileLocalRepository.deleteAllFileInRoom(any())).thenAnswer((_) async {});

      // When
      await useCase.call(params);

      // Then
      verify(() => mockChatRoomLocalRepository.deleteRoom('')).called(1);
      verify(() => mockChatRoomLocalRepository.deleteRoomSubscriptionWithRoomId('')).called(1);
      verify(() => mockChatRoomLocalRepository.deleteMemberInRoom('')).called(1);
      verify(() => mockMessageLocalRepository.deleteAllMessageInRoom(roomId: '')).called(1);
      verify(() => mockRoomFileLocalRepository.deleteAllFileInRoom('')).called(1);
    });
  });
}
