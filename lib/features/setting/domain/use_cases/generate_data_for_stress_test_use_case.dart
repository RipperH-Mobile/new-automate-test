import 'dart:math';

import 'package:uchat/api/services/message_service.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/entities/enum/room_access_type.dart';
import 'package:uchat/entities/enum/room_member_role.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/entities/models/contact_model.dart';
import 'package:uchat/features/chat_room/data/models/models/group_admin_permission_model.dart';
import 'package:uchat/features/chat_room/data/models/models/group_member_role_model.dart';
import 'package:uchat/features/chat_room/data/models/models/message_model.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_member_local_repository.dart';
import 'package:uchat/features/contact/contact_barrel.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/widgets/loading/loading.dart';
import 'package:uuid/uuid.dart';

class StressTestParams {
  final int messageCount;
  final int contactCount;
  final int groupCount;
  final int groupMemberCount;
  final int oaCount;

  StressTestParams({
    required this.messageCount,
    required this.contactCount,
    required this.groupCount,
    required this.groupMemberCount,
    required this.oaCount,
  });
}

class GenerateDataForStressTestUseCase extends SimpleUseCase<void, NoParams> {
  // Maximum limits for data generation
  static const double messageCountMax = 2000.0;
  static const double contactCountMax = 1000.0;
  static const double groupCountMax = 10000.0;
  static const double groupMemberCountMax = 500.0;
  static const double oaCountMax = 10000.0;

  final LoggerService log;
  final UserEntity currentUser;
  final ContactLocalRepository contactLocalRepository;
  final ChatRoomLocalRepository chatRoomLocalRepository;
  final RoomMemberLocalRepository roomMemberLocalRepository;
  final MessageLocalRepository messageLocalRepository;
  final ContactsController contactsController;
  final MessageService messageService;

  GenerateDataForStressTestUseCase({
    required this.log,
    required this.currentUser,
    required this.contactLocalRepository,
    required this.chatRoomLocalRepository,
    required this.roomMemberLocalRepository,
    required this.messageLocalRepository,
    required this.contactsController,
    required this.messageService,
  });

  @override
  Future<void> call(NoParams params) async {
    // Default optimized counts for backward compatibility
    const int messageCount = 50;
    const int contactCount = 3;
    const int groupCount = 2;
    const int groupMemberCount = 3;
    const int oaCount = 2;

    await callWithCustomParams(StressTestParams(
      messageCount: messageCount,
      contactCount: contactCount,
      groupCount: groupCount,
      groupMemberCount: groupMemberCount,
      oaCount: oaCount,
    ));
  }

  Future<void> callWithCustomParams(StressTestParams params) async {
    final int messageCount = params.messageCount;
    final int contactCount = params.contactCount;
    final int groupCount = params.groupCount;
    final int groupMemberCount = params.groupMemberCount;
    final int oaCount = params.oaCount;

    // Check current data counts and enforce maximum limits
    try {
      final existingFriendContacts = await contactLocalRepository.getFriendContacts();
      final existingOAContacts = await contactLocalRepository.getOfficialContacts();
      final existingGroupRooms = await chatRoomLocalRepository.getRoomTypeGroup();

      // Count existing mock data
      final existingMockContacts = existingFriendContacts.where((c) => c.id?.contains('_mock') == true).length;
      final existingMockOAs = existingOAContacts.where((c) => c.id?.contains('_mock') == true).length;
      final existingMockGroups =
          existingGroupRooms?.where((r) => r.roomName?.contains('Mock group') == true).length ?? 0;

      // Calculate what would be the new totals after generation
      final newContactTotal = existingMockContacts + contactCount;
      final newOATotal = existingMockOAs + oaCount;
      final newGroupTotal = existingMockGroups + groupCount;

      // Check limits and prevent generation if any limit would be exceeded
      if (newContactTotal > contactCountMax) {
        log.w(
            '⚠️ Contact limit reached! Current: $existingMockContacts, Requested: $contactCount, Max: ${contactCountMax.toInt()}');
        throw Exception(
            'Contact limit would be exceeded. Current: $existingMockContacts, Max: ${contactCountMax.toInt()}');
      }

      if (newOATotal > oaCountMax) {
        log.w(
            '⚠️ Official Account limit reached! Current: $existingMockOAs, Requested: $oaCount, Max: ${oaCountMax.toInt()}');
        throw Exception(
            'Official Account limit would be exceeded. Current: $existingMockOAs, Max: ${oaCountMax.toInt()}');
      }

      if (newGroupTotal > groupCountMax) {
        log.w(
            '⚠️ Group limit reached! Current: $existingMockGroups, Requested: $groupCount, Max: ${groupCountMax.toInt()}');
        throw Exception('Group limit would be exceeded. Current: $existingMockGroups, Max: ${groupCountMax.toInt()}');
      }

      if (groupMemberCount > groupMemberCountMax) {
        log.w('⚠️ Group member limit exceeded! Requested: $groupMemberCount, Max: ${groupMemberCountMax.toInt()}');
        throw Exception(
            'Group member count exceeds limit. Requested: $groupMemberCount, Max: ${groupMemberCountMax.toInt()}');
      }

      if (messageCount > messageCountMax) {
        log.w(
            '⚠️ Message limit would be exceeded! Current: ~$messageCount, Estimated new: $messageCount, Max: ${messageCountMax.toInt()}');
        throw Exception('Message limit would be exceeded. Current: ~$messageCount, Max: ${messageCountMax.toInt()}');
      }

      log.d('✅ Limit checks passed. Proceeding with data generation...');
      log.d(
          '📊 Current data: Contacts: $existingMockContacts, OAs: $existingMockOAs, Groups: $existingMockGroups, Messages: ~$messageCount');
    } catch (e) {
      log.w('Could not check existing data limits: $e. Proceeding with generation...');
      rethrow; // Re-throw limit exceptions
    }

    // Batch processing configuration
    const int messageBatchSize = 10;

    const uuid = Uuid();
    final random = Random();
    final maxBirthdate = DateTime.now().subYears(5);

    log.d('🚀 Starting optimized stress test data generation...');
    log.d('📊 Contacts: $contactCount, Groups: $groupCount, OAs: $oaCount, Messages per room: $messageCount');

    try {
      int totalOperations = contactCount + groupCount + oaCount;
      int currentOperation = 0;

      // Step 1: Generate friends with rooms and messages
      await _safeShowProgress('👥 Generating friend contacts and their rooms...');
      log.d('👥 Generating friend contacts and their rooms...');
      final List<ContactEntity> friendContacts = [];

      // Check for existing mock contacts to get the next index
      final existingContacts = await contactLocalRepository.getFriendContacts();
      final existingMockContacts = existingContacts.where((c) => c.id?.contains('_mock') == true).toList();
      int startContactIndex = existingMockContacts.length + 1;

      for (int i = 0; i < contactCount; i++) {
        currentOperation++;
        final dProgress = (currentOperation / totalOperations * 100);
        final progress = dProgress.toStringAsFixed(1);
        final contactIndex = startContactIndex + i;

        await _safeShowProgress('Creating friend contact $contactIndex with ${messageCount} messages... ($progress%)');
        log.d('Processing friend $contactIndex/$contactCount ($progress%)');

        try {
          final contact = _createContact(
            id: '${uuid.v4()}_mock',
            displayName: 'Mock Contact $contactIndex',
            type: 'NORMAL',
            random: random,
            maxBirthdate: maxBirthdate,
          );

          friendContacts.add(contact);

          // Generate room and messages for this contact
          await _generateDirectRoomWithMessages(
            contact: contact,
            messageCount: messageCount,
            messageBatchSize: messageBatchSize,
            uuid: uuid,
            random: random,
          );

          // Yield control periodically
          if (i % 2 == 0) {
            await Future.delayed(const Duration(milliseconds: 5));
          }
        } catch (e, stackTrace) {
          log.e('❌ Error generating friend ${i + 1}: $e', e, stackTrace);
        }
      }

      // Save friend contacts
      if (friendContacts.isNotEmpty) {
        await _safeShowProgress('Saving ${friendContacts.length} friend contacts...');
        await contactLocalRepository.putAllContact(friendContacts);
        log.d('✅ Saved ${friendContacts.length} friend contacts');
      }

      // Step 2: Generate official accounts
      await _safeShowProgress('🏢 Generating official accounts...');
      log.d('🏢 Generating official accounts...');
      final List<ContactEntity> oaContacts = [];

      // Check for existing mock OAs to get the next index
      final existingOAs =
          existingContacts.where((c) => c.id?.startsWith('@') == true && c.id?.contains('_mock') == true).toList();
      int startOAIndex = existingOAs.length + 1;

      for (int i = 0; i < oaCount; i++) {
        currentOperation++;
        final progress = (currentOperation / totalOperations * 100).toStringAsFixed(1);
        final oaIndex = startOAIndex + i;

        await _safeShowProgress('Creating official account $oaIndex with ${messageCount} messages... ($progress%)');
        log.d('Processing OA $oaIndex/$oaCount ($progress%)');

        try {
          final contact = _createContact(
            id: '@${uuid.v4()}_mock',
            displayName: 'Mock Official Account $oaIndex',
            type: 'OFFICIAL',
            random: random,
            maxBirthdate: maxBirthdate,
          );

          oaContacts.add(contact);

          await _generateDirectRoomWithMessages(
            contact: contact,
            messageCount: messageCount,
            messageBatchSize: messageBatchSize,
            uuid: uuid,
            random: random,
          );

          await Future.delayed(const Duration(milliseconds: 5));
        } catch (e, stackTrace) {
          log.e('❌ Error generating OA ${i + 1}: $e', e, stackTrace);
        }
      }

      // Save OA contacts
      if (oaContacts.isNotEmpty) {
        await _safeShowProgress('Saving ${oaContacts.length} official accounts...');
        await contactLocalRepository.putAllContact(oaContacts);
        log.d('✅ Saved ${oaContacts.length} official accounts');
      }

      // Step 3: Generate groups
      await _safeShowProgress('👨‍👩‍👧‍👦 Generating group chats...');
      log.d('👨‍👩‍👧‍👦 Generating group chats...');

      // Check for existing mock groups to get the next index
      final existingRooms = await chatRoomLocalRepository.getRoomTypeGroup();
      final existingMockGroups = existingRooms
          ?.where((r) => r.roomType == RoomType.group && (r.roomName?.contains('Mock group') ?? false))
          .toList();
      int startGroupIndex = (existingMockGroups?.length ?? 0) + 1;

      for (int i = 0; i < groupCount; i++) {
        currentOperation++;
        final dProgress = (currentOperation / totalOperations * 100);

        final progress = dProgress.toStringAsFixed(1);
        final groupIndex = startGroupIndex + i;

        await _safeShowProgress('Creating group chat $groupIndex with ${messageCount} messages... ($progress%)');
        log.d('Processing group $groupIndex/$groupCount ($progress%)');

        try {
          await _generateGroupWithMessages(
            groupIndex: groupIndex,
            memberContacts: friendContacts.take(groupMemberCount - 1).toList(),
            messageCount: messageCount,
            messageBatchSize: messageBatchSize,
            uuid: uuid,
            random: random,
          );

          await Future.delayed(const Duration(milliseconds: 10));
        } catch (e, stackTrace) {
          log.e('❌ Error generating group ${i + 1}: $e', e, stackTrace);
        }
      }

      // Step 4: Refresh UI data
      await _safeShowProgress('🔄 Refreshing contact screen data...');
      log.d('🔄 Refreshing contact screen data...');
      try {
        contactsController.initGroupListDataFromLocal();
        contactsController.initFriendListDataFromLocal();
        contactsController.initOAListDataFromLocal();
      } catch (e, stackTrace) {
        log.e('❌ Error refreshing UI data: $e', e, stackTrace);
      }

      await _safeShowProgress('🎉 Stress test data generation completed successfully!');
      log.d('🎉 Stress test data generation completed successfully!');
    } catch (e, stackTrace) {
      log.e('💥 Fatal error in stress test data generation: $e', e, stackTrace);
      rethrow;
    }
  }

  /// Helper method to create a contact entity
  ContactEntity _createContact({
    required String id,
    required String displayName,
    required String type,
    required Random random,
    required DateTime maxBirthdate,
  }) {
    return ContactEntity(
      id: id,
      displayName: displayName,
      username: id,
      avatarId: null,
      originalStatusMessage: random.nextBool() ? _generateRandomString(random.nextInt(50) + 1, random) : null,
      birthDate: random.nextBool() ? maxBirthdate.subDays(random.nextInt(365 * 100) + 1).toIso8601String() : null,
      email: random.nextBool() ? '${_generateRandomString(random.nextInt(20) + 1, random)}@gmail.com' : null,
      friendCanSeeMyLastSeen: random.nextBool() ? random.nextBool() : null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      type: type,
      phoneNumber: '+66${_generateRandomString(9, random, customCharacters: '0123456789')}',
      originalIsFriend: type == 'NORMAL',
    );
  }

  /// Generate a direct room with messages for a contact
  Future<void> _generateDirectRoomWithMessages({
    required ContactEntity contact,
    required int messageCount,
    required int messageBatchSize,
    required Uuid uuid,
    required Random random,
  }) async {
    try {
      final roomId = '${uuid.v4()}_mock';
      final roomAge = random.nextInt(365) + 1;

      // Create room
      final room = RoomEntity(
        id: roomId,
        createdAt: DateTime.now().subDays(roomAge),
        updatedAt: DateTime.now(),
        roomType: RoomType.direct,
        memberCount: 2,
      );

      // Create room members
      final member = _createRoomMember(contact, roomId, RoomType.direct, roomAge, random);
      final self = _createSelfMember(roomId, RoomType.direct, roomAge, random);
      final members = [member, self];

      // Create room subscription
      final roomSub = _createRoomSubscription(
        roomId: roomId,
        room: room,
        members: members,
        uuid: uuid,
        random: random,
        roomAge: roomAge,
      );

      // Generate messages in batches with proper sequential ordering
      final messages = <MessageEntity>[];
      final baseTime = DateTime.now().subDays(roomAge);

      for (int j = 0; j < messageCount; j++) {
        final sender = random.nextBool() ? member : self;

        // Create messages in chronological order (oldest to newest)
        final messageCreateTime = baseTime.add(Duration(
          minutes: j * 5, // 5 minutes between each message for realistic spacing
          seconds: random.nextInt(60), // Add some random seconds for variety
        ));

        // Ensure sequence is truly linear
        final sequence = baseTime.millisecondsSinceEpoch + (j * 300000); // 5 minutes in milliseconds

        final message = MessageEntity(
          id: '${uuid.v4()}_mock',
          ref: messageService.generateMsgUid(),
          account: ContactModel(
            id: sender.account.id,
            displayName: sender.account.displayName,
            email: sender.account.email,
            phoneNumber: sender.account.phoneNumber,
            type: sender.account.type,
            username: sender.account.username,
            updatedAt: sender.account.updatedAt,
            createdAt: sender.account.createdAt,
          ),
          accountId: sender.account.id,
          createdAt: messageCreateTime,
          sequence: sequence,
          updatedAt: messageCreateTime,
          roomId: roomId,
          type: MessageType.text,
          isSending: false,
          isSendFailed: false,
          message: 'Message ${j + 1}: Mock conversation ${_generateRandomString(10, random)}',
        );

        messages.add(message);

        // Save in batches to prevent memory issues
        if (messages.length >= messageBatchSize || j == messageCount - 1) {
          await messageLocalRepository.putAllMessages(messages: messages);
          messages.clear();
        }
      }

      // Save room data
      await chatRoomLocalRepository.putAllRoom([room]);
      await roomMemberLocalRepository.putAllRoomMember(members);
      await chatRoomLocalRepository.putAllRoomSub([roomSub]);
    } catch (e, stackTrace) {
      log.e('Error generating direct room for ${contact.displayName}: $e', e, stackTrace);
      rethrow;
    }
  }

  /// Generate a group room with messages
  Future<void> _generateGroupWithMessages({
    required int groupIndex,
    required List<ContactEntity> memberContacts,
    required int messageCount,
    required int messageBatchSize,
    required Uuid uuid,
    required Random random,
  }) async {
    try {
      final roomId = '${uuid.v4()}_mock';
      final roomAge = random.nextInt(365) + 1;

      // Create group room
      final room = RoomEntity(
        id: roomId,
        createdAt: DateTime.now().subDays(roomAge),
        updatedAt: DateTime.now(),
        roomType: RoomType.group,
        accessType: RoomAccessType.private,
        photoId: 'wallpaper${(random.nextInt(10) + 1).toString().padLeft(2, '0')}.png',
        roomName: 'Mock group $groupIndex',
        groupRef: _generateRandomString(6, random),
        isJoined: true,
        memberCount: memberContacts.length + 1, // +1 for self
      );

      // Create group members
      final members = <RoomMemberEntity>[];

      // Add other members
      for (final contact in memberContacts) {
        final member = _createGroupMember(contact, roomId, roomAge, random);
        members.add(member);
      }

      // Add self as member
      final self = _createSelfGroupMember(roomId, roomAge, random);
      members.add(self);

      // Set random owner
      final ownerIndex = random.nextInt(members.length);
      final owner = members[ownerIndex].copyWith(
        groupRole: GroupMemberRoleModel(
          role: RoomMemberRole.owner,
          permissions: GroupAdminPermissionModel(
            setGroupPermissions: true,
            changeGroupInfo: true,
            pinMessages: true,
            deleteOtherMessages: true,
            groupMemberSetting: true,
          ),
        ),
      );
      members[ownerIndex] = owner;

      final updatedRoom = room.copyWith(ownerId: owner.account.id);

      // Create room subscription
      final roomSub = _createRoomSubscription(
        roomId: roomId,
        room: updatedRoom,
        members: members,
        uuid: uuid,
        random: random,
        roomAge: roomAge,
      );

      // Generate group messages in batches with proper sequential ordering
      final messages = <MessageEntity>[];
      final baseTime = DateTime.now().subDays(roomAge);

      for (int j = 0; j < messageCount; j++) {
        final sender = members[random.nextInt(members.length)];

        // Create messages in chronological order (oldest to newest)
        final messageCreateTime = baseTime.add(Duration(
          minutes: j * 3, // 3 minutes between each message for active group chat
          seconds: random.nextInt(60), // Add some random seconds for variety
        ));

        // Ensure sequence is truly linear
        final sequence = baseTime.millisecondsSinceEpoch + (j * 180000); // 3 minutes in milliseconds

        final message = MessageEntity(
          id: '${uuid.v4()}_mock',
          ref: messageService.generateMsgUid(),
          account: ContactModel(
            id: sender.account.id,
            displayName: sender.account.displayName,
            email: sender.account.email,
            phoneNumber: sender.account.phoneNumber,
            type: sender.account.type,
            username: sender.account.username,
            updatedAt: sender.account.updatedAt,
            createdAt: sender.account.createdAt,
          ),
          accountId: sender.account.id,
          createdAt: messageCreateTime,
          sequence: sequence,
          updatedAt: messageCreateTime,
          roomId: roomId,
          type: MessageType.text,
          isSending: false,
          isSendFailed: false,
          message: 'Message ${j + 1}: ${sender.account.displayName} says ${_generateRandomString(15, random)}',
        );

        messages.add(message);

        // Save in batches
        if (messages.length >= messageBatchSize || j == messageCount - 1) {
          await messageLocalRepository.putAllMessages(messages: messages);
          messages.clear();
        }
      }

      // Save group data
      await chatRoomLocalRepository.putAllRoom([updatedRoom]);
      await roomMemberLocalRepository.putAllRoomMember(members);
      await chatRoomLocalRepository.putAllRoomSub([roomSub]);
    } catch (e, stackTrace) {
      log.e('Error generating group $groupIndex: $e', e, stackTrace);
      rethrow;
    }
  }

  /// Create a room member entity
  RoomMemberEntity _createRoomMember(
    ContactEntity contact,
    String roomId,
    RoomType roomType,
    int roomAge,
    Random random,
  ) {
    return RoomMemberEntity(
      account: ContactModel(
        id: contact.id,
        displayName: contact.displayName,
        email: contact.email,
        phoneNumber: contact.phoneNumber,
        type: contact.type,
        username: contact.username,
        updatedAt: contact.updatedAt,
        createdAt: contact.createdAt,
      ),
      roomId: roomId,
      roomType: roomType,
      lastSeenMessageAt: DateTime.now().subDays(random.nextInt(roomAge)),
    );
  }

  /// Create self member entity
  RoomMemberEntity _createSelfMember(
    String roomId,
    RoomType roomType,
    int roomAge,
    Random random,
  ) {
    return RoomMemberEntity(
      account: ContactModel(
        id: currentUser.id,
        displayName: currentUser.displayName,
        email: currentUser.email,
        phoneNumber: currentUser.phoneNumber,
        type: 'NORMAL',
        username: currentUser.username,
      ),
      roomId: roomId,
      roomType: roomType,
      lastSeenMessageAt: DateTime.now().subDays(random.nextInt(roomAge)),
    );
  }

  /// Create group member with permissions
  RoomMemberEntity _createGroupMember(
    ContactEntity contact,
    String roomId,
    int roomAge,
    Random random,
  ) {
    return RoomMemberEntity(
      account: ContactModel(
        id: contact.id,
        displayName: contact.displayName,
        email: contact.email,
        phoneNumber: contact.phoneNumber,
        type: contact.type,
        username: contact.username,
        updatedAt: contact.updatedAt,
        createdAt: contact.createdAt,
      ),
      roomId: roomId,
      roomType: RoomType.group,
      groupRole: GroupMemberRoleModel(
        role: RoomMemberRole.member,
        permissions: GroupAdminPermissionModel(
          setGroupPermissions: false,
          changeGroupInfo: false,
          pinMessages: false,
          deleteOtherMessages: false,
          groupMemberSetting: false,
        ),
      ),
      lastSeenMessageAt: DateTime.now().subDays(random.nextInt(roomAge)),
    );
  }

  /// Create self group member
  RoomMemberEntity _createSelfGroupMember(
    String roomId,
    int roomAge,
    Random random,
  ) {
    return RoomMemberEntity(
      account: ContactModel(
        id: currentUser.id,
        displayName: currentUser.displayName,
        email: currentUser.email,
        phoneNumber: currentUser.phoneNumber,
        type: 'NORMAL',
        username: currentUser.username,
      ),
      roomId: roomId,
      roomType: RoomType.group,
      groupRole: GroupMemberRoleModel(
        role: RoomMemberRole.member,
        permissions: GroupAdminPermissionModel(
          setGroupPermissions: false,
          changeGroupInfo: false,
          pinMessages: false,
          deleteOtherMessages: false,
          groupMemberSetting: false,
        ),
      ),
      lastSeenMessageAt: DateTime.now().subDays(random.nextInt(roomAge)),
    );
  }

  /// Create room subscription entity
  RoomSubscriptionEntity _createRoomSubscription({
    required String roomId,
    required RoomEntity room,
    required List<RoomMemberEntity> members,
    required Uuid uuid,
    required Random random,
    required int roomAge,
  }) {
    final self = members.firstWhere((m) => m.account.id == currentUser.id);

    // Use a recent timestamp for the last message (within last few hours)
    final lastMessageTime = DateTime.now().subtract(Duration(
      hours: random.nextInt(12) + 1, // 1-12 hours ago
      minutes: random.nextInt(60),
    ));

    return RoomSubscriptionEntity(
      id: '${uuid.v4()}_mock',
      accountId: self.account.id,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      hasFirstOtherInRoom: true,
      roomId: roomId,
      roomName: room.roomName,
      roomType: room.roomType,
      lastMessage: MessageModel(
        id: '${uuid.v4()}_mock',
        accountId: random.nextBool() ? members[random.nextInt(members.length)].account.id : self.account.id,
        createdAt: lastMessageTime,
        sequence: lastMessageTime.millisecondsSinceEpoch,
        updatedAt: lastMessageTime,
        roomId: roomId,
        type: MessageType.text,
        message: 'Latest: ${_generateRandomString(15, random)}',
      ),
    );
  }

  /// Safe wrapper for showing progress that handles test environments
  Future<void> _safeShowProgress(String message) async {
    try {
      // Check if we're likely in a test environment by checking if WidgetsBinding is properly initialized
      // In tests, we'll just log instead of showing UI progress
      await UChatLoading.showProgress(1.0, message: message);
    } catch (e) {
      // In test environments or when UChatLoading is not initialized,
      // silently log the progress message instead of failing
      try {
        log.d('[PROGRESS] $message');
      } catch (_) {
        // Even logging might fail in some test environments, so do nothing
      }
    }
  }

  String _generateRandomString(int length, Random random, {String? customCharacters}) {
    const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final possibleCharacters = customCharacters ?? characters;
    final buffer = StringBuffer();
    for (int i = 0; i < length; i++) {
      buffer.write(possibleCharacters[random.nextInt(possibleCharacters.length)]);
    }
    return buffer.toString();
  }
}
