import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_list_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/utils/calculate_member_last_read_at.dart';

// Mock classes
class MockLoggerService extends Mock implements LoggerService {}
class MockMessageListController extends Mock implements MessageListController {}
class MockRoomMemberCollection extends Mock implements RoomMemberCollection {}
class MockRxMap<K, V> extends Mock implements RxMap<K, V> {}
class MockRxInt extends Mock implements RxInt {}
class MockRxList<T> extends Mock implements RxList<T> {}

// Fake classes for complex types
class FakeRoomMemberCollection extends Fake implements RoomMemberCollection {}

void main() {
  late MockLoggerService mockLogger;
  late RxList<RoomMemberCollection> members;
  late RxInt myLastReadAt;
  late RxMap<String, int> memberLastReadAtMap;
  late RxInt roomLastReadAt;

  setUp(() {
    mockLogger = MockLoggerService();
    members = <RoomMemberCollection>[].obs;
    myLastReadAt = 0.obs;
    memberLastReadAtMap = <String, int>{}.obs;
    roomLastReadAt = 0.obs;
  });

  MockRoomMemberCollection createMockMember({
    required String accountId,
    required bool isMe,
    DateTime? lastSeenMessageAt,
  }) {
    final mockMember = MockRoomMemberCollection();
    when(() => mockMember.accountId).thenReturn(accountId);
    when(() => mockMember.isMe).thenReturn(isMe);
    when(() => mockMember.lastSeenMessageAt).thenReturn(lastSeenMessageAt);
    return mockMember;
  }

  group('calculateMemberLastReadAt', () {
    test('Given empty members list, When function is called, Then initializes with default values', () {
      // Given
      // Empty members list (already initialized)

      // When
      calculateMemberLastReadAtHelper(
        members: members,
        myLastReadAt: myLastReadAt,
        memberLastReadAtMap: memberLastReadAtMap,
        roomLastReadAt: roomLastReadAt,
        log: mockLogger,
      );

      // Then
      expect(memberLastReadAtMap, isEmpty);
      expect(roomLastReadAt.value, equals(0));
      expect(myLastReadAt.value, equals(0));
    });

    test('Given members with null lastSeenMessageAt, When function is called, Then skips those members', () {
      // Given
      final member1 = createMockMember(
        accountId: 'user1',
        isMe: false,
        lastSeenMessageAt: null,
      );
      final member2 = createMockMember(
        accountId: 'user2',
        isMe: false,
        lastSeenMessageAt: null,
      );
      members.addAll([member1, member2]);

      // When
      calculateMemberLastReadAtHelper(
        members: members,
        myLastReadAt: myLastReadAt,
        memberLastReadAtMap: memberLastReadAtMap,
        roomLastReadAt: roomLastReadAt,
        log: mockLogger,
      );

      // Then
      expect(memberLastReadAtMap, isEmpty);
      expect(roomLastReadAt.value, equals(0));
      expect(myLastReadAt.value, equals(0));
    });

    test('Given current user member with lastSeenMessageAt, When function is called, Then sets myLastReadAt and skips from map', () {
      // Given
      final currentUserTimestamp = DateTime(2023, 1, 1, 12, 0, 0);
      final currentUserMember = createMockMember(
        accountId: 'current-user',
        isMe: true,
        lastSeenMessageAt: currentUserTimestamp,
      );
      
      members.add(currentUserMember);

      // When
      calculateMemberLastReadAtHelper(
        members: members,
        myLastReadAt: myLastReadAt,
        memberLastReadAtMap: memberLastReadAtMap,
        roomLastReadAt: roomLastReadAt,
        log: mockLogger,
      );

      // Then
      expect(myLastReadAt.value, equals(currentUserTimestamp.millisecondsSinceEpoch));
      expect(memberLastReadAtMap, isEmpty);
      expect(roomLastReadAt.value, equals(0));
    });

    test('Given other members with lastSeenMessageAt, When function is called, Then adds to map and updates roomLastReadAt', () {
      // Given
      final timestamp1 = DateTime(2023, 1, 1, 10, 0, 0);
      final timestamp2 = DateTime(2023, 1, 1, 12, 0, 0);
      final timestamp3 = DateTime(2023, 1, 1, 8, 0, 0);

      final member1 = createMockMember(
        accountId: 'user1',
        isMe: false,
        lastSeenMessageAt: timestamp1,
      );
      final member2 = createMockMember(
        accountId: 'user2',
        isMe: false,
        lastSeenMessageAt: timestamp2,
      );
      final member3 = createMockMember(
        accountId: 'user3',
        isMe: false,
        lastSeenMessageAt: timestamp3,
      );

      members.addAll([member1, member2, member3]);

      // When
      calculateMemberLastReadAtHelper(
        members: members,
        myLastReadAt: myLastReadAt,
        memberLastReadAtMap: memberLastReadAtMap,
        roomLastReadAt: roomLastReadAt,
        log: mockLogger,
      );

      // Then
      expect(memberLastReadAtMap.length, equals(3));
      expect(memberLastReadAtMap['user1'], equals(timestamp1.millisecondsSinceEpoch));
      expect(memberLastReadAtMap['user2'], equals(timestamp2.millisecondsSinceEpoch));
      expect(memberLastReadAtMap['user3'], equals(timestamp3.millisecondsSinceEpoch));
      expect(roomLastReadAt.value, equals(timestamp2.millisecondsSinceEpoch)); // Latest timestamp
    });

    test('Given mixed members (current user and others), When function is called, Then processes correctly', () {
      // Given
      final currentUserTimestamp = DateTime(2023, 1, 1, 14, 0, 0);
      final otherUserTimestamp1 = DateTime(2023, 1, 1, 10, 0, 0);
      final otherUserTimestamp2 = DateTime(2023, 1, 1, 12, 0, 0);

      final currentUserMember = createMockMember(
        accountId: 'current-user',
        isMe: true,
        lastSeenMessageAt: currentUserTimestamp,
      );
      final otherMember1 = createMockMember(
        accountId: 'user1',
        isMe: false,
        lastSeenMessageAt: otherUserTimestamp1,
      );
      final otherMember2 = createMockMember(
        accountId: 'user2',
        isMe: false,
        lastSeenMessageAt: otherUserTimestamp2,
      );

      members.addAll([currentUserMember, otherMember1, otherMember2]);

      // When
      calculateMemberLastReadAtHelper(
        members: members,
        myLastReadAt: myLastReadAt,
        memberLastReadAtMap: memberLastReadAtMap,
        roomLastReadAt: roomLastReadAt,
        log: mockLogger,
      );

      // Then
      expect(myLastReadAt.value, equals(currentUserTimestamp.millisecondsSinceEpoch));
      expect(memberLastReadAtMap.length, equals(2));
      expect(memberLastReadAtMap['user1'], equals(otherUserTimestamp1.millisecondsSinceEpoch));
      expect(memberLastReadAtMap['user2'], equals(otherUserTimestamp2.millisecondsSinceEpoch));
      expect(roomLastReadAt.value, equals(otherUserTimestamp2.millisecondsSinceEpoch)); // Latest among others
    });

    test('Given members with null accountId, When function is called, Then logs error and handles gracefully', () {
      // Given
      final timestamp = DateTime(2023, 1, 1, 10, 0, 0);
      final memberWithNullAccountId = MockRoomMemberCollection();
      when(() => memberWithNullAccountId.isMe).thenReturn(false);
      when(() => memberWithNullAccountId.accountId).thenReturn(null);
      when(() => memberWithNullAccountId.lastSeenMessageAt).thenReturn(timestamp);

      members.add(memberWithNullAccountId);

      // When
      calculateMemberLastReadAtHelper(
        members: members,
        myLastReadAt: myLastReadAt,
        memberLastReadAtMap: memberLastReadAtMap,
        roomLastReadAt: roomLastReadAt,
        log: mockLogger,
      );

      // Then
      // When accountId is null, the function throws an exception and logs it
      expect(memberLastReadAtMap, isEmpty);
      expect(roomLastReadAt.value, equals(0)); // Default value due to exception
      expect(myLastReadAt.value, equals(0)); // Default value due to exception
      verify(() => mockLogger.e('Error calculating member last read at', any(), any())).called(1);
      // Messages refresh is not called due to exception
    });

    test('Given map is sorted by timestamp descending, When function is called, Then verifies sorting', () {
      // Given
      final timestamp1 = DateTime(2023, 1, 1, 8, 0, 0);  // Earliest
      final timestamp2 = DateTime(2023, 1, 1, 10, 0, 0); // Middle
      final timestamp3 = DateTime(2023, 1, 1, 12, 0, 0); // Latest

      final member1 = createMockMember(
        accountId: 'user1',
        isMe: false,
        lastSeenMessageAt: timestamp1,
      );
      final member2 = createMockMember(
        accountId: 'user2',
        isMe: false,
        lastSeenMessageAt: timestamp2,
      );
      final member3 = createMockMember(
        accountId: 'user3',
        isMe: false,
        lastSeenMessageAt: timestamp3,
      );

      members.addAll([member1, member2, member3]);

      // When
      calculateMemberLastReadAtHelper(
        members: members,
        myLastReadAt: myLastReadAt,
        memberLastReadAtMap: memberLastReadAtMap,
        roomLastReadAt: roomLastReadAt,
        log: mockLogger,
      );

      // Then
      final sortedValues = memberLastReadAtMap.values.toList();
      
      // Should be sorted by value descending (latest first)
      expect(sortedValues[0], greaterThanOrEqualTo(sortedValues[1]));
      expect(sortedValues[1], greaterThanOrEqualTo(sortedValues[2]));
    });

    test('Given exception occurs during processing, When function is called, Then logs error and continues', () {
      // Given
      final member = MockRoomMemberCollection();
      when(() => member.lastSeenMessageAt).thenReturn(DateTime(2023, 1, 1, 10, 0, 0));
      when(() => member.isMe).thenThrow(Exception('Test exception'));
      when(() => member.accountId).thenReturn('user1');

      members.add(member);

      // When
      calculateMemberLastReadAtHelper(
        members: members,
        myLastReadAt: myLastReadAt,
        memberLastReadAtMap: memberLastReadAtMap,
        roomLastReadAt: roomLastReadAt,
        log: mockLogger,
      );

      // Then
      verify(() => mockLogger.e('Error calculating member last read at', any(), any())).called(1);
    });

    test('Given exception in sortedBy extension, When function is called, Then logs error', () {
      // Given
      final member = createMockMember(
        accountId: 'user1',
        isMe: false,
        lastSeenMessageAt: DateTime(2023, 1, 1, 10, 0, 0),
      );

      // Mock memberLastReadAtMap to throw exception on assignment
      final mockMemberLastReadAtMap = MockRxMap<String, int>();
      when(() => mockMemberLastReadAtMap.value = any()).thenThrow(Exception('Sort exception'));

      members.add(member);

      // When
      calculateMemberLastReadAtHelper(
        members: members,
        myLastReadAt: myLastReadAt,
        memberLastReadAtMap: mockMemberLastReadAtMap,
        roomLastReadAt: roomLastReadAt,
        log: mockLogger,
      );

      // Then
      verify(() => mockLogger.e('Error calculating member last read at', any(), any())).called(1);
    });

    test('Given single member with latest timestamp, When function is called, Then sets correct roomLastReadAt', () {
      // Given
      final timestamp = DateTime(2023, 1, 1, 15, 30, 45);
      final member = createMockMember(
        accountId: 'user1',
        isMe: false,
        lastSeenMessageAt: timestamp,
      );

      members.add(member);

      // When
      calculateMemberLastReadAtHelper(
        members: members,
        myLastReadAt: myLastReadAt,
        memberLastReadAtMap: memberLastReadAtMap,
        roomLastReadAt: roomLastReadAt,
        log: mockLogger,
      );

      // Then
      expect(roomLastReadAt.value, equals(timestamp.millisecondsSinceEpoch));
      expect(memberLastReadAtMap['user1'], equals(timestamp.millisecondsSinceEpoch));
    });

    test('Given members with same timestamp, When function is called, Then handles correctly', () {
      // Given
      final sameTimestamp = DateTime(2023, 1, 1, 10, 0, 0);
      final member1 = createMockMember(
        accountId: 'user1',
        isMe: false,
        lastSeenMessageAt: sameTimestamp,
      );
      final member2 = createMockMember(
        accountId: 'user2',
        isMe: false,
        lastSeenMessageAt: sameTimestamp,
      );

      members.addAll([member1, member2]);

      // When
      calculateMemberLastReadAtHelper(
        members: members,
        myLastReadAt: myLastReadAt,
        memberLastReadAtMap: memberLastReadAtMap,
        roomLastReadAt: roomLastReadAt,
        log: mockLogger,
      );

      // Then
      expect(memberLastReadAtMap.length, equals(2));
      expect(memberLastReadAtMap['user1'], equals(sameTimestamp.millisecondsSinceEpoch));
      expect(memberLastReadAtMap['user2'], equals(sameTimestamp.millisecondsSinceEpoch));
      expect(roomLastReadAt.value, equals(sameTimestamp.millisecondsSinceEpoch));
    });

    test('Given zero timestamp, When function is called, Then handles edge case correctly', () {
      // Given
      final zeroTimestamp = DateTime.fromMillisecondsSinceEpoch(0);
      final member = createMockMember(
        accountId: 'user1',
        isMe: false,
        lastSeenMessageAt: zeroTimestamp,
      );

      members.add(member);

      // When
      calculateMemberLastReadAtHelper(
        members: members,
        myLastReadAt: myLastReadAt,
        memberLastReadAtMap: memberLastReadAtMap,
        roomLastReadAt: roomLastReadAt,
        log: mockLogger,
      );

      // Then
      expect(memberLastReadAtMap['user1'], equals(0));
      expect(roomLastReadAt.value, equals(0));
    });
  });
}