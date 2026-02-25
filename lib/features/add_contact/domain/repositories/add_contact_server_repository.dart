import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/add_contact/data/model/add_contact_group_requested_model.dart';
import 'package:uchat/features/add_contact/data/model/add_contact_invited_model.dart';
import 'package:uchat/features/add_contact/data/model/invited_list_request.dart';
import 'package:uchat/features/add_contact/data/model/requested_list_request.dart';
import 'package:uchat/features/contact/data/models/requests/approve_group_requested_request.dart';
import 'package:uchat/features/contact/data/models/requests/reject_group_requested_request.dart';

abstract class AddContactServerRepository {
  Future<ApproveGroupRequestedResponse?> approveGroupRequest(ApproveGroupRequestedRequest request);

  Future<PaginationPayload<AddContactInvitedModel>?> getFriendRequestList(
    InvitedListRequest request,
  );

  Future<PaginationPayload<AddContactInvitedModel>?> getGroupInvitedList(
    InvitedListRequest request,
  );

  Future<PaginationPayload<AddContactGroupRequestedModel>?> getGroupRequestedList(
    GetRequestedListRequest request,
  );

  Future<void> rejectGroupRequest(RejectGroupRequestedRequest request);
}
