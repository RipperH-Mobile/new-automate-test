import 'package:uchat/api/api.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
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

import 'backend_path.dart';

class ContactSocketService {
  final SocketCaller socketCaller;

  ContactSocketService({required this.socketCaller});

  Future<AddContactResponse?> addContact(AddContactRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      addContactPath.socket,
      request.toMap(),
    );

    return socketResp.mapToResponseV3<AddContactResponse>(
      (data) => AddContactResponse.fromMap(data),
    );
  }

  Future<ContactCollection?> addFriendInGroup(AddFriendInGroupRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      addFriendInGroupPath.socket,
      request.toMap(),
    );

    return socketResp.mapToResponseV3<ContactCollection>(
      (data) => ContactCollection.fromMap(data),
    );
  }

  // TODO (contact service refactor) after contact is blocked all secret room with this contact should expire immediately. Recheck flow to expire secret chat after blocking friend. see old code in _expireAllSecretChatWithFriendId function in contact_service.dart
  Future<List<ContactCollection?>> blockContact(BlockContactRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      blockFriendPath.socket,
      request.toMap(),
    );

    return socketResp.listToResponseV3((e) => ContactCollection.fromMap(e))?.toList() ?? [];
  }

  Future<void> declineFriendRequest(DeclineFriendRequest request) async {
    await socketCaller.emitCallV3(
      declineFriendPath.socket,
      request.toMap(),
    );
  }

  // Unused function
  Future<void> deleteContact(RejectFriendRequest request) async {
    await socketCaller.emitCall(
      deleteContactPath.socket,
      request.toMap(),
    );
  }

  Future<CheckIfRequestingFriendResponse?> checkIfRequestingFriend(CheckIfRequestingFriendRequest request) async {
    final resp = await socketCaller.emitCallV3(
      checkIfRequestingFriendPath.socket,
      request.toJson(),
    );

    return resp.mapToResponseV3<CheckIfRequestingFriendResponse>(
      (data) => CheckIfRequestingFriendResponse.fromJson(data),
    );
  }

  Future<PaginationPayload<ContactCollection>?> getFriendRequestList(GetFriendRequestRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      getFriendRequestListPath.socket,
      request.toJson(),
    );

    return socketResp.mapToResponse((e) {
      return PaginationPayload<ContactCollection>.fromMapV3(
        e,
        listMapper: (data) {
          List<ContactCollection> dataList = [];

          for (final item in data) {
            dataList.add(ContactCollection.fromMap(item));
          }

          return dataList;
        },
      );
    });
  }

  Future<List<ContactCollection?>> hideContact(HideContactRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      hideFriendPath.socket,
      request.toMap(),
    );
    return socketResp.listToResponseV3((e) => ContactCollection.fromMap(e))?.toList() ?? [];
  }

  Future<bool> removeFriend(RemoveFriendRequest request) async {
    await socketCaller.emitCall(
      removeFriendPath.socket,
      request.toMap(),
    );

    // TODO (improve) check response and maybe return response instead ?
    return true;
  }

  Future<SearchContactResponse?> searchContact(SearchContactRequest request) async {
    final socketResp = await socketCaller.emitCall(
      searchContactPath.socket,
      request.toMap(),
    );

    return socketResp.mapToResponse<SearchContactResponse>(
      (data) => SearchContactResponse.fromMap(data),
    );
  }

  Future<void> unHideContact(UnHideContactRequest request) async {
    await socketCaller.emitCallV3(
      unhideFriendPath.socket,
      request.toMap(),
    );
  }

  Future<void> unblockContact(UnblockContactRequest request) async {
    await socketCaller.emitCallV3(
      unblockFriendPath.socket,
      request.toMap(),
    );
  }

  Future<void> updateNickname(UpdateNicknameRequest request) async {
    await socketCaller.emitCallV3(
      updateNicknamePath.socket,
      request.toMap(),
    );
  }
}
