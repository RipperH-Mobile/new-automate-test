import 'package:uchat/features/auth/data/models/requests/get_otp_method_forgot_password_request.dart';
import 'package:uchat/features/auth/data/models/responses/get_otp_method_forgot_password_response.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetOtpMethodForgotPasswordUseCase extends SimpleUseCase<GetOtpMethodForgotPasswordResponse, GetOtpMethodForgotPasswordRequest> {
  final AuthServerRepository authServerRepository;

  GetOtpMethodForgotPasswordUseCase({required this.authServerRepository});

  @override
  Future<GetOtpMethodForgotPasswordResponse> call(GetOtpMethodForgotPasswordRequest params) async {
    return await authServerRepository.getOtpMethodForgotPassword(params);
  }
}