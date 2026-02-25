import 'package:uchat/features/chat_room/data/models/models/rich_menu_model.dart';
import 'package:uchat/features/contact/data/models/requests/get_friend_contact_request.dart';
import 'package:uchat/features/contact/data/models/requests/search_official_account_contact_request.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/params/search_friend_contact_params.dart';

abstract class ContactLocalRepository {
  ContactEntity? getContactSync(String id);

  Future<void> putContact(ContactEntity contact);

  Future<int> putAllContact(List<ContactEntity> contactList);

  Future<ContactEntity?> putOrUpdateContact(ContactEntity contact);

  /// Return a list of contacts that can chat
  Future<List<ContactEntity>> getCanChatWithContact();

  /// Search for contacts by [query]
  Future<List<ContactEntity>> searchCanChatWithContact(String query);

  /// Get a single contact by ID (async version)
  Future<ContactEntity?> getContact(String id);

  Future<List<ContactEntity>> getContactList(List<String> ids);

  Future<List<ContactEntity>> getFriendContacts();

  Future<List<ContactEntity>> getOfficialContacts();

  Future<List<ContactEntity>> getAllOnlineFriends();

  Future<List<ContactEntity>> searchFriendContact(SearchFriendContactParams params);

  Future<List<ContactEntity>> searchOfficialAccountContact(SearchOfficialAccountContactRequest request);

  Future<List<ContactEntity>> getCanShowInShareContactSortByDisplayName();

  Future<ContactEntity?> getFriendContactById(String id);

  ContactEntity? getFriendContactByIdSync(String id);

  Future<void> clearCollection();

  Future<void> putAllContactWithoutTxn(List<ContactEntity> contactList);

  Future<void> putContactRichMenu(String contactId, RichMenuModel? richMenu);

  Future<ContactEntity?> putContactWithoutTxn(ContactEntity contact);

  Future<bool> deleteContactWithoutTxn(String id);

  Future<List<ContactEntity>> getFriendContact(GetFriendContactRequest request);

  Future<List<ContactEntity>> getBlockedContact();

  Future<List<ContactEntity>> getHiddenContact();

  bool isDirectRoomBlocked(String accountId);

  bool isDirectRoomVibraniumShield(String accountId);

  Future<List<ContactEntity>> getContactsWithoutPhoneNumber();
}
