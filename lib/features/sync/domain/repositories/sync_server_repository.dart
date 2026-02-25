import 'package:uchat/api/payloads/pagination/pagination_payload.dart';

import '../../data/models/payloads/get_state.dart';
import '../../data/models/payloads/init_state_contacts.dart';
import '../../data/models/payloads/init_state_rooms.dart';
import '../../data/models/payloads/init_state_seqs.dart';

abstract class SyncServerRepository {
  Future<InitStateSeqsResponse?> initStateSeq();

  Future<GetStateResponse?> fetchStates(GetStateRequest request);

  Future<PaginationPayload<InitStateRoomsResponse>> initStateRooms(InitStateRoomsRequest request);

  Future<PaginationPayload<InitStateContactsResponse>> initStateContacts(InitStateContactsRequest request);

  Future<String> getFirebaseToken();
}
