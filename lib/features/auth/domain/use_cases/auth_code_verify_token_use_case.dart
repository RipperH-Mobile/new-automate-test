import 'package:uchat/use_cases/use_case.dart';

import '../../data/models/requests/auth_code_verify_token_request.dart';
import '../entities/auth_code_verify_entity.dart';
import '../repositories/auth_server_repository.dart';

class AuthCodeVerifyTokenUseCase extends SimpleUseCase<AuthCodeVerifyEntity?, AuthCodeVerifyTokenRequest> {
  final AuthServerRepository authServerRepository;

  AuthCodeVerifyTokenUseCase({required this.authServerRepository});

  @override
  Future<AuthCodeVerifyEntity?> call(AuthCodeVerifyTokenRequest params) async {
    return authServerRepository.authCodeVerifyToken(params);
  }
}
