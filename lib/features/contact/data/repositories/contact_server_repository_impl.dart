import 'package:get_it/get_it.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/null_response_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/contact/data/data_source/remote/contact_http_service.dart';
import 'package:uchat/features/contact/data/data_source/remote/contact_socket_service.dart';
import 'package:uchat/features/contact/data/models/mapper/contact_mapper_extensions.dart';
import 'package:uchat/features/contact/data/models/requests/add_contact_request.dart';
import 'package:uchat/features/contact/data/models/requests/add_friend_in_group_request.dart';
import 'package:uchat/features/contact/data/models/requests/block_contact_request.dart';
import 'package:uchat/features/contact/data/models/requests/check_if_requesting_friend_request.dart';
import 'package:uchat/features/contact/data/models/requests/decline_friend_request.dart';
import 'package:uchat/features/contact/data/models/requests/hide_contact_request.dart';
import 'package:uchat/features/contact/data/models/requests/reject_friend_request.dart';
import 'package:uchat/features/contact/data/models/requests/remove_friend_request.dart';
import 'package:uchat/features/contact/data/models/requests/search_contact_request.dart';
import 'package:uchat/features/contact/data/models/requests/unblock_contact_request.dart';
import 'package:uchat/features/contact/data/models/requests/unhide_contact_request.dart';
import 'package:uchat/features/contact/data/models/requests/update_nickname_request.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_server_repository.dart';

import '../models/requests/get_friend_request_request.dart';

final _log = useLogger();

class ContactServerRepositoryImpl implements ContactServerRepository {
  ContactServerRepositoryImpl();

  SocketCaller get socketCaller {
    return GetIt.I<SocketCaller>();
  }

  ContactHttpService get contactApiService {
    return GetIt.I<ContactHttpService>();
  }

  ContactSocketService get contactSocketService {
    return GetIt.I<ContactSocketService>();
  }

  RoomDb get roomDb {
    return GetIt.I<RoomDb>();
  }

  RoomMemberDb get roomMemberDb {
    return GetIt.I<RoomMemberDb>();
  }

  @override
  Future<AddContactResponse> addContact(AddContactRequest request) async {
    _log.d('addContact: ${request.toMap()}');
    if (socketCaller.isReadyForCall) {
      try {
        final res = await contactSocketService.addContact(request);
        if (res == null) throw NullResponseException();
        return res;
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('addContact with socket error. Fallback to HTTP request...', e, stackTrace);
      }
    }

    try {
      final res = await contactApiService.addContact(request);
      if (res == null) throw NullResponseException();
      return res;
    } catch (e, stackTrace) {
      _log.w('addContact with http error. ', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<ContactEntity> addFriendInGroup(AddFriendInGroupRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final res = await contactSocketService.addFriendInGroup(request);
        if (res == null) throw NullResponseException();
        return res.toEntity();
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('addFriendInGroup with socket error. Fallback to HTTP request...', e, stackTrace);
      }
    }

    final res = await contactApiService.addFriendInGroup(request);
    if (res == null) throw NullResponseException();
    return res.toEntity();
  }

  @override
  Future<ContactEntity?> blockContact(BlockContactRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final response = await contactSocketService.blockContact(request);

        return response.first?.toEntity();
      } catch (e, stackTrace) {
        _log.w('blockContact with socket error. Fallback to HTTP request...', e, stackTrace);
      }
    }

    final response = await contactApiService.blockContact(request);

    return response.first?.toEntity();
  }

  @override
  Future<void> deleteContact(RejectFriendRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await contactSocketService.deleteContact(request);
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('deleteContact with socket error. Fallback to HTTP request...', e, stackTrace);
      }
    }
  }

  @override
  Future<CheckIfRequestingFriendResponse?> checkIfRequestingFriend(CheckIfRequestingFriendRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final res = await contactSocketService.checkIfRequestingFriend(request);
        if (res == null) throw NullResponseException();
        return res;
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('checkIfRequestingFriend with socket error. Fallback to HTTP request...', e, stackTrace);
      }
    }
    final res = await contactApiService.checkIfRequestingFriend(request);
    if (res == null) throw NullResponseException();
    return res;
  }

  @override
  Future<PaginationPayload<ContactEntity>?> getFriendRequestList(GetFriendRequestRequest param) async {
    if (socketCaller.isReadyForCall) {
      try {
        final res = await contactSocketService.getFriendRequestList(param);
        if (res == null) throw NullResponseException();
        return res.toEntity((collections) => collections.toEntities());
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('getFriendRequestList with socket error. Fallback to HTTP request...', e, stackTrace);
      }
    }
    final res = await contactApiService.getFriendRequestList(param);
    if (res == null) throw NullResponseException();
    return res.toEntity((collections) => collections.toEntities());
  }

  @override
  Future<ContactEntity?> hideContact(HideContactRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final response = await contactSocketService.hideContact(request);

        return response.first?.toEntity();
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('hideContact with socket error. Fallback to HTTP request...', e, stackTrace);
      }
    }
    final response = await contactApiService.hideContact(request);
    return response.first?.toEntity();
  }

  @override
  Future<bool> removeFriend(RemoveFriendRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final res = await contactSocketService.removeFriend(request);
        return res;
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('removeFriend with socket error. Fallback to HTTP request...', e, stackTrace);
      }
    }
    return await contactApiService.removeFriend(request);
  }

  @override
  Future<SearchContactResponse> searchContact(SearchContactRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final res = await contactSocketService.searchContact(request);
        if (res == null) throw NullResponseException();
        return res;
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('searchContact with socket error. Fallback to HTTP request...', e, stackTrace);
      }
    }
    final res = await contactApiService.searchContact(request);
    if (res == null) throw NullResponseException();
    return res;
  }

  @override
  Future<void> unHideContact(UnHideContactRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await contactSocketService.unHideContact(request);
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('unHideContact with socket error. Fallback to HTTP request...', e, stackTrace);
      }
    }
    await contactApiService.unHideContact(request);
  }

  @override
  Future<void> unblockContact(UnblockContactRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await contactSocketService.unblockContact(request);
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('unblockContact with socket error. Fallback to HTTP request...', e, stackTrace);
      }
    }
    await contactApiService.unblockContact(request);
  }

  @override
  Future<void> updateNickname(UpdateNicknameRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await contactSocketService.updateNickname(request);
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('updateNickname with socket error. Fallback to HTTP request...', e, stackTrace);
      }
    }
    await contactApiService.updateNickname(request);
  }

  @override
  Future<void> declineFriendRequest(DeclineFriendRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await contactSocketService.declineFriendRequest(request);
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('declineFriendRequest with socket error. Fallback to HTTP request...', e, stackTrace);
      }
    }
    await contactApiService.declineFriendRequest(request);
  }
}
