import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/chat_room/domain/use_cases/is_read_message_use_case.dart';

void main() {
  group('IsReadMessageUseCase', () {
    late IsReadMessageUseCase useCase;

    setUp(() {
      useCase = IsReadMessageUseCase();
    });

    group('Edge Cases', () {
      test('should return (false, 0) when message sequence is null', () {
        // Arrange: Create params with null message sequence
        final params = IsReadMessageParams(
          messageSequence: null,
          memberLastReadAtMap: {'user1': 1000},
          memberJoinedMap: {},
        );

        // Act: Call the use case
        final result = useCase(params);

        // Assert: Should return false with 0 read count since sequence is null (treated as 0)
        expect(result.$1, false);
        expect(result.$2.length, 0);
      });

      test('should return (false, 0) when message sequence is 0', () {
        // Arrange: Create params with sequence 0
        final params = IsReadMessageParams(
          messageSequence: 0,
          memberLastReadAtMap: {'user1': 1000},
          memberJoinedMap: {},
        );

        // Act: Call the use case
        final result = useCase(params);

        // Assert: Should return false with 0 read count for sequence 0
        expect(result.$1, false);
        expect(result.$2.length, 0);
      });

      test('should return (false, 0) when memberLastReadAtMap is empty', () {
        // Arrange: Create params with empty last read map
        final params = IsReadMessageParams(
          messageSequence: 1000,
          memberLastReadAtMap: {}, // Empty map
          memberJoinedMap: {},
        );

        // Act: Call the use case
        final result = useCase(params);

        // Assert: Should return false with 0 read count when no members in map
        expect(result.$1, false);
        expect(result.$2.length, 0);
      });

      test('should handle null memberJoinedMap gracefully', () {
        // Arrange: Create params with null joined map
        final params = IsReadMessageParams(
          messageSequence: 1000,
          memberLastReadAtMap: {'user1': 1500},
          memberJoinedMap: null, // Null map should be treated as empty
          isGroup: true,
        );

        // Act: Call the use case
        final result = useCase(params);

        // Assert: Should work normally and count the read
        expect(result.$1, true);
        expect(result.$2.length, 1);
      });
    });

    group('Group Chat Scenarios', () {
      test('should return (true, 3) when all members in group have read the message', () {
        // Arrange: Set up group chat where all members read after message timestamp
        final messageTimestamp = 1000; // Message sent at timestamp 1000
        final readAfterMessage = 1500; // All members read at timestamp 1500
        final joinedBeforeMessage = DateTime.fromMillisecondsSinceEpoch(500); // Joined before message

        final params = IsReadMessageParams(
          messageSequence: messageTimestamp,
          memberLastReadAtMap: {
            'user1': readAfterMessage,
            'user2': readAfterMessage,
            'user3': readAfterMessage,
          },
          memberJoinedMap: {
            'user1': joinedBeforeMessage,
            'user2': joinedBeforeMessage,
            'user3': joinedBeforeMessage,
          },
          isGroup: true,
        );

        // Act: Call the use case
        final result = useCase(params);

        // Assert: All 3 members should be counted as having read the message
        expect(result.$1, true);
        expect(result.$2.length, 3);
      });

      test('should return (true, 2) when only some members have read the message', () {
        // Arrange: Set up group chat with mixed read statuses
        final messageTimestamp = 1000;
        final readAfterMessage = 1500;
        final readBeforeMessage = 500; // This member hasn't read the message yet
        final joinedBeforeMessage = DateTime.fromMillisecondsSinceEpoch(100);

        final params = IsReadMessageParams(
          messageSequence: messageTimestamp,
          memberLastReadAtMap: {
            'user1': readAfterMessage, // Has read the message
            'user2': readBeforeMessage, // Has NOT read the message
            'user3': readAfterMessage, // Has read the message
          },
          memberJoinedMap: {
            'user1': joinedBeforeMessage,
            'user2': joinedBeforeMessage,
            'user3': joinedBeforeMessage,
          },
          isGroup: true,
        );

        // Act: Call the use case
        final result = useCase(params);

        // Assert: Only 2 out of 3 members have read the message
        expect(result.$1, true);
        expect(result.$2.length, 2);
      });

      test('should exclude members who joined after the message was sent', () {
        // Arrange: Set up scenario where some members joined after message
        final messageTimestamp = 1000;
        final readAfterMessage = 1500;
        final joinedBeforeMessage = DateTime.fromMillisecondsSinceEpoch(500);
        final joinedAfterMessage = DateTime.fromMillisecondsSinceEpoch(1200); // Joined after message

        final params = IsReadMessageParams(
          messageSequence: messageTimestamp,
          memberLastReadAtMap: {
            'user1': readAfterMessage, // Joined before, read message
            'user2': readAfterMessage, // Joined after, should be excluded
            'user3': readAfterMessage, // Joined before, read message
          },
          memberJoinedMap: {
            'user1': joinedBeforeMessage,
            'user2': joinedAfterMessage, // This member should be excluded
            'user3': joinedBeforeMessage,
          },
          isGroup: true,
        );

        // Act: Call the use case
        final result = useCase(params);

        // Assert: Only 2 members should be counted (user2 joined after message)
        expect(result.$1, true);
        expect(result.$2.length, 2);
      });

      test('should exclude members with lastReadAt = 0 (never read)', () {
        // Arrange: Set up scenario with members who never read any message
        final messageTimestamp = 1000;
        final readAfterMessage = 1500;
        final joinedBeforeMessage = DateTime.fromMillisecondsSinceEpoch(500);

        final params = IsReadMessageParams(
          messageSequence: messageTimestamp,
          memberLastReadAtMap: {
            'user1': readAfterMessage, // Has read messages
            'user2': 0, // Never read any message (lastReadAt = 0)
            'user3': readAfterMessage, // Has read messages
          },
          memberJoinedMap: {
            'user1': joinedBeforeMessage,
            'user2': joinedBeforeMessage,
            'user3': joinedBeforeMessage,
          },
          isGroup: true,
        );

        // Act: Call the use case
        final result = useCase(params);

        // Assert: Only 2 members should be counted (user2 never read any messages)
        expect(result.$1, true);
        expect(result.$2.length, 2);
      });

      test('should include members with null join date (legacy users)', () {
        // Arrange: Set up scenario with members having null join dates
        // This typically happens with legacy users who joined before join date tracking
        // or due to data migration issues. These users should still be counted.
        final messageTimestamp = 1000;
        final readAfterMessage = 1500;
        final joinedBeforeMessage = DateTime.fromMillisecondsSinceEpoch(500);

        final params = IsReadMessageParams(
          messageSequence: messageTimestamp,
          memberLastReadAtMap: {
            'user1': readAfterMessage,
            'user2': readAfterMessage, // This user has null join date (legacy user)
            'user3': readAfterMessage,
          },
          memberJoinedMap: {
            'user1': joinedBeforeMessage,
            'user2': null, // Null join date - should be included as legacy user
            'user3': joinedBeforeMessage,
          },
          isGroup: true,
        );

        // Act: Call the use case
        final result = useCase(params);

        // Assert: All 3 members should be counted (including user2 with null join date)
        // Business logic: Users with null join dates are treated as legacy/founding members
        expect(result.$1, true);
        expect(result.$2.length, 3);
      });

      test('should distinguish between null join date (legacy) vs joined after message', () {
        // Arrange: Test the difference between null join date and joining after message
        final messageTimestamp = 1000;
        final readAfterMessage = 1500;
        final joinedBeforeMessage = DateTime.fromMillisecondsSinceEpoch(500);
        final joinedAfterMessage = DateTime.fromMillisecondsSinceEpoch(1200);

        final params = IsReadMessageParams(
          messageSequence: messageTimestamp,
          memberLastReadAtMap: {
            'legacy_user': readAfterMessage, // Null join date - should be counted
            'new_user': readAfterMessage, // Joined after message - should be excluded
            'old_user': readAfterMessage, // Joined before message - should be counted
          },
          memberJoinedMap: {
            'legacy_user': null, // Legacy user with null join date
            'new_user': joinedAfterMessage, // Joined after the message
            'old_user': joinedBeforeMessage, // Joined before the message
          },
          isGroup: true,
        );

        // Act: Call the use case
        final result = useCase(params);

        // Assert: Only legacy_user and old_user should be counted (2 total)
        // new_user should be excluded because they joined after the message
        expect(result.$1, true);
        expect(result.$2.length, 2);
      });

      test('should return (false, 0) when no members have read the message in group', () {
        // Arrange: Set up group where no one has read the message
        final messageTimestamp = 1000;
        final readBeforeMessage = 500; // All members read before this message
        final joinedBeforeMessage = DateTime.fromMillisecondsSinceEpoch(100);

        final params = IsReadMessageParams(
          messageSequence: messageTimestamp,
          memberLastReadAtMap: {
            'user1': readBeforeMessage,
            'user2': readBeforeMessage,
            'user3': readBeforeMessage,
          },
          memberJoinedMap: {
            'user1': joinedBeforeMessage,
            'user2': joinedBeforeMessage,
            'user3': joinedBeforeMessage,
          },
          isGroup: true,
        );

        // Act: Call the use case
        final result = useCase(params);

        // Assert: No one has read the message
        expect(result.$1, false);
        expect(result.$2.length, 0);
      });

      test('should handle members not present in memberJoinedMap', () {
        // Arrange: Set up scenario where member exists in lastReadAt but not in joinedMap
        final messageTimestamp = 1000;
        final readAfterMessage = 1500;
        final joinedBeforeMessage = DateTime.fromMillisecondsSinceEpoch(500);

        final params = IsReadMessageParams(
          messageSequence: messageTimestamp,
          memberLastReadAtMap: {
            'user1': readAfterMessage,
            'user2': readAfterMessage, // This user is not in joinedMap
          },
          memberJoinedMap: {
            'user1': joinedBeforeMessage,
            // user2 is missing from joinedMap
          },
          isGroup: true,
        );

        // Act: Call the use case
        final result = useCase(params);

        // Assert: Both users should be counted since user2 not being in joinedMap
        // means joinedAt is null, so they're treated as legacy users (like null join date)
        expect(result.$1, true);
        expect(result.$2.length, 2);
      });
    });

    group('Direct Chat Scenarios', () {
      test('should return (true, 1) when other user has read the message', () {
        // Arrange: Set up direct chat where other user read after message
        final messageTimestamp = 1000;
        final otherReadAfterMessage = 1500;

        final params = IsReadMessageParams(
          messageSequence: messageTimestamp,
          memberLastReadAtMap: {'other_user': otherReadAfterMessage},
          memberJoinedMap: {},
          otherLastReadAt: otherReadAfterMessage,
          isGroup: false,
        );

        // Act: Call the use case
        final result = useCase(params);

        // Assert: Other user has read the message
        expect(result.$1, true);
        expect(result.$2.length, 1);
      });

      test('should return (true, 1) when otherLastReadAt equals message timestamp', () {
        // Arrange: Set up direct chat where read timestamp equals message timestamp
        final messageTimestamp = 1000;
        final exactSameTime = 1000;

        final params = IsReadMessageParams(
          messageSequence: messageTimestamp,
          memberLastReadAtMap: {'other_user': exactSameTime},
          memberJoinedMap: {},
          otherLastReadAt: exactSameTime,
          isGroup: false,
        );

        // Act: Call the use case
        final result = useCase(params);

        // Assert: Should be considered as read (>= condition)
        expect(result.$1, true);
        expect(result.$2.length, 1);
      });

      test('should return (false, 0) when other user has not read the message', () {
        // Arrange: Set up direct chat where other user read before message
        final messageTimestamp = 1000;
        final otherReadBeforeMessage = 500;

        final params = IsReadMessageParams(
          messageSequence: messageTimestamp,
          memberLastReadAtMap: {'other_user': otherReadBeforeMessage},
          memberJoinedMap: {},
          otherLastReadAt: otherReadBeforeMessage,
          isGroup: false,
        );

        // Act: Call the use case
        final result = useCase(params);

        // Assert: Other user has not read the message
        expect(result.$1, false);
        expect(result.$2.length, 0);
      });

      test('should return (false, 0) when otherLastReadAt is null', () {
        // Arrange: Set up direct chat with null otherLastReadAt
        final messageTimestamp = 1000;

        final params = IsReadMessageParams(
          messageSequence: messageTimestamp,
          memberLastReadAtMap: {'other_user': 1500},
          memberJoinedMap: {},
          otherLastReadAt: null, // Null means never read
          isGroup: false,
        );

        // Act: Call the use case
        final result = useCase(params);

        // Assert: Should return false when otherLastReadAt is null
        expect(result.$1, false);
        expect(result.$2.length, 0);
      });

      test('should return (false, 0) when otherLastReadAt is 0', () {
        // Arrange: Set up direct chat with otherLastReadAt = 0 (never read)
        final messageTimestamp = 1000;

        final params = IsReadMessageParams(
          messageSequence: messageTimestamp,
          memberLastReadAtMap: {'other_user': 1500},
          memberJoinedMap: {},
          otherLastReadAt: 0, // 0 means never read any message
          isGroup: false,
        );

        // Act: Call the use case
        final result = useCase(params);

        // Assert: Should return false when otherLastReadAt is 0
        expect(result.$1, false);
        expect(result.$2.length, 0);
      });
    });

    group('Boundary Conditions', () {
      test('should handle very large timestamp values', () {
        // Arrange: Test with large timestamp values (year 2050+)
        final messageTimestamp = 2524608000000; // Jan 1, 2050
        final readAfterMessage = 2524608001000; // 1 second later
        final joinedBeforeMessage = DateTime.fromMillisecondsSinceEpoch(2524607999000);

        final params = IsReadMessageParams(
          messageSequence: messageTimestamp,
          memberLastReadAtMap: {'user1': readAfterMessage},
          memberJoinedMap: {'user1': joinedBeforeMessage},
          isGroup: true,
        );

        // Act: Call the use case
        final result = useCase(params);

        // Assert: Should handle large timestamps correctly
        expect(result.$1, true);
        expect(result.$2.length, 1);
      });

      test('should handle very small timestamp differences (1ms)', () {
        // Arrange: Test with 1 millisecond difference
        final messageTimestamp = 1000;
        final readOneMillisecondLater = 1001;
        final joinedBeforeMessage = DateTime.fromMillisecondsSinceEpoch(999);

        final params = IsReadMessageParams(
          messageSequence: messageTimestamp,
          memberLastReadAtMap: {'user1': readOneMillisecondLater},
          memberJoinedMap: {'user1': joinedBeforeMessage},
          isGroup: true,
        );

        // Act: Call the use case
        final result = useCase(params);

        // Assert: Should detect 1ms difference correctly
        expect(result.$1, true);
        expect(result.$2.length, 1);
      });

      test('should exclude member who joined exactly at message time', () {
        // Arrange: Member joined exactly when message was sent
        // Business Logic: Members who joined exactly at message time should be excluded
        // because they likely couldn't have read the message since they just joined
        final messageTimestamp = 1000;
        final readAfterMessage = 1500;
        final joinedAtExactMessageTime = DateTime.fromMillisecondsSinceEpoch(1000); // Same as message time

        final params = IsReadMessageParams(
          messageSequence: messageTimestamp,
          memberLastReadAtMap: {'user1': readAfterMessage},
          memberJoinedMap: {'user1': joinedAtExactMessageTime},
          isGroup: true,
        );

        // Act: Call the use case
        final result = useCase(params);

        // Assert: Should exclude member who joined exactly at message time
        // Logic: !messageSequenceDate.isAfter(joinedAt) evaluates to true when times are equal,
        // so the member is excluded from read count
        expect(result.$1, false);
        expect(result.$2.length, 0);
      });

      test('should include member who joined 1ms before message time', () {
        // Arrange: Member joined 1 millisecond before message was sent
        // Business Logic: Members who joined even slightly before message should be counted
        final messageTimestamp = 1000;
        final readAfterMessage = 1500;
        final joinedOneMillisecondBefore = DateTime.fromMillisecondsSinceEpoch(999); // 1ms before message

        final params = IsReadMessageParams(
          messageSequence: messageTimestamp,
          memberLastReadAtMap: {'user1': readAfterMessage},
          memberJoinedMap: {'user1': joinedOneMillisecondBefore},
          isGroup: true,
        );

        // Act: Call the use case
        final result = useCase(params);

        // Assert: Should include member who joined before message time
        // Logic: messageSequenceDate.isAfter(joinedAt) is true, so member is included
        expect(result.$1, true);
        expect(result.$2.length, 1);
      });
    });

    group('Complex Scenarios', () {
      test('should handle large group with mixed conditions', () {
        // Arrange: Complex group with various member statuses
        final messageTimestamp = 1000;
        final joinedEarly = DateTime.fromMillisecondsSinceEpoch(500);
        final joinedLate = DateTime.fromMillisecondsSinceEpoch(1500);
        final readBefore = 800;
        final readAfter = 1200;

        final params = IsReadMessageParams(
          messageSequence: messageTimestamp,
          memberLastReadAtMap: {
            'user1': readAfter, // Joined early, read message ✓
            'user2': readBefore, // Joined early, didn't read message ✗
            'user3': 0, // Joined early, never read any message ✗
            'user4': readAfter, // Joined late, read message but excluded ✗
            'user5': readAfter, // Joined early, read message ✓
          },
          memberJoinedMap: {
            'user1': joinedEarly, // Should be counted
            'user2': joinedEarly, // Joined early but didn't read
            'user3': joinedEarly, // Joined early but never read
            'user4': joinedLate, // Joined after message, excluded
            'user5': joinedEarly, // Should be counted
            // user6 exists in lastReadAtMap but not here
          },
          isGroup: true,
        );

        // Act: Call the use case
        final result = useCase(params);

        // Assert: Only user1 and user5 should be counted
        expect(result.$1, true);
        expect(result.$2.length, 2);
      });

      test('should handle empty group scenario', () {
        // Arrange: Group with no members
        final params = IsReadMessageParams(
          messageSequence: 1000,
          memberLastReadAtMap: {},
          memberJoinedMap: {},
          isGroup: true,
        );

        // Act: Call the use case
        final result = useCase(params);

        // Assert: Empty group should return false, 0
        expect(result.$1, false);
        expect(result.$2.length, 0);
      });

      test('should default to non-group chat when isGroup is not specified', () {
        // Arrange: Test default behavior (isGroup defaults to false)
        final params = IsReadMessageParams(
          messageSequence: 1000,
          memberLastReadAtMap: {'other_user': 1500},
          memberJoinedMap: {},
          otherLastReadAt: 1500,
          // isGroup not specified, should default to false
        );

        // Act: Call the use case
        final result = useCase(params);

        // Assert: Should be treated as direct chat
        expect(result.$1, true);
        expect(result.$2.length, 1);
      });
    });
  });
}
