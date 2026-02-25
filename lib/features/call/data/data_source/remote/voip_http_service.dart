import 'package:uchat/api/http/http_caller.dart';

import '../../models/payloads/deregister_voip.dart';
import '../../models/payloads/register_voip.dart';
import 'backend_path.dart';

class VoipHttpService {
  final HttpCaller httpCaller;

  VoipHttpService({
    required this.httpCaller,
  });

  ///
  /// Register VoIP
  /// Auto register VoIP token to OneSignal by session information from server.
  ///
  Future<RegisterVoipResponse?> registerVoip(RegisterVoipRequest request) async {
    final response = await httpCaller.post(voipRegister.http, data: request.toMap());

    return response.mapToResponseV3((data) => RegisterVoipResponse.fromMap(data));
  }

  ///
  /// Deregister VoIP
  /// Auto delete OneSignal user by session information from server.
  ///
  Future<DeregisterVoipResponse?> deregisterVoip() async {
    final response = await httpCaller.delete(voipDeregister.http);

    return response.mapToResponseV3((data) => DeregisterVoipResponse.fromMap(data));
  }
}
