import 'package:uchat/features/auth/domain/repositories/social_auth_provider_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class SignOutWithGoogleUseCase extends SimpleUseCase<void, NoParams> {
  SignOutWithGoogleUseCase({
    required this.socialAuthProviderRepository,
  });

  final SocialAuthProviderRepository socialAuthProviderRepository;

  @override
  Future<void> call(NoParams params) async {
    return socialAuthProviderRepository.signOutGoogle();
  }
}
