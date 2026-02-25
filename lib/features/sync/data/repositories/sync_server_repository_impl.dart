import 'package:uchat/api/api.dart';

import '../../domain/repositories/sync_server_repository.dart';
import '../data_source/remote/sync_http_service.dart';
import '../data_source/remote/sync_socket_service.dart';
import '../models/payloads/get_state.dart';
import '../models/payloads/init_state_contacts.dart';
import '../models/payloads/init_state_rooms.dart';
import '../models/payloads/init_state_seqs.dart';

class SyncServerRepositoryImpl implements SyncServerRepository {
  final SyncHttpService syncHttpService;
  final SyncSocketService syncSocketService;

  SyncServerRepositoryImpl({
    required this.syncHttpService,
    required this.syncSocketService,
  });

  @override
  Future<GetStateResponse?> fetchStates(GetStateRequest request) {
    if (syncSocketService.socketCaller.isReadyForCall) {
      try {
        return syncSocketService.fetchStates(request);
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e) {
        // Handle other exceptions if needed
      }
    }

    return syncHttpService.fetchStates(request);
  }

  @override
  Future<PaginationPayload<InitStateContactsResponse>> initStateContacts(InitStateContactsRequest request) {
    if (syncSocketService.socketCaller.isReadyForCall) {
      try {
        return syncSocketService.initStateContacts(request);
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e) {
        // Handle other exceptions if needed
      }
    }

    return syncHttpService.initStateContacts(request);
  }

  @override
  Future<PaginationPayload<InitStateRoomsResponse>> initStateRooms(InitStateRoomsRequest request) {
    if (syncSocketService.socketCaller.isReadyForCall) {
      try {
        return syncSocketService.initStateRooms(request);
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e) {
        // Handle other exceptions if needed
      }
    }

    return syncHttpService.initStateRooms(request);
  }

  @override
  Future<InitStateSeqsResponse?> initStateSeq() {
    if (syncSocketService.socketCaller.isReadyForCall) {
      try {
        return syncSocketService.initStateSeq();
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e) {
        // Handle other exceptions if needed
      }
    }

    return syncHttpService.initStateSeq();
  }

  @override
  Future<String> getFirebaseToken() async {
    if (syncSocketService.socketCaller.isReadyForCall) {
      try {
        return await syncSocketService.getFirebaseToken();
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      }
    }

    return await syncHttpService.getFirebaseToken();
  }
}
