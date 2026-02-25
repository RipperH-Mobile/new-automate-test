import 'package:uchat/features/auth/domain/entities/auth_login_entity.dart';
import 'package:uchat/features/auth/domain/repositories/social_auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class LinkAccountWithGoogleUseCase extends SimpleUseCase<AuthLoginEntity, String> {
  final SocialAuthServerRepository socialAuthServerRepository;

  LinkAccountWithGoogleUseCase({required this.socialAuthServerRepository});

  @override
  Future<AuthLoginEntity> call(String token) async {
    return socialAuthServerRepository.linkAccountWithGoogle(token);
  }
}
