import 'package:uchat/features/auth/data/models/requests/sign_in_with_facebook_param.dart';
import 'package:uchat/features/auth/domain/entities/link_account_auth_entity.dart';
import 'package:uchat/features/auth/domain/repositories/social_auth_provider_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class SignInWithFacebookProviderUseCase extends SimpleUseCase<LinkAccountAuthEntity, SignInWithFacebookParam?> {
  SignInWithFacebookProviderUseCase({
    required this.socialAuthProviderRepository,
  });

  final SocialAuthProviderRepository socialAuthProviderRepository;

  @override
  Future<LinkAccountAuthEntity> call(SignInWithFacebookParam? param) async {
    return socialAuthProviderRepository.signInWithFacebook(param);
  }
}
