import 'package:uchat/features/auth/domain/entities/auth_login_entity.dart';
import 'package:uchat/features/auth/domain/repositories/social_auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class SignInWithFacebookServerUseCase extends SimpleUseCase<AuthLoginEntity, String> {
  SignInWithFacebookServerUseCase({
    required this.socialAuthServerRepository,
  });

  final SocialAuthServerRepository socialAuthServerRepository;

  @override
  Future<AuthLoginEntity> call(String token) async {
    return socialAuthServerRepository.signInWithFacebook(token);
  }
}
