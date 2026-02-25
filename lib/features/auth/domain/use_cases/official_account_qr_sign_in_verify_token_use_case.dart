import 'package:uchat/features/auth/data/models/requests/oa_qr_verify_token_request.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class OfficialAccountQRSignInVerifyTokenUseCase extends SimpleUseCase<bool, OAQRVerifyTokenRequest> {
  final AuthServerRepository authServerRepository;

  OfficialAccountQRSignInVerifyTokenUseCase({required this.authServerRepository});

  @override
  Future<bool> call(OAQRVerifyTokenRequest params) async {
    return authServerRepository.officialAccountQRSignInVerifyToken(params);
  }
}