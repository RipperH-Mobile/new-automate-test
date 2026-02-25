import 'package:uchat/api/api.dart';

import '../../models/payloads/get_state.dart';
import '../../models/payloads/init_state_contacts.dart';
import '../../models/payloads/init_state_rooms.dart';
import '../../models/payloads/init_state_seqs.dart';
import 'backend_path.dart';

class SyncHttpService {
  final HttpCaller httpCaller;

  SyncHttpService({
    required this.httpCaller,
  });

  Future<GetStateResponse?> fetchStates(GetStateRequest request) async {
    final httpResp = await httpCaller.get(
      fetchStatesPath.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponse(
      (data) => GetStateResponse.fromMap(data),
    );
  }

  Future<InitStateSeqsResponse?> initStateSeq() async {
    final httpResp = await httpCaller.get(
      initStateSeqsPath.http,
    );

    return httpResp.mapToResponse(
      (data) => InitStateSeqsResponse.fromMap(data),
    );
  }

  Future<PaginationPayload<InitStateRoomsResponse>> initStateRooms(InitStateRoomsRequest request) async {
    final httpResp = await httpCaller.get(
      initStateRoomsPath.http,
      data: request.toMap(),
    );

    return PaginationPayload.fromMapV3(
      httpResp.data,
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
    final httpResp = await httpCaller.get(
      initStateContactsPath.http,
      data: request.toMap(),
    );

    return PaginationPayload.fromMapV3(
      httpResp.data,
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
    final httpResp = await httpCaller.post(
      getFirebaseTokenPath.http,
    );

    return httpResp.data['data']['firebaseToken'];
  }
}
