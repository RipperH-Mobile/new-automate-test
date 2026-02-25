import 'package:uchat/api/backend_path.dart';

/// UpdateStateService
const fetchStatesPath = BackendPathModel(
  http: 'v3/state',
  socket: 'v3.state.get',
);

const initStateSeqsPath = BackendPathModel(
  http: 'v3/state/init/seqs',
  socket: 'v3.state.init.seqs',
);

const initStateRoomsPath = BackendPathModel(
  http: 'v3/state/init/rooms',
  socket: 'v3.state.init.rooms',
);

const initStateContactsPath = BackendPathModel(
  http: 'v3/state/init/contacts',
  socket: 'v3.state.init.contacts',
);

const getFirebaseTokenPath = BackendPathModel(
  http: 'v3/auth/firebase-refresh-token',
  socket: 'v3.accounts.firebaseRefreshToken.post',
);
