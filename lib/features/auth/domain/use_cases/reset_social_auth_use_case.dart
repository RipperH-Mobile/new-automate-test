import 'package:uchat/features/auth/domain/repositories/social_auth_provider_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class ResetSocialAuthUseCase extends SimpleUseCase<void, NoParams> {
  ResetSocialAuthUseCase({
    required this.socialAuthProviderRepository,
  });

  final SocialAuthProviderRepository socialAuthProviderRepository;

  @override
  Future<void> call(NoParams params) async {
    await Future.wait([
      socialAuthProviderRepository.signOutGoogle(),
      socialAuthProviderRepository.signOutFacebook(),
    ]);
  }
}
