import 'package:uchat/api/backend_path.dart';

/// Voip Api
const voipRegister = BackendPathModel(
  http: 'v3/voip/register',
  socket: 'v3.voip.register.post',
);

const voipDeregister = BackendPathModel(
  http: 'v3/voip/deregister',
  socket: 'v3.voip.deregister.delete',
);
