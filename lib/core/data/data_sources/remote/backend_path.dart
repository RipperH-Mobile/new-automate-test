import 'package:uchat/api/backend_path.dart';

const checkAppVersion = BackendPathModel(
  http: 'v3/app-version/compare',
  socket: '',
);

const getPlatformDocument = BackendPathModel(
  http: 'v3/platform-document/version',
  socket: '',
);

const userAcceptTerm = BackendPathModel(
  http: 'v3/platform-document/accept',
  socket: '',
);
