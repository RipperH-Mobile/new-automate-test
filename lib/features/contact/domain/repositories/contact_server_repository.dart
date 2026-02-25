import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/contact/data/models/requests/add_contact_request.dart';
import 'package:uchat/features/contact/data/models/requests/add_friend_in_group_request.dart';
import 'package:uchat/features/contact/data/models/requests/block_contact_request.dart';
import 'package:uchat/features/contact/data/models/requests/check_if_requesting_friend_request.dart';
import 'package:uchat/features/contact/data/models/requests/decline_friend_request.dart';
import 'package:uchat/features/contact/data/models/requests/get_friend_request_request.dart';
import 'package:uchat/features/contact/data/models/requests/hide_contact_request.dart';
import 'package:uchat/features/contact/data/models/requests/reject_friend_request.dart';
import 'package:uchat/features/contact/data/models/requests/remove_friend_request.dart';
import 'package:uchat/features/contact/data/models/requests/search_contact_request.dart';
import 'package:uchat/features/contact/data/models/requests/unblock_contact_request.dart';
import 'package:uchat/features/contact/data/models/requests/unhide_contact_request.dart';
import 'package:uchat/features/contact/data/models/requests/update_nickname_request.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';

abstract class ContactServerRepository {
  Future<CheckIfRequestingFriendResponse?> checkIfRequestingFriend(CheckIfRequestingFriendRequest request);

  Future<SearchContactResponse> searchContact(SearchContactRequest request);

  Future<AddContactResponse> addContact(AddContactRequest request);

  Future<void> deleteContact(RejectFriendRequest request);

  Future<PaginationPayload<ContactEntity>?> getFriendRequestList(GetFriendRequestRequest request);
  // Future<ContactListResponse> getFriendRequestList();

  Future<bool> removeFriend(RemoveFriendRequest request);

  Future<ContactEntity?> blockContact(BlockContactRequest request);

  Future<void> unblockContact(UnblockContactRequest request);

  Future<ContactEntity?> hideContact(HideContactRequest request);

  Future<void> unHideContact(UnHideContactRequest request);

  Future<void> updateNickname(UpdateNicknameRequest request);

  Future<ContactEntity> addFriendInGroup(AddFriendInGroupRequest request);

  Future<void> declineFriendRequest(DeclineFriendRequest request);
}
