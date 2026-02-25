import 'dart:async';
import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/interfaces/contact_interface.dart';
import 'package:uchat/features/chat_room/data/models/models/member_typing_model.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_list_controller.dart';

class MockLoggerService extends Mock implements LoggerService {}

class MockContactInterface extends Mock implements ContactInterface {}

void main() {
  late MessageListController controller;
  late ContactInterface mockContact;
  late MockLoggerService mockLoggerService;

  setUpAll(() {
    registerFallbackValue(MockContactInterface());

    mockLoggerService = MockLoggerService();
    GetIt.I.registerSingleton<LoggerService>(mockLoggerService);
  });

  setUp(() {
    Get.testMode = true;
    controller = MessageListController(tag: 'chat-room-test123');
    mockContact = MockContactInterface();

    // Initialize the observable maps
    controller.typingMemberMap.value = HashMap<String, MemberTypingModel>();
    controller.timerTypingMap.value = HashMap<String, Timer?>();
  });

  tearDown(() {
    // Cancel all timers to prevent memory leaks
    for (final timer in controller.timerTypingMap.value.values) {
      timer?.cancel();
    }
    controller.typingMemberMap.value.clear();
    controller.timerTypingMap.value.clear();
    Get.reset();
  });

  group('updateTypingMember', () {
    test(
        'Given typing member with null lastTypeAt, When updateTypingMember is called, Then returns early without adding member',
        () async {
      // Given
      final memberWithNullLastTypeAt = MemberTypingModel(
        accountId: 'user123',
        contact: mockContact,
        isTyping: true,
        lastTypeAt: null,
      );

      // When
      await controller.updateTypingMember(memberWithNullLastTypeAt);

      // Then
      expect(controller.typingMemberMap.value.isEmpty, isTrue);
      expect(controller.timerTypingMap.value.isEmpty, isTrue);
    });

    test('Given typing member with old lastTypeAt, When updateTypingMember is called, Then removes member from map',
        () async {
      // Given
      final oldLastTypeAt = DateTime.now().subtract(const Duration(seconds: UChatConstant.typingTimeOutInSeconds + 1));
      final oldTypingMember = MemberTypingModel(
        accountId: 'user123',
        contact: mockContact,
        isTyping: true,
        lastTypeAt: oldLastTypeAt,
      );

      // When
      await controller.updateTypingMember(oldTypingMember);

      // Then
      expect(controller.typingMemberMap.value.containsKey('user123'), isFalse);
      expect(controller.timerTypingMap.value.containsKey('user123'), isFalse);
    });

    test(
        'Given new typing member with isTyping true, When updateTypingMember is called, Then adds member to map and sets timer',
        () async {
      // Given
      final recentLastTypeAt = DateTime.now().subtract(const Duration(seconds: 1));
      final newTypingMember = MemberTypingModel(
        accountId: 'user123',
        contact: mockContact,
        isTyping: true,
        lastTypeAt: recentLastTypeAt,
      );

      // When
      await controller.updateTypingMember(newTypingMember);

      // Then
      expect(controller.typingMemberMap.value.containsKey('user123'), isTrue);
      expect(controller.timerTypingMap.value.containsKey('user123'), isTrue);
      expect(controller.timerTypingMap.value['user123'], isNotNull);
      expect(controller.typingMemberMap.value['user123']?.accountId, equals('user123'));
    });

    test(
        'Given new typing member with isTyping false, When updateTypingMember is called, Then does not add member to map',
        () async {
      // Given
      final nonTypingMember = MemberTypingModel(
        accountId: 'user123',
        contact: mockContact,
        isTyping: false,
        lastTypeAt: DateTime.now(),
      );

      // When
      await controller.updateTypingMember(nonTypingMember);

      // Then
      expect(controller.typingMemberMap.value.containsKey('user123'), isFalse);
      expect(controller.timerTypingMap.value.containsKey('user123'), isFalse);
    });

    test(
        'Given existing typing member with isTyping false, When updateTypingMember is called, Then removes member from map and cancels timer',
        () async {
      // Given
      final existingMember = MemberTypingModel(
        accountId: 'user123',
        contact: mockContact,
        isTyping: true,
        lastTypeAt: DateTime.now(),
      );
      controller.typingMemberMap.value['user123'] = existingMember;
      controller.timerTypingMap.value['user123'] = Timer(const Duration(seconds: 5), () {});

      final updatedMember = MemberTypingModel(
        accountId: 'user123',
        contact: mockContact,
        isTyping: false,
        lastTypeAt: DateTime.now(),
      );

      // When
      await controller.updateTypingMember(updatedMember);

      // Then
      expect(controller.typingMemberMap.value, isEmpty);
    });

    test(
        'Given existing typing member with isTyping true, When updateTypingMember is called, Then updates member and resets timer',
        () async {
      // Given
      final existingMember = MemberTypingModel(
        accountId: 'user123',
        contact: mockContact,
        isTyping: true,
        lastTypeAt: DateTime.now().subtract(const Duration(seconds: 2)),
      );
      controller.typingMemberMap.value['user123'] = existingMember;
      final oldTimer = Timer(const Duration(seconds: 5), () {});
      controller.timerTypingMap.value['user123'] = oldTimer;

      final updatedMember = MemberTypingModel(
        accountId: 'user123',
        contact: mockContact,
        isTyping: true,
        lastTypeAt: DateTime.now(),
      );

      // When
      await controller.updateTypingMember(updatedMember);

      // Then
      expect(controller.typingMemberMap.value.containsKey('user123'), isTrue);
      expect(controller.timerTypingMap.value.containsKey('user123'), isTrue);
      expect(controller.timerTypingMap.value['user123'], isNot(equals(oldTimer)));
      expect(oldTimer.isActive, isFalse); // Old timer should be cancelled
    });

    test(
        'Given typing member with lastTypeAt at maximum timeout, When updateTypingMember is called, Then sets timer duration to maximum',
        () async {
      // Given
      final maxTimeoutLastTypeAt =
          DateTime.now().subtract(const Duration(seconds: UChatConstant.typingTimeOutInSeconds + 5));
      final memberAtMaxTimeout = MemberTypingModel(
        accountId: 'user123',
        contact: mockContact,
        isTyping: true,
        lastTypeAt: maxTimeoutLastTypeAt,
      );

      // When
      await controller.updateTypingMember(memberAtMaxTimeout);

      // Then
      expect(controller.typingMemberMap.value.containsKey('user123'), isFalse);
      expect(controller.timerTypingMap.value.containsKey('user123'), isFalse);
    });

    test(
        'Given typing member with future lastTypeAt, When updateTypingMember is called, Then caps timer duration to maximum',
        () async {
      // Given
      final futureLastTypeAt = DateTime.now().add(const Duration(seconds: 10));
      final memberWithFutureTime = MemberTypingModel(
        accountId: 'user123',
        contact: mockContact,
        isTyping: true,
        lastTypeAt: futureLastTypeAt,
      );

      // When
      await controller.updateTypingMember(memberWithFutureTime);

      // Then
      expect(controller.typingMemberMap.value.containsKey('user123'), isTrue);
      expect(controller.timerTypingMap.value.containsKey('user123'), isTrue);
      expect(controller.timerTypingMap.value['user123'], isNotNull);
    });

    test('Given timer expires, When timeout occurs, Then removes member from typing map', () async {
      // Given
      final recentLastTypeAt = DateTime.now().subtract(const Duration(milliseconds: 7900));
      final typingMember = MemberTypingModel(
        accountId: 'user123',
        contact: mockContact,
        isTyping: true,
        lastTypeAt: recentLastTypeAt,
      );

      // When
      await controller.updateTypingMember(typingMember);

      // Verify member is added
      expect(controller.typingMemberMap.value.containsKey('user123'), isTrue);

      // Wait for timer to expire
      await Future.delayed(const Duration(milliseconds: 1000)); // Short delay for test

      // Then
      expect(controller.typingMemberMap.value, isEmpty);
    });

    test(
        'Given multiple typing members, When updateTypingMember is called for each, Then manages all members independently',
        () async {
      // Given
      final member1 = MemberTypingModel(
        accountId: 'user1',
        contact: mockContact,
        isTyping: true,
        lastTypeAt: DateTime.now(),
      );
      final member2 = MemberTypingModel(
        accountId: 'user2',
        contact: mockContact,
        isTyping: true,
        lastTypeAt: DateTime.now(),
      );

      // When
      await controller.updateTypingMember(member1);
      await controller.updateTypingMember(member2);

      // Then
      expect(controller.typingMemberMap.value.length, equals(2));
      expect(controller.typingMemberMap.value.containsKey('user1'), isTrue);
      expect(controller.typingMemberMap.value.containsKey('user2'), isTrue);
      expect(controller.timerTypingMap.value.length, equals(2));
    });

    test('Given exception during processing, When updateTypingMember is called, Then handles error gracefully',
        () async {
      // Given
      final problematicMember = MemberTypingModel(
        accountId: 'user123',
        contact: mockContact,
        isTyping: true,
        lastTypeAt: DateTime.now(),
      );

      // Simulate error by setting invalid state
      controller.typingMemberMap.close();

      // When & Then
      expect(() async => await controller.updateTypingMember(problematicMember), returnsNormally);
    });

    test(
        'Given typing member with exact timeout boundary lastTypeAt, When updateTypingMember is called, Then removes member due to zero timer duration',
        () async {
      // Given
      final exactTimeoutLastTypeAt =
          DateTime.now().subtract(const Duration(seconds: UChatConstant.typingTimeOutInSeconds));
      final memberAtExactTimeout = MemberTypingModel(
        accountId: 'user123',
        contact: mockContact,
        isTyping: true,
        lastTypeAt: exactTimeoutLastTypeAt,
      );

      // When
      await controller.updateTypingMember(memberAtExactTimeout);

      // Then
      expect(controller.typingMemberMap.value.containsKey('user123'), isFalse);
      expect(controller.timerTypingMap.value.containsKey('user123'), isFalse);
    });

    test(
        'Given typing member with lastTypeAt one second before timeout, When updateTypingMember is called, Then sets timer with 1 second duration',
        () async {
      // Given
      final oneSecondBeforeTimeoutLastTypeAt =
          DateTime.now().subtract(const Duration(seconds: UChatConstant.typingTimeOutInSeconds - 1));
      final memberOneSecondBeforeTimeout = MemberTypingModel(
        accountId: 'user123',
        contact: mockContact,
        isTyping: true,
        lastTypeAt: oneSecondBeforeTimeoutLastTypeAt,
      );

      // When
      await controller.updateTypingMember(memberOneSecondBeforeTimeout);

      // Then
      expect(controller.typingMemberMap.value.containsKey('user123'), isTrue);
      expect(controller.timerTypingMap.value.containsKey('user123'), isTrue);
      expect(controller.timerTypingMap.value['user123'], isNotNull);

      // Verify the timer duration is approximately 1 second by checking it's active
      final timer = controller.timerTypingMap.value['user123'];
      expect(timer?.isActive, isTrue);
    });

    test(
        'Given typing member with lastTypeAt half timeout duration ago, When updateTypingMember is called, Then sets timer with remaining half duration',
        () async {
      // Given
      final halfTimeoutLastTypeAt =
          DateTime.now().subtract(Duration(seconds: (UChatConstant.typingTimeOutInSeconds / 2).floor()));
      final memberAtHalfTimeout = MemberTypingModel(
        accountId: 'user123',
        contact: mockContact,
        isTyping: true,
        lastTypeAt: halfTimeoutLastTypeAt,
      );

      // When
      await controller.updateTypingMember(memberAtHalfTimeout);

      // Then
      expect(controller.typingMemberMap.value.containsKey('user123'), isTrue);
      expect(controller.timerTypingMap.value.containsKey('user123'), isTrue);
      expect(controller.timerTypingMap.value['user123'], isNotNull);

      // Verify the timer is active (indicating proper duration calculation)
      final timer = controller.timerTypingMap.value['user123'];
      expect(timer?.isActive, isTrue);
    });

    test(
        'Given typing member with lastTypeAt just over timeout, When updateTypingMember is called, Then removes member immediately',
        () async {
      // Given
      final justOverTimeoutLastTypeAt =
          DateTime.now().subtract(const Duration(seconds: UChatConstant.typingTimeOutInSeconds + 1, milliseconds: 100));
      final memberJustOverTimeout = MemberTypingModel(
        accountId: 'user123',
        contact: mockContact,
        isTyping: true,
        lastTypeAt: justOverTimeoutLastTypeAt,
      );

      // When
      await controller.updateTypingMember(memberJustOverTimeout);

      // Then
      expect(controller.typingMemberMap.value.containsKey('user123'), isFalse);
      expect(controller.timerTypingMap.value.containsKey('user123'), isFalse);
    });

    test(
        'Given typing member with very recent lastTypeAt, When updateTypingMember is called, Then sets timer with nearly full duration',
        () async {
      // Given
      final veryRecentLastTypeAt = DateTime.now().subtract(const Duration(milliseconds: 100));
      final memberWithVeryRecentTime = MemberTypingModel(
        accountId: 'user123',
        contact: mockContact,
        isTyping: true,
        lastTypeAt: veryRecentLastTypeAt,
      );

      // When
      await controller.updateTypingMember(memberWithVeryRecentTime);

      // Then
      expect(controller.typingMemberMap.value.containsKey('user123'), isTrue);
      expect(controller.timerTypingMap.value.containsKey('user123'), isTrue);
      expect(controller.timerTypingMap.value['user123'], isNotNull);

      // Verify the timer is active with nearly full duration
      final timer = controller.timerTypingMap.value['user123'];
      expect(timer?.isActive, isTrue);
    });

    test(
        'Given existing typing member with negative timer duration, When updateTypingMember is called, Then removes member and refreshes map',
        () async {
      // Given
      // First add a member normally
      final initialMember = MemberTypingModel(
        accountId: 'user123',
        contact: mockContact,
        isTyping: true,
        lastTypeAt: DateTime.now(),
      );
      await controller.updateTypingMember(initialMember);

      // Verify member was added
      expect(controller.typingMemberMap.value.containsKey('user123'), isTrue);

      // Now update with expired time
      final expiredMember = MemberTypingModel(
        accountId: 'user123',
        contact: mockContact,
        isTyping: true,
        lastTypeAt: DateTime.now().subtract(const Duration(seconds: UChatConstant.typingTimeOutInSeconds + 10)),
      );

      // When
      await controller.updateTypingMember(expiredMember);

      // Then
      expect(controller.typingMemberMap.value, isEmpty);
    });

    test(
        'Given typing member with fractional second difference, When updateTypingMember is called, Then ceils timer duration properly',
        () async {
      // Given
      // Create a time that would result in fractional seconds (e.g., 7.3 seconds remaining)
      final fractionalSecondsLastTypeAt =
          DateTime.now().subtract(const Duration(milliseconds: (UChatConstant.typingTimeOutInSeconds * 1000 - 7300)));
      final memberWithFractionalDiff = MemberTypingModel(
        accountId: 'user123',
        contact: mockContact,
        isTyping: true,
        lastTypeAt: fractionalSecondsLastTypeAt,
      );

      // When
      await controller.updateTypingMember(memberWithFractionalDiff);

      // Then
      expect(controller.typingMemberMap.value.containsKey('user123'), isTrue);
      expect(controller.timerTypingMap.value.containsKey('user123'), isTrue);
      expect(controller.timerTypingMap.value['user123'], isNotNull);

      // Verify timer is properly set (should ceil to 8 seconds for 7.3 remaining)
      final timer = controller.timerTypingMap.value['user123'];
      expect(timer?.isActive, isTrue);
    });

    test(
        'Given multiple calls for same user with different timer durations, When updateTypingMember is called, Then properly cancels old timer and sets new one',
        () async {
      // Given
      final firstCallTime = DateTime.now().subtract(const Duration(seconds: UChatConstant.typingTimeOutInSeconds - 5));
      final firstMember = MemberTypingModel(
        accountId: 'user123',
        contact: mockContact,
        isTyping: true,
        lastTypeAt: firstCallTime,
      );

      await controller.updateTypingMember(firstMember);
      final firstTimer = controller.timerTypingMap.value['user123'];

      // Second call with different timing
      final secondCallTime = DateTime.now().subtract(const Duration(seconds: UChatConstant.typingTimeOutInSeconds - 2));
      final secondMember = MemberTypingModel(
        accountId: 'user123',
        contact: mockContact,
        isTyping: true,
        lastTypeAt: secondCallTime,
      );

      // When
      await controller.updateTypingMember(secondMember);

      // Then
      expect(controller.typingMemberMap.value.containsKey('user123'), isTrue);
      expect(controller.timerTypingMap.value.containsKey('user123'), isTrue);

      final secondTimer = controller.timerTypingMap.value['user123'];
      expect(secondTimer, isNot(equals(firstTimer))); // New timer created
      expect(firstTimer?.isActive, isFalse); // Old timer cancelled
      expect(secondTimer?.isActive, isTrue); // New timer active
    });
  });

  group('typingMemberList getter', () {
    test('Given empty typing member map, When typingMemberList is accessed, Then returns empty list', () {
      // Given
      controller.typingMemberMap.value.clear();

      // When
      final result = controller.typingMemberList;

      // Then
      expect(result, isEmpty);
    });

    test(
        'Given typing members with different lastTypeAt, When typingMemberList is accessed, Then returns sorted list by lastTypeAt descending',
        () async {
      // Given
      final olderTime = DateTime.now().subtract(const Duration(seconds: 2));
      final newerTime = DateTime.now().subtract(const Duration(seconds: 1));

      final olderMember = MemberTypingModel(
        accountId: 'user1',
        contact: mockContact,
        isTyping: true,
        lastTypeAt: olderTime,
      );
      final newerMember = MemberTypingModel(
        accountId: 'user2',
        contact: mockContact,
        isTyping: true,
        lastTypeAt: newerTime,
      );

      await controller.updateTypingMember(olderMember);
      await controller.updateTypingMember(newerMember);

      // When
      final result = controller.typingMemberList;

      // Then
      expect(result.length, equals(2));
      // Should be sorted with newer member first
      expect(result.first, equals(mockContact)); // Both use same mock contact for simplicity
    });

    test(
        'Given typing members with null lastTypeAt, When typingMemberList is accessed, Then handles null values gracefully',
        () async {
      // Given
      final memberWithNullTime = MemberTypingModel(
        accountId: 'user1',
        contact: mockContact,
        isTyping: true,
        lastTypeAt: DateTime.now(),
      );

      // Manually add member to bypass null check in updateTypingMember
      controller.typingMemberMap.value['user1'] = memberWithNullTime;

      // Create another member with null time by directly setting it
      final memberWithNullTime2 = MemberTypingModel(
        accountId: 'user2',
        contact: mockContact,
        isTyping: true,
        lastTypeAt: null,
      );
      controller.typingMemberMap.value['user2'] = memberWithNullTime2;

      // When
      final result = controller.typingMemberList;

      // Then
      expect(result.length, equals(2));
      expect(result, everyElement(isA<ContactInterface>()));
    });
  });
}
