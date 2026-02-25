import 'package:uchat/features/auth/data/models/requests/verify_token_forgot_password_request.dart';
import 'package:uchat/features/auth/data/models/responses/verify_token_forgot_password_response.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class VerifyTokenForgotPasswordUseCase extends SimpleUseCase<VerifyTokenForgotPasswordResponse, VerifyTokenForgotPasswordRequest> {
  final AuthServerRepository authServerRepository;

  VerifyTokenForgotPasswordUseCase({required this.authServerRepository});

  @override
  Future<VerifyTokenForgotPasswordResponse> call(VerifyTokenForgotPasswordRequest params) async {
    return await authServerRepository.verifyTokenForgotPassword(params);
  }
}