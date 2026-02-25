import 'package:uchat/features/auth/domain/entities/auth_login_entity.dart';
import 'package:uchat/features/auth/domain/repositories/social_auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class SignInWithGoogleServerUseCase extends SimpleUseCase<AuthLoginEntity, String> {
  SignInWithGoogleServerUseCase({
    required this.socialAuthServerRepository,
  });

  final SocialAuthServerRepository socialAuthServerRepository;

  @override
  Future<AuthLoginEntity> call(String token) async {
    return socialAuthServerRepository.signInWithGoogle(token);
  }
}
