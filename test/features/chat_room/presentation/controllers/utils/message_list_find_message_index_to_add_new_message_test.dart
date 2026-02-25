import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/presentation/controllers/utils/find_message_index.dart';

void main() {
  // newer message index is 0.
  // older message is length list.
  // failed message combined with messages list as a newest message
  group('findIndexToAddNewMessage', () {
    final message1 = MessageCollection(sequence: 1, isSendFailed: false);
    final message2 = MessageCollection(sequence: 2, isSendFailed: false);
    final message3 = MessageCollection(sequence: 3, isSendFailed: false);
    final failedMessage = MessageCollection(sequence: null, isSendFailed: true);

    test('returns 0 when list is empty and message has no sequence', () {
      final result = findIndexToAddNewMessage(
        MessageCollection(sequence: null, isSendFailed: false),
        [],
        0,
      );
      expect(result, 0);
    });

    test('returns correct index when message has a sequence and list is sorted', () {
      final result = findIndexToAddNewMessage(
        MessageCollection(sequence: 2, isSendFailed: false),
        [message3, message1],
        0,
      );
      expect(result, 1);
    });

    test('returns correct index when message has no sequence and failed messages exist', () {
      final result = findIndexToAddNewMessage(
        MessageCollection(sequence: null, isSendFailed: false),
        [failedMessage, message2, message1],
        1,
      );
      expect(result, 1);
    });

    test('returns correct index when message has no sequence, failed and failed messages exist', () {
      final result = findIndexToAddNewMessage(
        MessageCollection(sequence: null, isSendFailed: false),
        [failedMessage, failedMessage, message2, message1],
        2,
      );
      expect(result, 2);
    });

    test('returns correct index when message has no sequence and no failed messages exist', () {
      final result = findIndexToAddNewMessage(
        MessageCollection(sequence: null, isSendFailed: false),
        [message2, message1],
        0,
      );
      expect(result, 0);
    });

    test('returns correct index when message has a sequence and is older than all messages', () {
      final result = findIndexToAddNewMessage(
        MessageCollection(sequence: 0, isSendFailed: false),
        [message2, message1],
        0,
      );
      expect(result, 2);
    });

    test('returns correct index when message has a sequence and is newer than all messages', () {
      final result = findIndexToAddNewMessage(
        MessageCollection(sequence: 4, isSendFailed: false),
        [message3, message2, message1],
        0,
      );
      expect(result, 0);
    });

    test('returns correct index when message has a sequence and matches an existing message', () {
      final result = findIndexToAddNewMessage(
        MessageCollection(sequence: 2, isSendFailed: false),
        [message3, message2, message1],
        0,
      );
      expect(result, 1);
    });

    test(
      'returns correct index when there are 2 failed message and incoming message seq is between existing messages',
      () {
        final result = findIndexToAddNewMessage(
          MessageCollection(sequence: 4, isSendFailed: false),
          [
            failedMessage,
            failedMessage,
            MessageCollection(sequence: 5, isSendFailed: false),
            MessageCollection(sequence: 3, isSendFailed: false),
          ],
          2,
        );
        expect(result, 3);
      },
    );
  });
}
