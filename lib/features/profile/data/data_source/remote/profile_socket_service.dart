import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/features/profile/data/data_source/remote/profile_backend_path.dart';
import 'package:uchat/features/profile/domain/entities/profile_entity.dart';

class ProfileSocketService {
  final SocketCaller socketCaller;

  ProfileSocketService({required this.socketCaller});

  Future<ProfileEntity?> getProfile(String accountId) async {
    final httpRes = await socketCaller.emitCallV3(
      getProfilePath.socket,
      {
        'accountId': accountId,
      },
    );

    return httpRes.mapToResponseV3<ProfileEntity>(
      (data) => ProfileEntity.fromJson(data),
    );
  }
}
