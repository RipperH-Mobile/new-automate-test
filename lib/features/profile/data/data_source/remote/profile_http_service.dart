import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/features/profile/data/data_source/remote/profile_backend_path.dart';
import 'package:uchat/features/profile/domain/entities/profile_entity.dart';

class ProfileHttpService {
  final HttpCaller httpCaller;

  ProfileHttpService({required this.httpCaller});

  Future<ProfileEntity?> getProfile(String accountId) async {
    final httpRes = await httpCaller.get(
      getProfilePath.http.replaceAll(':accountId', accountId),
    );

    return httpRes.mapToResponseV3<ProfileEntity>(
      (data) => ProfileEntity.fromJson(data),
    );
  }
}
