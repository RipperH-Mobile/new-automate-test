import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/features/chat_room/domain/entities/group_permission_entity.dart';
import 'package:uchat/utils/datetime.dart';

void main() {
  group('GroupPermissionEntity', () {
    test(
        'Given default constructor with required roomId, When creating instance, Then returns entity with default values',
        () {
      // Given
      const roomId = 'test_room_id';

      // When
      const entity = GroupPermissionEntity(roomId: roomId);

      // Then
      expect(entity.roomId, equals(roomId));
      expect(entity.enable, isFalse);
      expect(entity.applyToAdmin, isFalse);
      expect(entity.canSendMessages, isTrue);
      expect(entity.canSendMedia, isTrue);
      expect(entity.canMentionAll, isTrue);
      expect(entity.canEditOwnMessage, isTrue);
      expect(entity.canUnsendOwnMessage, isTrue);
      expect(entity.canReactions, isTrue);
      expect(entity.canAddDeleteAlbum, isTrue);
      expect(entity.createdAt, isNull);
      expect(entity.updatedAt, isNull);
    });

    test(
        'Given full constructor with custom values, When creating instance, Then returns entity with custom values',
        () {
      // Given
      const roomId = 'test_room_id';
      const enable = false;
      const applyToAdmin = true;
      const canSendMessages = false;
      const canSendMedia = false;
      const canMentionAll = false;
      const canEditOwnMessage = false;
      const canUnsendOwnMessage = false;
      const canReactions = false;
      const canAddDeleteAlbum = false;
      final createdAt = DateTime.now();
      final updatedAt = DateTime.now();

      // When
      final entity = GroupPermissionEntity(
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
      expect(entity.roomId, equals(roomId));
      expect(entity.enable, equals(enable));
      expect(entity.applyToAdmin, equals(applyToAdmin));
      expect(entity.canSendMessages, equals(canSendMessages));
      expect(entity.canSendMedia, equals(canSendMedia));
      expect(entity.canMentionAll, equals(canMentionAll));
      expect(entity.canEditOwnMessage, equals(canEditOwnMessage));
      expect(entity.canUnsendOwnMessage, equals(canUnsendOwnMessage));
      expect(entity.canReactions, equals(canReactions));
      expect(entity.canAddDeleteAlbum, equals(canAddDeleteAlbum));
      expect(entity.createdAt, equals(createdAt));
      expect(entity.updatedAt, equals(updatedAt));
    });

    test(
        'Given entity with all null updated fields, When copyWith with all values, Then returns updated entity',
        () {
      // Given
      final original = const GroupPermissionEntity(roomId: 'original');
      final newRoomId = 'updated_room_id';
      const newEnable = false;
      const newApplyToAdmin = true;
      const newCanSendMessages = false;
      const newCanSendMedia = false;
      const newCanMentionAll = false;
      const newCanEditOwnMessage = false;
      const newCanUnsendOwnMessage = false;
      const newCanReactions = false;
      const newCanAddDeleteAlbum = false;
      final newCreatedAt = DateTime(2023, 5, 1);
      final newUpdatedAt = DateTime(2023, 5, 2);

      // When
      final updated = original.copyWith(
        roomId: newRoomId,
        enable: newEnable,
        applyToAdmin: newApplyToAdmin,
        canSendMessages: newCanSendMessages,
        canSendMedia: newCanSendMedia,
        canMentionAll: newCanMentionAll,
        canEditOwnMessage: newCanEditOwnMessage,
        canUnsendOwnMessage: newCanUnsendOwnMessage,
        canReactions: newCanReactions,
        canAddDeleteAlbum: newCanAddDeleteAlbum,
        createdAt: newCreatedAt,
        updatedAt: newUpdatedAt,
      );

      // Then
      expect(updated.roomId, equals(newRoomId));
      expect(updated.enable, equals(newEnable));
      expect(updated.applyToAdmin, equals(newApplyToAdmin));
      expect(updated.canSendMessages, equals(newCanSendMessages));
      expect(updated.canSendMedia, equals(newCanSendMedia));
      expect(updated.canMentionAll, equals(newCanMentionAll));
      expect(updated.canEditOwnMessage, equals(newCanEditOwnMessage));
      expect(updated.canUnsendOwnMessage, equals(newCanUnsendOwnMessage));
      expect(updated.canReactions, equals(newCanReactions));
      expect(updated.canAddDeleteAlbum, equals(newCanAddDeleteAlbum));
      expect(updated.createdAt, equals(newCreatedAt));
      expect(updated.updatedAt, equals(newUpdatedAt));
    });

    test(
        'Given entity, When copyWith with no values, Then returns original entity',
        () {
      // Given
      const original = GroupPermissionEntity(roomId: 'original');

      // When
      final updated = original.copyWith();

      // Then
      expect(updated.roomId, equals(original.roomId));
      expect(updated.enable, equals(original.enable));
      expect(updated.applyToAdmin, equals(original.applyToAdmin));
      expect(updated.canSendMessages, equals(original.canSendMessages));
      expect(updated.canSendMedia, equals(original.canSendMedia));
      expect(updated.canMentionAll, equals(original.canMentionAll));
      expect(updated.canEditOwnMessage, equals(original.canEditOwnMessage));
      expect(updated.canUnsendOwnMessage, equals(original.canUnsendOwnMessage));
      expect(updated.canReactions, equals(original.canReactions));
      expect(updated.canAddDeleteAlbum, equals(original.canAddDeleteAlbum));
      expect(updated.createdAt, equals(original.createdAt));
      expect(updated.updatedAt, equals(original.updatedAt));
    });

    test(
        'Given entity, When copyWith with partial values, Then returns entity with partial updates',
        () {
      // Given
      const original = GroupPermissionEntity(roomId: 'original');
      const newRoomId = 'updated';

      // When
      final updated = original.copyWith(roomId: newRoomId);

      // Then
      expect(updated.roomId, equals(newRoomId));
      expect(updated.enable, equals(original.enable)); // unchanged
      expect(updated.applyToAdmin, equals(original.applyToAdmin)); // unchanged
      expect(updated.canSendMessages, equals(original.canSendMessages));
      expect(updated.canSendMedia, equals(original.canSendMedia));
      expect(updated.canMentionAll, equals(original.canMentionAll));
      expect(updated.canEditOwnMessage, equals(original.canEditOwnMessage));
      expect(updated.canUnsendOwnMessage, equals(original.canUnsendOwnMessage));
      expect(updated.canReactions, equals(original.canReactions));
      expect(updated.canAddDeleteAlbum, equals(original.canAddDeleteAlbum));
      expect(updated.createdAt, equals(original.createdAt));
      expect(updated.updatedAt, equals(original.updatedAt));
    });

    test(
        'Given valid JSON data, When fromJson is called, Then returns correct GroupPermissionEntity',
        () {
      // Given
      final data = {
        '_id': 'test_room_id',
        'permissions': {
          'enable': false,
          'applyToAdmin': true,
          'canSendMessages': false,
          'canSendMedia': false,
          'canMentionAll': false,
          'canEditOwnMessage': false,
          'canUnsendOwnMessage': false,
          'canReactions': false,
          'canAddDeleteAlbum': false,
          'createdAt': '2023-05-01T10:00:00.000Z',
          'updatedAt': '2023-05-02T10:00:00.000Z',
        },
      };

      // When
      final entity = GroupPermissionEntity.fromJson(data);

      // Then
      expect(entity.roomId, equals('test_room_id'));
      expect(entity.enable, isFalse);
      expect(entity.applyToAdmin, isTrue);
      expect(entity.canSendMessages, isFalse);
      expect(entity.canSendMedia, isFalse);
      expect(entity.canMentionAll, isFalse);
      expect(entity.canEditOwnMessage, isFalse);
      expect(entity.canUnsendOwnMessage, isFalse);
      expect(entity.canReactions, isFalse);
      expect(entity.canAddDeleteAlbum, isFalse);
      expect(entity.createdAt, isNotNull);
      expect(entity.createdAt, strToDateTime('2023-05-01T10:00:00.000Z'));
      expect(entity.updatedAt, isNotNull);
      expect(entity.updatedAt, strToDateTime('2023-05-02T10:00:00.000Z'));
    });

    test(
        'Given entity with null dates, When toJson is called, Then returns correct JSON with null dates',
        () {
      // Given
      final entity = const GroupPermissionEntity(roomId: 'test_room_id', enable: false);

      // When
      final json = entity.toJson();

      // Then
      expect(json['roomId'], equals('test_room_id'));
      expect(json['permissions']['enable'], isFalse);
      expect(json['permissions']['createdAt'], isNull);
      expect(json['permissions']['updatedAt'], isNull);
    });

    test(
        'Given entity with dates, When toJson is called, Then returns correct JSON with date strings',
        () {
      // Given
      final createdAt = DateTime(2023, 5, 1, 10);
      final updatedAt = DateTime(2023, 5, 2, 10);
      final entity = GroupPermissionEntity(
        roomId: 'test_room_id',
        enable: false,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

      // When
      final json = entity.toJson();

      // Then
      expect(json['roomId'], equals('test_room_id'));
      expect(json['permissions']['enable'], isFalse);
      expect(json['permissions']['createdAt'], equals(createdAt.toUtc().toIso8601String()));
      expect(json['permissions']['updatedAt'], equals(updatedAt.toUtc().toIso8601String()));
    });

    test(
        'Given two identical entities, When == is called, Then returns true',
        () {
      // Given
      const entity1 = GroupPermissionEntity(roomId: 'test');
      const entity2 = GroupPermissionEntity(roomId: 'test');

      // When
      final result = entity1 == entity2;

      // Then
      expect(result, isTrue);
    });

    test(
        'Given two different entities, When == is called, Then returns false',
        () {
      // Given
      const entity1 = GroupPermissionEntity(roomId: 'test1');
      const entity2 = GroupPermissionEntity(roomId: 'test2');

      // When
      final result = entity1 == entity2;

      // Then
      expect(result, isFalse);
    });

    test(
        'Given two identical entities, When hashCode is called, Then returns same hash',
        () {
      // Given
      const entity1 = GroupPermissionEntity(roomId: 'test');
      const entity2 = GroupPermissionEntity(roomId: 'test');

      // When
      final hash1 = entity1.hashCode;
      final hash2 = entity2.hashCode;

      // Then
      expect(hash1, equals(hash2));
    });

    test(
        'Given entity, When toString is called, Then returns correct string representation',
        () {
      // Given
      const entity = GroupPermissionEntity(
        roomId: 'test_room_id',
        enable: false,
        applyToAdmin: true,
        canSendMessages: true,
      );

      // When
      final result = entity.toString();

      // Then
      expect(
        result,
        equals(
          'GroupPermissionEntity(roomId: test_room_id, enable: false, applyToAdmin: true, canSendMessages: true, canSendMedia: true, canMentionAll: true, canEditOwnMessage: true, canUnsendOwnMessage: true, canReactions: true, canAddDeleteAlbum: true, createdAt: null, updatedAt: null)',
        ),
      );
    });
  });
}