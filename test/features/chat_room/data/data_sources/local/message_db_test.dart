import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/data/data_sources/account_service.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/message_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/message_model.dart';

class MockAccountService extends Mock implements AccountService {}

class MockLoggerService extends Mock implements LoggerService {}

class MockUserController extends Mock implements UserController {
  @override
  InternalFinalCallback<void> get onStart => InternalFinalCallback(
        callback: () {},
      );
}

void main() {
  late Isar isar;
  late MessageDb messageDb;
  late MockAccountService mockAccountService;
  late MockLoggerService mockLoggerService;
  late MockUserController mockUserController;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Isar.initializeIsarCore(download: true);

    isar = await Isar.open(
      [MessageCollectionSchema],
      directory: './',
      name: 'message_db_test',
    );

    messageDb = MessageDb(customDbInstance: isar);
    mockAccountService = MockAccountService();
    GetIt.I.registerSingleton<AccountService>(mockAccountService);
    mockLoggerService = MockLoggerService();
    GetIt.I.registerSingleton<LoggerService>(mockLoggerService);
    when(() => mockLoggerService.d(any())).thenReturn(null);
    when(() => mockLoggerService.e(any(), any(), any())).thenReturn(null);
    mockUserController = MockUserController();
    Get.put<UserController>(mockUserController);

    reset(mockUserController);
    reset(mockAccountService);

    // Set up for currentUser call in message mixin to work.
    when(() => mockUserController.currentUser).thenReturn(
      UserEntity(
        id: 'accountId1',
        username: 'user1',
        displayName: 'User 1',
        phoneNumber: '0892345678',
      ).obs,
    );
    when(() => mockAccountService.getUserPublicAvatar(any())).thenReturn('');
  });

  setUp(() async {
    await isar.writeTxn(() async {
      await isar.messages.clear();
    });
  });

  tearDownAll(() async {
    await isar.close(deleteFromDisk: true);
  });

  group('getMessageByRef cases', () {
    test('Given no message in local db, When invoked, Should return null', () async {
      final result = await messageDb.getMessageByRef(ref: 'some-ref');
      expect(result, isNull);
    });

    test('Given some messages in local db, When invoked with ref, Should return message with that ref', () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putMessage(message1);

      // When
      final result = await messageDb.getMessageByRef(ref: 'messageRef1');

      // Then
      expect(result, message1);
    });
  });

  group('getMessageById cases', () {
    test('Given no message in local db, When invoked, Should return null', () async {
      final result = await messageDb.getMessageById(id: 'some-id');
      expect(result, isNull);
    });

    test('Given some messages in local db, When invoked with id, Should return message with that id', () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putMessage(message1);

      // When
      final result = await messageDb.getMessageById(id: 'messageId1');

      // Then
      expect(result, message1);
    });
  });

  group('getReplyMessageById cases', () {
    test('Given no message in local db, When invoked, Should return empty list', () async {
      final result = await messageDb.getReplyMessageById(id: 'some-id');
      expect(result, isEmpty);
    });

    test(
        'Given some messages in local db, When invoked with id, Should return message that have reply message with that id',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId2',
        message: 'message2',
        sequence: 2,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId2',
          username: 'user2',
          displayName: 'User 2',
        ),
        replyMessage: MessageModel(
          id: 'messageId1',
          ref: 'messageRef1',
          roomId: 'roomId1',
          message: 'message1',
          type: MessageType.text,
        ),
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId1',
        accountId: 'accountId2',
        message: 'message2',
        sequence: 3,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId2',
          username: 'user2',
          displayName: 'User 2',
        ),
        replyMessage: MessageModel(
          id: 'messageId2',
          ref: 'messageRef2',
          roomId: 'roomId1',
          message: 'message2',
          type: MessageType.text,
        ),
      );
      await messageDb.putAllMessages([message1, message2, message3]);

      // When
      final result = await messageDb.getReplyMessageById(id: 'messageId1');

      // Then
      expect(result.contains(message1), false);
      expect(result.contains(message2), true);
      expect(result.contains(message3), false);
    });
  });

  group('getBookmarkMessageByOriginalMsgId cases', () {
    test('Given no message in local db, When invoked, Should return null', () async {
      final result = await messageDb.getReplyMessageById(id: 'some-id');
      expect(result, isEmpty);
    });

    test(
        'Given some messages in local db, When invoked with id, Should return message that matching original message id',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId2',
        message: 'message2',
        sequence: 2,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId2',
          username: 'user2',
          displayName: 'User 2',
        ),
        originalMessageId: 'messageId1',
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId1',
        accountId: 'accountId2',
        message: 'message2',
        sequence: 3,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId2',
          username: 'user2',
          displayName: 'User 2',
        ),
        originalMessageId: 'messageId2',
      );
      await messageDb.putAllMessages([message1, message2, message3]);

      // When
      final result = await messageDb.getBookmarkMessageByOriginalMsgId(id: 'messageId1');

      // Then
      expect(result, message2);
    });
  });

  group('putMessage cases', () {
    test('Given no message in local db, When invoked, Should save new message to local db and return the new message',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );

      // When
      final result = await messageDb.putMessage(message1);

      // Then
      expect(result, message1);
      final fetchedMessage = await messageDb.getMessageById(id: 'messageId1');
      expect(fetchedMessage, message1);
    });

    test(
        'Given message is already exist in local db, When invoked with updated message, Should save new data to local db and return the updated message',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putMessage(message1);
      final updatedMessage1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'updated message1',
        type: MessageType.text,
      );

      // When
      final result = await messageDb.putMessage(updatedMessage1);

      // Then
      final correctMessage = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'updated message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      expect(result, correctMessage);
      final fetchedMessage = await messageDb.getMessageById(id: 'messageId1');
      expect(fetchedMessage, correctMessage);
    });

    test(
        'Given message is already exist in local db, When invoked with updated message and replaceData is true, Should save new message to local db and return the new message',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putMessage(message1);
      final updatedMessage1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 1,
        type: MessageType.system,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );

      // When
      final result = await messageDb.putMessage(updatedMessage1);

      // Then
      expect(result, updatedMessage1);
      final fetchedMessage = await messageDb.getMessageById(id: 'messageId1');
      expect(fetchedMessage, updatedMessage1);
    });
  });

  group('putMessageWithoutTxn cases', () {
    test('Given no message in local db, When invoked, Should save new message to local db and return the new message',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );

      // When
      messageDb.customDbInstance?.writeTxn(() async {
        final result = await messageDb.putMessageWithoutTxn(message1);

        // Then
        expect(result, message1);
        final fetchedMessage = await messageDb.getMessageById(id: 'messageId1');
        expect(fetchedMessage, message1);
      });
    });

    test(
        'Given message is already exist in local db, When invoked with updated message, Should save new data to local db and return the updated message',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putMessage(message1);
      final updatedMessage1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'updated message1',
        type: MessageType.text,
      );

      // When
      await messageDb.customDbInstance?.writeTxn(() async {
        final result = await messageDb.putMessageWithoutTxn(updatedMessage1);

        // Then
        final correctMessage = MessageCollection(
          id: 'messageId1',
          ref: 'messageRef1',
          roomId: 'roomId1',
          accountId: 'accountId1',
          message: 'updated message1',
          sequence: 1,
          type: MessageType.text,
          account: ContactModel(
            id: 'accountId1',
            username: 'user1',
            displayName: 'User 1',
          ),
        );
        expect(result, correctMessage);
        final fetchedMessage = await messageDb.getMessageById(id: 'messageId1');
        expect(fetchedMessage, correctMessage);
      });
    });

    test(
        'Given message is already exist in local db, When invoked with updated message and replaceData is true, Should save new message to local db and return the new message',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putMessage(message1);
      final updatedMessage1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 1,
        type: MessageType.system,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );

      // When
      await messageDb.customDbInstance?.writeTxn(() async {
        final result = await messageDb.putMessageWithoutTxn(updatedMessage1);

        // Then
        expect(result, updatedMessage1);
        final fetchedMessage = await messageDb.getMessageById(id: 'messageId1');
        expect(fetchedMessage, updatedMessage1);
      });
    });
  });

  group('putAllMessages cases', () {
    test('Given no message in local db, When invoked, Should save all message in local db', () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message2',
        sequence: 2,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );

      // When
      await messageDb.putAllMessages([message1, message2]);

      // Then
      final fetchedMessage1 = await messageDb.getMessageById(id: 'messageId1');
      final fetchedMessage2 = await messageDb.getMessageById(id: 'messageId2');
      expect(fetchedMessage1, message1);
      expect(fetchedMessage2, message2);
    });
  });

  group('putAllMessagesWithoutTxn cases', () {
    test('Given no message in local db, When invoked, Should save all message in local db', () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message2',
        sequence: 2,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );

      // When
      await messageDb.customDbInstance?.writeTxn(() async {
        await messageDb.putAllMessagesWithoutTxn([message1, message2]);

        // Then
        final fetchedMessage1 = await messageDb.getMessageById(id: 'messageId1');
        final fetchedMessage2 = await messageDb.getMessageById(id: 'messageId2');
        expect(fetchedMessage1, message1);
        expect(fetchedMessage2, message2);
      });
    });
  });

  group('deleteMessageByRefWithoutTxn cases', () {
    test('Given some message in local db, When invoked with ref, Should remove matching message from local db',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message2',
        sequence: 2,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2]);

      // When
      await messageDb.customDbInstance?.writeTxn(() async {
        await messageDb.deleteMessageByRefWithoutTxn(ref: 'messageRef1');
      });

      // Then
      final fetchedMessage1 = await messageDb.getMessageById(id: 'messageId1');
      final fetchedMessage2 = await messageDb.getMessageById(id: 'messageId2');
      expect(fetchedMessage1, isNull);
      expect(fetchedMessage2, message2);
    });
  });

  group('deleteMessageByRef cases', () {
    test('Given some message in local db, When invoked with ref, Should remove matching message from local db',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message2',
        sequence: 2,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2]);

      // When
      await messageDb.deleteMessageByRef(ref: 'messageRef1');

      // Then
      final fetchedMessage1 = await messageDb.getMessageById(id: 'messageId1');
      final fetchedMessage2 = await messageDb.getMessageById(id: 'messageId2');
      expect(fetchedMessage1, isNull);
      expect(fetchedMessage2, message2);
    });
  });

  group('deleteMessageByRoom cases', () {
    test(
        'Given some message in local db, When invoked with roomId, Should remove all message in that room from local db',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message2',
        sequence: 2,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId2',
        accountId: 'accountId1',
        message: 'message3',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2, message3]);

      // When
      await messageDb.deleteMessageByRoom(roomId: 'roomId1');

      // Then
      final fetchedMessage1 = await messageDb.getMessageById(id: 'messageId1');
      final fetchedMessage2 = await messageDb.getMessageById(id: 'messageId2');
      final fetchedMessage3 = await messageDb.getMessageById(id: 'messageId3');
      expect(fetchedMessage1, isNull);
      expect(fetchedMessage2, isNull);
      expect(fetchedMessage3, message3);
    });
  });

  group('deleteMessageByRoomWithoutTxn cases', () {
    test(
        'Given some message in local db, When invoked with roomId, Should remove all message in that room from local db',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message2',
        sequence: 2,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId2',
        accountId: 'accountId1',
        message: 'message3',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2, message3]);

      // When
      await messageDb.customDbInstance?.writeTxn(() async {
        await messageDb.deleteMessageByRoomWithoutTxn(roomId: 'roomId1');
      });

      // Then
      final fetchedMessage1 = await messageDb.getMessageById(id: 'messageId1');
      final fetchedMessage2 = await messageDb.getMessageById(id: 'messageId2');
      final fetchedMessage3 = await messageDb.getMessageById(id: 'messageId3');
      expect(fetchedMessage1, isNull);
      expect(fetchedMessage2, isNull);
      expect(fetchedMessage3, message3);
    });
  });

  group('deleteMessageByRoomWithoutTxnBeforeSequence cases', () {
    test(
        'Given some messages in local db, When invoked with room id and seq, Should remove all message in the specified room that has seq less than or equal the specified seq',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message2',
        sequence: 2,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId2',
        accountId: 'accountId1',
        message: 'message3',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message4',
        sequence: 3,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2, message3, message4]);

      // When
      await messageDb.customDbInstance?.writeTxn(() async {
        await messageDb.deleteMessageByRoomWithoutTxnBeforeSequence(roomId: 'roomId1', lastSequenceFromServer: 2);
      });

      // Then
      final fetchedMessage1 = await messageDb.getMessageById(id: 'messageId1');
      final fetchedMessage2 = await messageDb.getMessageById(id: 'messageId2');
      final fetchedMessage3 = await messageDb.getMessageById(id: 'messageId3');
      final fetchedMessage4 = await messageDb.getMessageById(id: 'messageId4');
      expect(fetchedMessage1, isNull);
      expect(fetchedMessage2, isNull);
      expect(fetchedMessage3, message3);
      expect(fetchedMessage4, message4);
    });
  });

  group('deleteBookmarkMessageByOriginalMsgId cases', () {
    test(
        'Given some messages in local db, When invoked with message id, Should remove bookmark message that have matching original message id',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message2',
        sequence: 2,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        originalMessageId: 'messageId1',
      );
      await messageDb.putAllMessages([message1, message2]);

      // When
      await messageDb.deleteBookmarkMessageByOriginalMsgId(msgId: 'messageId1');

      // Then
      final fetchedMessage1 = await messageDb.getMessageById(id: 'messageId1');
      final fetchedMessage2 = await messageDb.getMessageById(id: 'messageId2');
      expect(fetchedMessage1, message1);
      expect(fetchedMessage2, isNull);
    });
  });

  group('deleteBookmarkMessageByOriginalMsgIdWithoutTxn cases', () {
    test(
        'Given some messages in local db, When invoked with message id, Should remove bookmark message that have matching original message id',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message2',
        sequence: 2,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        originalMessageId: 'messageId1',
      );
      await messageDb.putAllMessages([message1, message2]);

      // When
      await messageDb.customDbInstance?.writeTxn(() async {
        await messageDb.deleteBookmarkMessageByOriginalMsgIdWithoutTxn(msgId: 'messageId1');
      });

      // Then
      final fetchedMessage1 = await messageDb.getMessageById(id: 'messageId1');
      final fetchedMessage2 = await messageDb.getMessageById(id: 'messageId2');
      expect(fetchedMessage1, message1);
      expect(fetchedMessage2, isNull);
    });
  });

  group('deleteBookmarkMessagesByOriginalRoomId cases', () {
    test(
        'Given some messages in local db, When invoked with room id, Should remove all bookmark message from that room',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message2',
        sequence: 2,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        originalMessageId: 'messageId1',
        originalRoomId: 'roomId1',
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message3',
        sequence: 3,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        originalMessageId: 'messageId2',
        originalRoomId: 'roomId1',
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId2',
        accountId: 'accountId1',
        message: 'message4',
        sequence: 4,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        originalMessageId: 'messageId99',
        originalRoomId: 'roomId2',
      );
      await messageDb.putAllMessages([message1, message2, message3, message4]);

      // When
      await messageDb.deleteBookmarkMessagesByOriginalRoomId(roomId: 'roomId1');

      // Then
      final fetchedMessage1 = await messageDb.getMessageById(id: 'messageId1');
      final fetchedMessage2 = await messageDb.getMessageById(id: 'messageId2');
      final fetchedMessage3 = await messageDb.getMessageById(id: 'messageId3');
      final fetchedMessage4 = await messageDb.getMessageById(id: 'messageId4');
      expect(fetchedMessage1, message1);
      expect(fetchedMessage2, isNull);
      expect(fetchedMessage3, isNull);
      expect(fetchedMessage4, message4);
    });
  });

  group('deleteBookmarkMessagesByOriginalRoomIdWithoutTxn cases', () {
    test(
        'Given some messages in local db, When invoked with room id, Should remove all bookmark message from that room',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message2',
        sequence: 2,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        originalMessageId: 'messageId1',
        originalRoomId: 'roomId1',
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message3',
        sequence: 3,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        originalMessageId: 'messageId2',
        originalRoomId: 'roomId1',
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId2',
        accountId: 'accountId1',
        message: 'message4',
        sequence: 4,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        originalMessageId: 'messageId99',
        originalRoomId: 'roomId2',
      );
      await messageDb.putAllMessages([message1, message2, message3, message4]);

      // When
      await messageDb.customDbInstance?.writeTxn(() async {
        await messageDb.deleteBookmarkMessagesByOriginalRoomIdWithoutTxn(roomId: 'roomId1');
      });

      // Then
      final fetchedMessage1 = await messageDb.getMessageById(id: 'messageId1');
      final fetchedMessage2 = await messageDb.getMessageById(id: 'messageId2');
      final fetchedMessage3 = await messageDb.getMessageById(id: 'messageId3');
      final fetchedMessage4 = await messageDb.getMessageById(id: 'messageId4');
      expect(fetchedMessage1, message1);
      expect(fetchedMessage2, isNull);
      expect(fetchedMessage3, isNull);
      expect(fetchedMessage4, message4);
    });
  });

  group('getFirstSequenceByRoom cases', () {
    test('Given no message in local db, When invoked, Should return null', () async {
      final result = await messageDb.getFirstSequenceByRoom(roomId: 'some-room-id');
      expect(result, isNull);
    });

    test('Given some messages in local db, When invoked, Should return the lowest sequence number in that room',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        isSendFailed: true,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message2',
        sequence: 2,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message3',
        sequence: 3,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId2',
        accountId: 'accountId1',
        message: 'message4',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2, message3, message4]);

      // When
      final result = await messageDb.getFirstSequenceByRoom(roomId: 'roomId1');

      // Then
      expect(result, message2);
    });
  });

  group('getLastSequenceByRoom cases', () {
    test('Given no message in local db, When invoked, Should return null', () async {
      final result = await messageDb.getLastSequenceByRoom(roomId: 'some-room-id');
      expect(result, isNull);
    });

    test('Given some messages in local db, When invoked, Should return the highest sequence number in that room',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        isSendFailed: true,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message2',
        sequence: 2,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message3',
        sequence: 3,
        isSendFailed: true,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId2',
        accountId: 'accountId1',
        message: 'message4',
        sequence: 99,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2, message3, message4]);

      // When
      final result = await messageDb.getLastSequenceByRoom(roomId: 'roomId1');

      // Then
      expect(result, message2);
    });
  });

  group('getLastSequenceByRoomSync cases', () {
    test('Given no message in local db, When invoked, Should return null', () {
      final result = messageDb.getLastSequenceByRoomSync(roomId: 'some-room-id');
      expect(result, isNull);
    });

    test('Given some messages in local db, When invoked, Should return the highest sequence number in that room',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        isSendFailed: true,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message2',
        sequence: 2,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message3',
        sequence: 3,
        isSendFailed: true,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId2',
        accountId: 'accountId1',
        message: 'message4',
        sequence: 99,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2, message3, message4]);

      // When
      final result = messageDb.getLastSequenceByRoomSync(roomId: 'roomId1');

      // Then
      expect(result, message2);
    });
  });

  group('getAllSentMessage cases', () {
    test('Given no message in local db, When invoked, Should return empty list', () async {
      final result = await messageDb.getAllSentMessage(roomId: 'some-room-id');
      expect(result, isEmpty);
    });

    test('Given some messages in local db, When invoked with room id, should return all sent message from that room',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message2',
        sequence: 2,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId2',
        accountId: 'accountId1',
        message: 'message3',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId1',
        accountId: 'accountId4',
        message: 'message4',
        sequence: 3,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2, message3, message4]);

      // When
      final result = await messageDb.getAllSentMessage(roomId: 'roomId1');

      // Then
      expect(result, [message4, message2, message1]);
    });

    test(
        'Given some messages in local db, When invoked with room id and limit, should return all sent message from that room',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message2',
        sequence: 2,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId2',
        accountId: 'accountId1',
        message: 'message3',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId1',
        accountId: 'accountId4',
        message: 'message4',
        sequence: 3,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2, message3, message4]);

      // When
      final result = await messageDb.getAllSentMessage(roomId: 'roomId1', limit: 2);

      // Then
      expect(result, [message4, message2]);
    });

    test(
        'Given some messages in local db, When invoked with room id and sequenceLessThan, should return all sent message from that room excluding all message with sequence >= specified sequence',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message2',
        sequence: 2,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId2',
        accountId: 'accountId1',
        message: 'message3',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId1',
        accountId: 'accountId4',
        message: 'message4',
        sequence: 3,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2, message3, message4]);

      // When
      final result = await messageDb.getAllSentMessage(roomId: 'roomId1', sequenceLessThan: 3);

      // Then
      expect(result, [message2, message1]);
    });

    test(
        'Given some messages in local db, When invoked with room id and sequenceGreaterThan, should return all sent message from that room excluding all message with sequence <= specified sequence',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message2',
        sequence: 2,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId2',
        accountId: 'accountId1',
        message: 'message3',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId1',
        accountId: 'accountId4',
        message: 'message4',
        sequence: 3,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2, message3, message4]);

      // When
      final result = await messageDb.getAllSentMessage(roomId: 'roomId1', sequenceGreaterThan: 1);

      // Then
      expect(result, [message4, message2]);
    });

    test(
        'Given some messages in local db, When invoked with room id and isMyNote is true, should return all sent message in my note from that room',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message2',
        sequence: 2,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        isMyNote: true,
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId2',
        accountId: 'accountId1',
        message: 'message3',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message4',
        sequence: 3,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message5 = MessageCollection(
        id: 'messageId5',
        ref: 'messageRef5',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message5',
        sequence: 4,
        type: MessageType.text,
        isMyNote: true,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message6 = MessageCollection(
        id: 'messageId6',
        ref: 'messageRef6',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message6',
        sequence: 5,
        type: MessageType.text,
        isMyNote: true,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2, message3, message4, message5, message6]);

      // When
      final result = await messageDb.getAllSentMessage(roomId: 'roomId1', isMyNote: true);

      // Then
      expect(result, [message6, message5, message2]);
    });

    test(
        'Given some messages in local db, When invoked with room id, sequenceLessThan and isMyNote is true, should return all sent message in my note from that room excluding all message with sequence >= specified sequence',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message2',
        sequence: 2,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        isMyNote: true,
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId2',
        accountId: 'accountId1',
        message: 'message3',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message4',
        sequence: 3,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message5 = MessageCollection(
        id: 'messageId5',
        ref: 'messageRef5',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message5',
        sequence: 4,
        type: MessageType.text,
        isMyNote: true,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message6 = MessageCollection(
        id: 'messageId6',
        ref: 'messageRef6',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message6',
        sequence: 5,
        type: MessageType.text,
        isMyNote: true,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2, message3, message4, message5, message6]);

      // When
      final result = await messageDb.getAllSentMessage(roomId: 'roomId1', sequenceLessThan: 3, isMyNote: true);

      // Then
      expect(result, [message2]);
    });

    test(
        'Given some messages in local db, When invoked with room id, sequenceGreaterThan and isMyNote is true, should return all sent message in my note from that room excluding all message with sequence <= specified sequence',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message2',
        sequence: 2,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        isMyNote: true,
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId2',
        accountId: 'accountId1',
        message: 'message3',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message4',
        sequence: 3,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message5 = MessageCollection(
        id: 'messageId5',
        ref: 'messageRef5',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message5',
        sequence: 4,
        type: MessageType.text,
        isMyNote: true,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message6 = MessageCollection(
        id: 'messageId6',
        ref: 'messageRef6',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message6',
        sequence: 5,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2, message3, message4, message5, message6]);

      // When
      final result = await messageDb.getAllSentMessage(roomId: 'roomId1', sequenceGreaterThan: 3, isMyNote: true);

      // Then
      expect(result, [message5]);
    });
  });

  group('getAllSentMessageWithFile cases', () {
    test('Given no message in local db, When invoked, Should return empty list', () async {
      final result = await messageDb.getAllSentMessageWithFile(roomId: 'some-room-id');
      expect(result, isEmpty);
    });

    test(
        'Given some messages in local db, When invoked with room id, should return all sent message with file from that room',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 2,
        type: MessageType.image,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 3,
        type: MessageType.video,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 4,
        type: MessageType.file,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message5 = MessageCollection(
        id: 'messageId5',
        ref: 'messageRef5',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 5,
        type: MessageType.file,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        isLocked: true,
      );
      final message6 = MessageCollection(
        id: 'messageId6',
        ref: 'messageRef6',
        roomId: 'roomId2',
        accountId: 'accountId1',
        sequence: 1,
        type: MessageType.file,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2, message3, message4, message5, message6]);

      // When
      final result = await messageDb.getAllSentMessageWithFile(roomId: 'roomId1');
      expect(result, [message4, message3, message2]);
    });

    test(
        'Given some messages in local db, When invoked with room id and limit, should return all sent message with file from that room without exceeding limit',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 2,
        type: MessageType.image,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 3,
        type: MessageType.video,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 4,
        type: MessageType.file,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message5 = MessageCollection(
        id: 'messageId5',
        ref: 'messageRef5',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 5,
        type: MessageType.file,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        isLocked: true,
      );
      final message6 = MessageCollection(
        id: 'messageId6',
        ref: 'messageRef6',
        roomId: 'roomId2',
        accountId: 'accountId1',
        sequence: 1,
        type: MessageType.file,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2, message3, message4, message5, message6]);

      // When
      final result = await messageDb.getAllSentMessageWithFile(roomId: 'roomId1', limit: 2);
      expect(result, [message4, message3]);
    });

    test(
        'Given some messages in local db, When invoked with room id and sequenceLessThan, should return all sent message with file from that room with sequence less than the specified value',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 2,
        type: MessageType.image,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        isLocked: true,
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 3,
        type: MessageType.video,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 4,
        type: MessageType.file,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message5 = MessageCollection(
        id: 'messageId5',
        ref: 'messageRef5',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 5,
        type: MessageType.file,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message6 = MessageCollection(
        id: 'messageId6',
        ref: 'messageRef6',
        roomId: 'roomId2',
        accountId: 'accountId1',
        sequence: 1,
        type: MessageType.file,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2, message3, message4, message5, message6]);

      // When
      final result = await messageDb.getAllSentMessageWithFile(roomId: 'roomId1', sequenceLessThan: 5);
      expect(result, [message4, message3]);
    });
  });

  group('getAllSentMessageMediaFiles cases', () {
    test('Given no message in local db, When invoked, Should return empty list', () async {
      final result = await messageDb.getAllSentMessageMediaFiles(roomId: 'some-room-id');
      expect(result, isEmpty);
    });

    test(
        'Given some messages in local db, When invoked with room id, should return all sent message with file from that room',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 2,
        type: MessageType.image,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 3,
        type: MessageType.video,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 4,
        type: MessageType.file,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message5 = MessageCollection(
        id: 'messageId5',
        ref: 'messageRef5',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 5,
        type: MessageType.file,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        isLocked: true,
      );
      final message6 = MessageCollection(
        id: 'messageId6',
        ref: 'messageRef6',
        roomId: 'roomId2',
        accountId: 'accountId1',
        sequence: 1,
        type: MessageType.file,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2, message3, message4, message5, message6]);

      // When
      final result = await messageDb.getAllSentMessageMediaFiles(roomId: 'roomId1');
      expect(result, [message2, message3]);
    });

    test(
        'Given some messages in local db, When invoked with room id and limit, should return all sent message with file from that room without exceeding limit',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 2,
        type: MessageType.image,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 3,
        type: MessageType.video,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 4,
        type: MessageType.file,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message5 = MessageCollection(
        id: 'messageId5',
        ref: 'messageRef5',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 5,
        type: MessageType.file,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        isLocked: true,
      );
      final message6 = MessageCollection(
        id: 'messageId6',
        ref: 'messageRef6',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 6,
        type: MessageType.file,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2, message3, message4, message5, message6]);

      // When
      final result = await messageDb.getAllSentMessageMediaFiles(roomId: 'roomId1', limit: 2);
      expect(result, [message2, message3]);
    });

    test(
        'Given some messages in local db, When invoked with room id and sequenceLessThan, should return all sent message with file from that room with sequence less than the specified value',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        message: 'message1',
        sequence: 1,
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 2,
        type: MessageType.image,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        isLocked: true,
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 3,
        type: MessageType.video,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 4,
        type: MessageType.file,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message5 = MessageCollection(
        id: 'messageId5',
        ref: 'messageRef5',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 5,
        type: MessageType.file,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message6 = MessageCollection(
        id: 'messageId6',
        ref: 'messageRef6',
        roomId: 'roomId2',
        accountId: 'accountId1',
        sequence: 1,
        type: MessageType.file,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2, message3, message4, message5, message6]);

      // When
      final result = await messageDb.getAllSentMessageMediaFiles(roomId: 'roomId1', sequenceLessThan: 5);
      expect(result, [message3]);
    });
  });

  group('getAllSendingMessage cases', () {
    test('Given no message in local db, When invoked, Should return empty list', () async {
      final result = await messageDb.getAllSendingMessage(roomId: 'roomId1');
      expect(result, isEmpty);
    });

    test(
        'Given some message in local db, When invoked with room id, Should return all not sent message from that room sorted by created at',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 1,
        message: 'message1',
        type: MessageType.text,
        createdAt: DateTime(2000, 1, 1, 1),
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 2,
        message: 'message2',
        type: MessageType.text,
        createdAt: DateTime(2000, 1, 1, 2),
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        isSending: true,
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 3,
        message: 'message3',
        type: MessageType.text,
        createdAt: DateTime(2000, 1, 1, 3),
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        isSendFailed: true,
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId2',
        accountId: 'accountId1',
        sequence: 1,
        message: 'message4',
        type: MessageType.text,
        createdAt: DateTime(2000, 1, 1, 4),
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message5 = MessageCollection(
        id: 'messageId5',
        ref: 'messageRef5',
        roomId: 'roomId2',
        accountId: 'accountId1',
        sequence: 2,
        message: 'message5',
        type: MessageType.text,
        createdAt: DateTime(2000, 1, 1, 5),
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        isSendFailed: true,
      );
      final message6 = MessageCollection(
        id: 'messageId6',
        ref: 'messageRef6',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 4,
        message: 'message6',
        type: MessageType.text,
        createdAt: DateTime(2000, 1, 1, 6),
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2, message3, message4, message5, message6]);

      // When
      final result = await messageDb.getAllSendingMessage(roomId: 'roomId1');

      // Then
      expect(result, [message2, message3]);
    });
  });

  group('getAllBookmarkMessages cases', () {});

  group('getAllBookmarkMessagesWithTags cases', () {});

  group('getAllBookmarkMessagesCount cases', () {});

  group('getAllOriginalMessagesOfBookmark cases', () {});

  group('getOriginalMessagesByBookmarkMsgId cases', () {});

  group('searchMessageInRoom cases', () {
    test('Given no message in local db, When invoked, Should return emptyList', () async {
      final result = await messageDb.searchMessageInRoom(roomId: 'some-room-id', keyword: 'some-keyword');
      expect(result, isEmpty);
    });

    test(
        'Given some message in local db, When invoked with room id and keyword, Should return message that contain keyword from that room id',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 1,
        message: 'message1',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 2,
        message: 'message2',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 3,
        message: 'qwerty',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId2',
        accountId: 'accountId1',
        sequence: 1,
        message: 'message4',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2, message3, message4]);

      // When
      final result = await messageDb.searchMessageInRoom(roomId: 'roomId1', keyword: 'message');

      // Then
      expect(result, [message2, message1]);
    });

    test(
        'Given some message in local db, When invoked with room id, keyword, page and pageSize, Should return message that contain keyword from that room id with pagination',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 1,
        message: 'message1',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 2,
        message: 'message2',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 3,
        message: 'qwerty',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId2',
        accountId: 'accountId1',
        sequence: 1,
        message: 'message4',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message5 = MessageCollection(
        id: 'messageId5',
        ref: 'messageRef5',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 4,
        message: 'message5',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2, message3, message4, message5]);

      // When
      final result = await messageDb.searchMessageInRoom(
        roomId: 'roomId1',
        keyword: 'message',
        page: 2,
        pageSize: 2,
      );

      // Then
      expect(result, [message1]);
    });
  });

  group('countMessageInRoom cases', () {
    test('Given no message in local db, When invoked, Should return 0', () async {
      final result = await messageDb.countMessageInRoom(roomId: 'some-room-id', keyword: 'some-keyword');
      expect(result, 0);
    });

    test('Given some messages in local db, When invoked with room id, Should return count of message in that room',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 1,
        message: 'message1',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 2,
        message: 'message2',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 3,
        message: 'message3',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId2',
        accountId: 'accountId1',
        sequence: 1,
        message: 'message4',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2, message3, message4]);

      // When
      final result = await messageDb.countMessageInRoom(roomId: 'roomId1', keyword: '');
      expect(result, 3);
    });

    test(
        'Given some messages in local db, When invoked with room id and keyword, Should return count of message in that room that contain the keyword',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 1,
        message: 'message1',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 2,
        message: 'message2',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 3,
        message: 'message3',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId2',
        accountId: 'accountId1',
        sequence: 1,
        message: 'message4',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2, message3, message4]);

      // When
      final result = await messageDb.countMessageInRoom(roomId: 'roomId1', keyword: '1');
      expect(result, 1);
    });
  });

  group('searchMessageInRoomWithBookmarkTag cases', () {});

  group('searchMessageInAllRoom cases', () {
    test('Given no message in local db, When invoked, Should return empty list', () async {
      final result = await messageDb.searchMessageInAllRoom(keyword: 'some-keyword');
      expect(result, isEmpty);
    });

    test(
        'Given some messages in local db, When invoked with keyword, Should return list of message that contain the keyword',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 1,
        message: 'message1',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 2,
        message: 'message2',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 3,
        message: 'message3',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId2',
        accountId: 'accountId1',
        sequence: 1,
        message: 'message4',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message5 = MessageCollection(
        id: 'messageId5',
        ref: 'messageRef5',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 4,
        message: 'qwerty',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message6 = MessageCollection(
        id: 'messageId6',
        ref: 'messageRef6',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 5,
        message: 'message6',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        isSendFailed: true,
      );
      await messageDb.putAllMessages([message1, message2, message3, message4, message5, message6]);

      // When
      final result = await messageDb.searchMessageInAllRoom(keyword: 'message');
      expect(result, [message4, message1, message2, message3]);
    });

    test(
        'Given some messages in local db, When invoked with keyword, page and pageSize, Should return list of message that contain the keyword with pagination',
        () async {
      // Given
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 1,
        message: 'message1',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 2,
        message: 'message2',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 3,
        message: 'message3',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId2',
        accountId: 'accountId1',
        sequence: 1,
        message: 'message4',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message5 = MessageCollection(
        id: 'messageId5',
        ref: 'messageRef5',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 4,
        message: 'qwerty',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message6 = MessageCollection(
        id: 'messageId6',
        ref: 'messageRef6',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 5,
        message: 'message6',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        isSendFailed: true,
      );
      await messageDb.putAllMessages([message1, message2, message3, message4, message5, message6]);

      // When
      final result = await messageDb.searchMessageInAllRoom(
        keyword: 'message',
        page: 2,
        pageSize: 2,
      );
      expect(result, [message2, message3]);
    });
  });

  group('countMessageFromSequence cases', () {
    test('Given no message in local db, When invoked, Should return 0', () async {
      final result = await messageDb.countMessageFromSequence(
        roomId: 'some-room-id',
        startSequence: 1,
        endSequence: 10,
      );
      expect(result, 0);
    });

    test(
        'Given some message in local db, When invoked, Should return count of message in that room id between specified sequence',
        () async {
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 1,
        message: 'message1',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 2,
        message: 'message2',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 3,
        message: 'message3',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message4 = MessageCollection(
        id: 'messageId4',
        ref: 'messageRef4',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 4,
        message: 'message4',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message5 = MessageCollection(
        id: 'messageId5',
        ref: 'messageRef5',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 5,
        message: 'message5',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        isSendFailed: true,
      );
      final message6 = MessageCollection(
        id: 'messageId6',
        ref: 'messageRef6',
        roomId: 'roomId2',
        accountId: 'accountId1',
        sequence: 2,
        message: 'message6',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      await messageDb.putAllMessages([message1, message2, message3, message4, message5, message6]);

      // When
      final result = await messageDb.countMessageFromSequence(
        roomId: 'roomId1',
        startSequence: 1,
        endSequence: 6,
      );

      // Then
      expect(result, 4);
    });
  });

  group('getAllSendingMessagesAcrossRooms cases', () {
    test('Given no message in local db, When invoked, Should return empty list', () async {
      final result = await messageDb.getAllSendingMessagesAcrossRooms();
      expect(result, isEmpty);
    });

    test('Given some message in local db, When invoked, Should return list of isSending message', () async {
      final message1 = MessageCollection(
        id: 'messageId1',
        ref: 'messageRef1',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 1,
        message: 'message1',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
      );
      final message2 = MessageCollection(
        id: 'messageId2',
        ref: 'messageRef2',
        roomId: 'roomId1',
        accountId: 'accountId1',
        sequence: 2,
        message: 'message2',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        isSending: true,
      );
      final message3 = MessageCollection(
        id: 'messageId3',
        ref: 'messageRef3',
        roomId: 'roomId2',
        accountId: 'accountId1',
        sequence: 1,
        message: 'message3',
        type: MessageType.text,
        account: ContactModel(
          id: 'accountId1',
          username: 'user1',
          displayName: 'User 1',
        ),
        isSending: true,
      );
      await messageDb.putAllMessages([message1, message2, message3]);

      // When
      final result = await messageDb.getAllSendingMessagesAcrossRooms();

      // Then
      expect(result.contains(message1), false);
      expect(result.contains(message2), true);
      expect(result.contains(message3), true);
    });
  });
}
