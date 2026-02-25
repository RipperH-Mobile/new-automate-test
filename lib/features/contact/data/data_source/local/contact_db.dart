import 'package:isar_community/isar.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/features/chat_room/data/models/models/rich_menu_model.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/utils/fast_hash.dart';

final _log = useLogger();

typedef IsarContactCollection = IsarCollection<ContactCollection>;
typedef ContactCollectionList = List<ContactCollection>;
typedef ContactQueryAfterFilter = QueryBuilder<ContactCollection, ContactCollection, QAfterFilterCondition>;

class ContactDb {
  Isar? customDbInstance;

  ContactDb({this.customDbInstance});

  // Start body
  Isar get dbInstance {
    return customDbInstance ?? DbManager().authenticatedInstance!;
  }

  IsarContactCollection get contactCollection {
    return dbInstance.contacts;
  }

  Future<void> putContact(ContactCollection contact) async {
    await dbInstance.writeTxn(() async {
      await contactCollection.put(contact);
    });
  }

  /// For updating few variable in ContactCollection
  Future<ContactCollection?> putOrUpdateContact(ContactCollection contact) async {
    return await dbInstance.writeTxn(() async {
      final localContact = await getContact(contact.id!);
      if (localContact != null) {
        localContact.update(contact);
        await contactCollection.put(localContact);

        return localContact;
      } else {
        await contactCollection.put(contact);

        return contact;
      }
    });
  }

  Future<int> putAllContact(List<ContactCollection> contactList) async {
    return await dbInstance.writeTxn(() async {
      return (await contactCollection.putAll(contactList)).length;
    });
  }

  Future<void> putAllContactWithoutTxn(List<ContactCollection> contacts) async {
    await contactCollection.putAll(contacts);
  }

  Future<void> putContactRichMenu(String contactId, RichMenuModel? richMenu) async {
    await dbInstance.writeTxn(() async {
      final contact = await getContact(contactId);
      if (contact != null) {
        contact.richMenu = richMenu;
        await contactCollection.put(contact);
      }
    });
  }

  Future<ContactCollection?> putContactWithoutTxn(ContactCollection contact) async {
    try {
      final localContact = await getContact(contact.id!);
      if (localContact != null) {
        // if update contact
        localContact.update(contact);
        await contactCollection.put(localContact);
        return localContact;
      } else {
        // if new contact
        await contactCollection.put(contact);
        return contact;
      }
    } catch (e, stacktrace) {
      _log.e('putContactWithoutTxn error', e, stacktrace);
      return null;
    }
  }

  Future<bool> deleteContactWithoutTxn(String id) async {
    return contactCollection.delete(fastHash(id));
  }

  ContactCollection? getContactSync(String id) {
    return contactCollection.getSync(fastHash(id));
  }

  Future<ContactCollection?> getContact(String id) async {
    return contactCollection.get(fastHash(id));
  }

  Future<List<ContactCollection?>> getContactList(List<String> ids) async {
    return await contactCollection.getAll(ids.map((e) => fastHash(e)).toList());
  }

  Future<ContactCollectionList> getOfficialAccountContact() async {
    return contactCollection
        .where()
        .canShowInOfficialAccountListEqualTo(true)
        .sortByNameLowercase()
        .thenByName()
        .thenById()
        .findAll();
  }

  Future<ContactCollectionList> getCanChatWithContact() async {
    return contactCollection.where().canChatWithEqualTo(true).sortByNameLowercase().thenByName().thenById().findAll();
  }

  Future<ContactCollectionList> getCanShowInShareContactSortByDisplayName() async {
    return contactCollection.where().canShowInShareContactEqualTo(true).sortByDisplayName().findAll();
  }

  bool isDirectRoomBlocked(String accountId) {
    return contactCollection.where().isBlockedEqualTo(true).filter().idEqualTo(accountId).findFirstSync() != null;
  }

  bool isDirectRoomVibraniumShield(String accountId) {
    return contactCollection.where().idEqualTo(accountId).filter().vibraniumShieldEqualTo(true).findFirstSync() != null;
  }

  Future<ContactCollectionList> getHiddenContact() async {
    return contactCollection
        .where()
        .isHiddenEqualTo(true)
        .filter()
        .isDeletedEqualTo(false)
        .isFriendEqualTo(true)
        .sortByHiddenAtDesc()
        .thenByName()
        .thenById()
        .findAll();
  }

  Future<ContactCollectionList> getBlockedContact() async {
    return contactCollection
        .where()
        .isBlockedEqualTo(true)
        .filter()
        .isDeletedEqualTo(false)
        .isFriendEqualTo(true)
        .sortByBlockedAtDesc()
        .thenByName()
        .thenById()
        .findAll();
  }

  Future<ContactCollectionList> searchCanChatWithContact(String keyword) async {
    return contactCollection
        .where()
        .canChatWithEqualTo(true)
        .filter()
        .nameContains(keyword, caseSensitive: false)
        .sortByNameLowercase()
        .thenByName()
        .thenById()
        .findAll();
  }

  ContactCollectionList searchCanChatWithContactSync(String keyword) {
    return contactCollection
        .where()
        .canChatWithEqualTo(true)
        .filter()
        .nameContains(keyword, caseSensitive: false)
        .sortByNameLowercase()
        .thenByName()
        .thenById()
        .findAllSync();
  }

  Future<ContactCollectionList> getFriendContact({
    int? limit,
    List<String> notInIds = const [],
  }) async {
    final query = contactCollection
        .where()
        .canShowInFriendListEqualTo(true)
        .filter()
        .not()
        .anyOf(notInIds, (q, element) => q.idEqualTo(element))
        .sortByNameLowercase()
        .thenByName()
        .thenById();

    if (limit != null) {
      return query.limit(limit).findAll();
    }

    return query.findAll();
  }

  ContactCollectionList getFriendContactSync({
    int? limit,
    List<String> notInIds = const [],
  }) {
    final query = contactCollection
        .where()
        .canShowInFriendListEqualTo(true)
        .filter()
        .not()
        .allOf(notInIds, (q, element) => q.idEqualTo(element))
        .sortByNameLowercase()
        .thenByName()
        .thenById();

    if (limit != null) {
      return query.limit(limit).findAllSync();
    }

    return query.findAllSync();
  }

  Future<ContactCollection?> getFriendContactById({
    required String id,
  }) async {
    return contactCollection.where().canShowInFriendListEqualTo(true).filter().idEqualTo(id).findFirst();
  }

  ContactCollection? getFriendContactByIdSync({
    required String id,
  }) {
    return contactCollection.where().canShowInFriendListEqualTo(true).filter().idEqualTo(id).findFirstSync();
  }

  Future<ContactCollectionList> searchFriendContact({required String keyword, int? limit}) async {
    final query = contactCollection
        .where()
        .canShowInFriendSearchEqualTo(true)
        .filter()
        .nameContains(keyword, caseSensitive: false)
        .sortByNameLowercase()
        .thenByName()
        .thenById();

    if (limit != null) {
      return query.limit(limit).findAll();
    } else {
      return query.findAll();
    }
  }

  Future<ContactCollectionList> searchFriendContactIncludePhoneNumber({required String keyword, int? limit}) async {
    final query = contactCollection
        .where()
        .canShowInFriendSearchEqualTo(true)
        .filter()
        .nameContains(keyword, caseSensitive: false)
        .or()
        .phoneNumberContains(keyword, caseSensitive: false)
        .sortByNameLowercase()
        .thenByName()
        .thenById();

    if (limit != null) {
      return query.limit(limit).findAll();
    } else {
      return query.findAll();
    }
  }

  Future<ContactCollectionList> searchOfficialAccountContact({
    required String keyword,
    int? limit,
  }) async {
    final query = contactCollection
        .where()
        .canShowInOfficialAccountSearchEqualTo(true)
        .filter()
        .nameContains(keyword, caseSensitive: false)
        .sortByNameLowercase()
        .thenByName()
        .thenById();
    if (limit != null) {
      return query.limit(limit).findAll();
    } else {
      return query.findAll();
    }
  }

  Future<ContactCollectionList> getAllOnlineFriends() async {
    return contactCollection
        .filter()
        .lastSeenAtGreaterThan(
          DateTime.now().subtract(const Duration(seconds: UChatConstant.secondsInOnlineStatus)),
        )
        .findAll();
  }

  Future<ContactCollectionList> getContactsWithoutPhoneNumber() async {
    return contactCollection.where().phoneNumberIsNull().findAll();
  }

  Future<void> clearCollection() async {
    await contactCollection.clear();
  }
}
