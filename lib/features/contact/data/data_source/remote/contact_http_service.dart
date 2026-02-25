import 'package:uchat/api/api.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/contact/data/models/requests/add_contact_request.dart';
import 'package:uchat/features/contact/data/models/requests/add_friend_in_group_request.dart';
import 'package:uchat/features/contact/data/models/requests/block_contact_request.dart';
import 'package:uchat/features/contact/data/models/requests/check_if_requesting_friend_request.dart';
import 'package:uchat/features/contact/data/models/requests/decline_friend_request.dart';
import 'package:uchat/features/contact/data/models/requests/get_friend_request_request.dart';
import 'package:uchat/features/contact/data/models/requests/hide_contact_request.dart';
import 'package:uchat/features/contact/data/models/requests/remove_friend_request.dart';
import 'package:uchat/features/contact/data/models/requests/search_contact_request.dart';
import 'package:uchat/features/contact/data/models/requests/unblock_contact_request.dart';
import 'package:uchat/features/contact/data/models/requests/unhide_contact_request.dart';
import 'package:uchat/features/contact/data/models/requests/update_nickname_request.dart';

import 'backend_path.dart';

class ContactHttpService {
  final HttpCaller httpCaller;

  ContactHttpService({required this.httpCaller});

  Future<AddContactResponse?> addContact(AddContactRequest request) async {
    final resp = await httpCaller.post(
      addContactPath.http,
      data: request.toMap(),
    );

    return resp.mapToResponse<AddContactResponse>(
      (data) => AddContactResponse.fromMap(data),
    );
  }

  Future<ContactCollection?> addFriendInGroup(AddFriendInGroupRequest request) async {
    final httpRes = await httpCaller.post(
      addFriendInGroupPath.http.replaceAll(':roomId', request.roomId),
      data: request.toMap(),
    );

    return httpRes.mapToResponseV3<ContactCollection>(
      (data) => ContactCollection.fromMap(data),
    );
  }

  // TODO (contact service refactor) after contact is blocked all secret room with this contact should expire immediately. Recheck flow to expire secret chat after blocking friend. see old code in _expireAllSecretChatWithFriendId function in contact_service.dart
  Future<List<ContactCollection?>> blockContact(BlockContactRequest request) async {
    final httpResp = await httpCaller.post(
      blockFriendPath.http,
      data: request.toMap(),
    );

    return httpResp.listToResponseV3((e) => ContactCollection.fromMap(e))?.toList() ?? [];
  }

  Future<void> declineFriendRequest(DeclineFriendRequest request) async {
    await httpCaller.post(
      declineFriendPath.http,
      data: request.toMap(),
    );
  }

  Future<CheckIfRequestingFriendResponse?> checkIfRequestingFriend(CheckIfRequestingFriendRequest request) async {
    final resp = await httpCaller.get(
      checkIfRequestingFriendPath.http,
      data: request.toJson(),
    );

    return resp.mapToResponse<CheckIfRequestingFriendResponse>(
      (data) => CheckIfRequestingFriendResponse.fromJson(data['data']),
    );
  }

  Future<PaginationPayload<ContactCollection>?> getFriendRequestList(GetFriendRequestRequest request) async {
    final socketResp = await httpCaller.get(
      getFriendRequestListPath.http,
      data: request.toJson(),
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
    final httpResp = await httpCaller.post(
      hideFriendPath.http,
      data: request.toMap(),
    );
    return httpResp.listToResponseV3((e) => ContactCollection.fromMap(e))?.toList() ?? [];
  }

  Future<bool> removeFriend(RemoveFriendRequest request) async {
    await httpCaller.post(
      removeFriendPath.http,
      data: request.toMap(),
    );
    // TODO (improve) check response and maybe return response instead ?
    return true;
  }

  Future<SearchContactResponse?> searchContact(SearchContactRequest request) async {
    final resp = await httpCaller.post(
      searchContactPath.http,
      data: request.toMap(),
    );

    return resp.mapToResponse<SearchContactResponse>(
      (data) => SearchContactResponse.fromMap(data),
    );
  }

  Future<void> unHideContact(UnHideContactRequest request) async {
    await httpCaller.post(
      unhideFriendPath.http,
      data: request.toMap(),
    );
  }

  Future<void> unblockContact(UnblockContactRequest request) async {
    await httpCaller.post(
      unblockFriendPath.http,
      data: request.toMap(),
    );
  }

  Future<void> updateNickname(UpdateNicknameRequest request) async {
    await httpCaller.post(
      updateNicknamePath.http.replaceAll(':friendAccountId', request.friendAccountId),
      data: request.toMap(),
    );
  }
}
