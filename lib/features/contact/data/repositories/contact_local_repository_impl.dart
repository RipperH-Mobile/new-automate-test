import 'package:uchat/features/chat_room/data/models/models/rich_menu_model.dart';
import 'package:uchat/features/contact/data/data_source/local/contact_db.dart';
import 'package:uchat/features/contact/data/models/mapper/contact_mapper_extensions.dart';
import 'package:uchat/features/contact/data/models/requests/get_friend_contact_request.dart';
import 'package:uchat/features/contact/data/models/requests/search_official_account_contact_request.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/params/search_friend_contact_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';

class ContactLocalRepositoryImpl extends ContactLocalRepository {
  ContactLocalRepositoryImpl({
    required this.contactDb,
  });

  final ContactDb contactDb;

  @override
  ContactEntity? getContactSync(String id) {
    return contactDb.getContactSync(id)?.toEntity();
  }

  @override
  Future<void> putContact(ContactEntity contact) async {
    await contactDb.putContact(contact.toCollection());
  }

  @override
  Future<List<ContactEntity>> getCanChatWithContact() async {
    final contactList = await contactDb.getCanChatWithContact();
    return contactList.toEntities();
  }

  @override
  Future<List<ContactEntity>> searchCanChatWithContact(String query) async {
    final contactList = await contactDb.searchCanChatWithContact(query);
    return contactList.toEntities();
  }

  @override
  Future<ContactEntity?> getContact(String id) async {
    final result = await contactDb.getContact(id);
    return result?.toEntity();
  }

  @override
  Future<List<ContactEntity>> getContactList(List<String> ids) async {
    final result = await contactDb.getContactList(ids);

    return result.map((e) => e?.toEntity()).nonNulls.toList();
  }

  @override
  Future<int> putAllContact(List<ContactEntity> contactList) async {
    return await contactDb.putAllContact(contactList.toCollections());
  }

  @override
  Future<void> putAllContactWithoutTxn(List<ContactEntity> contactList) async {
    final collections = contactList.toCollections();
    return await contactDb.putAllContactWithoutTxn(collections);
  }

  @override
  Future<void> putContactRichMenu(String contactId, RichMenuModel? richMenu) async {
    return await contactDb.putContactRichMenu(contactId, richMenu);
  }

  @override
  Future<ContactEntity?> putContactWithoutTxn(ContactEntity contact) async {
    final result = await contactDb.putContactWithoutTxn(contact.toCollection());
    return result?.toEntity();
  }

  @override
  Future<bool> deleteContactWithoutTxn(String id) async {
    return await contactDb.deleteContactWithoutTxn(id);
  }

  @override
  Future<List<ContactEntity>> getFriendContacts() async {
    final result = await contactDb.getFriendContact();
    return result.toEntities();
  }

  @override
  Future<List<ContactEntity>> getFriendContact(GetFriendContactRequest request) async {
    final result = await contactDb.getFriendContact(limit: request.limit, notInIds: request.notInIds);
    return result.toEntities();
  }

  @override
  Future<ContactEntity?> getFriendContactById(String id) async {
    final result = await contactDb.getFriendContactById(id: id);
    return result?.toEntity();
  }

  @override
  ContactEntity? getFriendContactByIdSync(String id) {
    final result = contactDb.getFriendContactByIdSync(id: id);
    return result?.toEntity();
  }

  @override
  Future<List<ContactEntity>> getOfficialContacts() async {
    final result = await contactDb.getOfficialAccountContact();
    return result.toEntities();
  }

  @override
  Future<List<ContactEntity>> getAllOnlineFriends() async {
    final result = await contactDb.getAllOnlineFriends();
    return result.toEntities();
  }

  @override
  Future<List<ContactEntity>> getHiddenContact() async {
    final collectionList = await contactDb.getHiddenContact();
    return collectionList.toEntities();
  }

  @override
  Future<List<ContactEntity>> getBlockedContact() async {
    final collectionList = await contactDb.getBlockedContact();
    return collectionList.toEntities();
  }

  @override
  Future<List<ContactEntity>> searchFriendContact(SearchFriendContactParams params) async {
    if (params.includePhoneNumber) {
      final result =
          await contactDb.searchFriendContactIncludePhoneNumber(keyword: params.keyword, limit: params.limit);
      return result.toEntities();
    } else {
      final result = await contactDb.searchFriendContact(keyword: params.keyword, limit: params.limit);
      return result.toEntities();
    }
  }

  @override
  Future<List<ContactEntity>> searchOfficialAccountContact(SearchOfficialAccountContactRequest request) async {
    final result = await contactDb.searchOfficialAccountContact(keyword: request.keyword, limit: request.limit);
    return result.toEntities();
  }

  @override
  Future<void> clearCollection() async {
    return await contactDb.clearCollection();
  }

  @override
  Future<List<ContactEntity>> getCanShowInShareContactSortByDisplayName() async {
    final result = await contactDb.getCanShowInShareContactSortByDisplayName();
    return result.toEntities();
  }

  @override
  Future<ContactEntity?> putOrUpdateContact(ContactEntity contact) async {
    final result = await contactDb.putOrUpdateContact(contact.toCollection());
    return result?.toEntity();
  }

  @override
  bool isDirectRoomBlocked(String accountId) {
    return contactDb.isDirectRoomBlocked(accountId);
  }

  @override
  bool isDirectRoomVibraniumShield(String accountId) {
    return contactDb.isDirectRoomVibraniumShield(accountId);
  }

  @override
  Future<List<ContactEntity>> getContactsWithoutPhoneNumber() async {
    final contactCollections = await contactDb.getContactsWithoutPhoneNumber();
    return contactCollections.map((collection) => collection.toEntity()).toList();
  }
}
