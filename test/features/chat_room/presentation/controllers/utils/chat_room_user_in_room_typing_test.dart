import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/entities/models/contact_model.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/member_typing_model.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_list_controller.dart';
import 'package:uchat/features/chat_room/utils/typing_handler.dart';

class MockMessageListController extends Mock implements MessageListController {}

class MockRoomMemberCollection extends Mock implements RoomMemberCollection {}

class MockContactModel extends Mock implements ContactModel {}

class FakeMemberTypingModel extends Fake implements MemberTypingModel {}

void main() {
  late MockMessageListController mockMessageListController;
  late List<MockRoomMemberCollection> members;
  late MockContactModel mockContact;

  setUpAll(() {
    registerFallbackValue(FakeMemberTypingModel());
  });

  setUp(() {
    mockMessageListController = MockMessageListController();
    mockContact = MockContactModel();

    // Setup mock member
    final mockMember = MockRoomMemberCollection();
    when(() => mockMember.accountId).thenReturn('member1');
    when(() => mockMember.account).thenReturn(mockContact);

    members = [mockMember];
  });

  tearDown(() {
    reset(mockMessageListController);
    for (final member in members) {
      reset(member);
    }
    reset(mockContact);
  });

  group('HandleUserInRoomTypingUseCase', () {
    test('should not update typing member when roomId does not match', () async {
      // Arrange
      final event = UserInRoomTypingEvent(
        accountId: 'member1',
        roomId: 'different_room_id',
        lastTypedAt: DateTime.now(),
        isTyping: true,
      );

      // Act
      await handleUserInRoomTyping(
        event: event,
        currentRoomId: 'current_room_id',
        currentUserId: 'current_user',
        members: members,
        messageListController: mockMessageListController,
      );

      // Assert
      verifyNever(() => mockMessageListController.updateTypingMember(any()));
    });

    test('should not update typing member when accountId matches currentUserId', () async {
      // Arrange
      final event = UserInRoomTypingEvent(
        accountId: 'current_user',
        roomId: 'room_id',
        lastTypedAt: DateTime.now(),
        isTyping: true,
      );

      when(() => mockMessageListController.updateTypingMember(any())).thenAnswer((_) async {});

      // Act
      await handleUserInRoomTyping(
        event: event,
        currentRoomId: 'room_id',
        currentUserId: 'current_user',
        members: members,
        messageListController: mockMessageListController,
      );

      // Assert
      verifyNever(() => mockMessageListController.updateTypingMember(any()));
    });

    test('should not update typing member when member is not found', () async {
      // Arrange
      final event = UserInRoomTypingEvent(
        accountId: 'unknown_member',
        roomId: 'room_id',
        lastTypedAt: DateTime.now(),
        isTyping: true,
      );

      when(() => mockMessageListController.updateTypingMember(any())).thenAnswer((_) async {});

      // Act
      await handleUserInRoomTyping(
        event: event,
        currentRoomId: 'room_id',
        currentUserId: 'current_user',
        members: members,
        messageListController: mockMessageListController,
      );

      // Assert
      verifyNever(() => mockMessageListController.updateTypingMember(any()));
    });

    test('should update typing member when all conditions are met', () async {
      // Arrange
      final now = DateTime.now();
      final event = UserInRoomTypingEvent(
        accountId: 'member1',
        roomId: 'room_id',
        lastTypedAt: now,
        isTyping: true,
      );

      when(() => mockMessageListController.updateTypingMember(any())).thenAnswer((_) async {});

      // Act
      await handleUserInRoomTyping(
        event: event,
        currentRoomId: 'room_id',
        currentUserId: 'current_user',
        members: members,
        messageListController: mockMessageListController,
      );

      // Assert
      verify(() => mockMessageListController.updateTypingMember(any())).called(1);
    });
  });
}
