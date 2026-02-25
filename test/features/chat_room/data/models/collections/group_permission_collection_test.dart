import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/chat_room/data/models/collections/group_permission_collection.dart';
import 'package:uchat/utils/fast_hash.dart';

void main() {
  group('GroupPermissionCollection', () {
    test('Given all permission fields provided, When constructor is called, Then creates PermissionCollection with all values set correctly', () {
      // Given
      final roomId = 'room123';
      final enable = true;
      final applyToAdmin = false;
      final canSendMessages = true;
      final canSendMedia = false;
      final canMentionAll = true;
      final canEditOwnMessage = false;
      final canUnsendOwnMessage = true;
      final canReactions = false;
      final canAddDeleteAlbum = true;
      final createdAt = DateTime.now();
      final updatedAt = DateTime.now().add(const Duration(hours: 1));

      // When
      final permission = GroupPermissionCollection(
        roomId: roomId,
        enable: enable,
        applyToAdmin: applyToAdmin,
        canSendMessages: canSendMessages,
        canSendMedia: canSendMedia,
        canMentionAll: canMentionAll,
        canEditOwnMessage: canEditOwnMessage,
        canUnsendOwnMessage: canUnsendOwnMessage,
        canReactions: canReactions,
        canAddDeleteAlbum: canAddDeleteAlbum,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

      // Then
      expect(permission.roomId, equals(roomId));
      expect(permission.enable, equals(enable));
      expect(permission.applyToAdmin, equals(applyToAdmin));
      expect(permission.canSendMessages, equals(canSendMessages));
      expect(permission.canSendMedia, equals(canSendMedia));
      expect(permission.canMentionAll, equals(canMentionAll));
      expect(permission.canEditOwnMessage, equals(canEditOwnMessage));
      expect(permission.canUnsendOwnMessage, equals(canUnsendOwnMessage));
      expect(permission.canReactions, equals(canReactions));
      expect(permission.canAddDeleteAlbum, equals(canAddDeleteAlbum));
      expect(permission.createdAt, equals(createdAt));
      expect(permission.updatedAt, equals(updatedAt));
    });

    test('Given roomId, When isarId is called, Then returns fastHash of roomId', () {
      // Given
      final roomId = 'room123';

      // When
      final permission = GroupPermissionCollection(roomId: roomId);

      // Then
      expect(permission.isarId, equals(fastHash(roomId)));
    });

    test('Given null roomId, When isarId is called, Then throws TypeError', () {
      // Given
      final permission = GroupPermissionCollection();

      // When
      final call = () => permission.isarId;

      // Then
      expect(call, throwsA(isA<TypeError>()));
    });

    test('Given two instances with same roomId, When == compared, Then returns true', () {
      // Given
      final roomId = 'room123';

      // When
      final instance1 = GroupPermissionCollection(roomId: roomId);
      final instance2 = GroupPermissionCollection(roomId: roomId);

      // Then
      expect(instance1 == instance2, equals(true));
    });

    test('Given two instances with different roomId, When == compared, Then returns false', () {
      // Given
      final roomId1 = 'room123';
      final roomId2 = 'room456';

      // When
      final instance1 = GroupPermissionCollection(roomId: roomId1);
      final instance2 = GroupPermissionCollection(roomId: roomId2);

      // Then
      expect(instance1 == instance2, equals(false));
    });

    test('Given one instance with roomId null and another with roomId set, When == compared, Then returns false', () {
      // Given
      final roomId = 'room123';

      // When
      final instance1 = GroupPermissionCollection(roomId: roomId);
      final instance2 = GroupPermissionCollection();

      // Then
      expect(instance1 == instance2, equals(false));
    });

    test('Given two instances both with roomId null, When == compared, Then returns true', () {
      // When
      final instance1 = GroupPermissionCollection();
      final instance2 = GroupPermissionCollection();

      // Then
      expect(instance1 == instance2, equals(true));
    });

    test('Given instance and non-GroupPermissionCollection object, When == compared, Then returns false', () {
      // Given
      final instance = GroupPermissionCollection(roomId: 'room123');

      // When
      final isEqual = instance == 'non-permission-object';

      // Then
      expect(isEqual, equals(false));
    });

    test('Given instances with same roomId, When hashCode called, Then returns equal hashCodes', () {
      // Given
      final roomId = 'room123';

      // When
      final instance1 = GroupPermissionCollection(roomId: roomId);
      final instance2 = GroupPermissionCollection(roomId: roomId);

      // Then
      expect(instance1.hashCode, equals(instance2.hashCode));
    });

    test('Given instances with different roomId, When hashCode called, Then returns different hashCodes', () {
      // Given
      final roomId1 = 'room123';
      final roomId2 = 'room456';

      // When
      final instance1 = GroupPermissionCollection(roomId: roomId1);
      final instance2 = GroupPermissionCollection(roomId: roomId2);

      // Then
      expect(instance1.hashCode, isNot(equals(instance2.hashCode)));
    });


    test('Given instance with mix of set and null fields, When toString called, Then formats string correctly including nulls', () {
      // Given
      final roomId = 'room123';
      final enable = true;

      // When
      final permission = GroupPermissionCollection(
        roomId: roomId,
        enable: enable,
        // other fields null by default
      );
      final result = permission.toString();

      // Then
      expect(result, startsWith('GroupPermissionCollection('));
      expect(result, contains('roomId: $roomId'));
      expect(result, contains('enable: $enable'));
      expect(result, contains('applyToAdmin: null'));
      expect(result, contains('canSendMessages: null'));
      expect(result, contains('canSendMedia: null'));
      expect(result, contains('canMentionAll: null'));
      expect(result, contains('canEditOwnMessage: null'));
      expect(result, contains('canUnsendOwnMessage: null'));
      expect(result, contains('canReactions: null'));
      expect(result, contains('canAddDeleteAlbum: null'));
      expect(result, contains('createdAt: null'));
      expect(result, contains('updatedAt: null'));
      expect(result, endsWith(')'));
    });
  });
}