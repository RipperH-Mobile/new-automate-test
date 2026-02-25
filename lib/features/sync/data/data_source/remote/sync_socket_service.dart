import 'package:uchat/api/api.dart';

import '../../models/payloads/get_state.dart';
import '../../models/payloads/init_state_contacts.dart';
import '../../models/payloads/init_state_rooms.dart';
import '../../models/payloads/init_state_seqs.dart';
import 'backend_path.dart';

class SyncSocketService {
  final SocketCaller socketCaller;

  SyncSocketService({
    required this.socketCaller,
  });

  Future<GetStateResponse?> fetchStates(GetStateRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      fetchStatesPath.socket,
      request.toMap(),
    );

    return socketResp.mapToResponse(
      (data) => GetStateResponse.fromMap(data),
    );
  }

  Future<InitStateSeqsResponse?> initStateSeq() async {
    final socketResp = await socketCaller.emitCallV3(
      initStateSeqsPath.socket,
      null,
    );

    return socketResp.mapToResponse(
      (data) => InitStateSeqsResponse.fromMap(data),
    );
  }

  Future<PaginationPayload<InitStateRoomsResponse>> initStateRooms(InitStateRoomsRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      initStateRoomsPath.socket,
      request.toMap(),
    );

    return PaginationPayload.fromMapV3(
      socketResp.data,
      listMapper: (rows) {
        List<InitStateRoomsResponse> result = [];
        for (final row in rows) {
          if (row == null) continue;
          result.add(InitStateRoomsResponse.fromMap(row));
        }
        return result;
      },
    );
  }

  Future<PaginationPayload<InitStateContactsResponse>> initStateContacts(InitStateContactsRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      initStateContactsPath.socket,
      request.toMap(),
    );

    return PaginationPayload.fromMapV3(
      socketResp.data,
      listMapper: (rows) {
        List<InitStateContactsResponse> result = [];
        for (final row in rows) {
          if (row == null) continue;
          result.add(InitStateContactsResponse.fromJson(row));
        }
        return result;
      },
    );
  }

  Future<String> getFirebaseToken() async {
    final socketResp = await socketCaller.emitCallV3(
      getFirebaseTokenPath.socket,
      {},
    );

    return socketResp.data['data']['firebaseToken'];
  }
}
