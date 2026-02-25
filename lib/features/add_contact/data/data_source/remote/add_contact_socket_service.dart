import 'package:uchat/api/api.dart';
import 'package:uchat/features/add_contact/data/model/add_contact_group_requested_model.dart';
import 'package:uchat/features/add_contact/data/model/add_contact_invited_model.dart';
import 'package:uchat/features/add_contact/data/model/invited_list_request.dart';
import 'package:uchat/features/add_contact/data/model/requested_list_request.dart';
import 'package:uchat/features/contact/data/models/requests/approve_group_requested_request.dart';
import 'package:uchat/features/contact/data/models/requests/reject_group_requested_request.dart';

class AddContactSocketService {
  final SocketCaller socketCaller;

  AddContactSocketService({required this.socketCaller});

  Future<ApproveGroupRequestedResponse?> approveGroupRequest(
    ApproveGroupRequestedRequest request,
  ) async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.approveGroupRequests.socket,
      request.toMap(),
    );

    return socketResp.mapToResponseV3<ApproveGroupRequestedResponse>(
      (data) => ApproveGroupRequestedResponse.fromMap(data),
    );
  }

  Future<PaginationPayload<AddContactInvitedModel>?> getFriendRequestList(InvitedListRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.getFriendRequests.socket,
      request.toMap(),
    );

    return socketResp.mapToResponse((e) {
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
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.getGroupInvites.socket,
      request.toMap(),
    );

    return socketResp.mapToResponse((e) {
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
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.getGroupRequests.socket,
      request.toMap(),
    );

    return socketResp.mapToResponse((e) {
      return PaginationPayload<AddContactGroupRequestedModel>.fromMapV3(
        e,
        listMapper: (data) {
          List<AddContactGroupRequestedModel> dataList = [];

          for (final item in data) {
            dataList.add(AddContactGroupRequestedModel.fromMap(item));
          }

          return dataList;
        },
      );
    });
  }

  Future<void> rejectGroupRequest(RejectGroupRequestedRequest request) async {
    await socketCaller.emitCallV3(
      BackendPath.rejectGroupRequests.socket,
      request.toMap(),
    );
  }
}
