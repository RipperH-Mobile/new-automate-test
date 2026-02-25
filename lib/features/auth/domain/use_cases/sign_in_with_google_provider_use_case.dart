import 'package:uchat/features/auth/domain/entities/link_account_auth_entity.dart';
import 'package:uchat/features/auth/domain/repositories/social_auth_provider_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class SignInWithGoogleProviderUseCase extends SimpleUseCase<LinkAccountAuthEntity, NoParams> {
  SignInWithGoogleProviderUseCase({
    required this.socialAuthProviderRepository,
  });

  final SocialAuthProviderRepository socialAuthProviderRepository;

  @override
  Future<LinkAccountAuthEntity> call(NoParams params) async {
    return socialAuthProviderRepository.signInWithGoogle();
  }
}
