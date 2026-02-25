import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/features/chat_room/data/models/requests/leave_group_with_me_as_an_owner_request.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_server_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/leave_groups_with_me_as_an_owner_use_case.dart';

// Mock classes
class MockChatRoomServerRepository extends Mock implements ChatRoomServerRepository {}

class FakeLeaveGroupWithMeAsAnOwnerRequest extends Fake implements LeaveGroupWithMeAsAnOwnerRequest {}

void main() {
  late LeaveGroupsWithMeAsAnOwnerUseCase useCase;
  late MockChatRoomServerRepository mockChatRoomServerRepository;

  setUpAll(() {
    registerFallbackValue(FakeLeaveGroupWithMeAsAnOwnerRequest());
  });

  setUp(() {
    mockChatRoomServerRepository = MockChatRoomServerRepository();
    useCase = LeaveGroupsWithMeAsAnOwnerUseCase(chatRoomServerRepository: mockChatRoomServerRepository);
  });

  // Test data
  final tLeaveGroupRequest = LeaveGroupWithMeAsAnOwnerRequest(actionToken: 'test_action_token');

  final tException = Exception('Something went wrong');

  group('LeaveGroupsWithMeAsAnOwnerUseCase', () {
    test(
      'Given leave group with me as an owner successfully, When call is executed, Then completes successfully',
      () async {
        // Given
        when(() => mockChatRoomServerRepository.leaveGroupWithMeAsAnOwner(tLeaveGroupRequest)).thenAnswer((_) async {});

        // When
        await useCase(tLeaveGroupRequest);

        // Then
        verify(() => mockChatRoomServerRepository.leaveGroupWithMeAsAnOwner(tLeaveGroupRequest)).called(1);
        verifyNoMoreInteractions(mockChatRoomServerRepository);
      },
    );
    test('Given ChatRoomServerRepository throws an exception, When use case is called, Then throws the exception',
        () async {
      // Given
      when(() => mockChatRoomServerRepository.leaveGroupWithMeAsAnOwner(any())).thenThrow(tException);

      // When
      final call = useCase(tLeaveGroupRequest);

      // Then
      await expectLater(call, throwsA(equals(tException)));
      verify(() => mockChatRoomServerRepository.leaveGroupWithMeAsAnOwner(tLeaveGroupRequest)).called(1);
      verifyNoMoreInteractions(mockChatRoomServerRepository);
    });
  });
}
