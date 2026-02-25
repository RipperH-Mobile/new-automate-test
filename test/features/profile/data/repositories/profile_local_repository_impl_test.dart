import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/exceptions/null_response_exception.dart';
import 'package:uchat/entities/enum/online_status.dart';
import 'package:uchat/entities/models/account_settings_model.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/contact/data/data_source/local/contact_db.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/profile/data/repositories/profile_local_repository_impl.dart';
import 'package:uchat/features/profile/domain/entities/profile_entity.dart';

// Mock Definitions
class MockContactDb extends Mock implements ContactDb {}

class MockRoomMemberDb extends Mock implements RoomMemberDb {}

class MockRoomDb extends Mock implements RoomDb {}

void main() {
  late ProfileLocalRepositoryImpl repository;
  late MockContactDb mockContactDb;
  late MockRoomMemberDb mockRoomMemberDb;
  late MockRoomDb mockRoomDb;
  late ContactCollection tContactCollection;
  late RoomCollection tRoomCollection;

  setUp(() {
    mockContactDb = MockContactDb();
    mockRoomMemberDb = MockRoomMemberDb();
    mockRoomDb = MockRoomDb();
    repository = ProfileLocalRepositoryImpl(
      contactDb: mockContactDb,
      roomMemberDb: mockRoomMemberDb,
      roomDB: mockRoomDb,
    );

    tContactCollection = ContactCollection(
      id: 'contact123',
      username: 'testUser',
      phoneNumber: '+1234567890',
      displayName: 'Test User',
      originalStatusMessage: 'Hello World',
      avatarId: 'avatar123',
      onlineStatus: OnlineStatus.online,
      originalIsDeleted: false,
      settings: AccountSettingsModel(),
      originalIsFriend: true,
      nickname: 'TestNick',
      blocked: false,
    );

    tRoomCollection = RoomCollection(
      id: 'room123',
      originalRoomName: 'Test Room',
      photoId: 'roomAvatar123',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      ownerId: 'user123',
    );
  });

  group('getContact', () {
    const tContactId = 'contact123';

    test(
        'Given a valid contact ID and contact exists in database, When getContact is called, Then returns ProfileEntity with all contact data',
        () async {
      // Given
      when(() => mockContactDb.getContact(tContactId)).thenAnswer((_) async => tContactCollection);

      // When
      final result = await repository.getContact(tContactId);

      // Then
      expect(result, isNotNull);
      expect(result, isA<ProfileEntity>());
      expect(result!.id, equals(tContactCollection.id));
      expect(result.username, equals(tContactCollection.username));
      expect(result.phoneNumber, equals(tContactCollection.phoneNumber));
      expect(result.displayName, equals(tContactCollection.displayName));
      expect(result.statusMessage, equals(tContactCollection.originalStatusMessage));
      expect(result.avatarId, equals(tContactCollection.avatarId));
      expect(result.onlineStatus, equals(tContactCollection.onlineStatus));
      expect(result.deleted, equals(tContactCollection.isDeleted));
      expect(result.settings, equals(tContactCollection.settings));
      expect(result.isFriend, equals(tContactCollection.isFriend));
      expect(result.friendNickname, equals(tContactCollection.nickname));
      expect(result.isBlocked, equals(tContactCollection.isBlocked));
      verify(() => mockContactDb.getContact(tContactId)).called(1);
    });

    test(
        'Given a valid contact ID but contact does not exist in database, When getContact is called, Then returns null',
        () async {
      // Given
      when(() => mockContactDb.getContact(tContactId)).thenAnswer((_) async => null);

      // When
      final result = await repository.getContact(tContactId);

      // Then
      expect(result, isNull);
      verify(() => mockContactDb.getContact(tContactId)).called(1);
    });

    test('Given contact with null id, When getContact is called, Then returns ProfileEntity with empty string id',
        () async {
      // Given
      final contactWithNullId = ContactCollection(
        id: null,
        username: 'testUser',
        phoneNumber: '+1234567890',
        displayName: 'Test User',
        originalStatusMessage: 'Hello World',
        avatarId: 'avatar123',
        onlineStatus: OnlineStatus.online,
        originalIsDeleted: false,
        settings: AccountSettingsModel(),
        originalIsFriend: true,
        nickname: 'TestNick',
        blocked: false,
      );
      when(() => mockContactDb.getContact(tContactId)).thenAnswer((_) async => contactWithNullId);

      // When
      final result = await repository.getContact(tContactId);

      // Then
      expect(result, isNotNull);
      expect(result!.id, equals(''));
      verify(() => mockContactDb.getContact(tContactId)).called(1);
    });

    test(
        'Given contact with null username, When getContact is called, Then returns ProfileEntity with empty string username',
        () async {
      // Given
      final contactWithNullUsername = ContactCollection(
        id: 'contact123',
        username: null,
        phoneNumber: '+1234567890',
        displayName: 'Test User',
        originalStatusMessage: 'Hello World',
        avatarId: 'avatar123',
        onlineStatus: OnlineStatus.online,
        originalIsDeleted: false,
        settings: AccountSettingsModel(),
        originalIsFriend: true,
        nickname: 'TestNick',
        blocked: false,
      );
      when(() => mockContactDb.getContact(tContactId)).thenAnswer((_) async => contactWithNullUsername);

      // When
      final result = await repository.getContact(tContactId);

      // Then
      expect(result, isNotNull);
      expect(result!.username, equals(''));
      verify(() => mockContactDb.getContact(tContactId)).called(1);
    });

    test(
        'Given contact with null phoneNumber, When getContact is called, Then returns ProfileEntity with empty string phoneNumber',
        () async {
      // Given
      final contactWithNullPhone = ContactCollection(
        id: 'contact123',
        username: 'testUser',
        phoneNumber: null,
        displayName: 'Test User',
        originalStatusMessage: 'Hello World',
        avatarId: 'avatar123',
        onlineStatus: OnlineStatus.online,
        originalIsDeleted: false,
        settings: AccountSettingsModel(),
        originalIsFriend: true,
        nickname: 'TestNick',
        blocked: false,
      );
      when(() => mockContactDb.getContact(tContactId)).thenAnswer((_) async => contactWithNullPhone);

      // When
      final result = await repository.getContact(tContactId);

      // Then
      expect(result, isNotNull);
      expect(result!.phoneNumber, equals(''));
      verify(() => mockContactDb.getContact(tContactId)).called(1);
    });

    test(
        'Given contact with null displayName, When getContact is called, Then returns ProfileEntity with empty string displayName',
        () async {
      // Given
      final contactWithNullDisplayName = ContactCollection(
        id: 'contact123',
        username: 'testUser',
        phoneNumber: '+1234567890',
        displayName: null,
        originalStatusMessage: 'Hello World',
        avatarId: 'avatar123',
        onlineStatus: OnlineStatus.online,
        originalIsDeleted: false,
        settings: AccountSettingsModel(),
        originalIsFriend: true,
        nickname: 'TestNick',
        blocked: false,
      );
      when(() => mockContactDb.getContact(tContactId)).thenAnswer((_) async => contactWithNullDisplayName);

      // When
      final result = await repository.getContact(tContactId);

      // Then
      expect(result, isNotNull);
      expect(result!.displayName, equals(''));
      verify(() => mockContactDb.getContact(tContactId)).called(1);
    });

    test(
        'Given contact with null onlineStatus, When getContact is called, Then returns ProfileEntity with offline status',
        () async {
      // Given
      final contactWithNullOnlineStatus = ContactCollection(
        id: 'contact123',
        username: 'testUser',
        phoneNumber: '+1234567890',
        displayName: 'Test User',
        originalStatusMessage: 'Hello World',
        avatarId: 'avatar123',
        onlineStatus: null,
        originalIsDeleted: false,
        settings: AccountSettingsModel(),
        originalIsFriend: true,
        nickname: 'TestNick',
        blocked: false,
      );
      when(() => mockContactDb.getContact(tContactId)).thenAnswer((_) async => contactWithNullOnlineStatus);

      // When
      final result = await repository.getContact(tContactId);

      // Then
      expect(result, isNotNull);
      expect(result!.onlineStatus, equals(OnlineStatus.offline));
      verify(() => mockContactDb.getContact(tContactId)).called(1);
    });

    test(
        'Given contact with null settings, When getContact is called, Then returns ProfileEntity with default AccountSettingsModel',
        () async {
      // Given
      final contactWithNullSettings = ContactCollection(
        id: 'contact123',
        username: 'testUser',
        phoneNumber: '+1234567890',
        displayName: 'Test User',
        originalStatusMessage: 'Hello World',
        avatarId: 'avatar123',
        onlineStatus: OnlineStatus.online,
        originalIsDeleted: false,
        settings: null,
        originalIsFriend: true,
        nickname: 'TestNick',
        blocked: false,
      );
      when(() => mockContactDb.getContact(tContactId)).thenAnswer((_) async => contactWithNullSettings);

      // When
      final result = await repository.getContact(tContactId);

      // Then
      expect(result, isNotNull);
      expect(result!.settings, isA<AccountSettingsModel>());
      verify(() => mockContactDb.getContact(tContactId)).called(1);
    });
  });

  group('getRoomByAccountId', () {
    const tAccountId = 'account123';
    const tRoomId = 'room123';

    test('Given a valid account ID and direct room exists, When getRoomByAccountId is called, Then returns RoomEntity',
        () async {
      // Given
      when(() => mockRoomMemberDb.getDirectRoomIdByOtherIdInRoom(tAccountId)).thenAnswer((_) async => tRoomId);
      when(() => mockRoomDb.getRoom(tRoomId)).thenAnswer((_) async => tRoomCollection);

      // When
      final result = await repository.getRoomByAccountId(tAccountId);

      // Then
      expect(result, isNotNull);
      expect(result, isA<RoomEntity>());
      expect(result!.id, equals(tRoomCollection.id));
      verify(() => mockRoomMemberDb.getDirectRoomIdByOtherIdInRoom(tAccountId)).called(1);
      verify(() => mockRoomDb.getRoom(tRoomId)).called(1);
    });

    test('Given a valid account ID but no direct room found, When getRoomByAccountId is called, Then returns null',
        () async {
      // Given
      when(() => mockRoomMemberDb.getDirectRoomIdByOtherIdInRoom(tAccountId)).thenAnswer((_) async => null);
      when(() => mockRoomDb.getRoom('')).thenAnswer((_) async => null);

      // When
      final result = await repository.getRoomByAccountId(tAccountId);

      // Then
      expect(result, isNull);
      verify(() => mockRoomMemberDb.getDirectRoomIdByOtherIdInRoom(tAccountId)).called(1);
      verify(() => mockRoomDb.getRoom('')).called(1);
    });

    test(
        'Given a valid account ID with room ID but room does not exist, When getRoomByAccountId is called, Then returns null',
        () async {
      // Given
      when(() => mockRoomMemberDb.getDirectRoomIdByOtherIdInRoom(tAccountId)).thenAnswer((_) async => tRoomId);
      when(() => mockRoomDb.getRoom(tRoomId)).thenAnswer((_) async => null);

      // When
      final result = await repository.getRoomByAccountId(tAccountId);

      // Then
      expect(result, isNull);
      verify(() => mockRoomMemberDb.getDirectRoomIdByOtherIdInRoom(tAccountId)).called(1);
      verify(() => mockRoomDb.getRoom(tRoomId)).called(1);
    });
  });

  group('updateProfile', () {
    late ProfileEntity tProfileEntity;

    setUp(() {
      tProfileEntity = ProfileEntity(
        id: 'contact123',
        username: 'updatedUser',
        phoneNumber: '+9876543210',
        displayName: 'Updated User',
        statusMessage: 'Updated status',
        avatarId: 'updatedAvatar123',
        onlineStatus: OnlineStatus.online,
        deleted: false,
        settings: AccountSettingsModel(),
        isFriend: true,
        friendNickname: 'UpdatedNick',
        isBlocked: false,
      );
    });

    test(
        'Given a valid ProfileEntity and existing contact, When updateProfile is called, Then updates contact successfully',
        () async {
      // Given
      when(() => mockContactDb.getContact(tProfileEntity.id)).thenAnswer((_) async => tContactCollection);
      when(() => mockContactDb.putContact(tContactCollection)).thenAnswer((_) async {});

      // When
      await repository.updateProfile(tProfileEntity);

      // Then
      verify(() => mockContactDb.getContact(tProfileEntity.id)).called(1);
      verify(() => mockContactDb.putContact(tContactCollection)).called(1);
    });

    test(
        'Given a valid ProfileEntity but contact does not exist, When updateProfile is called, Then throws NullResponseException',
        () async {
      // Given
      when(() => mockContactDb.getContact(tProfileEntity.id)).thenAnswer((_) async => null);

      // When & Then
      expect(
        () async => await repository.updateProfile(tProfileEntity),
        throwsA(isA<NullResponseException>()),
      );
      verify(() => mockContactDb.getContact(tProfileEntity.id)).called(1);
      verifyNever(() => mockContactDb.putContact(tContactCollection));
    });

    test(
        'Given a ProfileEntity with updated values, When updateProfile is called, Then contact is updated with new values',
        () async {
      // Given
      ContactCollection? capturedContact;
      when(() => mockContactDb.getContact(tProfileEntity.id)).thenAnswer((_) async => tContactCollection);
      when(() => mockContactDb.putContact(tContactCollection)).thenAnswer((invocation) async {
        capturedContact = invocation.positionalArguments[0] as ContactCollection;
      });

      // When
      await repository.updateProfile(tProfileEntity);

      // Then
      expect(capturedContact, isNotNull);
      expect(capturedContact!.id, equals(tProfileEntity.id));
      expect(capturedContact!.username, equals(tProfileEntity.username));
      expect(capturedContact!.phoneNumber, equals(tProfileEntity.phoneNumber));
      expect(capturedContact!.displayName, equals(tProfileEntity.displayName));
      expect(capturedContact!.originalStatusMessage, equals(tProfileEntity.statusMessage));
      expect(capturedContact!.avatarId, equals(tProfileEntity.avatarId));
      expect(capturedContact!.onlineStatus, equals(tProfileEntity.onlineStatus));
      expect(capturedContact!.settings, equals(tProfileEntity.settings));
      expect(capturedContact!.nickname, equals(tProfileEntity.friendNickname));
      verify(() => mockContactDb.getContact(tProfileEntity.id)).called(1);
      verify(() => mockContactDb.putContact(capturedContact!)).called(1);
    });

    test(
        'Given a ProfileEntity with null values, When updateProfile is called, Then contact is updated with null values',
        () async {
      // Given
      final profileWithNulls = ProfileEntity(
        id: 'contact123',
        username: 'updatedUser',
        phoneNumber: '+9876543210',
        displayName: 'Updated User',
        statusMessage: null,
        avatarId: null,
        onlineStatus: OnlineStatus.offline,
        deleted: false,
        settings: AccountSettingsModel(),
        isFriend: true,
        friendNickname: null,
        isBlocked: false,
      );
      ContactCollection? capturedContact;
      when(() => mockContactDb.getContact(profileWithNulls.id)).thenAnswer((_) async => tContactCollection);
      when(() => mockContactDb.putContact(tContactCollection)).thenAnswer((invocation) async {
        capturedContact = invocation.positionalArguments[0] as ContactCollection;
      });

      // When
      await repository.updateProfile(profileWithNulls);

      // Then
      expect(capturedContact, isNotNull);
      expect(capturedContact!.originalStatusMessage, isNull);
      expect(capturedContact!.avatarId, isNull);
      expect(capturedContact!.nickname, isNull);
      verify(() => mockContactDb.getContact(profileWithNulls.id)).called(1);
      verify(() => mockContactDb.putContact(capturedContact!)).called(1);
    });

    test(
        'Given a ProfileEntity with different settings, When updateProfile is called, Then contact is updated with new settings',
        () async {
      // Given
      final newSettings = AccountSettingsModel();
      final profileWithNewSettings = ProfileEntity(
        id: 'contact123',
        username: 'updatedUser',
        phoneNumber: '+9876543210',
        displayName: 'Updated User',
        statusMessage: 'Updated status',
        avatarId: 'updatedAvatar123',
        onlineStatus: OnlineStatus.online,
        deleted: false,
        settings: newSettings,
        isFriend: true,
        friendNickname: 'UpdatedNick',
        isBlocked: false,
      );
      ContactCollection? capturedContact;
      when(() => mockContactDb.getContact(profileWithNewSettings.id)).thenAnswer((_) async => tContactCollection);
      when(() => mockContactDb.putContact(tContactCollection)).thenAnswer((invocation) async {
        capturedContact = invocation.positionalArguments[0] as ContactCollection;
      });

      // When
      await repository.updateProfile(profileWithNewSettings);

      // Then
      expect(capturedContact, isNotNull);
      expect(capturedContact!.settings, equals(newSettings));
      verify(() => mockContactDb.getContact(profileWithNewSettings.id)).called(1);
      verify(() => mockContactDb.putContact(capturedContact!)).called(1);
    });

    test(
        'Given a ProfileEntity with different online status, When updateProfile is called, Then contact is updated with new online status',
        () async {
      // Given
      final profileWithBusyStatus = ProfileEntity(
        id: 'contact123',
        username: 'updatedUser',
        phoneNumber: '+9876543210',
        displayName: 'Updated User',
        statusMessage: 'Updated status',
        avatarId: 'updatedAvatar123',
        onlineStatus: OnlineStatus.busy,
        deleted: false,
        settings: AccountSettingsModel(),
        isFriend: true,
        friendNickname: 'UpdatedNick',
        isBlocked: false,
      );
      ContactCollection? capturedContact;
      when(() => mockContactDb.getContact(profileWithBusyStatus.id)).thenAnswer((_) async => tContactCollection);
      when(() => mockContactDb.putContact(tContactCollection)).thenAnswer((invocation) async {
        capturedContact = invocation.positionalArguments[0] as ContactCollection;
      });

      // When
      await repository.updateProfile(profileWithBusyStatus);

      // Then
      expect(capturedContact, isNotNull);
      expect(capturedContact!.onlineStatus, equals(OnlineStatus.busy));
      verify(() => mockContactDb.getContact(profileWithBusyStatus.id)).called(1);
      verify(() => mockContactDb.putContact(capturedContact!)).called(1);
    });
  });
}
