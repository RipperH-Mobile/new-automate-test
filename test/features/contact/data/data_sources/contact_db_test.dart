import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/data/data_sources/account_service.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/entities/enum/contact_type.dart';
import 'package:uchat/features/contact/data/data_source/local/contact_db.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';

class MockAccountService extends Mock implements AccountService {}

class MockUserController extends Mock implements UserController {
  @override
  InternalFinalCallback<void> get onStart => InternalFinalCallback(
        callback: () {},
      );
}

void main() {
  late Isar isar;
  late ContactDb contactDb;
  late MockAccountService mockAccountService;
  late MockUserController mockUserController;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Isar.initializeIsarCore(download: true);

    isar = await Isar.open(
      [ContactCollectionSchema],
      directory: './',
      name: 'contact_db_test',
    );

    contactDb = ContactDb(customDbInstance: isar);
    mockAccountService = MockAccountService();
    GetIt.I.registerSingleton<AccountService>(mockAccountService);

    mockUserController = MockUserController();
    Get.put<UserController>(mockUserController);

    reset(mockAccountService);
    reset(mockUserController);

    // Set up for currentUser call in contact mixin to work.
    when(() => mockUserController.currentUser).thenReturn(
      UserEntity(
        id: 'userId1',
        username: 'user1',
        displayName: 'User 1',
        phoneNumber: '0892345678',
      ).obs,
    );
  });

  setUp(() async {
    await isar.writeTxn(() async {
      await isar.contacts.clear();
    });
  });

  tearDownAll(() async {
    await isar.close(deleteFromDisk: true);
  });

  group('putOrUpdateContact cases', () {
    test(
        'Given a new ContactCollection, When invoked, Then save data in local db and return that new ContactCollection',
        () async {
      // Given
      final contact = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact.id!)).thenAnswer((_) => '');

      final result = await contactDb.putOrUpdateContact(contact);
      expect(result, contact);

      final fetchedContact = await contactDb.getContact('contact1');
      expect(fetchedContact, isNotNull);
      expect(fetchedContact, contact);
    });

    test(
        'Given there is already ContactCollection in local db, When invoked with the same contact but new data, Then save only new data without affecting other field and return new ContactCollection.',
        () async {
      // Given
      final contact = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact.id!)).thenAnswer((_) => '');
      await contactDb.putOrUpdateContact(contact);
      final updatedContact = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name NEW',
        updatedAt: DateTime(2000, 1, 1, 2),
      );
      final result = await contactDb.putOrUpdateContact(updatedContact);

      final correctContact = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name NEW',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 2),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );

      expect(result, correctContact);

      // When
      final fetchedContact = await contactDb.getContact('contact1');

      // Then
      expect(fetchedContact, isNotNull);
      expect(fetchedContact, correctContact);
    });
  });

  group('putContactWithoutTxn cases', () {
    setUp(() async {
      await isar.writeTxn(() async {
        await isar.contacts.clear();
      });

      // Set up for currentUser call in contact mixin to work.
      when(() => mockUserController.currentUser).thenReturn(
        UserEntity(
          id: 'userId1',
          username: 'user1',
          displayName: 'User 1',
          phoneNumber: '0892345678',
        ).obs,
      );
    });

    test(
        'Given a new ContactCollection, When invoked withoutTxn version, Then save data in local db and return that new ContactCollection',
        () async {
      // Given
      final contact = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact.id!)).thenAnswer((_) => '');

      await contactDb.customDbInstance?.writeTxn(() async {
        final result = await contactDb.putContactWithoutTxn(contact);
        expect(result, contact);
      });

      final fetchedContact = await contactDb.getContact('contact1');
      expect(fetchedContact, isNotNull);
      expect(fetchedContact, contact);
    });

    test(
        'Given there is already ContactCollection in local db, When invoked withoutTxn version with the same contact but new data, Then save only new data without affecting other field and return new ContactCollection.',
        () async {
      // Given
      final contact = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact.id!)).thenAnswer((_) => '');
      await contactDb.putOrUpdateContact(contact);

      // When
      final updatedContact = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name NEW',
        updatedAt: DateTime(2000, 1, 1, 2),
      );
      final correctContact = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name NEW',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 2),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      await contactDb.customDbInstance?.writeTxn(() async {
        final result = await contactDb.putContactWithoutTxn(updatedContact);
        expect(result, correctContact);
      });

      // Then
      final fetchedContact = await contactDb.getContact('contact1');
      expect(fetchedContact, isNotNull);
      expect(fetchedContact, correctContact);
    });
  });

  group('getOfficialAccountContact cases', () {
    test('Given no OA contact in local db, When invoked, Return empty list', () async {
      final result = await contactDb.getOfficialAccountContact();
      expect(result, []);
    });

    test('Given an OA account in local db, When invoked, Return list of 1 OA contact', () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact4 = ContactCollection(
        id: 'contact4',
        displayName: 'contact4 display name',
        username: 'contact4_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact4.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3, contact4]);

      // When
      final result = await contactDb.getOfficialAccountContact();

      // Then
      expect(result, [contact2]);
    });

    test('Given multiple OA account in local db, When invoked, Return list of OA contact sorted by name', () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact4 = ContactCollection(
        id: 'contact4',
        displayName: 'contact4 display name',
        username: 'contact4_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact5 = ContactCollection(
        id: 'contact5',
        displayName: 'contact5 display name',
        username: 'contact5_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact4.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact5.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3, contact4, contact5]);

      // When
      final result = await contactDb.getOfficialAccountContact();

      // Then
      expect(result, [contact2, contact3, contact4]);
    });

    test(
        'Given multiple OA account in local db with same name but different upper / lower case, When invoked, Return list of OA contact sorted by name',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contactA display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contacta display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact4 = ContactCollection(
        id: 'contact4',
        displayName: 'contact4 display name',
        username: 'contact4_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact5 = ContactCollection(
        id: 'contact5',
        displayName: 'contact5 display name',
        username: 'contact5_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact4.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact5.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3, contact4, contact5]);

      // When
      final result = await contactDb.getOfficialAccountContact();

      // Then
      expect(result, [contact4, contact2, contact3]);
    });

    test(
        'Given multiple OA account in local db with exactly same name, When invoked, Return list of OA contact sorted by name then by id',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contactA display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contactA display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact4 = ContactCollection(
        id: 'contact4',
        displayName: 'contact4 display name',
        username: 'contact4_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact5 = ContactCollection(
        id: 'contact5',
        displayName: 'contact5 display name',
        username: 'contact5_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact4.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact5.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3, contact4, contact5]);

      // When
      final result = await contactDb.getOfficialAccountContact();

      // Then
      expect(result, [contact4, contact2, contact3]);
    });
  });

  group('getCanChatWithContact cases', () {
    test('Given no contact in local db, When invoked, Should return empty list', () async {
      // When
      final result = await contactDb.getCanChatWithContact();

      // Then
      expect(result, []);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contact that can chat with excluding OA account',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.getCanChatWithContact();

      // Then
      expect(result, [contact1, contact3]);
    });

    test(
        'Given some contact in local db with same name but different upper / lower case, When invoked, Should return list of contact that can chat with sort by name',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contactA display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contacta display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.getCanChatWithContact();

      // Then
      expect(result, [contact2, contact1, contact3]);
    });

    test(
        'Given some contact in local db with exactly same name, When invoked, Should return list of contact that can chat with sort by name then by id',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contactA display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contactA display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.getCanChatWithContact();

      // Then
      expect(result, [contact2, contact1, contact3]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contact that can chat with excluding blocked account',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        blocked: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.getCanChatWithContact();

      // Then
      expect(result, [contact1, contact3]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contact that can chat with excluding remove friend account',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        originalIsDeleted: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.getCanChatWithContact();

      // Then
      expect(result, [contact1, contact3]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contact that can chat with excluding hidden account',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        hidden: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.getCanChatWithContact();

      // Then
      expect(result, [contact1, contact3]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contact that can chat with excluding not friend account',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: false,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.getCanChatWithContact();

      // Then
      expect(result, [contact1, contact3]);
    });
  });

  group('getCanShowInShareContactSortByDisplayName cases', () {
    test('Given no contact in local db, When invoked, Should return empty list', () async {
      // When
      final result = await contactDb.getCanShowInShareContactSortByDisplayName();

      // Then
      expect(result, []);
    });

    test('Given some contact in local db, When invoked, Should return list of contact that can share message to',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.getCanShowInShareContactSortByDisplayName();

      // Then
      expect(result, [contact1, contact2, contact3]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contact that can chat with excluding blocked account',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        blocked: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.getCanShowInShareContactSortByDisplayName();

      // Then
      expect(result, [contact1, contact3]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contact that can chat with excluding remove friend account',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        originalIsDeleted: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.getCanShowInShareContactSortByDisplayName();

      // Then
      expect(result, [contact1, contact3]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contact that can chat with excluding hidden account',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        hidden: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.getCanShowInShareContactSortByDisplayName();

      // Then
      expect(result, [contact1, contact3]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contact that can chat with excluding not friend account',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: false,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.getCanShowInShareContactSortByDisplayName();

      // Then
      expect(result, [contact1, contact3]);
    });
  });

  group('isDirectRoomBlocked cases', () {
    test(
        'Given some contact in local db, When invoked with contact id that does not exist in local db, Should return false',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1]);

      // When
      final result = contactDb.isDirectRoomBlocked('contact999');

      // Then
      expect(result, false);
    });

    test('Given not blocked contact in local db, When invoked with that contact id, Should return false', () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1]);

      // When
      final result = contactDb.isDirectRoomBlocked('contact1');

      // Then
      expect(result, false);
    });

    test('Given blocked contact in local db, When invoked with that contact id, Should return true', () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        blocked: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1]);

      // When
      final result = contactDb.isDirectRoomBlocked('contact1');

      // Then
      expect(result, true);
    });
  });

  group('isDirectRoomVibraniumShield cases', () {
    test(
        'Given some contact in local db, When invoked with contact id that does not exist in local db, Should return false',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1]);

      // When
      final result = contactDb.isDirectRoomVibraniumShield('contact999');

      // Then
      expect(result, false);
    });

    test('Given not vibraniumShield contact in local db, When invoked with that contact id, Should return false',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1]);

      // When
      final result = contactDb.isDirectRoomVibraniumShield('contact1');

      // Then
      expect(result, false);
    });

    test('Given vibraniumShield contact in local db, When invoked with that contact id, Should return true', () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        vibraniumShield: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1]);

      // When
      final result = contactDb.isDirectRoomVibraniumShield('contact1');

      // Then
      expect(result, true);
    });
  });

  group('getHiddenContact cases', () {
    test('Given no hidden contact in local db, When invoked, Should return empty list', () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1]);

      // When
      final result = await contactDb.getHiddenContact();

      // Then
      expect(result, []);
    });

    test('Given some hidden contact in local db, When invoked, Should return that hidden contacts sorted by hiddenAt',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        hidden: true,
        hiddenAt: DateTime(2000, 1, 1, 3),
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        hidden: true,
        hiddenAt: DateTime(2000, 1, 1, 1),
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        hidden: true,
        hiddenAt: DateTime(2000, 1, 1, 2),
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.getHiddenContact();

      // Then
      expect(result, [contact1, contact3, contact2]);
    });

    test(
        'Given some hidden contact in local db with same hiddenAt, When invoked, Should return that hidden contacts sorted by name',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        hidden: true,
        hiddenAt: DateTime(2000, 1, 1, 1),
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        hidden: true,
        hiddenAt: DateTime(2000, 1, 1, 1),
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        hidden: true,
        hiddenAt: DateTime(2000, 1, 1, 1),
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.getHiddenContact();

      // Then
      expect(result, [contact1, contact2, contact3]);
    });

    test(
        'Given some hidden contact but already remove friend with some contact in local db, When invoked, Should return that hidden contacts excluding removed friend',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        hidden: true,
        hiddenAt: DateTime(2000, 1, 1, 1),
      );
      // Is this case possible ? isFriend true but isDeleted true ?
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        hidden: true,
        hiddenAt: DateTime(2000, 1, 1, 1),
        originalIsDeleted: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: false,
        hidden: true,
        hiddenAt: DateTime(2000, 1, 1, 1),
      );
      final contact4 = ContactCollection(
        id: 'contact4',
        displayName: 'contact4 display name',
        username: 'contact4_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: false,
        hidden: true,
        hiddenAt: DateTime(2000, 1, 1, 1),
        originalIsDeleted: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact4.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3, contact4]);

      // When
      final result = await contactDb.getHiddenContact();

      // Then
      expect(result, [contact1]);
    });
  });

  group('getBlockedContact cases', () {
    test('Given no blocked contact in local db, When invoked, Should return empty list', () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1]);

      // When
      final result = await contactDb.getBlockedContact();

      // Then
      expect(result, []);
    });

    test(
        'Given some blocked contact in local db, When invoked, Should return that blocked contacts sorted by blockedAt',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        blocked: true,
        blockedAt: DateTime(2000, 1, 1, 3),
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        blocked: true,
        blockedAt: DateTime(2000, 1, 1, 1),
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        blocked: true,
        blockedAt: DateTime(2000, 1, 1, 2),
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.getBlockedContact();

      // Then
      expect(result, [contact1, contact3, contact2]);
    });

    test(
        'Given some blocked contact in local db with same hiddenAt, When invoked, Should return that blocked contacts sorted by name',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        blocked: true,
        blockedAt: DateTime(2000, 1, 1, 1),
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        blocked: true,
        blockedAt: DateTime(2000, 1, 1, 1),
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        blocked: true,
        blockedAt: DateTime(2000, 1, 1, 1),
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.getBlockedContact();

      // Then
      expect(result, [contact1, contact2, contact3]);
    });

    test(
        'Given some blocked contact but already remove friend with some contact in local db, When invoked, Should return that blocked contacts excluding removed friend',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        blocked: true,
        blockedAt: DateTime(2000, 1, 1, 1),
      );
      // Is this case possible ? isFriend true but isDeleted true ?
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        blocked: true,
        blockedAt: DateTime(2000, 1, 1, 1),
        originalIsDeleted: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: false,
        blocked: true,
        blockedAt: DateTime(2000, 1, 1, 1),
      );
      final contact4 = ContactCollection(
        id: 'contact4',
        displayName: 'contact4 display name',
        username: 'contact4_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: false,
        blocked: true,
        blockedAt: DateTime(2000, 1, 1, 1),
        originalIsDeleted: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact4.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3, contact4]);

      // When
      final result = await contactDb.getBlockedContact();

      // Then
      expect(result, [contact1]);
    });
  });

  group('searchCanChatWithContact cases', () {
    test('Given no contact in local db, When invoked, Should return empty list', () async {
      // When
      final result = await contactDb.searchCanChatWithContact('');

      // Then
      expect(result, []);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contact that can chat with excluding OA account',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchCanChatWithContact('');

      // Then
      expect(result, [contact1, contact3]);
    });

    test(
        'Given some contact in local db with same name but different upper / lower case, When invoked, Should return list of contact that can chat with sort by name',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contactA display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contacta display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchCanChatWithContact('');

      // Then
      expect(result, [contact2, contact1, contact3]);
    });

    test(
        'Given some contact in local db with exactly same name, When invoked, Should return list of contact that can chat with sort by name then by id',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contactA display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contactA display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchCanChatWithContact('');

      // Then
      expect(result, [contact2, contact1, contact3]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contact that can chat with excluding blocked account',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        blocked: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchCanChatWithContact('');

      // Then
      expect(result, [contact1, contact3]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contact that can chat with excluding remove friend account',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        originalIsDeleted: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchCanChatWithContact('');

      // Then
      expect(result, [contact1, contact3]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contact that can chat with excluding hidden account',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        hidden: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchCanChatWithContact('');

      // Then
      expect(result, [contact1, contact3]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contact that can chat with excluding not friend account',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: false,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchCanChatWithContact('');

      // Then
      expect(result, [contact1, contact3]);
    });

    test(
        'Given some contact in local db, When invoked with search text, Should return list of contact that have displayName that contains search text',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 Display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchCanChatWithContact('2 display');

      // Then
      expect(result, [contact2]);
    });

    test(
        'Given some contact in local db, When invoked with search text, Should return list of contact that have nickname that contains search text',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        nickname: 'Nickname3',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchCanChatWithContact('nick');

      // Then
      expect(result, [contact3]);
    });

    test(
        'Given some contact in local db, When invoked with search text, Should return list of contact that have name that contains search text sort by name',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchCanChatWithContact('contact');

      // Then
      expect(result, [contact1, contact2, contact3]);
    });
  });

  group('searchCanChatWithContactSync cases', () {
    test('Given no contact in local db, When invoked, Should return empty list', () async {
      // When
      final result = contactDb.searchCanChatWithContactSync('');

      // Then
      expect(result, []);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contact that can chat with excluding OA account',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = contactDb.searchCanChatWithContactSync('');

      // Then
      expect(result, [contact1, contact3]);
    });

    test(
        'Given some contact in local db with same name but different upper / lower case, When invoked, Should return list of contact that can chat with sort by name',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contactA display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contacta display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = contactDb.searchCanChatWithContactSync('');

      // Then
      expect(result, [contact2, contact1, contact3]);
    });

    test(
        'Given some contact in local db with exactly same name, When invoked, Should return list of contact that can chat with sort by name then by id',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contactA display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contactA display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = contactDb.searchCanChatWithContactSync('');

      // Then
      expect(result, [contact2, contact1, contact3]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contact that can chat with excluding blocked account',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        blocked: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = contactDb.searchCanChatWithContactSync('');

      // Then
      expect(result, [contact1, contact3]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contact that can chat with excluding remove friend account',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        originalIsDeleted: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = contactDb.searchCanChatWithContactSync('');

      // Then
      expect(result, [contact1, contact3]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contact that can chat with excluding hidden account',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        hidden: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = contactDb.searchCanChatWithContactSync('');

      // Then
      expect(result, [contact1, contact3]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contact that can chat with excluding not friend account',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: false,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = contactDb.searchCanChatWithContactSync('');

      // Then
      expect(result, [contact1, contact3]);
    });

    test(
        'Given some contact in local db, When invoked with search text, Should return list of contact that have displayName that contains search text',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 Display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = contactDb.searchCanChatWithContactSync('2 display');

      // Then
      expect(result, [contact2]);
    });

    test(
        'Given some contact in local db, When invoked with search text, Should return list of contact that have nickname that contains search text',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        nickname: 'Nickname3',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = contactDb.searchCanChatWithContactSync('nick');

      // Then
      expect(result, [contact3]);
    });

    test(
        'Given some contact in local db, When invoked with search text, Should return list of contact that have name that contains search text sort by name',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = contactDb.searchCanChatWithContactSync('contact');

      // Then
      expect(result, [contact1, contact2, contact3]);
    });
  });

  group('getFriendContact cases', () {
    test('Given no contact in local db, When invoked, Should return empty list', () async {
      // When
      final result = await contactDb.getFriendContact();

      // Then
      expect(result, []);
    });

    test('Given some contact in local db, When invoked, Should return list of contacts sort by name', () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.getFriendContact();

      // Then
      expect(result, [contact1, contact2, contact3]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contacts sort by name excluding removed friend or not friend contact',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: false,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        originalIsDeleted: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.getFriendContact();

      // Then
      expect(result, [contact1]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contacts sort by name excluding blocked contact',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        blocked: true,
        blockedAt: DateTime(2000, 1, 1, 1),
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.getFriendContact();

      // Then
      expect(result, [contact1, contact2]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contacts sort by name excluding hidden contact',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        hidden: true,
        hiddenAt: DateTime(2000, 1, 1, 1),
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.getFriendContact();

      // Then
      expect(result, [contact1, contact2]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contacts sort by name excluding official account',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.getFriendContact();

      // Then
      expect(result, [contact1, contact2]);
    });

    test(
        'Given some contact in local db, When invoked with limit, Should return list of contacts with amount not exceeding limit',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.getFriendContact(limit: 2);

      // Then
      expect(result, [contact1, contact2]);
    });

    test(
        'Given some contact in local db, When invoked with notInIds param, Should return list of contacts excluding contacts with ids in notInIds',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.getFriendContact(notInIds: ['contact2', 'contact3']);

      // Then
      expect(result, [contact1]);
    });
  });

  group('getFriendContactSync cases', () {
    test('Given some contact in local db, When invoked, Should return list of contacts sort by name', () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = contactDb.getFriendContactSync();

      // Then
      expect(result, [contact1, contact2, contact3]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contacts sort by name excluding removed friend or not friend contact',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: false,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        originalIsDeleted: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = contactDb.getFriendContactSync();

      // Then
      expect(result, [contact1]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contacts sort by name excluding blocked contact',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        blocked: true,
        blockedAt: DateTime(2000, 1, 1, 1),
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = contactDb.getFriendContactSync();

      // Then
      expect(result, [contact1, contact2]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contacts sort by name excluding hidden contact',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        hidden: true,
        hiddenAt: DateTime(2000, 1, 1, 1),
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = contactDb.getFriendContactSync();

      // Then
      expect(result, [contact1, contact2]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contacts sort by name excluding official account',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = contactDb.getFriendContactSync();

      // Then
      expect(result, [contact1, contact2]);
    });

    test(
        'Given some contact in local db, When invoked with limit, Should return list of contacts with amount not exceeding limit',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = contactDb.getFriendContactSync(limit: 2);

      // Then
      expect(result, [contact1, contact2]);
    });

    test(
        'Given some contact in local db, When invoked with notInIds param, Should return list of contacts excluding contacts with ids in notInIds',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.getFriendContact(notInIds: ['contact2', 'contact3']);

      // Then
      expect(result, [contact1]);
    });
  });

  group('getFriendContactById cases', () {
    test('Given no contact in local db, When invoked, Should return null', () async {
      // When
      final result = await contactDb.getFriendContactById(id: 'contact1');

      // Then
      expect(result, null);
    });

    test('Given some contact in local db, When invoked with existing contact, Should return that contact', () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      await contactDb.putContact(contact1);

      // When
      final result = await contactDb.getFriendContactById(id: 'contact1');

      // Then
      expect(result, contact1);
    });

    test(
        'Given some contact in local db, When invoked with contact id, Should return that contact if it is not removed friend',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      await contactDb.putContact(contact1);

      // When
      final result = await contactDb.getFriendContactById(id: 'contact1');

      // Then
      expect(result, contact1);
    });

    test(
        'Given some contact in local db, When invoked with contact id, Should return that contact if it is not blocked',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        blocked: true,
        blockedAt: DateTime(2000, 1, 1, 1),
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      await contactDb.putContact(contact1);

      // When
      final result = await contactDb.getFriendContactById(id: 'contact1');

      // Then
      expect(result, null);
    });

    test('Given some contact in local db, When invoked with contact id, Should return that contact if it is not hidden',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        hidden: true,
        hiddenAt: DateTime(2000, 1, 1, 1),
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      await contactDb.putContact(contact1);

      // When
      final result = await contactDb.getFriendContactById(id: 'contact1');

      // Then
      expect(result, null);
    });

    test(
        'Given some contact in local db, When invoked with contact id, Should return that contact if it is not official account',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      await contactDb.putContact(contact1);

      // When
      final result = await contactDb.getFriendContactById(id: 'contact1');

      // Then
      expect(result, null);
    });
  });

  group('getFriendContactByIdSync cases', () {
    test('Given no contact in local db, When invoked, Should return null', () async {
      // When
      final result = contactDb.getFriendContactByIdSync(id: 'contact1');

      // Then
      expect(result, null);
    });

    test('Given some contact in local db, When invoked with existing contact, Should return that contact', () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      await contactDb.putContact(contact1);

      // When
      final result = contactDb.getFriendContactByIdSync(id: 'contact1');

      // Then
      expect(result, contact1);
    });

    test(
        'Given some contact in local db, When invoked with contact id, Should return that contact if it is not removed friend',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      await contactDb.putContact(contact1);

      // When
      final result = contactDb.getFriendContactByIdSync(id: 'contact1');

      // Then
      expect(result, contact1);
    });

    test(
        'Given some contact in local db, When invoked with contact id, Should return that contact if it is not blocked',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        blocked: true,
        blockedAt: DateTime(2000, 1, 1, 1),
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      await contactDb.putContact(contact1);

      // When
      final result = contactDb.getFriendContactByIdSync(id: 'contact1');

      // Then
      expect(result, null);
    });

    test('Given some contact in local db, When invoked with contact id, Should return that contact if it is not hidden',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        hidden: true,
        hiddenAt: DateTime(2000, 1, 1, 1),
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      await contactDb.putContact(contact1);

      // When
      final result = contactDb.getFriendContactByIdSync(id: 'contact1');

      // Then
      expect(result, null);
    });

    test(
        'Given some contact in local db, When invoked with contact id, Should return that contact if it is not official account',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      await contactDb.putContact(contact1);

      // When
      final result = contactDb.getFriendContactByIdSync(id: 'contact1');

      // Then
      expect(result, null);
    });
  });

  group('searchFriendContact cases', () {
    test('Given no contact in local db, When invoked, Should return empty list', () async {
      // When
      final result = await contactDb.searchFriendContact(keyword: '');

      // Then
      expect(result, []);
    });

    test('Given some contact in local db, When invoked, Should return list of contacts sort by name', () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchFriendContact(keyword: '');

      // Then
      expect(result, [contact1, contact2, contact3]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contacts sort by name excluding removed friend or not friend contact',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: false,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        originalIsDeleted: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchFriendContact(keyword: '');

      // Then
      expect(result, [contact1]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contacts sort by name excluding blocked contact',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        blocked: true,
        blockedAt: DateTime(2000, 1, 1, 1),
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchFriendContact(keyword: '');

      // Then
      expect(result, [contact1, contact2]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contacts sort by name excluding hidden contact',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        hidden: true,
        hiddenAt: DateTime(2000, 1, 1, 1),
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchFriendContact(keyword: '');

      // Then
      expect(result, [contact1, contact2]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contacts sort by name excluding official account',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchFriendContact(keyword: '');

      // Then
      expect(result, [contact1, contact2]);
    });

    test(
        'Given some contact in local db, When invoked with limit, Should return list of contacts with amount not exceeding limit',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchFriendContact(keyword: '', limit: 2);

      // Then
      expect(result, [contact1, contact2]);
    });

    test(
        'Given some contact in local db, When invoked with keyword, Should return list of contacts that has display name that contain keyword',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 Display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchFriendContact(keyword: '2 display');

      // Then
      expect(result, [contact2]);
    });

    test(
        'Given some contact in local db, When invoked with keyword, Should return list of contacts that has nickname that contain keyword',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        nickname: 'Nickname2',
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchFriendContact(keyword: 'nick');

      // Then
      expect(result, [contact2]);
    });
  });

  group('searchFriendContactIncludePhoneNumber cases', () {
    test('Given no contact in local db, When invoked, Should return empty list', () async {
      // When
      final result = await contactDb.searchFriendContactIncludePhoneNumber(keyword: '');

      // Then
      expect(result, []);
    });

    test('Given some contact in local db, When invoked, Should return list of contacts sort by name', () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchFriendContactIncludePhoneNumber(keyword: '');

      // Then
      expect(result, [contact1, contact2, contact3]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contacts sort by name excluding removed friend or not friend contact',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: false,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        originalIsDeleted: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchFriendContactIncludePhoneNumber(keyword: '');

      // Then
      expect(result, [contact1]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contacts sort by name excluding blocked contact',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        blocked: true,
        blockedAt: DateTime(2000, 1, 1, 1),
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchFriendContactIncludePhoneNumber(keyword: '');

      // Then
      expect(result, [contact1, contact2]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contacts sort by name excluding hidden contact',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        hidden: true,
        hiddenAt: DateTime(2000, 1, 1, 1),
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchFriendContactIncludePhoneNumber(keyword: '');

      // Then
      expect(result, [contact1, contact2]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of contacts sort by name excluding official account',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchFriendContactIncludePhoneNumber(keyword: '');

      // Then
      expect(result, [contact1, contact2]);
    });

    test(
        'Given some contact in local db, When invoked with limit, Should return list of contacts with amount not exceeding limit',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchFriendContactIncludePhoneNumber(keyword: '', limit: 2);

      // Then
      expect(result, [contact1, contact2]);
    });

    test(
        'Given some contact in local db, When invoked with keyword, Should return list of contacts that has display name that contain keyword',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 Display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchFriendContactIncludePhoneNumber(keyword: '2 display');

      // Then
      expect(result, [contact2]);
    });

    test(
        'Given some contact in local db, When invoked with keyword, Should return list of contacts that has nickname that contain keyword',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        nickname: 'Nickname2',
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchFriendContactIncludePhoneNumber(keyword: 'nick');

      // Then
      expect(result, [contact2]);
    });

    test(
        'Given some contact in local db, When invoked with keyword, Should return list of contacts that has phone number that contain keyword',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
          id: 'contact2',
          displayName: 'contact2 display name',
          username: 'contact2_username',
          updatedAt: DateTime(2000, 1, 1, 1),
          createdAt: DateTime(2000, 1, 1, 1),
          originalIsFriend: true,
          nickname: 'Nickname2',
          phoneNumber: '0812345678');
      final contact3 = ContactCollection(
          id: 'contact3',
          displayName: 'contact3 display name',
          username: 'contact3_username',
          updatedAt: DateTime(2000, 1, 1, 1),
          createdAt: DateTime(2000, 1, 1, 1),
          originalIsFriend: true,
          phoneNumber: '0812345679');
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchFriendContactIncludePhoneNumber(keyword: '12345678');

      // Then
      expect(result, [contact2]);
    });
  });

  group('searchOfficialAccountContact cases', () {
    test('Given no contact in local db, When invoked, Should return empty list', () async {
      // When
      final result = await contactDb.searchOfficialAccountContact(keyword: '');

      // Then
      expect(result, []);
    });

    test('Given some contact in local db, When invoked, Should return list of OA contacts sort by name', () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchOfficialAccountContact(keyword: '');

      // Then
      expect(result, [contact1, contact2, contact3]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of OA contacts sort by name excluding removed friend or not friend contact',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: false,
        type: ContactType.official.value,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        originalIsDeleted: true,
        type: ContactType.official.value,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchOfficialAccountContact(keyword: '');

      // Then
      expect(result, [contact1]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of OA contacts sort by name excluding blocked contact',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        blocked: true,
        blockedAt: DateTime(2000, 1, 1, 1),
        type: ContactType.official.value,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchOfficialAccountContact(keyword: '');

      // Then
      expect(result, [contact1, contact2]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of OA contacts sort by name excluding hidden contact',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        hidden: true,
        hiddenAt: DateTime(2000, 1, 1, 1),
        type: ContactType.official.value,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchOfficialAccountContact(keyword: '');

      // Then
      expect(result, [contact1, contact2]);
    });

    test(
        'Given some contact in local db, When invoked, Should return list of OA contacts sort by name excluding normal account',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchOfficialAccountContact(keyword: '');

      // Then
      expect(result, [contact1, contact2]);
    });

    test(
        'Given some contact in local db, When invoked with limit, Should return list of OA contacts with amount not exceeding limit',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchOfficialAccountContact(keyword: '', limit: 2);

      // Then
      expect(result, [contact1, contact2]);
    });

    test(
        'Given some contact in local db, When invoked with keyword, Should return list of OA contacts that has display name that contain keyword',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 Display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchOfficialAccountContact(keyword: '2 display');

      // Then
      expect(result, [contact2]);
    });

    test(
        'Given some contact in local db, When invoked with keyword, Should return list of contacts that has nickname that contain keyword',
        () async {
      // Given
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        nickname: 'Nickname2',
        type: ContactType.official.value,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        originalIsFriend: true,
        type: ContactType.official.value,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.searchOfficialAccountContact(keyword: 'nick');

      // Then
      expect(result, [contact2]);
    });
  });

  group('getAllOnlineFriends cases', () {
    test('Given no contact in local db, When invoked, Should return empty list', () async {
      // When
      final result = await contactDb.getAllOnlineFriends();

      // Then
      expect(result, []);
    });

    test(
        'Given some contact in local db, When invoked, should return contact that has online in the last UChatConstant.secondsInOnlineStatus seconds',
        () async {
      // Given
      final now = DateTime.now();
      final contact1 = ContactCollection(
        id: 'contact1',
        displayName: 'contact1 display name',
        username: 'contact1_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        lastSeenAt: now,
        originalIsFriend: true,
      );
      final contact2 = ContactCollection(
        id: 'contact2',
        displayName: 'contact2 display name',
        username: 'contact2_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        lastSeenAt: now.subtract(const Duration(seconds: 650)),
        originalIsFriend: true,
      );
      final contact3 = ContactCollection(
        id: 'contact3',
        displayName: 'contact3 display name',
        username: 'contact3_username',
        updatedAt: DateTime(2000, 1, 1, 1),
        createdAt: DateTime(2000, 1, 1, 1),
        lastSeenAt: now.subtract(const Duration(seconds: 200)),
        originalIsFriend: true,
      );
      when(() => mockAccountService.getUserPublicAvatar(contact1.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact2.id!)).thenAnswer((_) => '');
      when(() => mockAccountService.getUserPublicAvatar(contact3.id!)).thenAnswer((_) => '');
      await contactDb.putAllContact([contact1, contact2, contact3]);

      // When
      final result = await contactDb.getAllOnlineFriends();

      // Then
      expect(result.contains(contact1), true);
      expect(result.contains(contact3), true);
    });
  });
}
