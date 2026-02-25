import 'package:get_it/get_it.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/features/add_contact/data/data_source/remote/add_contact_api_service.dart';
import 'package:uchat/features/add_contact/data/data_source/remote/add_contact_socket_service.dart';
import 'package:uchat/features/add_contact/data/model/add_contact_group_requested_model.dart';
import 'package:uchat/features/add_contact/data/model/add_contact_invited_model.dart';
import 'package:uchat/features/add_contact/data/model/invited_list_request.dart';
import 'package:uchat/features/add_contact/data/model/requested_list_request.dart';
import 'package:uchat/features/add_contact/domain/repositories/add_contact_server_repository.dart';
import 'package:uchat/features/contact/data/models/requests/approve_group_requested_request.dart';
import 'package:uchat/features/contact/data/models/requests/reject_group_requested_request.dart';

final _log = useLogger();

class AddContactServerRepositoryImpl implements AddContactServerRepository {
  SocketCaller get socketCaller {
    return GetIt.I<SocketCaller>();
  }

  AddContactApiService get addContactApiService {
    return GetIt.I<AddContactApiService>();
  }

  AddContactSocketService get addContactSocketService {
    return GetIt.I<AddContactSocketService>();
  }

  @override
  Future<ApproveGroupRequestedResponse?> approveGroupRequest(ApproveGroupRequestedRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await addContactSocketService.approveGroupRequest(request);

        if (socketResp != null) {
          return socketResp;
        }

        return null;
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('approveGroupRequest with socket error. fallback to http request...', e, stackTrace);
      }
    }

    try {
      final httpResp = await addContactApiService.approveGroupRequest(request);

      if (httpResp != null) {
        return httpResp;
      }

      return null;
    } catch (e, stackTrace) {
      _log.e('approveGroupRequest with http error', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<PaginationPayload<AddContactInvitedModel>?> getFriendRequestList(
    InvitedListRequest request,
  ) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await addContactSocketService.getFriendRequestList(request);

        if (socketResp != null) {
          return socketResp;
        }

        return null;
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('getFriendRequestList with socket error. fallback to http request...', e, stackTrace);
      }
    }

    try {
      final httpResp = await addContactApiService.getFriendRequestList(request);

      if (httpResp != null) {
        return httpResp;
      }

      return null;
    } catch (e, stackTrace) {
      _log.e('getFriendRequestList with http error', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<PaginationPayload<AddContactInvitedModel>?> getGroupInvitedList(
    InvitedListRequest request,
  ) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await addContactSocketService.getGroupInvitedList(request);

        if (socketResp != null) {
          return socketResp;
        }

        return null;
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('getInvitedList with socket error. fallback to http request...', e, stackTrace);
      }
    }

    try {
      final httpResp = await addContactApiService.getGroupInvitedList(request);

      if (httpResp != null) {
        return httpResp;
      }

      return null;
    } catch (e, stackTrace) {
      _log.e('getInvitedList with http error', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<PaginationPayload<AddContactGroupRequestedModel>?> getGroupRequestedList(
    GetRequestedListRequest request,
  ) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await addContactSocketService.getGroupRequestedList(request);

        if (socketResp != null) {
          return socketResp;
        }

        return null;
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('getGroupRequestedList with socket error. fallback to http request...', e, stackTrace);
      }
    }

    try {
      final httpResp = await addContactApiService.getGroupRequestedList(request);

      if (httpResp != null) {
        return httpResp;
      }

      return null;
    } catch (e, stackTrace) {
      _log.e('getGroupRequestedList with http error', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> rejectGroupRequest(RejectGroupRequestedRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await addContactSocketService.rejectGroupRequest(request);
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('rejectGroupRequest with socket error. fallback to http request...', e, stackTrace);
      }
    }

    try {
      await addContactApiService.rejectGroupRequest(request);
    } catch (e, stackTrace) {
      _log.e('rejectGroupRequest with http error', e, stackTrace);
      rethrow;
    }
  }
}
