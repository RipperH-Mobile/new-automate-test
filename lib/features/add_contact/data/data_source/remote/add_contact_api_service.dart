import 'package:uchat/api/api.dart';
import 'package:uchat/features/add_contact/data/model/add_contact_group_requested_model.dart';
import 'package:uchat/features/add_contact/data/model/add_contact_invited_model.dart';
import 'package:uchat/features/add_contact/data/model/invited_list_request.dart';
import 'package:uchat/features/add_contact/data/model/requested_list_request.dart';
import 'package:uchat/features/contact/data/models/requests/approve_group_requested_request.dart';
import 'package:uchat/features/contact/data/models/requests/reject_group_requested_request.dart';

class AddContactApiService {
  final HttpCaller httpCaller;

  AddContactApiService({
    required this.httpCaller,
  });

  Future<ApproveGroupRequestedResponse?> approveGroupRequest(ApproveGroupRequestedRequest request) async {
    final res = await httpCaller.post(
      BackendPath.approveGroupRequests.http,
      data: request.toMap(),
    );

    return res.mapToResponseV3<ApproveGroupRequestedResponse>(
      (data) => ApproveGroupRequestedResponse.fromMap(data),
    );
  }

  Future<PaginationPayload<AddContactInvitedModel>?> getFriendRequestList(InvitedListRequest request) async {
    final res = await httpCaller.get(
      BackendPath.getFriendRequests.http,
      data: request.toMap(),
    );

    return res.mapToResponse((e) {
      return PaginationPayload<AddContactInvitedModel>.fromMapV3(
        e,
        listMapper: (data) {
          List<AddContactInvitedModel> dataList = [];
          for (final item in data) {
            dataList.add(AddContactInvitedModel.fromMapToFriend(item));
          }
          return dataList;
        },
      );
    });
  }

  Future<PaginationPayload<AddContactInvitedModel>?> getGroupInvitedList(InvitedListRequest request) async {
    final res = await httpCaller.get(
      BackendPath.getGroupInvites.http,
      data: request.toMap(),
    );

    return res.mapToResponse((e) {
      return PaginationPayload<AddContactInvitedModel>.fromMapV3(
        e,
        listMapper: (data) {
          List<AddContactInvitedModel> dataList = [];
          for (final item in data) {
            dataList.add(AddContactInvitedModel.fromMapToGroup(item));
          }
          return dataList;
        },
      );
    });
  }

  Future<PaginationPayload<AddContactGroupRequestedModel>?> getGroupRequestedList(
    GetRequestedListRequest request,
  ) async {
    final res = await httpCaller.get(
      BackendPath.getGroupRequests.http,
      data: request.toMap(),
    );

    return res.mapToResponse((e) {
      return PaginationPayload<AddContactGroupRequestedModel>.fromMapV3(
        e,
        listMapper: (data) {
          return data.map((item) => AddContactGroupRequestedModel.fromMap(item)).toList();
        },
      );
    });
  }

  Future<void> rejectGroupRequest(RejectGroupRequestedRequest request) async {
    await httpCaller.post(
      BackendPath.rejectGroupRequests.http,
      data: request.toMap(),
    );
  }
}
