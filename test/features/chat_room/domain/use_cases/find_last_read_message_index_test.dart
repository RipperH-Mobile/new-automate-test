import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/domain/use_cases/find_last_read_message_index_use_case.dart';
import 'package:uchat/utils/date.dart';

void main() {
  // Mock message list with 100 message
  final List<MessageCollection> messages = [];
  final maximumMockMessage = 100;
  late FindLastReadMessageIndexUseCase useCase;
  final String currentUserId = 'current_user_id';
  final String otherUserId = 'other_user_id';
  final DateTime now = DateTime.now();

  setUpAll(() {
    // Create a list of messages with sequence numbers from 0 to 99
    // and isSendFailed set to false
    for (int i = 0; i < maximumMockMessage; i++) {
      messages.add(MessageCollection(
        accountId: otherUserId,
        ref: 'ref_$i',
        sequence: i,
        isSendFailed: false,
        createdAt: now.subtract(Duration(minutes: i)),
      ));
    }
  });

  setUp(() {
    useCase = FindLastReadMessageIndexUseCase();
  });

  group('findLastReadMessageIndex', () {
    test('returns correct index when last read message is in the list', () async {
      /// This test case is to check if the last read message is in the first group of messages (100 messages)
      /// and unread count is correct number as well
      final unreadCount = 50;
      final lastReadAt = messages[unreadCount].createdAt?.millisecondsSinceEpoch ?? 0;

      final result = await useCase(
        FindLastReadMessageIndexParams(
          currentMessageList: messages,
          lastReadAt: lastReadAt,
          unreadCount: unreadCount,
          currentUserId: currentUserId,
        ),
      );

      expect(result, (49, messages[49].ref));
    });

    test('returns -1 when last read message is not in the list', () async {
      /// This test case is to check if the last read message is not in the first group of messages (100 messages)
      /// and the unread count is greater than the message list
      /// that means the last read message is older than the first group of messages
      /// then the last read message index should be -1
      final unreadCount = 80;
      final lastReadAt = now.subHours(2).millisecondsSinceEpoch;

      final result = await useCase(
        FindLastReadMessageIndexParams(
          currentMessageList: messages,
          lastReadAt: lastReadAt,
          unreadCount: unreadCount,
          currentUserId: currentUserId,
        ),
      );

      expect(result, (-1, ''));
    });

    test('returns -1 when unread count is greater than message list', () async {
      /// This test case is to check if the unread count is greater than the message list
      /// then the last read message index should be -1
      final unreadCount = 200;
      final lastReadAt = now.subHours(2).millisecondsSinceEpoch;

      final result = await useCase(
        FindLastReadMessageIndexParams(
          currentMessageList: messages,
          lastReadAt: lastReadAt,
          unreadCount: unreadCount,
          currentUserId: currentUserId,
        ),
      );

      expect(result, (-1, ''));
    });

    test('returns -1 when message list is empty', () async {
      /// This test case is to check if the message list is empty
      /// and this case could be happen when the user just joined the room at the first time
      /// or the room is empty, happen when the controller fail to load the message list
      /// then the last read message index should be -1
      final lastReadAt = 0;
      final unreadCount = 10;

      final result = await useCase(
        FindLastReadMessageIndexParams(
          currentMessageList: [],
          lastReadAt: lastReadAt,
          unreadCount: unreadCount,
          currentUserId: currentUserId,
        ),
      );

      expect(result, (-1, ''));
    });

    test('returns oldest message in list when last read message time is 0', () async {
      /// This test case is to check if the last read message time is 0
      /// and this case could be happen when the user just joined the room at the first time
      /// and never get into the room, that means the user never read any message in this room
      /// then the last read message index should be the last message in the list
      final lastReadAt = 0;
      final unreadCount = 10;

      final result = await useCase(
        FindLastReadMessageIndexParams(
          currentMessageList: messages,
          lastReadAt: lastReadAt,
          unreadCount: unreadCount,
          currentUserId: currentUserId,
        ),
      );

      expect(result, (unreadCount - 1, messages[unreadCount - 1].ref));
    });

    test('returns correct index when last read message is newer than all messages', () async {
      /// This test case is to check if the last read message is newer than all messages
      /// and unread count is correct number as well
      ///
      /// This case could be happen when the read trigger has been sent with incorrect time
      /// or send from outside the correct flow
      /// and unread count is not updated yet
      ///
      /// that means the last read message is not found in the first group of messages
      /// then the last read message index should be -1
      final lastReadAt = now.addMinutes(10).millisecondsSinceEpoch;
      final unreadCount = 10;

      final result = await useCase(
        FindLastReadMessageIndexParams(
          currentMessageList: messages,
          lastReadAt: lastReadAt,
          unreadCount: unreadCount,
          currentUserId: currentUserId,
        ),
      );

      expect(result, (0, messages[0].ref));
    });

    test('returns correct index when last read message is in the middle of the list', () async {
      /// This test case is to check if the last read message is in the middle of the list
      /// and unread count is correct number as well
      final unreadCount = 50;
      final lastReadAt = messages[unreadCount].createdAt?.millisecondsSinceEpoch ?? 0;

      final result = await useCase(
        FindLastReadMessageIndexParams(
          currentMessageList: messages,
          lastReadAt: lastReadAt,
          unreadCount: unreadCount,
          currentUserId: currentUserId,
        ),
      );

      expect(result, (49, messages[49].ref));
    });

    test('returns correct index when last read message is the first message', () async {
      /// This test case is to check if the last read message is the first message
      /// and unread count is correct number as well
      ///
      /// Have only 1 unread message
      final unreadCount = 1;
      final lastReadAt = messages[unreadCount].createdAt?.millisecondsSinceEpoch ?? 0;

      final result = await useCase(
        FindLastReadMessageIndexParams(
          currentMessageList: messages,
          lastReadAt: lastReadAt,
          unreadCount: unreadCount,
          currentUserId: currentUserId,
        ),
      );

      expect(result, (0, messages[0].ref));
    });

    test('returns -1 when unread count is 0, but last read message is in the list', () async {
      final unreadCount = 0;
      final lastReadAt = messages[50].createdAt?.millisecondsSinceEpoch ?? 0;

      final result = await useCase(
        FindLastReadMessageIndexParams(
          currentMessageList: messages,
          lastReadAt: lastReadAt,
          unreadCount: unreadCount,
          currentUserId: currentUserId,
        ),
      );

      expect(result, (-1, ''));
    });

    test(
        'returns 10 when unread count is 10, but last read message is in the list and older than the message number 10'
        'should be show at the real last read message index', () async {
      /// This test case is to check if the last read message is in the list, but unread count less than the message number
      /// and unread count is correct number as well
      ///
      /// This case could be happen when the unread count updated incorrectly
      /// and the last read message is older than the message number 10
      final unreadCount = 10;
      final lastReadAt = messages[50].createdAt?.millisecondsSinceEpoch ?? 0;

      final result = await useCase(
        FindLastReadMessageIndexParams(
          currentMessageList: messages,
          lastReadAt: lastReadAt,
          unreadCount: unreadCount,
          currentUserId: currentUserId,
        ),
      );

      expect(result, (49, messages[49].ref));
    });

    test('returns the message index before mine message', () async {
      /// This test case is to check if the last read message is in the list,
      /// but unread count and last read message is older than the mine message
      final unreadCount = 50;
      final lastReadAt = messages[unreadCount].createdAt?.millisecondsSinceEpoch ?? 0;
      messages[10].accountId = currentUserId;

      final result = await useCase(
        FindLastReadMessageIndexParams(
          currentMessageList: messages,
          lastReadAt: lastReadAt,
          unreadCount: unreadCount,
          currentUserId: currentUserId,
        ),
      );

      expect(result, (9, messages[9].ref));
    });
  });
}
