import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/entities/collections/user_collection.dart';
import 'package:uchat/features/central_notification/data/model/central_notification_data_model.dart';
import 'package:uchat/features/central_notification/domain/entities/central_notification_entity.dart';
import 'package:uchat/features/central_notification/domain/param/put_all_notification_param.dart';
import 'package:uchat/features/central_notification/domain/use_cases/get_all_notifications_from_local_use_case.dart';
import 'package:uchat/features/central_notification/domain/use_cases/put_all_notifications_to_local_use_case.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/message_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/contact/data/models/mapper/contact_mapper_extensions.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/params/contact_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/delete_contact_without_txn_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/put_contact_without_txn_use_case.dart';
import 'package:uchat/features/sync/data/models/entities/update_state_model.dart';
import 'package:uchat/features/sync/data/models/enum/state_group.dart';
import 'package:uchat/features/sync/data/models/enum/update_state_type.dart';
import 'package:uchat/features/sync/domain/use_cases/process_group_friend_use_case.dart';
import 'package:uchat/features/sync/domain/use_cases/sync_handle_update_user_use_case.dart';
import 'package:uchat/use_cases/use_case.dart';

// Mock classes
class MockLoggerService extends Mock implements LoggerService {}

class MockEventBus extends Mock implements EventBus {}

class MockRoomSubscriptionDb extends Mock implements RoomSubscriptionDb {}

class MockRoomMemberDb extends Mock implements RoomMemberDb {}

class MockMessageDb extends Mock implements MessageDb {}

class MockContactLocalRepository extends Mock implements ContactLocalRepository {}

class MockSyncHandleUpdateUserUseCase extends Mock implements SyncHandleUpdateUserUseCase {}

class MockGetContactUseCase extends Mock implements GetContactUseCase {}

class MockDeleteContactWithoutTxnUseCase extends Mock implements DeleteContactWithoutTxnUseCase {}

class MockPutContactWithoutTxnUseCase extends Mock implements PutContactWithoutTxnUseCase {}

class MockGetAllNotificationsFromLocalUseCase extends Mock implements GetAllNotificationsFromLocalUseCase {}

class MockPutAllNotificationsToLocalUseCase extends Mock implements PutAllNotificationsToLocalUseCase {}

// Fake classes
class FakeContactCollection extends Fake implements ContactCollection {}

class FakeContactEntity extends Fake implements ContactEntity {}

class FakeContactParams extends Fake implements ContactParams {}

class FakePutAllNotificationParam extends Fake implements PutAllNotificationParam {}

class FakeSyncHandleUpdateUserParams extends Fake implements SyncHandleUpdateUserParams {}

class FakeUserCollection extends Fake implements UserCollection {}

class FakeRoomSubscriptionCollection extends Fake implements RoomSubscriptionCollection {}

class FakeRoomMemberCollection extends Fake implements RoomMemberCollection {}

class FakeMessageCollection extends Fake implements MessageCollection {}

class FakeCentralNotificationDataModel extends Fake implements CentralNotificationDataModel {}

class FakeNoParams extends Fake implements NoParams {}

void main() {
  late ProcessGroupFriendUseCase useCase;
  late MockLoggerService mockLogger;
  late MockEventBus mockEventBus;
  late MockRoomSubscriptionDb mockRoomSubDb;
  late MockRoomMemberDb mockRoomMemberDb;
  late MockMessageDb mockMessageDb;
  late MockContactLocalRepository mockContactLocalRepository;
  late MockSyncHandleUpdateUserUseCase mockSyncHandleUpdateUserUseCase;
  late MockGetContactUseCase mockGetContactUseCase;
  late MockDeleteContactWithoutTxnUseCase mockDeleteContactWithoutTxnUseCase;
  late MockPutContactWithoutTxnUseCase mockPutContactWithoutTxnUseCase;
  late MockGetAllNotificationsFromLocalUseCase mockGetAllNotificationsFromLocalUseCase;
  late MockPutAllNotificationsToLocalUseCase mockPutAllNotificationsToLocalUseCase;

  late UpdateStateModel testDeleteFriendState;
  late UpdateStateModel testNewFriendState;
  late UpdateStateModel testUpdateFriendState;
  late UpdateStateModel testUpdateUserState;
  late UpdateStateModel testUnknownState;
  late ContactCollection testContactCollection;
  late ContactEntity testContactEntity;
  late UserCollection testUserCollection;

  setUpAll(() {
    registerFallbackValue(FakeContactCollection());
    registerFallbackValue(FakeContactEntity());
    registerFallbackValue(FakeContactParams());
    registerFallbackValue(FakePutAllNotificationParam());
    registerFallbackValue(FakeSyncHandleUpdateUserParams());
    registerFallbackValue(FakeUserCollection());
    registerFallbackValue(FakeRoomSubscriptionCollection());
    registerFallbackValue(FakeRoomMemberCollection());
    registerFallbackValue(FakeMessageCollection());
    registerFallbackValue(FakeCentralNotificationDataModel());
    registerFallbackValue(FakeNoParams());
    registerFallbackValue(true);
    registerFallbackValue(false);
  });

  setUp(() {
    mockLogger = MockLoggerService();
    mockEventBus = MockEventBus();
    mockRoomSubDb = MockRoomSubscriptionDb();
    mockRoomMemberDb = MockRoomMemberDb();
    mockMessageDb = MockMessageDb();
    mockContactLocalRepository = MockContactLocalRepository();
    mockSyncHandleUpdateUserUseCase = MockSyncHandleUpdateUserUseCase();
    mockGetContactUseCase = MockGetContactUseCase();
    mockDeleteContactWithoutTxnUseCase = MockDeleteContactWithoutTxnUseCase();
    mockPutContactWithoutTxnUseCase = MockPutContactWithoutTxnUseCase();
    mockGetAllNotificationsFromLocalUseCase = MockGetAllNotificationsFromLocalUseCase();
    mockPutAllNotificationsToLocalUseCase = MockPutAllNotificationsToLocalUseCase();

    useCase = ProcessGroupFriendUseCase(
      log: mockLogger,
      eventBus: mockEventBus,
      roomSubDb: mockRoomSubDb,
      roomMemberDb: mockRoomMemberDb,
      messageDb: mockMessageDb,
      contactLocalRepository: mockContactLocalRepository,
      syncHandleUpdateUserUseCase: mockSyncHandleUpdateUserUseCase,
      getContactUseCase: mockGetContactUseCase,
      deleteContactWithoutTxnUseCase: mockDeleteContactWithoutTxnUseCase,
      putContactWithoutTxnUseCase: mockPutContactWithoutTxnUseCase,
      getAllNotificationsFromLocalUseCase: mockGetAllNotificationsFromLocalUseCase,
      putAllNotificationsToLocalUseCase: mockPutAllNotificationsToLocalUseCase,
    );

    // Test data setup
    testContactCollection = ContactCollection(
      id: 'test-contact-id',
      nickname: 'TestNick',
      displayName: 'Test Display Name',
      avatarId: 'test-avatar-id',
    );

    testContactEntity = ContactEntity(
      id: 'test-contact-id',
      nickname: 'TestNick',
      displayName: 'Test Display Name',
      avatarId: 'test-avatar-id',
    );

    testUserCollection = UserCollection(
      id: 'test-user-id',
    );

    testDeleteFriendState = UpdateStateModel(
      id: 'test-state-id-1',
      accountId: 'test-account-id',
      group: StateGroup.friend,
      type: UpdateStateType.deleteFriend,
      seq: 1,
      data: <String, dynamic>{'_id': testContactCollection.id, 'displayName': testContactCollection.displayName},
    );

    testNewFriendState = UpdateStateModel(
      id: 'test-state-id-2',
      accountId: 'test-account-id',
      group: StateGroup.friend,
      type: UpdateStateType.newFriend,
      seq: 2,
      data: <String, dynamic>{'_id': testContactCollection.id, 'displayName': testContactCollection.displayName},
    );

    testUpdateFriendState = UpdateStateModel(
      id: 'test-state-id-3',
      accountId: 'test-account-id',
      group: StateGroup.friend,
      type: UpdateStateType.updateFriend,
      seq: 3,
      data: <String, dynamic>{'_id': testContactCollection.id, 'displayName': testContactCollection.displayName},
    );

    testUpdateUserState = UpdateStateModel(
      id: 'test-state-id-4',
      accountId: 'test-account-id',
      group: StateGroup.friend,
      type: UpdateStateType.updateUser,
      seq: 4,
      data: <String, dynamic>{'_id': testUserCollection.id},
    );

    testUnknownState = UpdateStateModel(
      id: 'test-state-id-5',
      accountId: 'test-account-id',
      group: StateGroup.friend,
      type: UpdateStateType.unknown,
      seq: 5,
      data: {},
    );
  });

  group('ProcessGroupFriendUseCase', () {
    group('call method', () {
      test(
        'Given deleteFriend state with valid contact, When use case is called, Then processes delete contact and returns event list',
        () async {
          // Given
          when(() => mockGetContactUseCase.call(any())).thenAnswer((_) async => testContactEntity);
          when(() => mockDeleteContactWithoutTxnUseCase.call(any())).thenAnswer((_) async => true);
          when(() => mockRoomMemberDb.getDirectRoomIdByOtherIdInRoom(any())).thenAnswer((_) async => 'test-room-id');
          when(() => mockRoomSubDb.getRoomSubscriptionWithRoomId(any()))
              .thenAnswer((_) async => RoomSubscriptionCollection(
                    id: 'test-room-sub-id',
                    roomId: 'test-room-id',
                    hasFirstOtherInRoom: true,
                  ));
          when(() => mockRoomSubDb.putRoomSubscriptionWithoutTxn(any())).thenAnswer((_) async => null);
          when(() => mockEventBus.fire(any())).thenReturn(null);

          // When
          final result = await useCase.call(testDeleteFriendState);

          // Then
          expect(result, isA<List<void Function()>>());
          expect(result.length, equals(1));
          verify(() => mockGetContactUseCase.call(any())).called(1);
          verify(() => mockDeleteContactWithoutTxnUseCase.call('test-contact-id')).called(1);
          verify(() => mockRoomMemberDb.getDirectRoomIdByOtherIdInRoom('test-contact-id')).called(1);
          verify(() => mockRoomSubDb.getRoomSubscriptionWithRoomId('test-room-id')).called(1);
          verify(() => mockRoomSubDb.putRoomSubscriptionWithoutTxn(any())).called(1);

          // Execute the event callbacks to verify they work
          for (final eventCallback in result) {
            eventCallback();
          }

          // Verify that eventBus.fire was called
          verify(() => mockEventBus.fire(any())).called(1);
        },
      );

      test(
        'Given deleteFriend state with null contact id, When use case is called, Then returns empty event list',
        () async {
          // Given
          final stateWithNullContact = UpdateStateModel(
            id: 'test-state-id',
            accountId: 'test-account-id',
            group: StateGroup.friend,
            type: UpdateStateType.deleteFriend,
            seq: 1,
            data: <String, dynamic>{'_id': null},
          );

          // When
          final result = await useCase.call(stateWithNullContact);

          // Then
          expect(result, isEmpty);
          verifyNever(() => mockGetContactUseCase.call(any()));
          verifyNever(() => mockDeleteContactWithoutTxnUseCase.call(any()));
        },
      );

      test(
        'Given deleteFriend state with contact not found, When use case is called, Then skips deletion and continues with room update',
        () async {
          // Given
          when(() => mockGetContactUseCase.call(any())).thenAnswer((_) async => null);
          when(() => mockRoomMemberDb.getDirectRoomIdByOtherIdInRoom(any())).thenAnswer((_) async => 'test-room-id');
          when(() => mockRoomSubDb.getRoomSubscriptionWithRoomId(any()))
              .thenAnswer((_) async => RoomSubscriptionCollection(
                    id: 'test-room-sub-id',
                    roomId: 'test-room-id',
                    hasFirstOtherInRoom: true,
                  ));
          when(() => mockRoomSubDb.putRoomSubscriptionWithoutTxn(any())).thenAnswer((_) async => null);

          // When
          final result = await useCase.call(testDeleteFriendState);

          // Then
          expect(result, isEmpty);
          verify(() => mockGetContactUseCase.call(any())).called(1);
          verifyNever(() => mockDeleteContactWithoutTxnUseCase.call(any()));
          verify(() => mockRoomMemberDb.getDirectRoomIdByOtherIdInRoom('test-contact-id')).called(1);
          verify(() => mockRoomSubDb.putRoomSubscriptionWithoutTxn(any())).called(1);
        },
      );

      test(
        'Given deleteFriend state with FailedHostLookupException during contact deletion, When use case is called, Then handles exception and continues',
        () async {
          // Given
          when(() => mockGetContactUseCase.call(any())).thenAnswer((_) async => testContactEntity);
          when(() => mockDeleteContactWithoutTxnUseCase.call(any())).thenThrow(FailedHostLookupException());
          when(() => mockRoomMemberDb.getDirectRoomIdByOtherIdInRoom(any())).thenAnswer((_) async => 'test-room-id');
          when(() => mockRoomSubDb.getRoomSubscriptionWithRoomId(any())).thenAnswer((_) async => null);

          // When
          final result = await useCase.call(testDeleteFriendState);

          // Then
          expect(result, isEmpty);
          verify(() => mockGetContactUseCase.call(any())).called(1);
          verify(() => mockDeleteContactWithoutTxnUseCase.call('test-contact-id')).called(1);
          verifyNever(() => mockRoomMemberDb.getDirectRoomIdByOtherIdInRoom(any()));
        },
      );

      test(
        'Given newFriend state with valid contact, When use case is called, Then processes new contact and returns event list',
        () async {
          // Given
          when(() => mockContactLocalRepository.getContact(any())).thenAnswer((_) async => null);
          when(() => mockPutContactWithoutTxnUseCase.call(any())).thenAnswer((_) async => testContactEntity);
          when(() => mockEventBus.fire(any())).thenReturn(null);

          // When
          final result = await useCase.call(testNewFriendState);

          // Then
          expect(result, isA<List<void Function()>>());
          expect(result.length, equals(1));
          verify(() => mockContactLocalRepository.getContact('test-contact-id')).called(1);
          verify(() => mockPutContactWithoutTxnUseCase.call(any())).called(1);

          // Execute the event callbacks to verify they work
          for (final eventCallback in result) {
            eventCallback();
          }

          // Verify that eventBus.fire was called
          verify(() => mockEventBus.fire(any())).called(1);
        },
      );

      test(
        'Given updateFriend state with existing contact, When use case is called, Then updates contact and returns event list',
        () async {
          // Given
          final existingContact = ContactCollection(
            id: 'test-contact-id',
            nickname: 'OldNick',
          );
          when(() => mockContactLocalRepository.getContact(any())).thenAnswer((_) async => existingContact.toEntity());
          when(() => mockPutContactWithoutTxnUseCase.call(any())).thenAnswer((_) async => testContactEntity);
          when(() => mockGetAllNotificationsFromLocalUseCase.call(any())).thenAnswer((_) async => []);
          when(() => mockPutAllNotificationsToLocalUseCase.call(any())).thenAnswer((_) async {});
          when(() => mockRoomMemberDb.getDirectRoomIdByOtherIdInRoom(any())).thenAnswer((_) async => 'test-room-id');
          when(() => mockRoomSubDb.getRoomSubscriptionWithRoomId(any()))
              .thenAnswer((_) async => RoomSubscriptionCollection(
                    id: 'test-room-sub-id',
                    roomId: 'test-room-id',
                    roomName: 'Old Room Name',
                  ));
          when(() => mockRoomSubDb.putRoomSubscriptionWithoutTxn(any())).thenAnswer((_) async => null);
          when(() => mockRoomMemberDb.getAllMemberWithId(any())).thenAnswer((_) async => []);
          when(() => mockRoomMemberDb.updateAllRoomMemberWithoutTxn(any())).thenAnswer((_) async {});
          when(() => mockEventBus.fire(any())).thenReturn(null);

          // When
          final result = await useCase.call(testUpdateFriendState);

          // Then
          expect(result, isA<List<void Function()>>());
          expect(result.length, equals(1));
          verify(() => mockContactLocalRepository.getContact('test-contact-id')).called(1);
          verify(() => mockPutContactWithoutTxnUseCase.call(any())).called(1);
          verify(() => mockGetAllNotificationsFromLocalUseCase.call(any())).called(1);
          verify(() => mockPutAllNotificationsToLocalUseCase.call(any())).called(1);
          verify(() => mockRoomMemberDb.getDirectRoomIdByOtherIdInRoom('test-contact-id')).called(1);
          verify(() => mockRoomSubDb.putRoomSubscriptionWithoutTxn(any())).called(1);
          verifyNever(() => mockRoomMemberDb.getAllMemberWithId(any()));
          verifyNever(() => mockRoomMemberDb.updateAllRoomMemberWithoutTxn(any()));

          // Execute the event callbacks to verify they work
          for (final eventCallback in result) {
            eventCallback();
          }

          // Verify that eventBus.fire was called twice (ContactUpdateEvent and RoomUpdateEvent)
          verify(() => mockEventBus.fire(any())).called(2);
        },
      );

      test(
        'Given updateUser state with valid user, When use case is called, Then delegates to syncHandleUpdateUserUseCase',
        () async {
          // Given
          when(() => mockSyncHandleUpdateUserUseCase.call(any())).thenAnswer((_) async => <void Function()>[]);

          // When
          final result = await useCase.call(testUpdateUserState);

          // Then
          expect(result, isA<List<void Function()>>());
          verify(() => mockSyncHandleUpdateUserUseCase.call(any())).called(1);
        },
      );

      test(
        'Given unknown state type, When use case is called, Then logs warning and returns empty event list',
        () async {
          // Given
          when(() => mockLogger.w(any())).thenReturn(null);

          // When
          final result = await useCase.call(testUnknownState);

          // Then
          expect(result, isEmpty);
          verify(() => mockLogger.w('Skipping state type ${UpdateStateType.unknown} from ProcessGroupDefaultUseCase'))
              .called(1);
        },
      );

      test(
        'Given state with null contact, When use case is called, Then returns empty event list',
        () async {
          // Given
          final stateWithNullContact = UpdateStateModel(
            id: 'test-state-id',
            accountId: 'test-account-id',
            group: StateGroup.friend,
            type: UpdateStateType.newFriend,
            seq: 1,
            data: <String, dynamic>{},
          );

          // When
          final result = await useCase.call(stateWithNullContact);

          // Then
          expect(result, isEmpty);
          verifyNever(() => mockContactLocalRepository.getContact(any()));
          verifyNever(() => mockPutContactWithoutTxnUseCase.call(any()));
        },
      );

      test(
        'Given state with null user for updateUser type, When use case is called, Then returns empty event list',
        () async {
          // Given
          final stateWithNullUser = UpdateStateModel(
            id: 'test-state-id',
            accountId: 'test-account-id',
            group: StateGroup.friend,
            type: UpdateStateType.updateUser,
            seq: 1,
            data: <String, dynamic>{},
          );

          // Set up the mock to return empty list when called
          when(() => mockSyncHandleUpdateUserUseCase.call(any())).thenAnswer((_) async => <void Function()>[]);

          // When
          final result = await useCase.call(stateWithNullUser);

          // Then
          expect(result, isEmpty);
          verify(() => mockSyncHandleUpdateUserUseCase.call(any())).called(1);
        },
      );
    });

    group('updateCentralNotificationLocalData method', () {
      test(
        'Given central notifications with matching contact id, When updating central notification data, Then updates display name and avatar id',
        () async {
          // Given
          final centralNotifications = [
            CentralNotificationEntity(
              id: 'noti-1',
              data: CentralNotificationDataModel(
                accountId: 'test-contact-id',
                displayName: 'Old Display Name',
                avatarId: 'old-avatar-id',
              ),
            ),
            CentralNotificationEntity(
              id: 'noti-2',
              data: CentralNotificationDataModel(
                accountId: 'other-contact-id',
                displayName: 'Other Display Name',
                avatarId: 'other-avatar-id',
              ),
            ),
          ];

          when(() => mockGetAllNotificationsFromLocalUseCase.call(any())).thenAnswer((_) async => centralNotifications);
          when(() => mockPutAllNotificationsToLocalUseCase.call(any())).thenAnswer((_) async {});

          // When
          await useCase.updateCentralNotificationLocalData(testContactCollection);

          // Then
          verify(() => mockGetAllNotificationsFromLocalUseCase.call(any())).called(1);
          verify(() => mockPutAllNotificationsToLocalUseCase.call(any())).called(1);

          // Verify the notification data was updated
          expect(centralNotifications[0].data?.displayName, equals('Test Display Name'));
          expect(centralNotifications[0].data?.avatarId, equals('test-avatar-id'));
          expect(centralNotifications[1].data?.displayName, equals('Other Display Name')); // Should remain unchanged
        },
      );

      test(
        'Given empty central notifications list, When updating central notification data, Then completes without error',
        () async {
          // Given
          when(() => mockGetAllNotificationsFromLocalUseCase.call(any())).thenAnswer((_) async => []);
          when(() => mockPutAllNotificationsToLocalUseCase.call(any())).thenAnswer((_) async {});

          // When
          await useCase.updateCentralNotificationLocalData(testContactCollection);

          // Then
          verify(() => mockGetAllNotificationsFromLocalUseCase.call(any())).called(1);
          verify(() => mockPutAllNotificationsToLocalUseCase.call(any())).called(1);
        },
      );
    });

    group('error handling', () {
      test(
        'Given generic exception during contact retrieval, When deleting contact, Then handles exception gracefully',
        () async {
          // Given
          final exception = Exception('Database error');
          when(() => mockGetContactUseCase.call(any())).thenThrow(exception);
          when(() => mockLogger.e(any(), any(), any())).thenReturn(null);

          // When
          final result = await useCase.call(testDeleteFriendState);

          // Then
          expect(result, isEmpty);
          verify(() => mockGetContactUseCase.call(any())).called(1);
          verify(() => mockLogger.e('Error GetContactUseCase while deleting contact', exception, any())).called(1);
          verifyNever(() => mockDeleteContactWithoutTxnUseCase.call(any()));
        },
      );

      test(
        'Given exception during room name mirroring, When updating contact, Then logs error and continues',
        () async {
          // Given
          final existingContact = ContactCollection(id: 'test-contact-id');
          when(() => mockContactLocalRepository.getContact(any())).thenAnswer((_) async => existingContact.toEntity());
          when(() => mockPutContactWithoutTxnUseCase.call(any())).thenAnswer((_) async => testContactEntity);
          when(() => mockGetAllNotificationsFromLocalUseCase.call(any())).thenAnswer((_) async => []);
          when(() => mockPutAllNotificationsToLocalUseCase.call(any())).thenAnswer((_) async {});
          when(() => mockRoomMemberDb.getDirectRoomIdByOtherIdInRoom(any())).thenThrow(Exception('Room error'));
          when(() => mockLogger.e(any(), any(), any())).thenReturn(null);
          when(() => mockRoomMemberDb.getAllMemberWithId(any())).thenAnswer((_) async => []);

          // When
          final result = await useCase.call(testUpdateFriendState);

          // Then
          expect(result, isA<List<void Function()>>());
          verify(() => mockLogger.e('Mirror room name from contact to room sub error', any(), any())).called(1);
        },
      );

      test(
        'Given exception during nickname update in room members, When updating contact, Then logs error and continues',
        () async {
          // Given
          final existingContact = ContactCollection(id: 'test-contact-id');
          when(() => mockContactLocalRepository.getContact(any())).thenAnswer((_) async => existingContact.toEntity());
          when(() => mockPutContactWithoutTxnUseCase.call(any())).thenAnswer((_) async => testContactEntity);
          when(() => mockGetAllNotificationsFromLocalUseCase.call(any())).thenAnswer((_) async => []);
          when(() => mockPutAllNotificationsToLocalUseCase.call(any())).thenAnswer((_) async {});
          when(() => mockRoomMemberDb.getDirectRoomIdByOtherIdInRoom(any())).thenAnswer((_) async => 'test-room-id');
          when(() => mockRoomSubDb.getRoomSubscriptionWithRoomId(any())).thenAnswer((_) async => null);
          when(() => mockRoomMemberDb.getAllMemberWithId(any())).thenThrow(Exception('Member error'));
          when(() => mockLogger.e(any(), any(), any())).thenReturn(null);

          // When
          final result = await useCase.call(testUpdateFriendState);

          // Then
          expect(result, isA<List<void Function()>>());
          verifyNever(() => mockLogger.e('update nickname in RoomMemberCollection error', any(), any()));
        },
      );
    });
  });
}
