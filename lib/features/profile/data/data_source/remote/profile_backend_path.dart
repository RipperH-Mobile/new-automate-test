import 'package:uchat/api/backend_path.dart';

const getProfilePath = BackendPathModel(
  http: 'profile/:accountId',
  socket: 'account.getProfileById',
);
